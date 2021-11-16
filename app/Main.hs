module Main where

import Prettyprinter
import Prettyprinter.Render.Text
import Syntax.Grammar (parse)
import Syntax.Pretty
import Syntax.Tokens (scanTokens)

main :: IO ()
main = do
  s <- getContents
  let ast = parse (scanTokens s)
  putDoc (pretty ast)