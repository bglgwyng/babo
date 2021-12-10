{
module Syntax.Tokens where

import Data.List.NonEmpty (NonEmpty(..), fromList)
import Data.List.Split (wordsBy)

}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]
@lsymbol = [a-z] [$alpha $digit \_ \']*
@usymbol = [A-Z] [$alpha $digit \_ \']*
@namespace = [A-Z] [$alpha $digit]*
@lsymbolQ = (@namespace \.)+ @lsymbol
@usymbolQ = (@namespace \.)+ @usymbol
@string_literal = \" [^\"]* \"

tokens :-
  $white+                       ;
  "--".*                        ;
  data                          { \s -> TokenDatatype }
  decl                          { \s -> TokenDeclare }
  def                           { \s -> TokenDefine }
  let                           { \s -> TokenLet }
  forall                        { \s -> TokenForAll } 
  Type                          { \s -> TokenType } 
  $digit+                       { \s -> TokenInt (True, s) }
  \- $digit+                    { \s -> TokenInt (False, s) }
  $digit+ \. $digit+            { \s -> TokenFloat (True, (\[x,y] -> (x, y)) (wordsByDot s)) }
  \- $digit+ \. $digit+         { \s -> TokenFloat (True, (\[x,y] -> (x, y)) (wordsByDot $ tail s)) }
  @string_literal               { \s -> TokenString (tail $ init s) }
  \=                            { \s -> TokenEq }
  "->"                          { \s -> TokenArrow }
  \(                            { \s -> TokenLParen }
  \)                            { \s -> TokenRParen }
  \{                            { \s -> TokenLBrace }
  \}                            { \s -> TokenRBrace }
  \[                            { \s -> TokenLBracket }
  \]                            { \s -> TokenRBracket }
  \\                            { \s -> TokenBackslash }
  \_                            { \s -> TokenUnderscore }
  @lsymbol                      { \s -> TokenLSym s }
  @usymbol                      { \s -> TokenUSym s }
  @lsymbolQ                     { \s -> TokenLSymQ (fromList $ wordsByDot s) }
  @usymbolQ                     { \s -> TokenUSymQ (fromList $ wordsByDot s) }
  \. @lsymbol                   { \(_:s) -> TokenInfixOp (s :| []) }
  \. @lsymbolQ                  { \(_:s) -> TokenInfixOp (fromList $ wordsByDot s) }
  \,                            { \s -> TokenComma }
  \:                            { \s -> TokenColon }
  \;                            { \s -> TokenSemicolon }
{

wordsByDot = wordsBy (== '.')

-- The token type:
data Token = TokenDatatype
           | TokenDeclare
           | TokenDefine
           | TokenLet
           | TokenIn
           | TokenInt (Bool, String)
           | TokenFloat (Bool, (String, String))
           | TokenType
           | TokenString String
           | TokenLSym String
           | TokenUSym String
           | TokenLSymQ (NonEmpty String)
           | TokenUSymQ (NonEmpty String)
           | TokenEq
           | TokenArrow
           | TokenForAll
           | TokenLParen
           | TokenRParen
           | TokenLBrace
           | TokenRBrace
           | TokenLBracket
           | TokenRBracket
           | TokenBackslash
           | TokenUnderscore
           | TokenInfixOp (NonEmpty String)
           | TokenComma
           | TokenColon
           | TokenSemicolon
           deriving (Eq,Show)

scanTokens = alexScanTokens

}
