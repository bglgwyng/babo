{-# OPTIONS_GHC -fplugin=Polysemy.Plugin #-}

module Core.Unification
  ( Term (..),
    raise,
    subst,
    substMV,
    manySubst,
    Constraint (..),
    Subst (..),
    unify,
    unifyAll,
    runUnifyM,
    Effects,
    UnifyState (..),
    peelApTelescope,
    applyApTelescope,
    reduce,
    initialState,
    (|-),
    (?:),
    (?=),
  )
where

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
  )
import qualified Core.Term as T
import Core.UnifyState
import Data.Either (partitionEithers)
import Data.Foldable
import Data.Functor (($>))
import Data.List (uncons)
import Data.Map (assocs)
import qualified Data.Map.Strict as M
import Data.Maybe
import Data.Set (difference)
import qualified Data.Set as S
import Data.Tuple (swap)
import Debug.Trace (traceShow)
import Effect.ElaborationError (ElaborationError (..))
import Effect.Gen (Gen, gen, runGen)
import Polysemy (Embed (unEmbed), Member, Members, Sem, embed, runM)
import Polysemy.Embed (runEmbedded)
import Polysemy.Error (Error, throw)
import Polysemy.NonDet (NonDet, runNonDet)
import Polysemy.Reader (Reader, ask, runReader)
import Polysemy.State (State, evalState, execState, get, modify, put)
import Prettyprinter (Pretty (pretty), defaultLayoutOptions, hsep, indent, layoutPretty, line, vsep, (<+>))
import Prettyprinter.Render.String (renderString)

--------------------------------------------------
------------------ the language ------------------
--------------------------------------------------

-- | Raise @Local@s without a binding by @i@ amount. Used to avoid
-- capture in terms with free de Bruijn variables.
raise :: Int -> Term -> Term
raise = go 0
  where
    go lower i t = case t of
      Local j -> if j >= lower then Local (i + j) else Local j
      Ap l r -> go lower i l `Ap` go lower i r
      Lam arg body -> Lam (go lower i arg) (go (lower + 1) i body)
      Pi arg body -> Pi (go lower i arg) (go (lower + 1) i body)
      _ -> t

