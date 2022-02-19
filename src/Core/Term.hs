module Core.Term where

import Common
import Control.Arrow ((>>>))
import Data.List (find, foldl')
import Data.List.NonEmpty (NonEmpty, toList)
import Data.List.NonEmpty.Extra (NonEmpty)
import Data.Map (Map, (!))
import qualified Data.Map as M
import GHC.Exts (Any)
import GHC.OldList (intercalate)
import Syntax.Literal

data Term
  = Global QName
  | Local Index
  | Meta Id
  | Type
  | Ap Term Term
  | Lam Term Term
  | Pi Term Term
  | Case Term (Maybe InductiveType) [(Pattern, Term)]
  deriving (Eq, Ord)

data Pattern
  = Constructor LocalName
  | Literal Literal
  | Self
  deriving (Eq, Ord)

data Plicity = Explicit | Implicit deriving (Show, Eq, Ord)

data Argument = Argument
  { name :: LocalName,
    -- FIXME:
    plicity :: Plicity,
    type' :: Term
  }
  deriving (Show, Eq, Ord)

data InductiveType = InductiveType
  { qname :: QName,
    variants :: [(LocalName, ([Argument], Term))],
    params :: [Argument],
    indices :: [Argument]
  }
  deriving (Eq, Ord)

instance Show InductiveType where
  show InductiveType {qname} = show qname

instance Show Term where
  showsPrec _ (Global x) = shows x
  showsPrec _ (Local i) = showString "!" . shows i
  showsPrec _ (Meta i) = showString "?" . shows i
  showsPrec _ Type = showString "Type"
  showsPrec prec (Ap t1 t2) = showParen (prec > 3) $ showsPrec 3 t1 . showString " " . showsPrec 4 t2
  showsPrec prec (Lam t1 t2) = showParen (prec > 0) $ showString "\\(_: " . shows t1 . showString ") -> " . shows t2
  showsPrec prec (Pi t1 t2) = showParen (prec > 1) $ showsPrec 2 t1 . showString " -> " . showsPrec 1 t2
  showsPrec _ (Case x ind t2) =
    showString "case " . shows x . maybe id ((showString " in " .) . shows) ind
      . showString " { "
      . foldl1 (\x y -> x . showString "; " . y) (showAlt <$> t2)
      . showString " }"
    where
      showAlt :: (Pattern, Term) -> ShowS
      showAlt (p, t) = shows p . showString " -> " . shows t

instance Show Pattern where
  show (Constructor x) = show x
  show x@(Literal _) = show x
  show Self = "_"

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
subst new i = \case
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
  Case _ Nothing _ -> error "not implemented"
  x -> x

occurs :: Term -> Term -> Bool
occurs x = go
  where
    go t | t == x = True
    go t = case t of
      Ap l r -> go l || go r
      Lam arg body -> go arg || go body
      Pi arg body -> go arg || go body
      _ -> False

induct :: (Term -> Term) -> Term -> Term
induct go = \case
  Ap l r -> Ap (go l) (go r)
  Lam arg body -> Lam (go arg) (go body)
  Pi arg body -> Pi (go arg) (go body)
  Case {} -> error "not implemented"
  x -> x

-- | Turn @f a1 a2 a3 a4 ... an@ to @(f, [a1...an])@.
peelApTelescope :: Term -> (Term, [Term])
peelApTelescope t = go t []
  where
    go (Ap f r) rest = go f (r : rest)
    go t rest = (t, rest)

-- | Turn @(f, [a1...an])@ into @f a1 a2 a3 a4 ... an@.
applyApTelescope :: Term -> [Term] -> Term
applyApTelescope = foldl' Ap
