module Main where

import Prettyprinter
import Prettyprinter.Render.Text
import Syntax.Grammar (parse)
import Syntax.Pretty
import Syntax.Tokens (scanTokens)
import Syntax.Validate (validate)

main :: IO ()
main = do
  s <- getContents
  let ast = parse (scanTokens s)
  putDoc (pretty ast)
  print (validate ast)