{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# OPTIONS_GHC -Wno-unused-do-bind #-}

module Concrete.Parser where

-- import qualified Data.Scientific as Scientific

-- import qualified Data.Time as Time

-- import qualified Data.Scientific as Scientific

-- import qualified Data.Time as Time

import Common
-- import Data.Text (Text)
-- import qualified Data.Text as Text
-- import qualified Data.Text.Encoding as Text.Encoding

import Common (QName (namespace))
import Concrete.Pattern hiding (Implicit)
import Concrete.Syntax
import Control.Applicative (Alternative (..), optional, (<**>))
import Control.Arrow
import Control.Monad (MonadPlus (..), guard, mfilter, replicateM)
import Core.Term (Plicity (Explicit, Implicit))
import Data.Char (isAlpha, isAlphaNum, isDigit, isLower, isUpper)
import qualified Data.Char as Char
import Data.Fixed (Pico)
import Data.Foldable (fold)
import Data.Function ((&))
import Data.Functor (void, ($>), (<&>))
import Data.List.NonEmpty (NonEmpty (..), some1)
import qualified Data.List.NonEmpty as NonEmpty
import qualified Data.Map as Map
import Data.Maybe
import Data.Ratio ((%))
import Data.String (IsString (..))
import Data.Void (Void)
import Text.Megaparsec
  ( MonadParsec (eof),
    Parsec,
    between,
    notFollowedBy,
    satisfy,
    sepBy,
    sepBy1,
    sepEndBy,
    takeWhile1P,
    takeWhileP,
    try,
  )
import Text.Megaparsec.Char (alphaNumChar, char, space1, string)
import qualified Text.Megaparsec.Char.Lexer as L
import Prelude hiding (exponent, takeWhile)

newtype Parser a = Parser {unParser :: Parsec Void String a}
  deriving
    ( Alternative,
      Applicative,
      Functor,
      Monad,
      MonadFail,
      MonadParsec Void String,
      MonadPlus,
      Monoid,
      Semigroup
    )

-- instance a ~ Text => IsString (Parser a) where
--   fromString x = Parser (fromString x)

pKeyword :: String -> Parser String
pKeyword keyword = lexeme (string keyword <* notFollowedBy nameTail)

sc :: Parser ()
sc =
  L.space
    space1
    (L.skipLineComment "--")
    mzero

lexeme :: Parser a -> Parser a
lexeme = L.lexeme sc

symbol :: String -> Parser String
symbol = L.symbol sc

-- utils
braced = between (symbol "{") (symbol "}")

parenthesized = between (symbol "(") (symbol ")")

sepByComma :: Parser a -> Parser [a]
sepByComma = (`sepBy` symbol ",")

sepByComma1 :: Parser a -> Parser [a]
sepByComma1 = (`sepBy1` symbol ",")

--

keywords = ["data", "decl", "def", "let", "forall", "case", "of", "where"]

localName :: Parser String
localName = lexeme $ mfilter (not . (`elem` keywords)) $ try lowerName <|> upperName

qname :: Parser QName
qname = lexeme do
  try ((upperName <&> (:|)) <*> go <&> \xs -> QName (NonEmpty.init xs) (NonEmpty.last xs))
    <|> (localName <&> QName [])
  where
    go =
      try
        ( char '.'
            *> ( try ((upperName <&> (:)) <*> go)
                   <|> (lowerName <&> (: []))
               )
        )
        <|> pure []

nameTail :: Parser String
nameTail = takeWhileP Nothing (\x -> isAlphaNum x || x == '\'')

lowerName :: Parser LocalName
lowerName = (satisfy isLower <&> (:)) <*> nameTail

upperName :: Parser LocalName
upperName = (satisfy isUpper <&> (:)) <*> nameTail

annotations' :: Parser [Annotation]
annotations' = many (Annotation <$> (symbol "@" *> expression))

argument :: Parser (NonEmpty String, Expression)
argument = ((,) <$> some1 localName) <*> (symbol ":" *> expression)

application :: Parser (Expression -> Expression)
application =
  (Application `flip`)
    <$> parenthesized (NonEmpty.fromList <$> sepByComma1 disk)
  where
    disk :: Parser (Maybe String, Expression)
    disk =
      try (((,) . Just <$> localName <* symbol "=") <*> expression)
        <|> (Nothing,) <$> expression

infix' :: Parser (Expression -> Expression)
infix' = ((Infix `flip`) <$> qname <&> flip) <*> expression

forall :: Parser Expression
forall = uncurry ForAll <$> (symbol "forall" *> argument <* symbol ",") <*> expression

let' :: Parser Expression
let' = Let <$> (symbol "let" *> localName) <*> (symbol "=" *> expression <* symbol ",") <*> expression

case' :: Parser Expression
case' = Case <$> (symbol "case" *> some expression <* symbol "of") <*> braced (sepEndBy branch (symbol ";"))
  where
    branch :: Parser Branch
    branch = (,) <$> (sepByComma1 pattern' <* symbol "->") <*> expression
    pattern' :: Parser Pattern
    pattern' =
      try
        (Data <$> (QName [] <$> lexeme upperName) <*> (fold <$> optional patternArguments))
        <|> try
          (Variable <$> lexeme lowerName)
        <|> (Wildcard <$ symbol "_")
    patternArguments =
      parenthesized $
        sepByComma1
          ( try (Left <$> (NamedPattern <$> lexeme lowerName <*> (symbol "=" *> pattern')))
              <|> (Right <$> pattern')
          )

arrow :: Parser (Expression -> Expression)
arrow = (Arrow `flip`) <$> (symbol "->" *> expression)

lambda :: Parser Expression
lambda = symbol "\\" *> (Lambda <$> some1 argument <*> (symbol "->" *> expression))
  where
    argument :: Parser Argument
    argument =
      try ((,Nothing,[]) . (:| []) <$> localName)
        <|> parenthesized ((,,[]) <$> some1 localName <*> (Just <$> (symbol ":" *> expression)))

parenthesize :: Parser Expression
parenthesize = Parenthesized <$> parenthesized expression

identifier :: Parser Expression
identifier =
  qname
    >>= \case
      QName [] "Type" -> pure Type
      x -> pure $ Identifier x

meta :: Parser Expression
meta = Meta <$ symbol "_"

quoatable :: Parser String -> Parser String
quoatable p = (try (char '\'' <&> (:)) <|> pure id) <*> p

atom :: Parser Expression
atom =
  ( try identifier
      <|> try forall
      <|> try lambda
      <|> try let'
      <|> try case'
      <|> try meta
      <|> parenthesize
  )
    <**> ( try ((foldl (&) `flip`) <$> some application)
             <|> pure id
         )

expression :: Parser Expression
expression =
  atom
    <**> ( try infix'
             <|> try arrow
             <|> pure id
         )

lhsArgument :: Plicity -> Parser Argument
lhsArgument plicity =
  (,,) <$> some1 (quoatable localName)
    <*> optional (symbol ":" *> expression)
    <*> annotations'

lhsArguments :: Parser [ArgumentGroup]
lhsArguments =
  many
    ( try ((Explicit,) <$> parenthesized (sepByComma1 (lhsArgument Explicit)))
        <|> (Implicit,) <$> braced (sepByComma1 (lhsArgument Implicit))
    )

dataDeclaration :: Parser TopLevelStatement
dataDeclaration =
  (annotations' <* symbol "data")
    <**> ( DataDeclaration <$> localName <*> lhsArguments <*> optional (symbol ":" *> expression) <* symbol "where"
             <*> braced (sepEndBy varaint (symbol ";"))
         )
  where
    varaint =
      Variant <$> lexeme upperName <*> lhsArguments
        <*> optional (symbol ":" *> expression)
        <*> annotations'

definition :: Parser TopLevelStatement
definition =
  (annotations' <* symbol "def")
    <**> ( Definition <$> localName <*> lhsArguments <*> optional (symbol ":" *> expression)
             <*> (symbol "=" *> expression)
         )

declaration :: Parser TopLevelStatement
declaration =
  (annotations' <* symbol "decl")
    <**> (Declaration <$> localName <*> lhsArguments <*> (symbol ":" *> expression))

eval :: Parser TopLevelStatement
eval = symbol "%eval" *> (Eval <$> expression)

typeof :: Parser TopLevelStatement
typeof = symbol "%typeof" *> (TypeOf <$> expression)

check :: Parser TopLevelStatement
check =
  symbol "%check"
    *> expression
      <**> ( try (symbol "=" $> CheckUnify)
               <|> (symbol ":" $> CheckTypeOf)
           )
      <*> expression

statement :: Parser TopLevelStatement
statement =
  try dataDeclaration
    <|> try definition
    <|> try declaration
    <|> try eval
    <|> try typeof
    <|> check

parse :: Parser Source
parse = (Source <$> many statement) <* eof