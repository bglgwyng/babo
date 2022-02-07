{-# OPTIONS_GHC -fplugin=Polysemy.Plugin #-}

module Core.Unification
  ( Term (..),
    raise,
    subst,
    substMV,
    manySubst,
    substFV,
    Constraint (..),
    Subst (..),
    unify,
    unifyAll,
    runUnifyM,
    -- driver,
    Effects,
    UnifyState (..),
    peelApTelescope,
    applyApTelescope,
    reduce,
    initialState,
    (?:),
    (?=),
  )
where

import Common
import Context as C (GlobalContext, Inhabitant (Definition), type', value)
import Control.Applicative ((<|>))
import Control.Arrow (Arrow (first, second, (&&&)), (>>>))
import Control.Monad (forM, join, unless, void, when, (>=>))
import Control.Monad.Extra (whenM)
import Core.Term as T
  ( Argument (Argument),
    InductiveType (..),
    Pattern (..),
    Term (..),
    type',
  )
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
import Debug.Trace
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
      Local j -> if i > lower then Local (i + j) else Local j
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
  Free type' j -> Free (substMV new i type') j
  Ap l r -> substMV new i l `Ap` substMV new i r
  Lam arg body -> Lam (substMV new i arg) (substMV (raise 1 new) i body)
  Pi arg body -> Pi (substMV new i arg) (substMV (raise 1 new) i body)
  _ -> t

-- | Substitute a term for all free variable with a given identifier.
substFV :: Term -> Id -> Term -> Term
substFV new i t = case t of
  Free _ j | i == j -> new
  Ap l r -> substFV new i l `Ap` substFV new i r
  Lam arg body -> Lam (substFV new i arg) (substFV (raise 1 new) i body)
  Pi arg body -> Pi (substFV new i arg) (substFV (raise 1 new) i body)
  _ -> t

-- | Gather all the metavariables in a term into a set.
metavars :: Term -> S.Set Id
metavars t = case t of
  Meta j -> S.singleton j
  Ap l r -> metavars l <> metavars r
  Lam arg body -> metavars arg <> metavars body
  Pi arg body -> metavars arg <> metavars body
  _ -> S.empty

-- | Returns @True@ if a term has no freeh variables and is therefore a
-- valid candidate for a solution to a metavariable.
isClosed :: Term -> Bool
isClosed t =
  case t of
    Free {} -> False
    Ap l r -> isClosed l && isClosed r
    Lam arg body -> isClosed arg && isClosed body
    Pi arg body -> isClosed arg && isClosed body
    Case x _ alts -> isClosed x && all (isClosed . snd) alts
    _ -> True

introFree :: Members Effects r => Term -> Sem r Term
introFree type' = Free type' <$> gen

resolveConstraint :: Members Effects r => Constraint -> Sem r ()
resolveConstraint x = modify (\state@UnifyState {constraints} -> state {constraints = S.delete x constraints})

occurs :: Term -> Term -> Bool
occurs x = go
  where
    go t | t == x = True
    go t = case t of
      Ap l r -> go l || go r
      Lam arg body -> go arg || go body
      Pi arg body -> go arg || go body
      _ -> False

emit :: Members Effects r => Constraint -> Sem r ()
emit x = do
  state@UnifyState {metas, constraints, solutions} <- get
  let emitSolutions :: Members Effects r => Id -> Term -> Sem r ()
      emitSolutions k v = do
        put
          state
            { metas = substMV v k <$> metas,
              constraints =
                S.map
                  ( \case
                      Equal t1 t2 -> Equal (substMV v k t1) (substMV v k t2)
                      TypeOf t1 t2 -> TypeOf (substMV v k t1) (substMV v k t2)
                  )
                  constraints,
              solutions = M.insert k v (substMV v k <$> solutions)
            }
      shouldBeFree :: Term -> Maybe (Term, Id)
      shouldBeFree (Free type' i) = Just (type', i)
      shouldBeFree _ = Nothing
      freevars :: Term -> [Id]
      freevars t = case t of
        Free _ i -> [i]
        Ap l r -> freevars l <> freevars r
        Lam arg body -> freevars arg <> freevars body
        Pi arg body -> freevars arg <> freevars body
        Case x _ branches -> undefined
        _ -> []
      -- pattern unification
      solve :: Term -> Term -> Maybe (Id, Term)
      solve x y
        | (m@(Meta i), args) <- peelApTelescope x,
          not $ occurs m y,
          Just frees <- traverse shouldBeFree args,
          let frees' = S.fromList (snd <$> frees),
          length frees == length frees',
          all (`S.member` frees') (freevars y),
          -- TODO: check if there are no other free vars in term
          Just argTypes <-
            sequenceA $
              ( \(substs, (y, _)) ->
                  if all (`S.member` S.fromList (snd <$> substs)) (freevars y)
                    then Just $ foldr (uncurry $ substFV . Local) y $ zip [0 ..] $ snd <$> reverse substs
                    else Nothing
              )
                <$> withPrevious frees,
          let body = foldr (uncurry $ substFV . Local) y $ zip [0 ..] $ snd <$> reverse frees =
          pure (i, foldr T.Lam body argTypes)
        where
          withPrevious :: [a] -> [([a], a)]
          withPrevious = go []
            where
              go _ [] = []
              go ys (x : xs) = (ys, x) : go (x : ys) xs
      solve x y = Nothing
  case x of
    Equal x y | x == y -> pure ()
    Equal x y | Just (i, v) <- solve x y -> emitSolutions i v
    Equal y x | Just (i, v) <- solve x y -> emitSolutions i v
    Equal y@(Meta i) x | isClosed x && not (occurs y x) ->
      case M.lookup i solutions of
        Just y -> emit $ x ?= y
        Nothing -> emitSolutions i x
    Equal x y@(Meta i) | isClosed x && not (occurs y x) ->
      case M.lookup i solutions of
        Just y -> emit $ x ?= y
        Nothing -> emitSolutions i x
    TypeOf (Meta i) x ->
      case M.lookup i metas of
        Just y -> emit $ x ?= y
        Nothing -> put state {metas = M.insert i x metas}
    x -> modify (\state@UnifyState {constraints} -> state {constraints = S.insert x constraints})

-- | Implement reduction for the language. Given a term, normalize it.
-- This boils down mainly to applying lambdas to their arguments and all
-- the appropriate congruence rules.
reduce :: GlobalContext -> Bool -> Term -> Term
reduce globals unfold = go
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
            let Just (_, body) = find (\(Constructor name', _) -> name' == name constructor) branches
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

data Constraint = Equal Term Term | TypeOf Term Term deriving (Eq, Ord)

infix 2 ?=

(?=) :: Term -> Term -> Constraint
(?=) = Equal

infix 2 ?:

(?:) :: Term -> Term -> Constraint
(?:) = TypeOf

instance Pretty Constraint where
  pretty (Equal x y) = pretty (show x) <+> pretty "=" <+> pretty (show y)
  pretty (TypeOf x y) = pretty (show x) <+> pretty ":" <+> pretty (show y)

instance Show Constraint where
  show = renderString . layoutPretty defaultLayoutOptions . pretty

typeOf :: Members Effects r => Term -> Sem r Term
typeOf t = do
  globals <- ask
  state@UnifyState {metas, constraints} <- get
  case t of
    Local i -> error "impossible"
    Free type' _ -> pure type'
    Meta i ->
      maybe
        ( do
            meta <- Meta <$> gen
            emit $ t ?: meta
            pure meta
        )
        pure
        $ M.lookup i metas
    Global i ->
      maybe
        (error "impossible")
        (pure . C.type')
        $ M.lookup i globals
    Type -> pure Type
    Ap l r -> do
      lType <- typeOf l
      traceShowM ("ap", t, l)
      if
          | Pi from to <- lType -> do
            emit $ r ?: from
            pure (subst r 0 to)
          | (Meta _, _) <- peelApTelescope lType -> do
            argMeta <- Meta <$> gen
            emit $ argMeta ?: Type
            bodyMeta <- Meta <$> gen
            emit $ bodyMeta ?: Type

            emit $ lType ?= Pi argMeta bodyMeta
            emit $ r ?: argMeta
            pure bodyMeta
          | otherwise -> throw ApplyToNonFunction
    Lam arg body -> do
      emit $ arg ?: Type
      free <- introFree arg
      bodyType <- typeOf (subst free 0 body)
      emit $ bodyType ?: Type
      let Free _ k = free
      pure $ Pi arg (substFV (Local 0) k bodyType)
    Pi from to -> do
      free <- introFree from
      emit $ from ?: Type
      emit $ subst free 0 to ?: Type
      pure Type
    Case x (Just ind) cases -> do
      xType <- typeOf x
      let InductiveType {qname = indName, params, indices, variants} = ind
          QName {namespace} = indName
      -- TODO: is reduce necessary?
      let y = reduce globals True xType
      (spine, cs'') <- case peelApTelescope y of
        (Global name, spine)
          | name == indName -> pure (spine, mempty)
          | otherwise ->
            throw InvalidCase
        _ -> do
          paramMetas <- forM params (const $ Meta <$> gen)
          indexMetas <- forM indices (const $ Meta <$> gen)
          let spine = paramMetas <> indexMetas
          pure (spine, S.singleton (xType ?= applyApTelescope (Global indName) spine))
      mapM_ emit (toList cs'')
      toTypes <-
        forM
          cases
          ( \(Constructor name, body) -> do
              let Just (_, (args, _)) = find (\(name', _) -> name' == name) variants
              let params' = zip (reverse (take (length params) spine)) [0 ..]
              let argTypes =
                    ( \(i, arg) ->
                        foldr (uncurry subst) (T.type' arg) (second (+ i) <$> params')
                    )
                      <$> zip [0 ..] args
              frees <- forM argTypes introFree
              let body' =
                    foldr
                      -- (\(i, v) -> subst (Free (level + length args + length params) v) i)
                      (\(i, v) -> subst v i)
                      body
                      (zip [0 ..] (reverse frees))
              typeOf body'
          )
      let (toType : toTypes') = toTypes
      forM_ toTypes' $ emit . (toType ?=)
      pure toType
    Case x _ cases -> error "not implemented"

-- | Given a constraint, produce a collection of equivalent but
-- simpler constraints. Any solution for the returned set of
-- constraints should be a solution for the original constraint.
simplify :: Members Effects r => Constraint -> Sem r ()
simplify e = resolveConstraint e *> simplify' e
  where
    simplify' :: Members Effects r => Constraint -> Sem r ()
    simplify' e@(TypeOf (Lam argType1 type') (Pi argType2 bodyType)) = do
      globals <- ask @GlobalContext
      emit $ argType1 ?= argType2
      free <- introFree argType1
      emit $ subst free 0 type' ?: subst free 0 bodyType
    simplify' e@(TypeOf t1 t2) = do
      globals <- ask @GlobalContext
      type' <- typeOf t1
      emit $ type' ?= t2
    simplify' e@(Equal t1 t2)
      | t1 == t2 && S.null (metavars t1) = void $ resolveConstraint e
      | otherwise = do
        globals <- ask
        let irreducible Free {} = True
            irreducible Type = True
            irreducible (Global qname) =
              case M.lookup qname globals of
                Just Definition {} -> False
                Just _ -> True
                Nothing -> undefined
            irreducible _ = False
        let t1' = reduce globals True t1
        let t2' = reduce globals True t2
        if
            | t1' /= t1 -> simplify' (t1' ?= t2)
            | t2' /= t2 -> simplify' (t1 ?= t2')
            | (x, spine1) <- peelApTelescope t1,
              (y, spine2) <- peelApTelescope t2,
              irreducible x && irreducible y -> do
              if x == y && length spine1 == length spine2
                then do
                  mapM_ simplify' (zipWith (?=) spine1 spine2)
                else throw $ CannotUnify t1 t2
            | Lam arg1 body1 <- t1,
              Lam arg2 body2 <- t2 -> do
              free <- introFree arg1
              mapM_
                emit
                [ subst free 0 body1 ?= subst free 0 body2,
                  arg1 ?= arg2
                ]
            | Pi arg1 body1 <- t1,
              Pi arg2 body2 <- t2 -> do
              free <- introFree arg1
              mapM_
                emit
                [ subst free 0 body1 ?= subst free 0 body2,
                  arg1 ?= arg2
                ]
            | otherwise -> do
              if isStuck t1 || isStuck t2
                then emit $ t1 ?= t2
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
data UnifyState = UnifyState
  { metas :: M.Map Id Term,
    constraints :: S.Set Constraint,
    solutions :: M.Map Id Term
  }
  deriving (Eq)

instance Show UnifyState where
  show = renderString . layoutPretty defaultLayoutOptions . pretty

instance Pretty UnifyState where
  pretty UnifyState {metas, constraints, solutions} =
    unless
      (null metas)
      ( pretty "metas:"
          <> line
          <> vsep ((\(k, v) -> indent 2 $ pretty k <> pretty "? : " <> pretty (show v)) <$> assocs metas)
          <> line
      )
      <> unless
        (null constraints)
        ( pretty
            "constraints:"
            <> line
            <> vsep (indent 2 . pretty <$> S.toList constraints)
            <> line
        )
      <> unless
        (null solutions)
        ( pretty "solutions:"
            <> line
            <> vsep ((\(k, v) -> indent 2 $ pretty k <> pretty "? = " <> pretty (show v)) <$> assocs solutions)
        )
    where
      unless p m
        | p = mempty
        | otherwise = m

unify :: Members Effects r => S.Set Constraint -> Sem r (Subst, S.Set Constraint)
unify cs = do
  modify \state -> state {constraints = cs}
  unify'
  (solutions &&& constraints) <$> get

unify' :: Members Effects r => Sem r ()
unify' = do
  oldState@UnifyState {constraints} <- get
  fold <$> forM (toList constraints) simplify
  state <- get
  unless (oldState == state) unify'

unifyAll :: Members Effects r => S.Set Constraint -> Sem r (Term -> Term)
unifyAll constraints = do
  (subst, flexflex) <- unify constraints
  if null flexflex
    then pure $ manySubst subst
    else throw UnresolvedMeta

initialState :: UnifyState
initialState =
  UnifyState
    { metas = M.empty,
      constraints = S.empty,
      solutions = M.empty
    }

runUnifyM :: GlobalContext -> UnifyState -> Sem (State UnifyState : Reader GlobalContext : Gen : r) a -> Sem r a
runUnifyM globals state =
  runGen
    . runReader globals
    . evalState state
