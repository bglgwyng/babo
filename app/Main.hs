{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}

module Main where

import Common (Id)
import Context (GlobalContext, Inhabitant (Definition))
import Control.Monad (foldM, forM)
import Control.Monad.Gen (Gen, MonadGen (gen), runGen)
import Core.Client (infer, infer')
import Core.Term (Term (..))
import Core.Unification (driver, runUnifyM, unify)
import Data.List.NonEmpty (NonEmpty (..))
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
  -- putDoc (pretty ast)
  -- putStrLn ""
  -- print (validate ast)
  -- putStrLn ""
  print $ elaborate ast

-- print $ infer

-- let foo = LocalVar 0
-- let bar = GlobalVar ("bar" :| [])
-- print $ driver (MetaVar 0, FreeVar 1)

-- print $ driver (Lam $ Ap (MetaVar 1) (LocalVar 0), Lam $ Ap foo (LocalVar 0))

--  (Ap foo (MetaVar 2), Ap foo (Pi foo Uni))

-- putStrLn ""
-- print (compile ast)\\\

-- \z -> (\x -> x (\y -> y)) z = \z -> z z