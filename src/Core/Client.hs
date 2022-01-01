{-# LANGUAGE DataKinds #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE TupleSections #-}

module Core.Client (infer, infer') where

import Common
import Context
import Control.Applicative
import Control.Arrow (Arrow (first, second), (>>>))
import Control.Monad
import Control.Monad.Gen
import Control.Monad.Trans
import Core.Term (Inductive (..))
import qualified Core.Term as T
import Core.Unification
import Data.Foldable (find)
import Data.Function ((&))
import Data.Functor
import Data.List.Extra (snoc)
import qualified Data.Map as M
import Data.Maybe
import Data.Monoid hiding (Ap)
import Data.Set (fromList)
import qualified Data.Set as S

typeOf :: GlobalContext -> M.Map Id Term -> M.Map Id Term -> Term -> UnifyM (Term, S.Set Constraint)
typeOf gcxt mcxt cxt t =
  case t of
    Local i -> mzero
    Free i -> foldMap (pure . (,S.empty)) $ M.lookup i cxt
    Meta i -> mzero
    Global i ->
      maybe
        undefined
        (pure . (type' >>> (,mempty)))
        $ M.lookup i gcxt
    Type -> pure (Type, S.empty)
    Ap l r -> do
      ( do
          (tpl, cl) <- typeOf' mcxt cxt l
          let (from, to) = case tpl of
                Pi from to -> (from, to)
                _ -> error "typeOf: Ap: not a Pi"
          optional (typeOf' mcxt cxt r)
            <&> ((subst r 0 to,) . (cl <>) . foldMap (\(tpr, cr) -> cr <> S.singleton (from, tpr)))
        )
        <|>
        -- NOTE: when `typeOf' mcxt cxt l` failed
        do
          let Lam argType body = l
          (rType, cs1) <- typeOf' mcxt cxt r
          (type', cs2) <- typeOf' mcxt cxt (subst r 0 body)
          pure (type', cs1 <> cs2 <> S.singleton (rType, argType))
    Lam arg b -> do
      v <- lift gen
      (to, cs) <-
        typeOf
          gcxt
          mcxt
          (M.insert v arg cxt)
          (subst (Free v) 0 b)
      return
        ( Pi arg (substFV (Local 0) v (raise 1 to)),
          cs <> S.singleton (arg, arg)
        )
    Pi from to -> do
      v <- lift gen
      maybeFromUnification <- optional $ typeOf' mcxt cxt from
      (toTp, toCs) <- typeOf' mcxt (M.insert v from cxt) (subst (Free v) 0 to)
      return
        ( Type,
          foldMap snd maybeFromUnification
            <> toCs
            <> foldMap (S.singleton . (Type,) . fst) maybeFromUnification
            <> S.singleton (Type, toTp)
        )
    Case x (Just inductive) cases -> do
      (type', cs) <- typeOf' mcxt cxt x
      let Inductive {T.name = inductiveName, parameters, variants} = inductive
      let (Global name : spine) = spinify type'
      guard (name == inductiveName)
      (returnTypes, cs') <-
        unzip
          <$> forM
            cases
            ( \(T.Constructor qname, body) -> do
                let Just (_, arguments, _) = find (\(qname', _, _) -> qname == qname') variants
                let params' = zip (reverse (take (length parameters) spine)) [0 ..]
                vs <-
                  forM
                    (zip [0 ..] arguments)
                    ( \(i, T.Argument _ type' _) ->
                        (,foldr (uncurry subst) type' (second (+ i) <$> params'))
                          <$> lift gen
                    )
                let body' =
                      foldr
                        (\(i, v) body'' -> subst (Free v) i body'')
                        body
                        (zip [0 ..] (reverse (fst <$> vs)))
                typeOf' mcxt (cxt <> M.fromList vs) body'
            )
      let y : ys = returnTypes
          everyBranchReturnsSame = fromList ((y,) <$> ys)
      pure (head returnTypes, foldl (<>) mempty cs' <> everyBranchReturnsSame)
      where
        spinify :: Term -> [Term]
        spinify (Ap x y) = spinify x ++ [y]
        spinify x = [x]
    Case x _ cases -> undefined
  where
    typeOf' = typeOf gcxt

infer :: GlobalContext -> Term -> Maybe (Term, Subst, S.Set Constraint)
infer gcxt t = listToMaybe . runUnifyM $ go
  where
    go = do
      (tp, cs) <- typeOf gcxt M.empty M.empty t
      (subst, flexflex) <- unify Context {metas = M.empty} cs
      return (manySubst subst tp, subst, cs)

infer' :: GlobalContext -> M.Map Id Term -> Term -> Term -> Maybe (Term, Term)
infer' gctx ctx t1 t2 = listToMaybe . runUnifyM $ go
  where
    go = do
      (tp, cs) <- typeOf gctx M.empty ctx t1
      (subst, flexflex) <- unify Context {metas = M.empty} (cs <> S.singleton (tp, t2))
      return (manySubst subst t1, manySubst subst tp)