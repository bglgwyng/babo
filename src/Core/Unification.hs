{-# OPTIONS_GHC -fplugin=Polysemy.Plugin #-}

module Core.Unification where

import Common
import Context (GlobalContext, Inhabitant (Definition), value)
import qualified Context as C
import Control.Applicative ((<|>))
import Control.Arrow (Arrow (first, second, (&&&)), (>>>))
import Control.Monad (forM, join, unless, void, when, (>=>))
import Control.Monad.Extra (unlessM, whenM)
import Core.Constraint
import Core.Meta
import Core.Term
  ( Argument,
    InductiveType (..),
    Pattern (..),
    Term (..),
    applyApTelescope,
    occurs,
    peelApTelescope,
    raise,
    subst,
  )
import qualified Core.Term as T
import Core.UnifyState
import Data.Either (partitionEithers)
import Data.Foldable
import Data.Function (on)
import Data.Functor (($>))
import Data.List (uncons)
import Data.Map (assocs, (!))
import qualified Data.Map.Strict as M
import Data.Maybe
import Data.Set (difference)
import qualified Data.Set as S
import Data.Tuple (swap)
import Effect.ElaborationError (ElaborationError (..))
import Effect.Gen (Gen, gen, runGen)
import Polysemy (Embed (unEmbed), Member, Members, Sem, embed, interpret, makeSem, runM, subsume, subsume_)
import Polysemy.Embed (runEmbedded)
import Polysemy.Error (Error, throw)
import Polysemy.NonDet (NonDet, runNonDet)
import Polysemy.Reader (Reader, ask, runReader)
import Polysemy.State (State, evalState, execState, get, modify, put)

type Effects = '[Error ElaborationError, Reader GlobalContext, State UnifyState, Gen]

data UnifyEffect m a where
  Emit :: Constraint -> UnifyEffect m ()
  Solve :: Id -> Term -> UnifyEffect m ()
  Resolve :: Id -> UnifyEffect m ()
  GetState :: UnifyEffect m UnifyState
  GenMeta :: Level -> UnifyEffect m Term

makeSem ''UnifyEffect

rename :: M.Map Id Id -> Term -> Maybe Term
rename = go 0
  where
    go :: Int -> M.Map Id Id -> Term -> Maybe Term
    go level map t@(Local i)
      | level > i = pure t
      | otherwise = Local . (level +) <$> M.lookup (i - level) map
    go level map (Ap l r) = Ap <$> go level map l <*> go level map r
    go level map (Lam arg body) = Lam <$> go level map arg <*> go (level + 1) map body
    go level map (Pi arg body) = Pi <$> go level map arg <*> go (level + 1) map body
    go level map (Case x _ branches _) = error "not implemented"
    go _ _ t = pure t

wellScoped :: Level -> Term -> Bool
wellScoped level = \case
  Local i | i >= level -> False
  Ap l r -> wellScoped level l && wellScoped level r
  Lam argType body -> wellScoped level argType && wellScoped (level + 1) body
  Pi from to -> wellScoped level from && wellScoped (level + 1) to
  Case {} -> error "not implemented"
  _ -> True

type Abstraction = Term -> Term -> Term

force :: Members '[Reader GlobalContext, UnifyEffect] r => Bool -> Term -> Sem r Term
force unfold x = do
  globals <- ask
  UnifyState {metas} <- getState
  let go :: Term -> Term
      go = \case
        Ap l r -> do
          let l' = go l
          case l' of
            Lam arg body -> go (subst r 0 body)
            l -> Ap l' (go r)
        Let x y -> go (subst x 0 y)
        Lam arg body -> Lam (go arg) (go body)
        Pi arg body -> Pi (go arg) (go body)
        x@(Meta i) ->
          case M.lookup i metas of
            Just (Solved t _) -> go t
            _ -> x
        x@(Global qname) ->
          fromJust $
            ( \case
                Definition {value}
                  | unfold -> go value
                  | otherwise -> x
                _ -> x
            )
              <$> M.lookup qname globals
        y@(Case x (Just ind) branches defaults) ->
          case peelApTelescope (go (Local x)) of
            (Global constructor, spine) ->
              let body = maybe undefined snd $ find (\(Constructor name', _) -> name' == Common.name constructor) branches
               in go $ foldr (`subst` 0) body spine
            _ -> y
        x -> x
  pure $ go x

typeOf :: Members '[Error ElaborationError, Reader GlobalContext, UnifyEffect] r => Context -> Term -> Sem r Term
typeOf cxt t = do
  globals <- ask
  UnifyState {metas} <- getState
  case t of
    Local i -> if i < length cxt then pure $ raise (i + 1) $ cxt !! i else error (show (cxt, t))
    Meta i ->
      maybe
        ( do
            meta <- genMeta 0
            emit $ [] |- t ?: meta
            pure meta
        )
        (pure . type')
        $ M.lookup i metas
    Global i -> pure . C.type' $ globals ! i
    Type -> pure Type
    Let x y -> typeOf cxt =<< force True (subst x 0 y)
    Ap l r -> do
      lType <- typeOf cxt l >>= force True
      case lType of
        Pi from to -> do
          emit $ cxt |- r ?: from
          pure (subst r 0 to)
        _ -> do
          from <- genMeta (length cxt)
          to <- genMeta (length cxt + 1)
          emit $ cxt |- Pi from to ?= lType
          emit $ cxt |- from ?: Type
          emit $ cxt |- r ?: from
          emit $ (from : cxt) |- to ?: Type
          pure (subst r 0 to)
    Lam arg body -> do
      emit $ cxt |- arg ?: Type
      bodyType <- typeOf (arg : cxt) body
      emit $ arg : cxt |- bodyType ?: Type
      pure $ Pi arg bodyType
    Pi from to -> do
      emit $ cxt |- from ?: Type
      emit $ from : cxt |- to ?: Type
      pure Type
    Case x (Just ind) branches defaults -> do
      xType <- typeOf cxt (Local x) >>= force True
      let InductiveType {qname = indName, params, indices, variants} = ind
          QName {namespace} = indName
      spine <-
        (id <$>)
          <$> ( case peelApTelescope xType of
                  (Global name, spine)
                    | name == indName -> pure spine
                    | otherwise ->
                      throw InvalidCase
                  _ -> do
                    spine <- forM (params <> indices) (const $ genMeta (length cxt))
                    emit $ cxt |- xType ?= applyApTelescope (Global indName) spine
                    pure spine
              )
      type' <- genMeta (length cxt)
      UnifyState {constraints, metas} <- getState
      forM_
        branches
        ( \(Constructor name, body) ->
            let Just (_, (args, _)) = find ((== name) . fst) variants
                arity = length args
                argTypes = (foldr (`subst` 0) `flip` spine) <$> zipWith (raise >>> (. T.type')) [arity -1, arity - 2 ..] args
                body' = foldr (`subst` 0) body spine
              in emit $ reverse argTypes <> cxt |- body ?: raise (length args) type'
        )
      forM_ defaults $ emit . (cxt |-) . (?: type')
      pure type'
    Case x _ branches _ -> error "not implemented"

-- | Given a constraint, produce a collection of equivalent but
-- simpler constraints. Any solution for the returned set of
-- constraints should be a solution for the original constraint.
-- NOTE: terms in the constraint are normalized
simplify :: Members '[Error ElaborationError, Reader GlobalContext, UnifyEffect] r => Constraint -> Sem r Bool
-- simplify (Constraint cxt (HasType (Lam argType body) (Pi from to))) = do
--   emit $ cxt |- argType ?= from
--   emit $ cxt |- argType ?: Type
--   emit $ argType : cxt |- body ?: to
--   pure True
simplify (Constraint cxt (HasType t1 t2)) = do
  type' <- typeOf cxt t1
  emit $ cxt |- type' ?= t2
  pure True
simplify (Constraint _ (Equal t1 t2)) | t1 == t2 = pure True
simplify (Constraint cxt (Equal t1 t2))
  | t1 == t2 = pure True
  | Lam arg1 body1 <- t1,
    Lam arg2 body2 <- t2 = do
    emit $ cxt |- arg1 ?= arg2
    emit $ arg1 : cxt |- body1 ?= body2
    pure True
  | Pi arg1 body1 <- t1,
    Pi arg2 body2 <- t2 = do
    emit $ cxt |- arg1 ?= arg2
    emit $ arg1 : cxt |- body1 ?= body2
    pure True
  | (head1, spine1) <- peelApTelescope t1,
    (head2, spine2) <- peelApTelescope t2 =
    if head1 == head2 && on (==) length spine1 spine2
      then mapM_ (emit . (cxt |-)) (zipWith (?=) spine1 spine2) $> True
      else case (head1, head2) of
        (Meta {}, _) -> pure False
        (_, Meta {}) -> pure False
        _ -> throw $ CannotUnify t1 t2

run :: Members Effects r => Sem (UnifyEffect : r) a -> Sem r a
run = interpret \case
  Emit (Constraint cxt c) -> run $ do
    state@UnifyState {constraints, metas} <- get
    case c of
      Equal x y | x == y -> pure ()
      Equal y x | Just (k, v) <- solution T.Lam x y -> solve k v
      Equal x y
        | Just (k, v) <- solution T.Lam x y -> solve k v
        | otherwise -> do
          x <- force True x
          y <- force True y
          trySimplify $ cxt |- x ?= y
      HasType v t
        | Just (i, v') <- solution T.Pi v t ->
          case M.lookup i metas of
            Just (Solved _ z) -> emit $ [] |- v' ?= z
            Just (Unsolved z) -> emit $ [] |- v' ?= z
            Nothing -> put state {metas = M.insert i (Unsolved v') metas}
        | otherwise -> do
          -- FIXME: this is a workaround to unfold less global variables
          -- v <- force True v
          t <- force True t
          trySimplify $ cxt |- v ?: t
    where
      shouldBeFree :: Term -> Maybe (Term, Index)
      shouldBeFree (Local i) = if i < length cxt then Just (cxt !! i, i) else error (show (cxt, i))
      shouldBeFree _ = Nothing
      solution :: Abstraction -> Term -> Term -> Maybe (Id, Term)
      solution abstract lhs rhs
        | (m@(Meta i), spine) <- peelApTelescope lhs,
          not $ occurs m rhs,
          Just frees <- traverse shouldBeFree spine,
          not $ any (occurs m . fst) frees,
          let renamings = M.fromList $ zip (reverse (snd <$> frees)) [0 ..],
          length frees == length renamings,
          Just body <- rename renamings rhs,
          let v = foldr abstract body $ fst <$> frees,
          -- TODO: maybe it's redundant
          wellScoped 0 v =
          pure (i, v)
      solution _ x y = Nothing
      trySimplify :: Members (UnifyEffect : Effects) r => Constraint -> Sem r ()
      trySimplify c = unlessM (simplify c) do
        k <- gen
        modify (\state@UnifyState {constraints} -> state {constraints = M.insert k c constraints})
  Solve k v -> run do
    state@UnifyState {constraints, metas} <- get
    type' <- case M.lookup k metas of
      Just Unsolved {type'} -> pure type'
      -- FIXME: make this case not happen
      Just Solved {value, type'} -> emit ([] |- v ?= value) $> type'
      Nothing -> typeOf [] v
    put state {metas = M.insert k Solved {value = v, type'} metas}
    -- FIXME: avoid revisiting every constraints
    forM_
      (assocs constraints)
      ( \(k, x@(Constraint cxt v)) -> do
          -- FIXME: avoid emitting new one
          resolve k
          case v of
            Equal x y -> do
              x <- force True x
              y <- force True y
              emit (cxt |- x ?= y)
            HasType v t -> do
              v <- force True v
              t <- force True t
              emit (cxt |- v ?: t)
      )
  Resolve k ->
    modify
      ( \state@UnifyState {constraints} ->
          state {constraints = M.delete k constraints}
      )
  GetState -> get
  GenMeta level ->
    -- FIXME: If `reverse` is ommited, inference fails. Find out why.
    (`applyApTelescope` (Local <$> reverse [0 .. level - 1])) . Meta <$> gen

runUnifyM ::
  Members '[Error ElaborationError, Reader GlobalContext] r =>
  Sem (UnifyEffect : State UnifyState : Gen : r) a ->
  Sem r a
runUnifyM = runGen . evalState initialState . run