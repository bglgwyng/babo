module Main where

import Concrete.Grammar
import Concrete.Tokens
import Elaboration
import Polysemy
import Polysemy.Error
import Polysemy.Trace

main :: IO ()
main = runM . traceToIO $ do
  s <- embed getContents
  case parse (scanTokens s) of
    Right ast -> runError (elaborate ast) >>= either (trace . show) (const $ pure ())
    Left message -> trace message
