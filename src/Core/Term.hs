module Core.Term where

import Common
import Control.Arrow ((>>>))
import Data.List.NonEmpty (NonEmpty, toList)
import Data.List.NonEmpty.Extra (NonEmpty)
import GHC.Exts (Any)
import GHC.OldList (intercalate)
import Syntax.Literal

data Term
  = Free Id
  | Global QName
  | Local Index
  | Meta Id
  | Type
  | Ap Term Term
  | Lam Term Term
  | Pi Term Term
  | Case Term [(Pattern, Term)]
  deriving (Eq, Ord)

instance Show Term where
  showsPrec _ (Free i) = shows i . showString "$"
  showsPrec _ (Global x) = shows x
  showsPrec _ (Local i) = shows i . showString "!"
  showsPrec _ (Meta i) = shows i . showString "?"
  showsPrec _ Type = showString "Type"
  showsPrec prec (Ap t1 t2) = showParen (prec > 3) $ showsPrec 3 t1 . showString " " . showsPrec 4 t2
  showsPrec prec (Lam t1 t2) = showParen (prec > 0) $ showString "\\_: " . shows t1 . showString " -> " . shows t2
  showsPrec prec (Pi t1 t2) = showParen (prec > 1) $ showsPrec 2 t1 . showString " -> " . showsPrec 1 t2
  showsPrec _ (Case x t2) =
    showString "case " . shows x
      . showString " { "
      . foldl1 (\x y -> x . showString "; " . y) (showAlt <$> t2)
      . showString " }"
    where
      showAlt :: (Pattern, Term) -> ShowS
      showAlt (p, t) = shows p . showString " -> " . shows t

data Pattern
  = Constructor QName
  | Literal Literal
  | Self
  deriving (Eq, Ord)

instance Show Pattern where
  show (Constructor x) = show x
  show x@(Literal _) = show x
  show Self = "_"