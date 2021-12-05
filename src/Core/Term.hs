module Core.Term where

import Common
import Data.List.NonEmpty (NonEmpty, toList)
import Data.List.NonEmpty.Extra (NonEmpty)
import GHC.Exts (Any)
import GHC.OldList (intercalate)

data Term
  = FreeVar Id
  | GlobalVar Name
  | LocalVar Index
  | MetaVar Id
  | Uni
  | Ap Term Term
  | Lam Term Term
  | Pi Term Term
  deriving (Eq, Ord)

instance Show Term where
  showsPrec _ (FreeVar i) = shows i . showString "$"
  showsPrec _ (GlobalVar xs) = showString $ intercalate "." $ toList xs
  showsPrec _ (LocalVar i) = shows i . showString "!"
  showsPrec _ (MetaVar i) = shows i . showString "?"
  showsPrec _ Uni = showString "Type"
  showsPrec prec (Ap t1 t2) = showParen (prec > 3) $ showsPrec 3 t1 . showString " " . showsPrec 4 t2
  showsPrec prec (Lam t1 t2) = showParen (prec > 0) $ showString "\\_: " . shows t1 . showChar ' ' . shows t2
  showsPrec prec (Pi t1 t2) = showParen (prec > 1) $ showsPrec 2 t1 . showString " -> " . showsPrec 1 t2
