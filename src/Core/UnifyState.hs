module Core.UnifyState where

import BasicPrelude
import Common
import Control.Arrow ((&&&), (***))
import Core.Constraint
import Core.Meta
import Core.Term
import Data.Map (assocs)
import qualified Data.Map as M
import qualified Data.Set as S
import Polysemy (Member, Sem)
import Polysemy.State (State, get)
import Prettyprinter
import Prettyprinter.Render.String

data UnifyState = UnifyState
  { constraints :: M.Map Id Constraint,
    freshConstraints :: S.Set Id,
    metas :: MetaContext
  }
  deriving (Eq)

initialState :: UnifyState
initialState =
  UnifyState
    { constraints = M.empty,
      freshConstraints = S.empty,
      metas = M.empty
    }

instance Show UnifyState where
  show = renderString . layoutPretty defaultLayoutOptions . pretty

instance Pretty UnifyState where
  pretty UnifyState {constraints, metas} =
    unless
      (null constraints)
      ( ptext
          "constraints:"
          <> line
          <> vsep (indent 2 . pretty <$> M.elems constraints)
          <> line
      )
      <> unless
        (null metas)
        ( ptext "metas:"
            <> line
            <> vsep
              ( indent 2
                  . uncurry (<+>)
                  . ( (pretty . show . Meta)
                        *** ( \case
                                Solved x _ -> ptext "=" <+> pretty (show x)
                                Unsolved t -> ptext ":" <+> pretty (show t)
                            )
                    )
                  <$> assocs metas
              )
        )
    where
      unless p m
        | p = mempty
        | otherwise = m

allMetaSolved :: Member (State UnifyState) r => Sem r Bool
allMetaSolved =
  all solved . M.elems . metas <$> get
