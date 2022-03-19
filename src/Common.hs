module Common where

import Data.Text (unpack)
import Prettyprinter (Doc, Pretty (pretty))

type LocalName = Text

data QName = QName {namespace :: [Text], name :: LocalName} deriving (Eq, Ord)

instance Show QName where
  show QName {namespace = [], name} = unpack name
  show QName {namespace, name} = error "not implemented"

type Id = Int

type Level = Int

type Index = Int