-- | Substitute a term for the de Bruijn variable @i@.
subst :: Term -> Int -> Term -> Term
subst new i t = case t of
  Local j -> case compare j i of
    LT -> Local j
    EQ -> new
    GT -> Local (j - 1)
  Ap l r -> subst new i l `Ap` subst new i r
  Lam arg body -> Lam (subst new i arg) (subst (raise 1 new) (i + 1) body)
  Pi arg body -> Pi (subst new i arg) (subst (raise 1 new) (i + 1) body)
  Case x (Just ind) branches ->
    Case (subst new i x) (Just ind) $
      ( \case
          (Constructor name, body) ->
            let InductiveType {qname = QName {namespace}, variants} = ind
                Just (_, (argument, _)) = find (\(name', _) -> name' == name) variants
             in ( Constructor name,
                  subst
                    (raise (length argument) new)
                    (i + length argument)
                    body
                )
          x -> error (show x)
      )
        <$> branches
  Case _ Nothing _ -> undefined
  _ -> t

-- | Substitute a term for all metavariables with a given identifier.
substMV :: Term -> Id -> Term -> Term
substMV new i t
  | (Meta j, spine) <- peelApTelescope t,
    j == i =
    instantiate new spine
  where
    instantiate (Lam _ body) (x : xs) = instantiate (subst x 0 body) xs
    instantiate new xs = applyApTelescope new xs
substMV new i t = case t of
  Ap l r -> substMV new i l `Ap` substMV new i r
  Lam arg body -> Lam (substMV new i arg) (substMV (raise 1 new) i body)
  Pi arg body -> Pi (substMV new i arg) (substMV (raise 1 new) i body)
  _ -> t

-- | Gather all the metavariables in a term into a set.
metavars :: Term -> S.Set Id
metavars t = case t of
  Meta j -> S.singleton j
  Ap l r -> metavars l <> metavars r
  Lam arg body -> metavars arg <> metavars body
  Pi arg body -> metavars arg <> metavars body
  _ -> S.empty

occurs :: Term -> Term -> Bool
occurs x = go
  where
    go t | t == x = True
    go t = case t of
      Ap l r -> go l || go r
      Lam arg body -> go arg || go body
      Pi arg body -> go arg || go body
      _ -> False

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
    go level map (Case x _ branches) = undefined
    go _ _ t = pure t

resolve :: Members Effects r => Id -> Sem r ()
resolve k = modify (\state@UnifyState {constraints} -> state {constraints = M.delete k constraints})

emit :: Members Effects r => Constraint -> Sem r ()
emit c@(Constraint cxt x) = do
  state@UnifyState {constraints, metas} <- get
  let emitSolutions :: Members Effects r => Id -> Term -> Sem r ()
      emitSolutions k v = do
        type' <- case M.lookup k metas of
          Just (Unsolved t) -> pure t
          -- FIXME:
          Just (Solved x t) -> emit ([] |- v ?= x) $> t
          Nothing -> typeOf [] v
        put
          state
            { constraints =
                ( \case
                    Constraint cxt (Equal t1 t2) -> substMV v k <$> cxt |- substMV v k t1 ?= substMV v k t2
                    Constraint cxt (TypeOf t1 t2) -> substMV v k <$> cxt |- substMV v k t1 ?: substMV v k t2
                )
                  <$> constraints,
              metas =
                M.insert
                  k
                  (Solved v type')
                  ( ( \case
                        Solved v' t -> Solved (substMV v k v') (substMV v k t)
                        Unsolved t -> Unsolved (substMV v k t)
                    )
                      <$> metas
                  )
            }
        mapM_
          (\(k, v) -> whenM (simplify v) $ resolve k)
          (assocs constraints)
      shouldBeFree :: Term -> Maybe (Term, Index)
      shouldBeFree (Local i) = Just (cxt !! i, i)
      shouldBeFree _ = Nothing
      -- pattern unification
      solve :: (Term -> Term -> Term) -> Term -> Term -> Maybe (Id, Term)
      solve abstract lhs rhs
        | (m@(Meta i), spine) <- peelApTelescope lhs,
          not $ occurs m rhs,
          Just frees <- traverse shouldBeFree spine,
          -- FIXME:
          all not $ occurs m . fst <$> frees,
          let renamings = M.fromList $ zip (reverse (snd <$> frees)) [0 ..],
          length frees == length renamings,
          Just body <- rename renamings rhs =
          -- TODO: check if the types of arguments are well formed
          pure (i, foldr abstract body $ fst <$> frees)
      solve _ x y = Nothing
  case x of
    Equal x y | x == y -> pure ()
    Equal x y | Just (i, v) <- solve T.Lam x y -> emitSolutions i v
    Equal y x | Just (i, v) <- solve T.Lam x y -> emitSolutions i v
    TypeOf x y | Just (i, v) <- solve T.Pi x y ->
      case M.lookup i metas of
        Just (Solved _ z) -> emit $ [] |- v ?= z
        Just (Unsolved z) -> emit $ [] |- v ?= z
        Nothing -> put state {metas = M.insert i (Unsolved v) metas}
    x -> do
      k <- gen
      unlessM (simplify c) $
        modify (\state@UnifyState {constraints} -> state {constraints = M.insert k c constraints})

-- | Implement reduction for the language. Given a term, normalize it.
-- This boils down mainly to applying lambdas to their arguments and all
-- the appropriate congruence rules.
reduce :: GlobalContext -> MetaContext -> Bool -> Term -> Term
reduce globals metas unfold = go
  where
    go :: Term -> Term
    go = \case
      Ap l r -> do
        let l' = go l
        case l' of
          Lam arg body -> go (subst r 0 body)
          l -> Ap l' (go r)
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
      y@(Case x (Just ind) branches) -> do
        let x' = peelApTelescope (go x)
        case x' of
          (Global constructor, spine) ->
            let Just (_, body) = find (\(Constructor name', _) -> name' == Common.name constructor) branches
             in go $ foldr (`subst` 0) body spine
          _ -> y
      x -> x

-- | Check to see if a term is blocked on applying a metavariable.
isStuck :: Term -> Bool
isStuck Meta {} = True
isStuck (Ap f _) = isStuck f
isStuck _ = False

-- | Turn @f a1 a2 a3 a4 ... an@ to @(f, [a1...an])@.
peelApTelescope :: Term -> (Term, [Term])
peelApTelescope t = go t []
  where
    go (Ap f r) rest = go f (r : rest)
    go t rest = (t, rest)

-- | Turn @(f, [a1...an])@ into @f a1 a2 a3 a4 ... an@.
applyApTelescope :: Term -> [Term] -> Term
applyApTelescope = foldl' Ap

-----------------------------------------------------------------
-------------- the actual unification code ----------------------
-----------------------------------------------------------------

type Effects = '[Gen, Error ElaborationError, State UnifyState, Reader GlobalContext]

typeOf :: Members Effects r => Context -> Term -> Sem r Term
typeOf cxt t = do
  globals <- ask
  state@UnifyState {metas, constraints} <- get
  case t of
    Local i -> pure $ raise (i + 1) $ cxt !! i
    Meta i ->
      maybe
        ( do
            meta <- Meta <$> gen
            emit $ cxt |- t ?: meta
            pure meta
        )
        (pure . type')
        $ M.lookup i metas
    Global i ->
      maybe
        (error "impossible")
        (pure . C.type')
        $ M.lookup i globals
    Type -> pure Type
    Ap l r -> do
      lType <- reduce globals metas True <$> typeOf' l
      if
          | Pi from to <- lType -> do
            emit $ cxt |- r ?: from
            pure (subst r 0 to)
          | otherwise -> do
            from <- (`applyApTelescope` (Local <$> reverse [0 .. length cxt - 1])) . Meta <$> gen
            -- FIXME: If `reverse` is ommited, inference fails. Find out why.
            to <- (`applyApTelescope` (Local <$> reverse [0 .. length cxt])) . Meta <$> gen
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
    Case x (Just ind) cases -> do
      xType <- typeOf' x
      let InductiveType {qname = indName, params, indices, variants} = ind
          QName {namespace} = indName
      -- TODO: is reduce necessary?
      let y = reduce globals metas True xType
      (spine, cs'') <- case peelApTelescope y of
        (Global name, spine)
          | name == indName -> pure (spine, mempty)
          | otherwise ->
            throw InvalidCase
        _ -> do
          paramMetas <- forM params (const $ Meta <$> gen)
          indexMetas <- forM indices (const $ Meta <$> gen)
          let spine = paramMetas <> indexMetas
          pure (spine, S.singleton (cxt |- xType ?= applyApTelescope (Global indName) spine))
      mapM_ emit (toList cs'')
      toTypes <-
        forM_
          cases
          ( \(Constructor name, body) -> do
              let Just (_, (args, _)) = find (\(name', _) -> name' == name) variants
              let params' = zip (reverse (take (length params) spine)) [0 ..]
              let argTypes =
                    ( \(i, arg) ->
                        foldr (uncurry subst) (T.type' arg) (second (+ i) <$> params')
                    )
                      <$> zip [0 ..] args
              let body' =
                    foldr
                      (\(i, v) -> subst v i)
                      body
                      (zip [0 ..] (reverse undefined))
              typeOf' body'
          )
      let (toType : toTypes') = undefined
      forM_ toTypes' $ emit . (cxt |-) . (toType ?=)
      pure toType
    Case x _ cases -> error "not implemented"
  where
    typeOf' = typeOf cxt

irreducible :: GlobalContext -> Term -> Bool
irreducible globals Type = True
irreducible globals Local {} = True
irreducible globals (Global qname) =
  case M.lookup qname globals of
    Just Definition {} -> False
    Just _ -> True
    Nothing -> error "impossible"
irreducible _ _ = False

-- | Given a constraint, produce a collection of equivalent but
-- simpler constraints. Any solution for the returned set of
-- constraints should be a solution for the original constraint.
simplify :: Members Effects r => Constraint -> Sem r Bool
simplify e@(Constraint cxt (TypeOf (Lam argType1 type') (Pi argType2 bodyType))) = do
  globals <- ask @GlobalContext
  emit $ cxt |- argType1 ?= argType2
  emit $ cxt |- argType1 ?: Type
  emit $ argType1 : cxt |- type' ?: bodyType
  pure True
simplify e@(Constraint cxt (TypeOf t1 t2)) = do
  globals <- ask @GlobalContext
  UnifyState {metas} <- get @UnifyState
  type' <- typeOf cxt t1
  emit $ cxt |- type' ?= t2
  pure True
simplify e@(Constraint cxt (Equal t1 t2))
  | t1 == t2 = pure True
  | otherwise = do
    globals <- ask
    UnifyState {metas} <- get @UnifyState
    let t1' = reduce globals metas True t1
    let t2' = reduce globals metas True t2
    if
        | t1' /= t1 -> simplify (cxt |- t1' ?= t2)
        | t2' /= t2 -> simplify (cxt |- t1 ?= t2')
        | (x, spine1) <- peelApTelescope t1,
          (y, spine2) <- peelApTelescope t2,
          irreducible globals x && irreducible globals y -> do
          if x == y && length spine1 == length spine2
            then mapM_ (simplify . (cxt |-)) (zipWith (?=) spine1 spine2) $> True
            else throw $ CannotUnify t1 t2
        | Lam arg1 body1 <- t1,
          Lam arg2 body2 <- t2 -> do
          emit $ cxt |- arg1 ?= arg2
          emit $ arg1 : cxt |- body1 ?= body2
          pure True
        | Pi arg1 body1 <- t1,
          Pi arg2 body2 <- t2 -> do
          emit $ cxt |- arg1 ?= arg2
          emit $ arg1 : cxt |- body1 ?= body2
          pure True
        | otherwise -> do
          if isStuck t1 || isStuck t2
            then pure False
            else throw $ CannotUnify t1 t2

type Subst = M.Map Id Term

manySubst :: Subst -> Term -> Term
manySubst s t = M.foldrWithKey (flip substMV) t s

union :: Subst -> Subst -> Subst
s1 `union` s2 | not (M.null (M.intersection s1 s2)) = error "Impossible"
s1 `union` s2 = M.union (manySubst s1 <$> s2) s1

-- | The top level function, given a substitution and a set of
-- constraints, produce a solution substution and the resulting set of
-- flex-flex equations.
unify :: Members Effects r => S.Set Constraint -> Sem r (Subst, S.Set Constraint)
unify cs = do
  mapM_ emit (toList cs)
  ( (M.fromList . catMaybes . ((\case (k, Solved x _) -> Just (k, x); _ -> Nothing) <$>) . assocs . metas)
      &&& S.fromList . toList . constraints
    )
    <$> get

unifyAll :: Members Effects r => S.Set Constraint -> Sem r (Term -> Term)
unifyAll constraints = do
  (subst, flexflex) <- unify constraints
  if null flexflex
    then pure $ manySubst subst
    else throw $ UnresolvedConstraints $ toList flexflex

runUnifyM :: GlobalContext -> UnifyState -> Sem (State UnifyState : Reader GlobalContext : Gen : r) a -> Sem r a
runUnifyM globals state =
  runGen
    . runReader globals
    . evalState state
