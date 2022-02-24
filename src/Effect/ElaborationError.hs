module Effect.ElaborationError where

import Common (QName (..))
import Core.Constraint (Constraint)
import qualified Core.Term as T
import Core.UnifyState (UnifyState)

data ElaborationError
  = NameNotFound QName
  | ConstructorNotFound QName
  | InvalidPatterns
  | ApplyToNonFunction
  | InvalidCase
  | CannotUnify T.Term T.Term
  | UnresolvedConstraints UnifyState
  deriving (Show)
