{-# LANGUAGE DataKinds #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TupleSections #-}

module Core.Client (infer, infer') where

import Common
import Context
import Control.Applicative
import Control.Monad
import Control.Monad.Gen
import Control.Monad.Trans
import Core.Unification
import Data.Functor
import qualified Data.Map as M
import Data.Maybe
import Data.Monoid hiding (Ap)
import qualified Data.Set as S
import Debug.Trace

typeOf :: GlobalContext -> M.Map Id Term -> M.Map Id Term -> Term -> UnifyM (Term, S.Set Constraint)
typeOf gcxt mcxt cxt t =
  case t of
    Local i -> mzero
    Free i -> foldMap (\x -> return (x, S.empty)) $ M.lookup i cxt
    Meta i -> mzero
    Global i ->
      maybe
        undefined
        ( \case
            Declaration x -> pure (x, mempty)
            Definition x _ -> pure (x, mempty)
            DataConstructor x -> pure (x, mempty)
            TypeConstructor x -> pure (x, mempty)
        )
        $ M.lookup i gcxt
    Type -> pure (Type, S.empty)
    Ap l r -> do
      (tpl, cl) <- typeOf' mcxt cxt l
      case tpl of
        Pi from to -> do
          optional (typeOf' mcxt cxt r)
            <&> (subst r 0 to,) . (cl <>) . foldMap (\(tpr, cr) -> cr <> S.singleton (from, tpr))
        t -> error $ show t
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
    Case x cases -> typeOf' mcxt cxt (snd $ head cases)
  where
    typeOf' = typeOf gcxt

fill ::
  GlobalContext ->
  M.Map Id Term ->
  M.Map Id Term ->
  Term ->
  UnifyM (S.Set Constraint)
fill gcxt mcxt cxt t =
  case t of
    Ap l r -> do
      (tpl, cl) <- typeOf' mcxt cxt l
      case tpl of
        Pi from to -> do
          optional (typeOf' mcxt cxt r)
            <&> (cl <>) . foldMap (\(tpr, cr) -> cr <> S.singleton (from, tpr))
        t -> error $ show t
    Lam arg b -> do
      v <- lift gen
      args' <- fill gcxt mcxt cxt arg
      cs <-
        fill
          gcxt
          mcxt
          (M.insert v arg cxt)
          (subst (Free v) 0 b)
      pure $ args' <> cs
    Pi from to -> do
      v <- lift gen
      maybeFromUnification <- fill gcxt mcxt cxt from
      (toTp, toCs) <- typeOf' mcxt (M.insert v from cxt) (subst (Free v) 0 to)
      return
        ( maybeFromUnification
            <> toCs
            -- <> foldMap (S.singleton . (Uni,) . fst) maybeFromUnification
            <> S.singleton (Type, toTp)
        )
    _ -> mzero
  where
    typeOf' = typeOf gcxt

infer :: GlobalContext -> Term -> Maybe (Term, Subst, S.Set Constraint)
infer gcxt t = listToMaybe . runUnifyM $ go
  where
    go = do
      (tp, cs) <- typeOf gcxt M.empty M.empty t
      (subst, flexflex) <- unify Context {metas = M.empty} cs
      return (manySubst subst tp, subst, cs)

fill' :: GlobalContext -> Term -> Maybe Term
fill' gcxt t = listToMaybe . runUnifyM $ go
  where
    go = do
      (tp, cs) <- typeOf gcxt M.empty M.empty t
      (subst, flexflex) <- unify Context {metas = M.empty} cs
      return (manySubst subst tp)

infer' :: GlobalContext -> M.Map Id Term -> Term -> Term -> Maybe (Term, Term)
infer' gctx ctx t1 t2 = listToMaybe . runUnifyM $ go
  where
    go = do
      (tp, cs) <- typeOf gctx M.empty ctx t1
      (subst, flexflex) <- unify Context {metas = M.empty} (cs <> S.singleton (tp, t2))
      return (manySubst subst t1, manySubst subst tp)