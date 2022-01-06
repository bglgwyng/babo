{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}

module Main where

import Common (Id)
import Context (GlobalContext, Inhabitant (Definition))
import Control.Monad (foldM, forM)
import Control.Monad.Gen (Gen, MonadGen (gen), runGen)
import Core.Term (Term (..))
import Core.Unification (driver, runUnifyM, unify)
import Data.List.NonEmpty (NonEmpty (..))
import Data.Map (assocs, toList)
import Data.Maybe (listToMaybe)
import Data.Set (fromList)
import Elaborate (elaborate)
import Prettyprinter
import Prettyprinter.Render.Text
import Syntax.AST as AST
import Syntax.Desugar (desugarExpression)
import Syntax.Grammar (parse)
import Syntax.Pretty
import Syntax.Tokens (scanTokens)
import System.IO (putStrLn)

main :: IO ()
main = do
  s <- getContents
  let ast = parse (scanTokens s)
  case elaborate ast of
    Just xs -> mapM_ print (toList xs)
    Nothing -> putStrLn "Something wrong"