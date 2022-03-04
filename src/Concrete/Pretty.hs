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
commaSeparated = sep . punctuate (ptext ",")

prettyName = ptext . intercalate "." . toList

instance Pretty QName where
  pretty x = pretty (show x)

instance Pretty Annotation where
  pretty (Annotation value) = ptext "@" <> pretty value

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
          else ptext "(" <> pretty x <> ptext ")"
      pretty' x = pretty x
      prettyArgs (Left (P.NamedPattern x as)) = ptext "(" <> pretty x <+> ptext "=" <+> pretty as <> ptext ")"
      -- prettyArgs (Left (P.PunnedImplicit x)) = ptext "(" <> pretty x <> ptext ")"
      prettyArgs (Right x) = pretty x
  pretty (P.Literal x) = pretty x
  pretty (P.Tuple xs) = ptext "( " <> commaSeparated (pretty <$> xs) <> ptext " )"
  pretty (P.List xs) = ptext "[ " <> commaSeparated (pretty <$> xs) <> ptext " ]"
  pretty Wildcard = ptext "_"

prettyBranch :: Branch -> Doc ann
prettyBranch (pattern, expression) =
  sep
    [ commaSeparated $ toList (pretty <$> pattern),
      ptext "->"
        <+> align (pretty expression)
        <> pretty ';'
    ]

instance Pretty Expression where
  pretty (Identifier name) = pretty name
  pretty (Application x xs) = hang tabSize $ pretty x <> ptext "(" <> sep (prettyDisk <$> toList xs) <> ptext ")"
    where
      prettyDisk (Nothing, x) = pretty x
      prettyDisk (Just x, y) = pretty '(' <> pretty x <+> ptext "=" <+> pretty y <> pretty ')'
  pretty (Arrow x y) = sep [pretty x, ptext "->" <+> pretty y]
  pretty Meta = ptext "?"
  pretty (Let name value body) =
    vsep
      [ ptext "let" <+> pretty name <+> ptext "=" <+> pretty value <> ptext ",",
        pretty body
      ]
  pretty (ForAll froms to) =
    ptext "forall" <+> align (commaSeparated (prettyArgument <$> toList froms)) <> ptext "," <+> pretty to
    where
      prettyArgument = uncurry (<>) . (pretty *** (ptext ":" <+>) . pretty)
  pretty (Infix x op y) = pretty x <+> pretty op <+> pretty y
  pretty (Tuple xs) = ptext "( " <> align (commaSeparated (pretty <$> xs) <> ptext " )")
  pretty (List xs) = ptext "[ " <> align (commaSeparated (pretty <$> xs) <> ptext " ]")
  pretty (Lambda names x) =
    ptext "\\" <> align (sep [prettyLambdaArguments names <+> ptext "->", pretty x])
  pretty (Case x cases) =
    ptext "case" <+> commaSeparated (pretty <$> x) <+> ptext "of" <+> align (vsep (prettyBranch <$> cases))
  pretty (LambdaCase names cases) =
    ptext "\\"
      <> align
        ( case nonEmpty names of
            Nothing -> mempty
            Just xs -> prettyLambdaArguments xs <> line
        )
      <> ptext "{" <+> align (sep (prettyBranch <$> cases) <+> ptext "}")
  pretty Type = ptext "Type"
  pretty (Literal x) = pretty x
  pretty (Parenthesized x) = ptext "(" <> align (pretty x <> ptext ")")

prettyLambdaArguments :: NonEmpty Argument -> Doc ann
prettyLambdaArguments args = sep $ pretty' <$> toList args
  where
    pretty' :: Argument -> Doc ann
    pretty' (name, Nothing, _) = pretty name
    pretty' (name, Just type', _) = ptext "(" <> pretty name <+> ptext ":" <+> pretty type' <> ptext ")"

prettyArguments :: [ArgumentBlock] -> Doc ann
prettyArguments [] = mempty
prettyArguments xs =
  align $ hcat $ prettyArgumentBlock <$> xs
  where
    prettyArgument :: Argument -> Doc ann
    prettyArgument (name, type', _) =
      pretty name
        <> maybe mempty ((ptext ":" <+>) . align . pretty) type'
    prettyArgumentBlock :: ArgumentBlock -> Doc ann
    prettyArgumentBlock (plicity, args) =
      ( case plicity of
          Implicit -> (ptext "{" <>) . (<> ptext "}")
          Explicit -> (ptext "(" <>) . (<> ptext ")")
      )
        $ commaSeparated (prettyArgument <$> args)

instance Pretty TopLevelStatement where
  pretty DataDeclaration {name, args, maybeType, variants, annotations} =
    ptext "data"
      <+> pretty name
        <> prettyArguments args
        <> maybe mempty ((ptext ":" <+>) . pretty) maybeType
      <+> ptext "{"
        <> ( if null variants
               then mempty
               else
                 line
                   <> indent' (vsep (prettyVariant <$> variants))
                   <> line
           )
        <> ptext "}"
    where
      prettyVariant :: Variant -> Doc ann
      prettyVariant Variant {name, args, maybeType} =
        pretty name
          <> prettyArguments args
          <> maybe mempty (ptext " :" <+>) (pretty <$> maybeType)
          <> pretty ';'
  pretty Definition {name, args, maybeType, value, annotations} =
    ptext "def"
      <+> align
        ( sep
            [ pretty name
                <> prettyArguments args
                <> maybe mempty (ptext " :" <+>) (pretty <$> maybeType),
              ptext "="
                <+> align (pretty value)
            ]
        )
  pretty Declaration {name, args, type', annotations} =
    ptext "decl"
      <+> align
        ( pretty name
            <> prettyArguments args
            <+> ptext ":"
            <+> align (pretty type')
        )
  pretty Import {url, rule, annotations} = ptext "import" <+> pretty url
  pretty _ = ptext ""

instance Pretty Literal where
  pretty UnitLiteral = ptext "()"
  pretty (StringLiteral s) = pretty $ show s
  pretty IntegerLiteral {negative, integer} = pretty integer
  pretty FloatLiteral {negative, integer, fractional} =
    (if negative then ptext "-" else mempty)
      <> pretty integer
      <> case fractional of
        "" -> mempty
        _ -> ptext "." <> pretty fractional

instance Pretty Source where
  pretty (Source decls) = vsep $ pretty <$> decls

instance Show Expression where
  show = renderString . layoutPretty defaultLayoutOptions . pretty

instance Show Source where
  show = renderString . layoutPretty defaultLayoutOptions . pretty

instance Show Annotation where
  show = renderString . layoutPretty defaultLayoutOptions . pretty