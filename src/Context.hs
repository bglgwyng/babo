module Context where

import Common
import Core.Term as T
import Data.Map

data Inhabitant
  = TypeConstructor {type' :: T.Term}
  | DataConstructor {type' :: T.Term}
  | Declaration {type' :: T.Term}
  | Definition {type' :: T.Term, value :: T.Term}
  deriving (Show)

type GlobalContext = Map QName Inhabitant

type LocalContext = [LocalName]
