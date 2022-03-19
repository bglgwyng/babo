module Concrete.Pretty where

import Common
import Concrete.Pattern hiding (List, Literal, Tuple, Variable)
import qualified Concrete.Pattern as P
import Concrete.Syntax
import Control.Arrow (Arrow ((***)), (>>>))
import Core.Term (Plicity (Explicit, Implicit))
import Data.Function ((&))
import Data.Functor
import Data.List.NonEmpty (NonEmpty, nonEmpty, toList)
import Polysemy.Law (NonEmptyList (NonEmpty))
import Prettyprinter
  ( Doc,
    Pretty (pretty),
    align,
    defaultLayoutOptions,
    hang,
    hcat,
    indent,
    layoutPretty,
    line,
    punctuate,
    sep,
    vsep,
    (<+>),
  )
import Prettyprinter.Render.String (renderString)

tabSize = 2

indent' :: Doc ann -> Doc ann
indent' = indent tabSize

commaSeparated :: [Doc ann] -> Doc ann
commaSeparated = sep . punctuate ","

instance Pretty QName where
  pretty x = pretty (show x)

instance Pretty Annotation where
  pretty (Annotation value) = "@" <> pretty value

instance Pretty Pattern where
  pretty (P.Variable x) = pretty x
  pretty (Data constructor args) =
    if null args
      then pretty constructor
      else hang 2 (sep (pretty constructor : (prettyArgs <$> args)))
    where
      pretty' x@(Data constructor (_ : _)) =
        if null args
          then pretty x
          else "(" <> pretty x <> ")"
      pretty' x = pretty x
      prettyArgs (Left (P.NamedPattern x as)) = "(" <> pretty x <+> "=" <+> pretty as <> ")"
      -- prettyArgs (Left (P.PunnedImplicit x)) = "(" <> pretty x <> ")"
      prettyArgs (Right x) = pretty x
  pretty (P.Literal x) = pretty x
  pretty (P.Tuple xs) = "( " <> commaSeparated (pretty <$> xs) <> " )"
  pretty (P.List xs) = "[ " <> commaSeparated (pretty <$> xs) <> " ]"
  pretty Wildcard = "_"

prettyBranch :: Branch -> Doc ann
prettyBranch (pattern, expression) =
  sep
    [ commaSeparated $ toList (pretty <$> pattern),
      "->"
        <+> align (pretty expression)
        <> pretty ';'
    ]

instance Pretty Expression where
  pretty (Identifier name) = pretty name
  pretty (Application x xs) = hang tabSize $ pretty x <> "(" <> sep (prettyDisk <$> toList xs) <> ")"
    where
      prettyDisk (Nothing, x) = pretty x
      prettyDisk (Just x, y) = pretty '(' <> pretty x <+> "=" <+> pretty y <> pretty ')'
  pretty (Arrow x y) = sep [pretty x, "->" <+> pretty y]
  pretty Meta = "?"
  pretty (Let name value body) =
    vsep
      [ "let" <+> pretty name <+> "=" <+> pretty value <> ",",
        pretty body
      ]
  pretty (ForAll froms to) =
    "forall" <+> align (commaSeparated (prettyArgument <$> toList froms)) <> "," <+> pretty to
    where
      prettyArgument = uncurry (<>) . (pretty *** (":" <+>) . pretty)
  pretty (Infix x op y) = pretty x <+> pretty op <+> pretty y
  pretty (Tuple xs) = "( " <> align (commaSeparated (pretty <$> xs) <> " )")
  pretty (List xs) = "[ " <> align (commaSeparated (pretty <$> xs) <> " ]")
  pretty (Lambda names x) =
    "\\" <> align (sep [prettyLambdaArguments names <+> "->", pretty x])
  pretty (Case x cases) =
    "case" <+> commaSeparated (pretty <$> x) <+> "of" <+> align (vsep (prettyBranch <$> cases))
  pretty (LambdaCase names cases) =
    "\\"
      <> align
        ( case nonEmpty names of
            Nothing -> mempty
            Just xs -> prettyLambdaArguments xs <> line
        )
      <> "{" <+> align (sep (prettyBranch <$> cases) <+> "}")
  pretty Type = "Type"
  pretty (Literal x) = pretty x
  pretty (Parenthesized x) = "(" <> align (pretty x <> ")")

prettyLambdaArguments :: NonEmpty Argument -> Doc ann
prettyLambdaArguments args = sep $ pretty' <$> toList args
  where
    pretty' :: Argument -> Doc ann
    pretty' (name, Nothing, _) = pretty name
    pretty' (name, Just type', _) = "(" <> pretty name <+> ":" <+> pretty type' <> ")"

prettyArguments :: [ArgumentBlock] -> Doc ann
prettyArguments [] = mempty
prettyArguments xs =
  align $ hcat $ prettyArgumentBlock <$> xs
  where
    prettyArgument :: Argument -> Doc ann
    prettyArgument (name, type', _) =
      pretty name
        <> maybe mempty ((":" <+>) . align . pretty) type'
    prettyArgumentBlock :: ArgumentBlock -> Doc ann
    prettyArgumentBlock (plicity, args) =
      ( case plicity of
          Implicit -> ("{" <>) . (<> "}")
          Explicit -> ("(" <>) . (<> ")")
      )
        $ commaSeparated (prettyArgument <$> args)

instance Pretty TopLevelStatement where
  pretty DataDeclaration {name, args, maybeType, variants, annotations} =
    "data"
      <+> pretty name
        <> prettyArguments args
        <> maybe mempty ((":" <+>) . pretty) maybeType
      <+> "{"
        <> ( if null variants
               then mempty
               else
                 line
                   <> indent' (vsep (prettyVariant <$> variants))
                   <> line
           )
        <> "}"
    where
      prettyVariant :: Variant -> Doc ann
      prettyVariant Variant {name, args, maybeType} =
        pretty name
          <> prettyArguments args
          <> maybe mempty (" :" <+>) (pretty <$> maybeType)
          <> pretty ';'
  pretty Definition {name, args, maybeType, value, annotations} =
    "def"
      <+> align
        ( sep
            [ pretty name
                <> prettyArguments args
                <> maybe mempty (" :" <+>) (pretty <$> maybeType),
              "="
                <+> align (pretty value)
            ]
        )
  pretty Declaration {name, args, type', annotations} =
    "decl"
      <+> align
        ( pretty name
            <> prettyArguments args
            <+> ":"
            <+> align (pretty type')
        )
  pretty Import {url, rule, annotations} = "import" <+> pretty url
  pretty _ = ""

instance Pretty Literal where
  pretty UnitLiteral = "()"
  pretty (StringLiteral s) = pretty $ show s
  pretty IntegerLiteral {negative, integer} = pretty integer
  pretty FloatLiteral {negative, integer, fractional} =
    (if negative then "-" else mempty)
      <> pretty integer
      <> case fractional of
        "" -> mempty
        _ -> "." <> pretty fractional

instance Pretty Source where
  pretty (Source decls) = vsep $ pretty <$> decls

instance Show Expression where
  show = renderString . layoutPretty defaultLayoutOptions . pretty

instance Show Source where
  show = renderString . layoutPretty defaultLayoutOptions . pretty

instance Show Annotation where
  show = renderString . layoutPretty defaultLayoutOptions . pretty