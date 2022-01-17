module Effect.ElaborationError where

import Common (QName (..))

data ElaborationError
  = NameNotFound QName
  | ConstructorNotFound QName
  | InvalidPatterns
  | ApplyToNonFunction
  | InvalidCase
  deriving (Show)
