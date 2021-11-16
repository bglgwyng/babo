module Syntax.Pattern (Pattern (..)) where

import Common
import Syntax.Literal

data Pattern
  = Data Name [Pattern]
  | Implicit NewName Pattern
  | PunnedImplicit NewName
  | Variable NewName
  | Tuple [Pattern]
  | List [Pattern]
  | Literal Literal
  | Wildcard
