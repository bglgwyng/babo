{-# OPTIONS_GHC -fplugin=Polysemy.Plugin #-}

module App where

import Concrete.Parser (Parser (..), parse)
import Core.Term
import Elaboration (elaborate)
import Polysemy (embed, runM)
import Polysemy.Error (runError)
import Polysemy.Trace (trace, traceToIO)
import Text.Megaparsec (errorBundlePretty, runParser)

app :: IO ()
app = runM . traceToIO $ do
  s <- embed getContents
  case runParser (unParser parse) "" s of
    Right ast ->
      runError (elaborate ast)
        >>= either (trace . show) (const $ pure ())
    Left e -> trace . errorBundlePretty $ e
