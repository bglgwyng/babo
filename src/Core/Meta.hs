module Core.Meta where

import Common (Id)
import Core.Term (Term)
import qualified Data.Map as M

data Meta = Solved {value :: Term, type' :: Term} | Unsolved {type' :: Term} deriving (Ord, Eq, Show)

type MetaContext = M.Map Id Meta