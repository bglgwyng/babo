{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Syntax.AST (module Syntax.Literal, module Syntax.Pattern, module Syntax.AST) where

import Common
import Control.Arrow
import Data.Function
import Data.Functor
import Data.List
import Data.List.NonEmpty (NonEmpty, toList)
import GHC.Generics hiding (Constructor)
import GHC.IOArray (unsafeWriteIOArray)
import GHC.OverloadedLabels (IsLabel (fromLabel))
import Prettyprinter.Render.String (renderString)
import Prettyprinter.Render.Text (putDoc)
import Syntax.Literal
import Syntax.Pattern (Pattern)

newtype Annotation
  = Annotation Expression
  deriving (Show)

type Case = (Pattern, Expression)

type Disk = (Maybe LocalName, Expression)

data Expression
  = Application Expression (NonEmpty Disk)
  | Identifier Name
  | ForAll (NonEmpty LocalName) Expression Expression
  | Arrow Expression Expression
  | Let LocalName Expression Expression
  | Case Expression [Case]
  | Lambda (NonEmpty Argument) Expression
  | LambdaCase [Argument] [Case]
  | Infix Expression Name Expression
  | Type
  | Tuple [Expression]
  | List [Expression]
  | Literal Literal
  | Parenthesized Expression
  deriving (Show)

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
  deriving (Show)

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

newtype Source = Source {statements :: [TopLevelStatement]}

instance IsLabel "name" (Variant -> String) where
  fromLabel = name

instance IsLabel "name" (TopLevelStatement -> String) where
  fromLabel = name
