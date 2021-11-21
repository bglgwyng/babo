module Core.Term where

import Common (Name)
import Data.List.NonEmpty (NonEmpty)
import Data.List.NonEmpty.Extra (NonEmpty)
import GHC.Exts (Any)

type Id = Int

type Index = Int

data Term
  = FreeVar Id
  | GlobalVar Name
  | LocalVar Index
  | MetaVar Id
  | Uni
  | Ap Term Term
  | Lam Term
  | Pi Term Term
  deriving (Eq, Show, Ord)

-- data Data
--   = Application' String [Data]
--   | Literal' (Either String Int)
--   | Null

-- data Abstraction = Abstraction
--   { body :: Term,
--     binderType :: Term
--   }

-- data Term
--   = GlobalName String
--   | LocalVariable Int
--   | Application Term (NonEmpty Term)
--   | Pi Abstraction
--   | Lambda Abstraction
--   | LambdaCase
--       { cases :: [(String, Term)],
--         otherwise :: Maybe Term
--       }
--   | Literal Any
--   | Type Int
--   | Data
--       { value :: Data,
--         type' :: (Maybe Term)
--       }

-- type Context = [(String, Term, Maybe Term)]
