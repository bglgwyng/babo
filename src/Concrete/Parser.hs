{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# OPTIONS_GHC -Wno-unused-do-bind #-}

module Concrete.Parser where

-- import qualified Data.Scientific as Scientific

-- import qualified Data.Time as Time

-- import qualified Data.Scientific as Scientific

-- import qualified Data.Time as Time

-- import Data.Text (Text)
-- import qualified Data.Text as Text
-- import qualified Data.Text.Encoding as Text.Encoding

import BasicPrelude
import Common
import Common (QName (namespace))
import Concrete.Pattern hiding (Implicit)
import Concrete.Syntax
import Control.Applicative (Alternative (..), optional, (<**>))
import Control.Arrow
import Control.Monad (MonadPlus (..), guard, mfilter, replicateM)
import Core.Term (Plicity (Explicit, Implicit))
-- import Data.Char (isAlpha, isAlphaNum, isDigit, isLower, isUpper)

-- import Data.Text (IsText (..))

-- import Data.Char (isAlpha, isAlphaNum, isDigit, isLower, isUpper)

-- import Data.Text (IsText (..))
-- import Data.Char (isAlpha, isAlphaNum, isDigit, isLower, isUpper)

-- import Data.Text (IsText (..))

-- import Data.Char (isAlpha, isAlphaNum, isDigit, isLower, isUpper)

-- import Data.Text (IsText (..))
import Data.Char (isAlphaNum, isLower, isUpper)
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
import Data.Semigroup (Semigroup)
import Data.Text (cons)
import Data.Void (Void)
import GHC.Base (assert)
import Text.Megaparsec
  ( MonadParsec (eof, hidden, label),
    Parsec,
    between,
    notFollowedBy,
    satisfy,
    sepBy,
    sepBy1,
    sepEndBy,
    single,
    takeWhile1P,
    takeWhileP,
    try,
  )
import Text.Megaparsec.Char (space1, string)
import qualified Text.Megaparsec.Char.Lexer as L

newtype Parser a = Parser {unParser :: Parsec Void Text a}
  deriving
    ( Alternative,
      Applicative,
      Functor,
      Monad,
      MonadFail,
      MonadParsec Void Text,
      MonadPlus,
      Monoid,
      Semigroup
    )

sc :: Parser ()
sc =
  L.space
    space1
    (L.skipLineComment "--")
    mzero

lexeme :: Parser a -> Parser a
lexeme = L.lexeme sc

symbol :: Text -> Parser Text
symbol = L.symbol sc

-- utils
braced :: Parser a -> Parser a
braced = between (symbol "{") (symbol "}")

parenthesized :: Parser a -> Parser a
parenthesized = between (symbol "(") (symbol ")")

sepByComma :: Parser a -> Parser [a]
sepByComma = (`sepBy` symbol ",")

sepByComma1 :: Parser a -> Parser (NonEmpty a)
sepByComma1 = (NonEmpty.fromList <$>) . (`sepBy1` symbol ",")

--

keywords :: [Text]
keywords = ["data", "decl", "def", "let", "forall", "case", "of", "where"]

keyword :: Text -> Parser Text
keyword x =
  assert (x `elem` keywords) $
    lexeme (string x <* notFollowedBy (satisfy nameTailPredicate))

notKeyword :: Parser Text -> Parser Text
notKeyword = mfilter (not . (`elem` keywords))

localName :: Parser Text
localName = lexeme $ notKeyword lowerName <|> upperName

-- FIXME: better design
qname :: Bool -> Parser QName
qname isConstructor =
  lexeme $
    ((upperName <&> (:|)) <*> go <&> \xs -> QName (NonEmpty.init xs) (NonEmpty.last xs))
      <|> if isConstructor then mzero else QName [] <$> notKeyword lowerName
  where
    go =
      try (single '.') *> (((: []) <$> lowerName) <|> ((:) <$> upperName <*> go))
        <|> pure []

nameTailPredicate :: Char -> Bool
nameTailPredicate x = isAlphaNum x || x == '\''

nameTail :: Parser Text
nameTail = takeWhileP Nothing nameTailPredicate

lowerName :: Parser LocalName
lowerName = label "lowercase name" $ (satisfy isLower <&> cons) <*> nameTail

upperName :: Parser LocalName
upperName = label "uppercase name" $ (satisfy isUpper <&> cons) <*> nameTail

annotations' :: Parser [Annotation]
annotations' = many (Annotation <$> (hidden (symbol "@") *> expression))

application :: Parser (Expression -> Expression)
application =
  (Application `flip`)
    <$> parenthesized (sepByComma1 disk)
  where
    disk :: Parser (Maybe Text, Expression)
    disk =
      try (((,) . Just <$> localName <* symbol "=") <*> expression)
        <|> (Nothing,) <$> expression

infix' :: Parser (Expression -> Expression)
infix' = ((Infix `flip`) <$> qname False <&> flip) <*> expression

forall :: Parser Expression
forall =
  ForAll
    <$> (hidden (keyword "forall") *> sepByComma1 ((,) <$> localName <*> (symbol ":" *> expression)))
    <*> (symbol "=>" *> expression)

let' :: Parser Expression
let' = Let <$> (hidden (keyword "let") *> localName) <*> (symbol "=" *> expression <* symbol ",") <*> expression

case' :: Parser Expression
case' = Case <$> (keyword "case" *> some expression <* keyword "of") <*> braced (sepEndBy branch (symbol ";"))
  where
    branch :: Parser Branch
    branch = (,) <$> (sepByComma1 pattern' <* symbol "->") <*> expression
    pattern' :: Parser Pattern
    pattern' =
      try
        (Data <$> qname True <*> (maybe [] NonEmpty.toList <$> optional patternArguments))
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
lambda = symbol "\\" *> (Lambda <$> sepByComma1 argument <*> (symbol "=>" *> expression))
  where
    argument = (,,[]) <$> localName <*> optional (symbol ":" *> expression)

parenthesize :: Parser Expression
parenthesize = Parenthesized <$> parenthesized expression

identifier :: Parser Expression
identifier =
  qname False
    >>= \case
      QName [] "Type" -> pure Type
      x -> pure $ Identifier x

meta :: Parser Expression
meta = Meta <$ symbol "_"

expression :: Parser Expression
expression =
  try forall
    <|> try lambda
    <|> try let'
    <|> try case'
    <|> ( ( try identifier
              <|> try meta
              <|> parenthesize
          )
            <**> (try ((foldl (&) `flip`) <$> some application) <|> pure id)
            <**> ( try infix'
                     <|> try arrow
                     <|> pure id
                 )
        )

lhsArgument :: Parser Argument
lhsArgument =
  (,,) <$> localName
    <*> optional (symbol ":" *> expression)
    <*> annotations'

lhsArguments :: Parser [ArgumentBlock]
lhsArguments =
  many
    ( try ((Explicit,) <$> parenthesized arguments)
        <|> ((Implicit,) <$> braced arguments)
    )
  where
    arguments = NonEmpty.toList <$> sepByComma1 lhsArgument

dataDeclaration :: [Annotation] -> Parser TopLevelStatement
dataDeclaration anns =
  pure anns
    <**> ( DataDeclaration <$> localName <*> lhsArguments <*> optional (symbol ":" *> expression) <* keyword "where"
             <*> braced (sepEndBy varaint (symbol ";"))
         )
  where
    varaint =
      Variant <$> lexeme upperName <*> lhsArguments
        <*> optional (symbol ":" *> expression)
        <*> annotations'

definition :: [Annotation] -> Parser TopLevelStatement
definition anns =
  pure anns
    <**> ( Definition <$> localName <*> lhsArguments <*> optional (symbol ":" *> expression)
             <*> (symbol "=" *> expression)
         )

declaration :: [Annotation] -> Parser TopLevelStatement
declaration anns =
  pure anns
    <**> (Declaration <$> localName <*> lhsArguments <*> (symbol ":" *> expression))

eval :: Parser TopLevelStatement
eval = Eval <$> expression

typeof :: Parser TopLevelStatement
typeof = TypeOf <$> expression

check :: Parser TopLevelStatement
check =
  expression
    <**> ( symbol "=" $> CheckUnify
             <|> symbol ":" $> CheckTypeOf
         )
    <*> expression

statement :: Parser TopLevelStatement
statement = do
  anns <- annotations'
  (hidden (keyword "data") *> try (dataDeclaration anns))
    <|> (hidden (keyword "def") *> try (definition anns))
    <|> (hidden (keyword "decl") *> try (declaration anns))
    -- TODO: these are unannotatble
    <|> (hidden (keyword "%eval") *> try eval)
    <|> (hidden (keyword "%typeof") *> try typeof)
    <|> (hidden (keyword "%check") *> check)

parse :: Parser Source
parse = sc *> (Source <$> many statement) <* eof