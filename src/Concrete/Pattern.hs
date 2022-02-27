module Concrete.Pattern (Pattern (..), NamedPattern (..)) where

import Common
import Concrete.Literal (Literal)
import Data.List (intercalate)

data NamedPattern
  = NamedPattern LocalName Pattern
  deriving (Show)

-- | PunnedImplicit LocalName
data Pattern
  = Data QName [Either NamedPattern Pattern]
  | Variable LocalName
  | Tuple [Pattern]
  | List [Pattern]
  | Literal Literal
  | Wildcard

intercalates :: Foldable f => ShowS -> f ShowS -> ShowS
intercalates sep = foldl1 ((.) . (. sep))

instance Show Pattern where
  showsPrec prec (Data constructor []) = shows constructor
  showsPrec prec (Data constructor ps) =
    showParen (prec > 0) $
      intercalates (showChar ' ') $ shows constructor : (either (showsPrec 1) (showsPrec 1) <$> ps)
  showsPrec _ (Variable x) = showString x
  showsPrec _ (Tuple ps) = showParen True $ intercalates (showChar ',') (shows <$> ps)
  showsPrec _ (List ps) = showChar '[' . intercalates (showChar ',') (shows <$> ps) . showChar ']'
  showsPrec _ (Literal l) = shows l
  showsPrec _ Wildcard = showChar '_'
