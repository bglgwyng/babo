module Syntax.Literal where

data Literal
  = UnitLiteral
  | StringLiteral String
  | IntegerLiteral
      { negative :: Bool,
        integer :: String
      }
  | FloatLiteral
      { negative :: Bool,
        integer :: String,
        fractional :: String
      }
  deriving (Show, Eq, Ord)