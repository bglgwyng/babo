{
module Syntax.Grammar where

import Syntax.Tokens

import Data.List.NonEmpty (NonEmpty(..), toList, fromList)
import Syntax.AST
import Common
import qualified Syntax.Pattern as P
import Syntax.Pattern hiding (List, Literal, Tuple, Variable)

}

%name parse
%tokentype { Token }
%error { parseError }

%token
    datatype { TokenDatatype }
    declare { TokenDeclare }
    define { TokenDefine }
    let { TokenLet }
    int { TokenInt $$ }
    float { TokenFloat $$ }
    string { TokenString $$ }
    lsym { TokenLSym $$ }
    usym { TokenUSym $$ }
    lsymQ { TokenLSymQ $$ }
    usymQ { TokenUSymQ $$ }
    '\\' { TokenBackslash }
    '_' { TokenUnderscore }
    '=' { TokenEq }
    '->' { TokenArrow }
    infixOp { TokenInfixOp $$ }
    '(' { TokenLParen }
    ')' { TokenRParen }
    '{' { TokenLBrace }
    '}' { TokenRBrace }
    '[' { TokenLBracket }
    ']' { TokenRBracket }
    ',' { TokenComma }
    ':' { TokenColon }
    ';' { TokenSemicolon }

%right ';'
%right '->'
%right infixOp

%%
    
Statements :: { Source }
          : Statement { Source [$1] }
          | Statement Statements { Source ($1 : statements $2) }

Statement :: { TopLevelStatement }
          : datatype usym Arguments '{' Variants '}' { DataDeclaration $2 $3 Nothing $5 [] }
          | datatype usym Arguments ':' Expression '{' Variants '}' { DataDeclaration $2 $3 (Just $5) $7 [] }
          | declare lsym Arguments ':' Expression  { Declaration $2 $3 $5 [] }
          | define lsym Arguments '=' Expression  { Definition $2 $3 Nothing $5 [] }
          | define lsym Arguments ':' Expression '=' Expression  { Definition $2 $3 (Just $5) $7 [] }

Variant :: { Variant }
          : usym Arguments { ([], $1, $2, Nothing) }
          | usym Arguments ':' Expression { ([], $1, $2, Just $4) }

Variants :: { [Variant] }
          : {- empty -} { [] }
          | Variant { [$1] }
          | Variant ';' Variants { $1 : $3 }

LocalName :: { String }
          : lsym { $1 }

LocalNames : LocalName { $1 :| [] }
          | LocalName LocalNames { $1 :| toList $2 }

Argument :: { Argument }
          : LocalNames ':' Expression { ($1, $3, []) }
Arguments_  :: { [Argument] }
          : Argument { [$1] }
          | Argument ',' Arguments_ { $1 : $3 }

Arguments :: { [Argument] }
          : {- empty -} { [] }
          | '(' Arguments_ ')' { $2 }

CommaSeperated :: { [Expression] }
          : Expression { [$1] }
          | Expression ',' CommaSeperated  { $1 : $3 }

LocalName_ :: { LocalName }
          : LocalName { $1 }
          | '_'     { "_" }

LocalName_s :: { NonEmpty LocalName }
          : LocalName_ { $1 :| [] }
          | LocalName_ LocalName_s { $1 :| toList $2 }

LambdaArgument :: { LambdaArgument }
          : LocalName_                     { ($1 :| [], Nothing) }
          | '(' LocalName_s ':' Expression ')'                     { ($2, Just $4) }

LambdaArguments :: { NonEmpty LambdaArgument }
          : LambdaArgument { $1 :| [] }
          | LambdaArgument LambdaArguments { $1 :| toList $2 }

Constructor :: { NonEmpty String }
          : usym { $1 :| [] }
          | usymQ { $1 }

PatternArgument :: { P.Pattern }
          : Pattern_ { $1 }
          | '(' LocalName '=' Pattern_ ')' { Implicit $2 $4 }
          | '(' lsym ')' { PunnedImplicit $2 }

PatternArguments :: { NonEmpty P.Pattern }
          : PatternArgument { $1 :| [] }
          | PatternArgument PatternArguments { $1 :| toList $2 }

TuplePattern :: { [Pattern] }
                : Pattern ',' Pattern { [$1, $3] }
                | Pattern ',' TuplePattern  { $1 : $3 }


Pattern__ :: { P.Pattern }
          : Constructor { P.Data $1 [] }
          | lsym { P.Variable $1 }
          | '(' TuplePattern ')' { P.Tuple $2 }
          | '[' ']' { P.List [] }
          | '[' Patterns ']' { P.List (toList $2) }
          | IntegerLiteral { P.Literal $1 }
          | StringLiteral { P.Literal $1 }
          | '_' { Wildcard }


Pattern_ :: { P.Pattern }
          : Pattern__ { $1 }
          | '(' Constructor PatternArguments ')' { P.Data $2 (toList $3) }

Pattern :: { P.Pattern }
        : Pattern__ { $1 }
        | Constructor PatternArguments { P.Data $1 (toList $2) }

Patterns :: { NonEmpty P.Pattern }
          : Pattern { $1 :| [] }
          | Pattern ',' Patterns { $1 :| toList $3 }
          
Case :: { Case }
          : Patterns '->' Expression { ($1, $3) }

Cases :: { [Case] }
          : {- empty -} { [] }
          | Case { [$1] }
          | Case ';' Cases { $1 : $3 }

Expression :: { Expression }
          : let lsym '=' Expression ',' Expression { Let $2 $4 $6 }
          | BinaryExpression                     { $1 }

Juxtaposition :: { Expression }
          : Juxtaposition Atom                      { Application $1 ((Nothing, $2) :| []) }
          | Juxtaposition '(' LocalName '=' Atom ')'                      { Application $1 ((Just $3, $5) :| []) }
          | Atom                           { $1 }

IntegerLiteral :: { Literal }
        : int                         { uncurry IntegerLiteral $1 }
FloatLiteral :: { Literal }
        : float                         { uncurry (FloatLiteral (fst $1)) (snd $1) }
StringLiteral :: { Literal }
        : string { StringLiteral $1 }

Atom :: { Expression }
          : '(' Expression ')'                 { Parenthesized $2 }
          | '(' ')'                     { Literal UnitLiteral }
          | '(' Expression ',' CommaSeperated ')'       { Tuple ($2 : $4) }
          | '[' CommaSeperated ']'       { List $2 }
          | '\\' LambdaArguments '->' Atom       { Lambda $2 $4 }
          | '\\' LambdaArguments '{' Cases '}'       { LambdaCase (toList $2) $4 } 
          | '\\' '{' Cases '}'       { LambdaCase [] $3 } 
          | lsym                        { Identifier ($1 :| []) }
          | usym                        { Identifier ($1 :| []) }
          | lsymQ                       { Identifier $1 }
          | usymQ                       { Identifier $1 }
          | IntegerLiteral { Literal $1 }
          | FloatLiteral { Literal $1 }
          | StringLiteral                      { Literal $1 }
          
          
BinaryExpression :: { Expression }
          : BinaryExpression '->' BinaryExpression              { Arrow $1 $3 }
          | BinaryExpression infixOp BinaryExpression           { Infix $1 $2 $3 }
          | Juxtaposition                        { $1 }


{

parseError :: [Token] -> a
parseError _ = error "Parse error"

-- ' prevents syntax highlighting

}
