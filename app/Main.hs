module Main where

import Common (Id)
import Context (GlobalContext)
import Control.Monad (foldM, forM, void)
import Control.Monad.Gen (Gen, MonadGen (gen), runGen)
import Core.Term (Term (..))
import Core.Unification (driver, runUnifyM, unify)
import Data.List.NonEmpty (NonEmpty (..))
import Data.Map (assocs, toList)
import Data.Maybe (listToMaybe)
import Data.Set (fromList)
import Elaborate (elaborate)
import Polysemy (embed, run, runM)
import Polysemy.IO
import Polysemy.Trace (traceToIO)
import Prettyprinter
import Prettyprinter.Render.Text
import Syntax.AST as AST
import Syntax.Desugar (desugarExpression)
import Syntax.Grammar (parse)
import Syntax.Pretty
import Syntax.Tokens (scanTokens)
import System.IO (putStrLn)

main :: IO ()
main = runM . traceToIO $ do
  s <- embed getContents
  let ast = parse (scanTokens s)
  void $ elaborate ast