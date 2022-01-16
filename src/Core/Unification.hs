module Core.Unification
  ( Term (..),
    raise,
    subst,
    substMV,
    manySubst,
    substFV,
    UnifyM (..),
    Constraint (..),
    Subst (..),
    unify,
    runUnifyM,
    driver,
    Context (..),
    peelApTelescope,
    applyApTelescope,
    reduce,
  )
where

import Common
import Context (GlobalContext, Inhabitant (..))
import Control.Monad
import Control.Monad.Gen
import Control.Monad.Logic
import Control.Monad.Trans
import Core.Term
  ( InductiveType (..),
    Pattern (..),
    Term (..),
  )
import Data.Foldable
import qualified Data.Map.Strict as M
import Data.Maybe
import Data.Monoid hiding (Ap)
import qualified Data.Set as S

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
substMV new i t = case t of
  Meta _ j | i == j -> new
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
  Meta _ j -> S.singleton j
  Ap l r -> metavars l <> metavars r
  Lam arg body -> metavars arg <> metavars body
  Pi arg body -> metavars arg <> metavars body
  _ -> S.empty

-- | Returns @True@ if a term has no free variables and is therefore a
-- valid candidate for a solution to a metavariable.
isClosed :: Level -> Term -> Bool
isClosed level t = case t of
  Free l i
    | l >= level -> False
  Ap l r -> isClosed' l && isClosed' r
  Lam arg body -> isClosed' arg && isClosed (level + 1) body
  Pi arg body -> isClosed' arg && isClosed (level + 1) body
  Case x _ alts -> isClosed' x && all (isClosed' . snd) alts
  _ -> True
  where
    isClosed' = isClosed level

-- | Implement reduction for the language. Given a term, normalize it.
-- This boils down mainly to applying lambdas to their arguments and all
-- the appropriate congruence rules.
reduce :: Context -> Term -> Term
reduce cxt@Context {globals} = \case
  Ap l r -> case reduce' l of
    Lam arg body -> reduce' (subst r 0 body)
    l' -> Ap l' (reduce' r)
  Lam arg body -> Lam (reduce' arg) (reduce' body)
  Pi arg body -> Pi (reduce' arg) (reduce' body)
  x@(Global qname) ->
    maybe
      (error "reduce: Global")
      ( \case
          Definition {value} -> reduce' value
          _ -> x
      )
      $ M.lookup qname globals
  x -> x
  where
    reduce' = reduce cxt

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

type UnifyM = LogicT (Gen Id)

type Constraint = (Term, Term, Level)

-- | Given a constraint, produce a collection of equivalent but
-- simpler constraints. Any solution for the returned set of
-- constraints should be a solution for the original constraint.
simplify :: Context -> Constraint -> UnifyM (S.Set Constraint)
simplify cxt@Context {globals} (t1, t2, level)
  | t1 == t2 && S.null (metavars t1) = pure S.empty
  | reduce cxt t1 /= t1 = simplify' (reduce cxt t1, t2, level)
  | reduce cxt t2 /= t2 = simplify' (t1, reduce cxt t2, level)
  | (x, cxt) <- peelApTelescope t1,
    (y, cxt') <- peelApTelescope t2,
    irreducible x && irreducible y = do
    guard (x == y && length cxt == length cxt')
    fold <$> mapM simplify' (zipWith (,,level) cxt cxt')
  | Lam arg1 body1 <- t1,
    Lam arg2 body2 <- t2 = do
    v <- Free level <$> lift gen
    pure $
      S.fromList
        [ (subst v 0 body1, subst v 0 body2, level + 1),
          (arg1, arg2, level)
        ]
  | Pi arg1 body1 <- t1,
    Pi arg2 body2 <- t2 = do
    v <- Free level <$> lift gen
    pure $
      S.fromList
        [ (subst v 0 body1, subst v 0 body2, level + 1),
          (arg1, arg2, level)
        ]
  | otherwise =
    if isStuck t1 || isStuck t2
      then pure $ S.singleton (t1, t2, level)
      else mzero
  where
    irreducible (Free _ _) = True
    irreducible Type = True
    irreducible (Global qname) =
      case M.lookup qname globals of
        Just Definition {} -> False
        Just _ -> True
        Nothing -> undefined
    irreducible _ = False
    simplify' = simplify cxt

type Subst = M.Map Id Term

-- | Generate all possible solutions to flex-rigid equations as an
-- infinite list of computations producing finite lists.
tryFlexRigid :: Constraint -> [UnifyM [Subst]]
tryFlexRigid (t1, t2, _)
  | Meta level i <- t1,
    (stuckTerm, cxt2) <- peelApTelescope t2,
    not (i `S.member` metavars t2) =
    [pure [M.singleton i t2] | isClosed level t2]
  -- proj (length cxt1) i stuckTerm 0
  | Meta level i <- t2,
    (stuckTerm, cxt2) <- peelApTelescope t1,
    not (i `S.member` metavars t1) =
    [pure [M.singleton i t1 | isClosed level t1]]
  | otherwise = []

-- | The reflexive transitive closure of @simplify@
repeatedlySimplify :: Context -> S.Set Constraint -> UnifyM (S.Set Constraint)
repeatedlySimplify cxt cs = do
  cs' <- fold <$> traverse (simplify cxt) (S.toList cs)
  if cs' == cs then pure cs else repeatedlySimplify cxt cs'

manySubst :: Subst -> Term -> Term
manySubst s t = M.foldrWithKey (flip substMV) t s

(<+>) :: Subst -> Subst -> Subst
s1 <+> s2 | not (M.null (M.intersection s1 s2)) = error "Impossible"
s1 <+> s2 = M.union (manySubst s1 <$> s2) s1

-- | The top level function, given a substitution and a set of
-- constraints, produce a solution substution and the resulting set of
-- flex-flex equations.
data Context = Context {metas :: Subst, globals :: GlobalContext} deriving (Show)

unify :: Context -> S.Set Constraint -> UnifyM (Subst, S.Set Constraint)
unify cxt@Context {metas = s} cs = do
  let cs' = applySubst s cs
  cs'' <- repeatedlySimplify cxt cs'
  let (flexflexes, flexrigids) = S.partition flexflex cs''
  if S.null flexrigids
    then pure (s, flexflexes)
    else do
      let psubsts = tryFlexRigid (S.findMax flexrigids)
      trySubsts psubsts (flexrigids <> flexflexes)
  where
    applySubst s = S.map (\(t1, t2, level) -> (manySubst s t1, manySubst s t2, level))
    flexflex (t1, t2, _) = isStuck t1 && isStuck t2
    trySubsts [] cs = mzero
    trySubsts (mss : psubsts) cs = do
      ss <- mss
      let these = foldr interleave mzero [unify cxt {metas = newS <+> s} cs | newS <- ss]
      let those = trySubsts psubsts cs
      these `interleave` those

runUnifyM :: UnifyM a -> [a]
runUnifyM = runGenFrom 100 . observeAllT

-- | Solve a constraint and return the remaining flex-flex constraints
-- and the substitution for it.
driver :: Constraint -> Maybe (Subst, S.Set Constraint)
driver = listToMaybe . runUnifyM . unify Context {metas = M.empty} . S.singleton
