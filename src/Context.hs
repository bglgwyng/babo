module Context where

import Common
import Core.Term as T
import Data.Map

data Inhabitant
  = TypeConstructor {type' :: T.Term, inductive :: T.Inductive}
  | DataConstructor {type' :: T.Term, inductive :: T.Inductive}
  | Declaration {type' :: T.Term}
  | Definition {type' :: T.Term, value :: T.Term}
  deriving (Show)

type GlobalContext = Map QName Inhabitant

type LocalContext = [LocalName]
