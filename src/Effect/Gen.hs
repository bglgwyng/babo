module Effect.Gen where

import Polysemy
import Polysemy.State (State, evalState, get, put, runState)

data Gen m a where
  Gen :: Gen m Int

makeSem ''Gen

runGen :: Sem (Gen ': r) a -> Sem r a
runGen = evalState 0 . go
  where
    go :: Sem (Gen ': r) a -> Sem (State Int ': r) a
    go =
      reinterpret
        \Gen -> do
          x <- get
          put (x + 1)
          pure x
