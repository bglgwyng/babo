module Syntax.Pattern (Pattern (..), Implicit (..)) where

import Common
import Syntax.Literal (Literal)

data Implicit
  = Implicit LocalName Pattern
  | PunnedImplicit LocalName
  deriving (Show)

data Pattern
  = Data QName [Either Implicit Pattern]
  | Variable LocalName
  | Tuple [Pattern]
  | List [Pattern]
  | Literal Literal
  | Wildcard
  deriving (Show)