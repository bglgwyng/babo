{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}

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
  )
where

import Common
import Control.Monad
import Control.Monad.Gen
import Control.Monad.Logic
import Control.Monad.Trans
import Core.Term
import Data.Foldable
import qualified Data.Map.Strict as M
import Data.Maybe
import Data.Monoid hiding (Ap)
import qualified Data.Set as S
import Debug.Trace (traceShowM)

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
      Lam tp body -> Lam (go lower i tp) (go (lower + 1) i body)
      Pi tp body -> Pi (go lower i tp) (go (lower + 1) i body)
      _ -> t

-- | Substitute a term for the de Bruijn variable @i@.
subst :: Term -> Int -> Term -> Term
subst new i t = case t of
  Local j -> case compare j i of
    LT -> Local j
    EQ -> new
    GT -> Local (j - 1)
  Ap l r -> subst new i l `Ap` subst new i r
  Lam tp body -> Lam (subst new i tp) (subst (raise 1 new) (i + 1) body)
  Pi tp body -> Pi (subst new i tp) (subst (raise 1 new) (i + 1) body)
  Case x (Just inductive) branches ->
    Case (subst new i x) (Just inductive) $
      ( \case
          (Constructor qname, body) ->
            let Inductive {variants} = inductive
                Just (_, argument, _) = find (\(qname', _, _) -> qname == qname') variants
             in -- Just
                ( Constructor qname,
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
  Meta j -> if i == j then new else Meta j
  Ap l r -> substMV new i l `Ap` substMV new i r
  Lam tp body -> Lam (substMV new i tp) (substMV (raise 1 new) i body)
  Pi tp body -> Pi (substMV new i tp) (substMV (raise 1 new) i body)
  _ -> t

-- | Substitute a term for all free variable with a given identifier.
substFV :: Term -> Id -> Term -> Term
substFV new i t = case t of
  Free j -> if i == j then new else Free j
  Ap l r -> substFV new i l `Ap` substFV new i r
  Lam tp body -> Lam (substFV new i tp) (substFV (raise 1 new) i body)
  Pi tp body -> Pi (substFV new i tp) (substFV (raise 1 new) i body)
  _ -> t

-- | Gather all the metavariables in a term into a set.
metavars :: Term -> S.Set Id
metavars t = case t of
  Meta j -> S.singleton j
  Ap l r -> metavars l <> metavars r
  Lam tp body -> metavars tp <> metavars body
  Pi tp body -> metavars tp <> metavars body
  _ -> S.empty

-- | Returns @True@ if a term has no free variables and is therefore a
-- valid candidate for a solution to a metavariable.
isClosed :: Term -> Bool
isClosed t = case t of
  Free i -> False
  Local i -> True
  Global _ -> True
  Meta j -> True
  Type -> True
  Ap l r -> isClosed l && isClosed r
  Lam tp body -> isClosed tp && isClosed body
  Pi tp body -> isClosed tp && isClosed body
  Case x _ alts -> isClosed x && all (isClosed . snd) alts

-- | Implement reduction for the language. Given a term, normalize it.
-- This boils down mainly to applying lambdas to their arguments and all
-- the appropriate congruence rules.
reduce :: Term -> Term
reduce = \case
  Ap l r -> case reduce l of
    Lam tp body -> reduce (subst r 0 body)
    l' -> Ap l' (reduce r)
  Lam tp body -> Lam (reduce tp) (reduce body)
  Pi tp body -> Pi (reduce tp) (reduce body)
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

type UnifyM = LogicT (Gen Id)

type Constraint = (Term, Term)

-- | Given a constraint, produce a collection of equivalent but
-- simpler constraints. Any solution for the returned set of
-- constraints should be a solution for the original constraint.
simplify :: Constraint -> UnifyM (S.Set Constraint)
simplify (t1, t2)
  | t1 == t2 && S.null (metavars t1) = return S.empty
  | reduce t1 /= t1 = simplify (reduce t1, t2)
  | reduce t2 /= t2 = simplify (t1, reduce t2)
  | (Free i, cxt) <- peelApTelescope t1,
    (Free j, cxt') <- peelApTelescope t2 = do
    guard (i == j && length cxt == length cxt')
    fold <$> mapM simplify (zip cxt cxt')
  | (Global i, cxt) <- peelApTelescope t1,
    (Global j, cxt') <- peelApTelescope t2 = do
    guard (i == j && length cxt == length cxt')
    fold <$> mapM simplify (zip cxt cxt')
  | Lam tp1 body1 <- t1,
    Lam tp2 body2 <- t2 = do
    v <- Free <$> lift gen
    return $
      S.fromList
        [ (subst v 0 body1, subst v 0 body2),
          (tp1, tp2)
        ]
  | Pi tp1 body1 <- t1,
    Pi tp2 body2 <- t2 = do
    v <- Free <$> lift gen
    return $
      S.fromList
        [ (subst v 0 body1, subst v 0 body2),
          (tp1, tp2)
        ]
  | otherwise =
    if isStuck t1 || isStuck t2
      then return $ S.singleton (t1, t2)
      else do
        traceShowM
          "hi"
        mzero

type Subst = M.Map Id Term

-- | Generate all possible solutions to flex-rigid equations as an
-- infinite list of computations producing finite lists.
tryFlexRigid :: Constraint -> [UnifyM [Subst]]
tryFlexRigid (t1, t2)
  | Meta i <- t1,
    (stuckTerm, cxt2) <- peelApTelescope t2,
    not (i `S.member` metavars t2) =
    [pure [M.singleton i t2] | isClosed t2]
  -- proj (length cxt1) i stuckTerm 0
  | Meta i <- t2,
    (stuckTerm, cxt2) <- peelApTelescope t1,
    not (i `S.member` metavars t1) =
    [pure [M.singleton i t1 | isClosed t1]]
  | otherwise = []

-- | The reflexive transitive closure of @simplify@
repeatedlySimplify :: S.Set Constraint -> UnifyM (S.Set Constraint)
repeatedlySimplify cs = do
  cs' <- fold <$> traverse simplify (S.toList cs)
  if cs' == cs then return cs else repeatedlySimplify cs'

manySubst :: Subst -> Term -> Term
manySubst s t = M.foldrWithKey (\mv sol t -> substMV sol mv t) t s

(<+>) :: Subst -> Subst -> Subst
s1 <+> s2 | not (M.null (M.intersection s1 s2)) = error "Impossible"
s1 <+> s2 = M.union (manySubst s1 <$> s2) s1

-- | The top level function, given a substitution and a set of
-- constraints, produce a solution substution and the resulting set of
-- flex-flex equations.
data Context = Context {metas :: Subst, globals :: M.Map String Term}

unify :: Context -> S.Set Constraint -> UnifyM (Subst, S.Set Constraint)
unify ctx@Context {metas = s} cs = do
  let cs' = applySubst s cs
  cs'' <- repeatedlySimplify cs'
  let (flexflexes, flexrigids) = S.partition flexflex cs''
  if S.null flexrigids
    then return (s, flexflexes)
    else do
      let psubsts = tryFlexRigid (S.findMax flexrigids)
      trySubsts psubsts (flexrigids <> flexflexes)
  where
    applySubst s = S.map (\(t1, t2) -> (manySubst s t1, manySubst s t2))
    flexflex (t1, t2) = isStuck t1 && isStuck t2
    trySubsts [] cs = do
      traceShowM ("hhh", cs)
      mzero
    trySubsts (mss : psubsts) cs = do
      ss <- mss
      let these = foldr interleave mzero [unify ctx {metas = newS <+> s} cs | newS <- ss]
      let those = trySubsts psubsts cs
      these `interleave` those

runUnifyM :: UnifyM a -> [a]
runUnifyM = runGenFrom 100 . observeAllT

-- | Solve a constraint and return the remaining flex-flex constraints
-- and the substitution for it.
driver :: Constraint -> Maybe (Subst, S.Set Constraint)
driver = listToMaybe . runUnifyM . unify Context {metas = M.empty} . S.singleton
