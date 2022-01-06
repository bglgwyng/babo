{-# LANGUAGE DataKinds #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE TupleSections #-}

module Core.Client (infer, infer') where

import Common
import Context
import Control.Applicative
import Control.Arrow (Arrow (first, second), (***), (>>>))
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
import Data.List.NonEmpty (NonEmpty)
import qualified Data.Map as M
import Data.Maybe
import Data.Monoid hiding (Ap)
import Data.Set (fromList)
import qualified Data.Set as S
import Debug.Trace (traceShowM)

typeOf :: Level -> GlobalContext -> M.Map Id Term -> M.Map Id Term -> Term -> UnifyM (Term, S.Set Constraint)
typeOf level gcxt mcxt cxt t =
  case t of
    Local i -> mzero
    Free _ i -> foldMap (pure . (,S.empty)) $ M.lookup i cxt
    Meta _ i -> mzero
    Global i ->
      maybe
        undefined
        (pure . (type' >>> (,mempty)))
        $ M.lookup i gcxt
    Type -> pure (Type, S.empty)
    Ap l r -> do
      (tpl, cl) <- typeOf' mcxt cxt l
      case tpl of
        Pi from to ->
          optional (typeOf' mcxt cxt r)
            <&> ( (subst r 0 to,)
                    . (cl <>)
                    . foldMap (uncurry (<>) . first (S.singleton . (from,,level)))
                )
        _ -> error "typeOf: Ap: not a Pi"
    Lam arg b -> do
      v <- lift gen
      (to, cs) <-
        typeOf
          (level + 1)
          gcxt
          mcxt
          (M.insert v arg cxt)
          (subst (Free level v) 0 b)
      pure
        (Pi arg (substFV (Local 0) v (raise 1 to)), cs)
    Pi from to -> do
      v <- lift gen
      cs <-
        (uncurry (<>) . first (S.singleton . (Type,,level)) <$> typeOf' mcxt cxt from)
          <|> pure mempty
      (toTp, toCs) <- typeOf (level + 1) gcxt mcxt (M.insert v from cxt) (subst (Free level v) 0 to)
      pure
        ( Type,
          cs
            <> toCs
            <> S.singleton (Type, toTp, level + 1)
        )
    Case x (Just inductive) cases -> do
      (type', cs) <- typeOf' mcxt cxt x
      let Inductive {T.name = inductiveName, parameters, indices, variants} = inductive
      (spine, cs') <- case spinify type' of
        (Global name : spine)
          | name == inductiveName -> pure (spine, mempty)
          | otherwise ->
            error (show inductiveName <> " != " <> show name)
        x -> do
          paramMetas <- forM parameters (const $ T.Meta level <$> lift gen)
          indexMetas <- forM indices (const $ T.Meta level <$> lift gen)
          pure (paramMetas <> indexMetas, S.singleton (x, foldl T.Ap (Global inductiveName) (paramMetas <> indexMetas)))
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
                        (\(i, v) -> subst (Free (level + length arguments + length parameters) v) i)
                        body
                        (zip [0 ..] (reverse (fst <$> vs)))
                typeOf' mcxt (cxt <> M.fromList vs) body'
            )
      let y : ys = returnTypes
          everyBranchReturnsSame = fromList ((y,,level) <$> ys)
      pure (head returnTypes, foldl (<>) mempty cs' <> everyBranchReturnsSame)
      where
        spinify :: Term -> [Term]
        spinify (Ap x y) = spinify x ++ [y]
        spinify x = [x]
    Case x _ cases -> undefined
  where
    typeOf' = typeOf level gcxt

infer :: GlobalContext -> Term -> Maybe (Term, Subst, S.Set Constraint)
infer gcxt t = listToMaybe . runUnifyM $ go
  where
    go = do
      (tp, cs) <- typeOf 0 gcxt M.empty M.empty t
      (subst, flexflex) <- unify Context {metas = M.empty} cs
      pure (manySubst subst tp, subst, cs)

infer' :: GlobalContext -> M.Map Id Term -> Term -> Term -> Maybe (Term, Term)
infer' gctx ctx t1 t2 = listToMaybe . runUnifyM $ go
  where
    go = do
      (tp, cs) <- typeOf 0 gctx M.empty ctx t1
      (subst, flexflex) <- unify Context {metas = M.empty} (cs <> S.singleton (tp, t2, 0))
      pure (manySubst subst t1, manySubst subst tp)
