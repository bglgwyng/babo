module Concrete.Pretty where

import Common
import Concrete.Pattern hiding (List, Literal, Tuple, Variable)
import qualified Concrete.Pattern as P
import Concrete.Syntax
import Control.Arrow (Arrow ((***)), (>>>))
import Core.Term (Plicity (Explicit, Implicit))
import Data.Function ((&))
import Data.Functor
import Data.List (intercalate)
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
commaSeparated = sep . punctuate (pretty ",")

prettyName = pretty . intercalate "." . toList

instance Pretty QName where
  pretty x = pretty (show x)

instance Pretty Annotation where
  pretty (Annotation value) = pretty "@" <> pretty value

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
          else pretty "(" <> pretty x <> pretty ")"
      pretty' x = pretty x
      prettyArgs (Left (P.NamedPattern x as)) = pretty "(" <> pretty x <+> pretty "=" <+> pretty as <> pretty ")"
      -- prettyArgs (Left (P.PunnedImplicit x)) = pretty "(" <> pretty x <> pretty ")"
      prettyArgs (Right x) = pretty x
  pretty (P.Literal x) = pretty x
  pretty (P.Tuple xs) = pretty "( " <> commaSeparated (pretty <$> xs) <> pretty " )"
  pretty (P.List xs) = pretty "[ " <> commaSeparated (pretty <$> xs) <> pretty " ]"
  pretty Wildcard = pretty "_"

prettyBranch :: Branch -> Doc ann
prettyBranch (pattern, expression) =
  sep
    [ commaSeparated $ toList (pretty <$> pattern),
      pretty "->"
        <+> align (pretty expression)
        <> pretty ';'
    ]

instance Pretty Expression where
  pretty (Identifier name) = pretty name
  pretty (Application x xs) = hang tabSize $ pretty x <> pretty "(" <> sep (prettyDisk <$> toList xs) <> pretty ")"
    where
      prettyDisk (Nothing, x) = pretty x
      prettyDisk (Just x, y) = pretty '(' <> pretty x <+> pretty "=" <+> pretty y <> pretty ')'
  pretty (Arrow x y) = sep [pretty x, pretty "->" <+> pretty y]
  pretty Meta = pretty "?"
  pretty (Let name value body) =
    vsep
      [ pretty "let" <+> pretty name <+> pretty "=" <+> pretty value <> pretty ",",
        pretty body
      ]
  pretty (ForAll froms to) =
    pretty "forall" <+> align (commaSeparated (prettyArgument <$> toList froms)) <> pretty "," <+> pretty to
    where
      prettyArgument = uncurry (<>) . (pretty *** (pretty ":" <+>) . pretty)
  pretty (Infix x op y) = pretty x <+> pretty op <+> pretty y
  pretty (Tuple xs) = pretty "( " <> align (commaSeparated (pretty <$> xs) <> pretty " )")
  pretty (List xs) = pretty "[ " <> align (commaSeparated (pretty <$> xs) <> pretty " ]")
  pretty (Lambda names x) =
    pretty "\\" <> align (sep [prettyLambdaArguments names <+> pretty "->", pretty x])
  pretty (Case x cases) =
    pretty "case" <+> commaSeparated (pretty <$> x) <+> pretty "of" <+> align (vsep (prettyBranch <$> cases))
  pretty (LambdaCase names cases) =
    pretty "\\"
      <> align
        ( case nonEmpty names of
            Nothing -> mempty
            Just xs -> prettyLambdaArguments xs <> line
        )
      <> pretty "{" <+> align (sep (prettyBranch <$> cases) <+> pretty "}")
  pretty Type = pretty "Type"
  pretty (Literal x) = pretty x
  pretty (Parenthesized x) = pretty "(" <> align (pretty x <> pretty ")")

prettyLambdaArguments :: NonEmpty Argument -> Doc ann
prettyLambdaArguments args = sep $ pretty' <$> toList args
  where
    pretty' :: Argument -> Doc ann
    pretty' (name, Nothing, _) = pretty name
    pretty' (name, Just type', _) = pretty "(" <> pretty name <+> pretty ":" <+> pretty type' <> pretty ")"

prettyArguments :: [ArgumentBlock] -> Doc ann
prettyArguments [] = mempty
prettyArguments xs =
  align $ hcat $ prettyArgumentBlock <$> xs
  where
    prettyArgument :: Argument -> Doc ann
    prettyArgument (name, type', _) =
      pretty name
        <> maybe mempty ((pretty ":" <+>) . align . pretty) type'
    prettyArgumentBlock :: ArgumentBlock -> Doc ann
    prettyArgumentBlock (plicity, args) =
      ( case plicity of
          Implicit -> (pretty "{" <>) . (<> pretty "}")
          Explicit -> (pretty "(" <>) . (<> pretty ")")
      )
        $ commaSeparated (prettyArgument <$> args)

instance Pretty TopLevelStatement where
  pretty DataDeclaration {name, args, maybeType, variants, annotations} =
    pretty "data"
      <+> pretty name
        <> prettyArguments args
        <> maybe mempty ((pretty ":" <+>) . pretty) maybeType
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
  pretty _ = pretty ""

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
  pretty (Source decls) = vsep $ pretty <$> decls

instance Show Expression where
  show = renderString . layoutPretty defaultLayoutOptions . pretty

instance Show Source where
  show = renderString . layoutPretty defaultLayoutOptions . pretty

instance Show Annotation where
  show = renderString . layoutPretty defaultLayoutOptions . pretty