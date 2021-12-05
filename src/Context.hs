module Context where

import Common
import Core.Term as T
import Data.Map

data Inhabitant
  = TypeConstructor T.Term
  | DataConstructor T.Term
  | Declaration T.Term
  | Definition T.Term T.Term
  deriving (Show)

type GlobalContext = Map Name Inhabitant

type LocalContext = [LocalName]
