module Common where

import Data.List (intercalate)
import Data.List.NonEmpty

type LocalName = String

data QName = QName {namespace :: [String], name :: LocalName} deriving (Eq, Ord)

instance Show QName where
  show QName {namespace = [], name} = name
  show QName {namespace, name} = intercalate "." namespace <> "." <> name

type Id = Int

type Level = Int

type Index = Int