{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}
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
import Prettyprinter.Render.String (renderString)
import Prettyprinter.Render.Text (putDoc)
import Syntax.Literal
import Syntax.Pattern (Pattern)

newtype Annotation
  = Annotation Expression

type LambdaArgument = (NonEmpty NewName, Maybe Expression)

type Case = (NonEmpty Pattern, Expression)

type Disk = (Maybe NewName, Expression)

data Expression
  = Identifier Name
  | Application Expression (NonEmpty Disk)
  | ForAll [NewName] Expression Expression
  | Arrow Expression Expression
  | Let NewName Expression Expression
  | Lambda (NonEmpty LambdaArgument) Expression
  | LambdaCase [LambdaArgument] [Case]
  | Infix Expression Name Expression
  | Tuple [Expression]
  | List [Expression]
  | Literal Literal
  | Parenthesized Expression

-- TODO: Better name
data ImportRule
  = Unqualified
  | UnqualifiedOnly [(String, ImportRule)]
  | Qualified String

type Argument = (NonEmpty NewName, Expression, [Annotation])

type Variant = ([Annotation], String, [Argument], Maybe Expression)

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
