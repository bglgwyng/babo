module Context where

import BasicPrelude
import Common
import Core.Term as T
import Data.List.NonEmpty
import Data.Map

type Argument = (NonEmpty LocalName, Maybe Term)

data Inhabitant
  = Definition {args :: [(LocalName, Plicity)], type' :: T.Term, value :: T.Term}
  | Declaration {args :: [(LocalName, Plicity)], type' :: T.Term}
  | TypeConstructor {args :: [(LocalName, Plicity)], type' :: T.Term, ind :: InductiveType}
  | DataConstructor {args :: [(LocalName, Plicity)], type' :: T.Term, ind :: InductiveType}
  deriving (Show)

type GlobalContext = Map QName Inhabitant

type LocalContext = [LocalName]
