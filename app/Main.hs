module Main where

import Common (Id)
import Context (GlobalContext)
import Control.Monad (foldM, forM, void)
import Control.Monad.Gen (Gen, MonadGen (gen), runGen)
import Core.Term (Term (..))
import Data.List.NonEmpty (NonEmpty (..))
import Data.Map (assocs, toList)
import Data.Maybe (listToMaybe)
import Data.Set (fromList)
import Elaboration (elaborate)
import Polysemy (embed, run, runM)
import Polysemy.Error (runError)
import Polysemy.IO
import Polysemy.Trace (trace, traceToIO)
import Prettyprinter
import Prettyprinter.Render.Text
import Concrete.Syntax
import Concrete.Desugar (desugarExpression)
import Concrete.Grammar (parse)
import Concrete.Pretty
import Concrete.Tokens (scanTokens)
import System.IO (putStrLn)

main :: IO ()
main = runM . traceToIO $ do
  y <- runError do
    s <- embed getContents
    let ast = parse (scanTokens s)
    void $ elaborate ast
  case y of
    Left x -> trace (show x)
    Right _ -> pure ()
