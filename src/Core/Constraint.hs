module Core.Constraint where

import Core.Term (Term)
import Prettyprinter (Pretty (pretty), defaultLayoutOptions, layoutPretty, (<+>))
import Prettyprinter.Render.String (renderString)

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
  pretty (Equal x y) = pretty (show x) <+> pretty "=" <+> pretty (show y)
  pretty (HasType x y) = pretty (show x) <+> pretty ":" <+> pretty (show y)

instance Pretty Constraint where
  pretty (Constraint cxt x) = pretty (show $ reverse cxt) <+> pretty "|-" <+> pretty x

instance Show Constraint where
  show = renderString . layoutPretty defaultLayoutOptions . pretty
