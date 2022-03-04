module Common where

import BasicPrelude
import Prettyprinter (Doc, Pretty (pretty))

type LocalName = Text

data QName = QName {namespace :: [Text], name :: LocalName} deriving (Eq, Ord)

instance Show QName where
  show QName {namespace = [], name} = "name"
  show QName {namespace, name} = ""

type Id = Int

type Level = Int

type Index = Int

-- FIXME:
ptext :: Text -> Doc ann
ptext = pretty
