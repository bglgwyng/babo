module Main where

import Control.Monad.Gen (runGen)
import Prettyprinter
import Prettyprinter.Render.Text
import Syntax.Desugar (desugar)
import Syntax.Grammar (parse)
import Syntax.Pretty
import Syntax.Tokens (scanTokens)
import Syntax.Validate (validate)
import System.IO (putStrLn)

main :: IO ()
main = do
  s <- getContents
  let ast = parse (scanTokens s)
  putDoc (pretty ast)
  putStrLn ""
  print (validate ast)
  putStrLn ""
  print $ runGen $ desugar ast

-- putStrLn ""
-- print (compile ast)
