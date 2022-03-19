module Core.Constraint where

import Common
import Core.Term (Term)
import Prettyprinter (Doc, Pretty (pretty), defaultLayoutOptions, layoutPretty, (<+>))
import Prettyprinter.Render.Text (renderLazy, renderStrict)

type Context = [Term]

data Constraint = Constraint Context Constraint' deriving (Eq, Ord)

data Constraint' = Equal Term Term | HasType Term Term deriving (Eq, Ord)

infix 1 |-

(|-) :: Context -> Constraint' -> Constraint
(|-) = Constraint

infix 2 ?=

(?=) :: Term -> Term -> Constraint'
(?=) = Equal

infix 2 ?:

(?:) :: Term -> Term -> Constraint'
(?:) = HasType

instance Pretty Constraint' where
  pretty (Equal x y) = pretty (tshow x) <+> "=" <+> pretty (tshow y)
  pretty (HasType x y) = pretty (tshow x) <+> ":" <+> pretty (tshow y)

instance Pretty Constraint where
  pretty (Constraint cxt x) = pretty (tshow $ reverse cxt) <+> "|-" <+> pretty x

instance Show Constraint where
  show = textToString . renderStrict . layoutPretty defaultLayoutOptions . pretty
