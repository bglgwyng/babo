module Context where

import Common
import Core.Term as T
import Data.List.NonEmpty
import Data.Map

type Argument = (NonEmpty LocalName, Maybe Term)

data Inhabitant = 
  Definition {args :: [(LocalName, Plicity)], type' :: T.Term, value :: T.Term}
  | Declaration {args :: [(LocalName, Plicity)], type' :: T.Term }
  | TypeConstructor {args :: [(LocalName, Plicity)], type' :: T.Term, ind :: InductiveType }
  | DataConstructor {args :: [(LocalName, Plicity)], type' :: T.Term, ind :: InductiveType }
  deriving (Show)

-- typeOfDefinition :: Definition -> T.Term
-- typeOfDefinition x = Prelude.foldr T.Pi (Context.type' x) (T.type' <$> args x)

-- valueOfDefinition :: Definition -> T.Term
-- valueOfDefinition x = Prelude.foldr T.Lam (Context.value x) (T.type' <$> args x)

type GlobalContext = Map QName Inhabitant

type LocalContext = [LocalName]
