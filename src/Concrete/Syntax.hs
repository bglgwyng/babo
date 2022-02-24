module Concrete.Syntax (module Concrete.Literal, module Concrete.Pattern, module Concrete.Syntax) where

import Common
import Control.Arrow
import Data.Function
import Data.Functor
import Data.List
import Data.List.NonEmpty (NonEmpty, toList)
import GHC.Generics hiding (Constructor)
import GHC.IOArray (unsafeWriteIOArray)
import GHC.OverloadedLabels (IsLabel (fromLabel))
import Prettyprinter (pretty)
import Prettyprinter.Render.String (renderString)
import Prettyprinter.Render.Text (putDoc, renderLazy)
import Concrete.Literal
import Concrete.Pattern (Pattern)

newtype Annotation
  = Annotation Expression

type Branch = ([Pattern], Expression)

type Disk = (Maybe LocalName, Expression)

data Expression
  = Application Expression (NonEmpty Disk)
  | Identifier QName
  | ForAll (NonEmpty LocalName) Expression Expression
  | Arrow Expression Expression
  | Let LocalName Expression Expression
  | Case [Expression] [Branch]
  | Lambda (NonEmpty Argument) Expression
  | LambdaCase [Argument] [Branch]
  | Infix Expression QName Expression
  | Type
  | Tuple [Expression]
  | List [Expression]
  | Literal Literal
  | Parenthesized Expression
  | Meta

-- TODO: Better name
data ImportRule
  = Unqualified
  | UnqualifiedOnly [(String, ImportRule)]
  | Qualified String

type Argument = (NonEmpty LocalName, Maybe Expression, [Annotation])

data Variant = Variant
  { annotatoins :: [Annotation],
    name :: LocalName,
    args :: [Argument],
    maybeType :: Maybe Expression
  }

data TopLevelStatement
  = DataDeclaration
      { name :: String,
        args :: [Argument],
        maybeType :: Maybe Expression,
        variants :: [Variant],
        annotations :: [Annotation]
      }
  | Definition
      { name :: String,
        args :: [Argument],
        maybeType :: Maybe Expression,
        value :: Expression,
        annotations :: [Annotation]
      }
  | Declaration
      { name :: String,
        args :: [Argument],
        type' :: Expression,
        annotations :: [Annotation]
      }
  | Import
      { url :: String,
        rule :: ImportRule,
        annotations :: [Annotation]
      }
  | Eval Expression
  | TypeOf Expression
  | CheckUnify Expression Expression
  | CheckTypeOf Expression Expression

newtype Source = Source {statements :: [TopLevelStatement]}