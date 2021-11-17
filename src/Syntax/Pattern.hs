module Syntax.Pattern (Pattern (..)) where

import Common
import Syntax.Literal

data Pattern
  = Data Name [Pattern]
  | Implicit LocalName Pattern
  | PunnedImplicit LocalName
  | Variable LocalName
  | Tuple [Pattern]
  | List [Pattern]
  | Literal Literal
  | Wildcard
