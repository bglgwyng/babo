module Effect.ElaborationError where

import Common (QName (..))
import qualified Core.Term as T

data ElaborationError
  = NameNotFound QName
  | ConstructorNotFound QName
  | InvalidPatterns
  | ApplyToNonFunction
  | InvalidCase
  | CannotUnify T.Term T.Term
  | UnresolvedMeta
  deriving (Show)
