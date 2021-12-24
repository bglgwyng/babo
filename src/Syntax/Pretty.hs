{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}

module Syntax.Pretty where

import Control.Arrow ((>>>))
import Data.Functor
import Data.List (intercalate)
import Data.List.NonEmpty (NonEmpty, nonEmpty, toList)
import Prettyprinter
  ( Doc,
    Pretty (pretty),
    align,
    hang,
    indent,
    line,
    punctuate,
    sep,
    vsep,
    (<+>),
  )
import Syntax.AST
import Syntax.AST as AST
import Syntax.Grammar hiding (indent)
import Syntax.Pattern hiding (List, Literal, Tuple, Variable)
import qualified Syntax.Pattern as P

tabSize = 2

indent' = indent tabSize

commaSeparated = sep . punctuate (pretty ",")

prettyName = pretty . intercalate "." . toList

instance Pretty Pattern where
  pretty (P.Variable x) = pretty x
  pretty (Data constructor args) =
    if null args
      then prettyName constructor
      else hang 2 (sep (prettyName constructor : (prettyArgs <$> args)))
    where
      pretty' x@(Data constructor (_ : _)) =
        if null args
          then pretty x
          else pretty "(" <> pretty x <> pretty ")"
      pretty' x = pretty x
      prettyArgs (Left (P.Implicit x as)) = pretty "(" <> pretty x <+> pretty "=" <+> pretty as <> pretty ")"
      prettyArgs (Left (P.PunnedImplicit x)) = pretty "(" <> pretty x <> pretty ")"
      prettyArgs (Right x) = pretty x
  pretty (P.Literal x) = pretty x
  pretty (P.Tuple xs) = pretty "( " <> commaSeparated (pretty <$> xs) <> pretty " )"
  pretty (P.List xs) = pretty "[ " <> commaSeparated (pretty <$> xs) <> pretty " ]"
  pretty Wildcard = pretty "_"

instance Pretty Expression where
  pretty (Identifier name) = prettyName name
  pretty (Application x xs) = hang tabSize $ sep $ pretty x : (prettyDisk <$> toList xs)
    where
      prettyDisk (Nothing, x) = pretty x
      prettyDisk (Just x, y) = pretty '(' <> pretty x <+> pretty "=" <+> pretty y <> pretty ')'
  pretty (Arrow x y) = sep [pretty x, pretty "->" <+> pretty y]
  pretty (Let name value body) =
    vsep
      [ pretty "let" <+> pretty name <+> pretty "=" <+> pretty value <> pretty ",",
        pretty body
      ]
  pretty (ForAll names type' y) =
    pretty "forall" <+> align (sep (pretty <$> toList names) <+> pretty ":" <+> pretty type' <> pretty "," <+> pretty y)
  pretty (Infix x op y) = pretty x <+> pretty "." <> prettyName op <+> pretty y
  pretty (Tuple xs) = pretty "( " <> align (commaSeparated (pretty <$> xs) <> pretty " )")
  pretty (List xs) = pretty "[ " <> align (commaSeparated (pretty <$> xs) <> pretty " ]")
  pretty (Lambda names x) =
    pretty "\\" <> align (sep [prettyLambdaArguments names <+> pretty "->", pretty x])
  pretty (Case x cases) =
    pretty "case" <+> pretty x <+> pretty "of" <+> align (vsep (pretty <$> cases))
  pretty (LambdaCase names cases) =
    pretty "\\"
      <> align
        ( case nonEmpty names of
            Nothing -> mempty
            Just xs -> prettyLambdaArguments xs <> line
        )
      <> pretty "{" <+> align (sep (prettyCase <$> cases) <+> pretty "}")
    where
      prettyCase :: Case -> Doc ann
      prettyCase (pattern, expression) =
        sep
          [ pretty pattern,
            pretty "->"
              <+> align (pretty expression)
              <> pretty ';'
          ]
  pretty Type = pretty "Type"
  pretty (Literal x) = pretty x
  pretty (Parenthesized x) = pretty "(" <> align (pretty x <> pretty ")")

prettyLambdaArguments :: NonEmpty AST.Argument -> Doc ann
prettyLambdaArguments args = sep $ pretty' <$> toList args
  where
    pretty' :: AST.Argument -> Doc ann
    pretty' (name, Nothing, _) = sep (pretty <$> toList name)
    pretty' (name, Just type', _) = pretty "(" <> sep (pretty <$> toList name) <+> pretty ":" <+> pretty type' <> pretty ")"

prettyArguments :: [Argument] -> Doc ann
prettyArguments [] = mempty
prettyArguments xs =
  pretty "("
    <> align
      (commaSeparated $ pretty' <$> xs)
    <> pretty ")"
  where
    pretty' :: Argument -> Doc ann
    pretty' (names, type', _) =
      let names' = sep $ pretty <$> toList names
          type'' = pretty type'
       in names' <+> pretty ":" <+> align type''

instance Pretty TopLevelStatement where
  pretty DataDeclaration {name, args, maybeType, variants, annotations} =
    pretty "data"
      <+> pretty name
        <> prettyArguments args
        <> maybe mempty ((pretty " :" <+>) . pretty) maybeType
      <+> pretty "{"
        <> ( if null variants
               then mempty
               else
                 line
                   <> indent' (vsep (prettyVariant <$> variants))
                   <> line
           )
        <> pretty "}"
    where
      prettyVariant :: Variant -> Doc ann
      prettyVariant Variant {name, args, maybeType} =
        pretty name
          <> prettyArguments args
          <> maybe mempty (pretty " :" <+>) (pretty <$> maybeType)
          <> pretty ';'
  pretty Definition {name, args, maybeType, value, annotations} =
    pretty "def"
      <+> align
        ( sep
            [ pretty name
                <> prettyArguments args
                <> maybe mempty (pretty " :" <+>) (pretty <$> maybeType),
              pretty "="
                <+> align (pretty value)
            ]
        )
  pretty Declaration {name, args, type', annotations} =
    pretty "decl"
      <+> align
        ( pretty name
            <> prettyArguments args
            <+> pretty ":"
            <+> align (pretty type')
        )
  pretty Import {url, rule, annotations} = pretty "import" <+> pretty url

instance Pretty Literal where
  pretty UnitLiteral = pretty "()"
  pretty (StringLiteral s) = pretty $ show s
  pretty IntegerLiteral {negative, integer} = pretty integer
  pretty FloatLiteral {negative, integer, fractional} =
    (if negative then pretty "-" else mempty)
      <> pretty integer
      <> case fractional of
        "" -> mempty
        _ -> pretty "." <> pretty fractional

instance Pretty Source where
  pretty (Source decls) = vsep $ decls <&> pretty
