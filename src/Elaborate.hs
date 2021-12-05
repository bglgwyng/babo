{-# LANGUAGE NamedFieldPuns #-}

module Elaborate where

import Common (Id)
import Context
import Control.Monad (foldM)
import Control.Monad.Gen (Gen, MonadGen (gen), runGen)
import Control.Monad.Trans (lift)
import Core.Client (infer')
import Core.Term
import Core.Unification (UnifyM, runUnifyM)
import Data.Functor
import Data.List.NonEmpty (NonEmpty (..))
import Data.Map (fromList)
import qualified Data.Map as M
import Data.Maybe (listToMaybe)
import Syntax.AST
import qualified Syntax.AST as AST
import Syntax.Desugar

elaborate' :: GlobalContext -> AST.TopLevelStatement -> UnifyM (Maybe GlobalContext)
elaborate' ctx AST.DataDeclaration {name, variants} =
  pure $
    Just $
      fromList
        ( (name :| [], TypeConstructor Uni) :
          (variants <&> (\(_, name', _, _) -> (name' :| [], DataConstructor (GlobalVar (name :| [])))))
        )
elaborate' ctx AST.Declaration {name, type'} =
  do
    type' <- lift $ desugarExpression ctx type'
    pure $
      infer' ctx type' Uni
        <&> ( \(x, y) ->
                M.singleton (name :| []) $ Context.Declaration x
            )
elaborate' ctx AST.Definition {name, maybeType, value} =
  do
    type' <- lift $ maybe (MetaVar <$> gen) (desugarExpression ctx) maybeType
    value' <- lift $ desugarExpression ctx value
    pure $
      infer' ctx value' type'
        <&> ( \(x, y) ->
                M.singleton (name :| []) $ Context.Definition x y
            )
elaborate' ctx AST.Import {} = undefined

elaborate :: AST.Source -> Maybe GlobalContext
elaborate (AST.Source xs) =
  foldM
    ( \xs y ->
        do
          Just ys <- listToMaybe . runUnifyM $ elaborate' xs y
          pure $ xs <> ys
    )
    mempty
    xs