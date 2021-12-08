{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}

module Elaborate where

import Common (Id)
import Context
import Control.Arrow ((>>>))
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
import Debug.Trace
import Syntax.AST
import qualified Syntax.AST as AST
import Syntax.Desugar

elaborate' :: GlobalContext -> AST.TopLevelStatement -> UnifyM (Maybe GlobalContext)
elaborate' ctx AST.DataDeclaration {name, variants} =
  pure $
    Just $
      fromList
        ( (name :| [], TypeConstructor Uni) :
          (variants <&> (\Variant {name = name'} -> (name' :| [], DataConstructor (GlobalVar (name :| [])))))
        )
elaborate' ctx AST.Declaration {name, args, type'} =
  do
    (args', ctx') <- lift $ desugarArguments ctx [] args
    type' <- lift $ desugarExpression ctx ctx' type'
    pure $
      infer' ctx (foldr Pi type' args') Uni
        <&> (fst >>> (M.singleton (name :| []) . Context.Declaration))
elaborate' ctx AST.Definition {name, maybeType, value} =
  do
    type' <- lift $ maybe (MetaVar <$> gen) (desugarExpression ctx []) maybeType
    value' <- lift $ desugarExpression ctx [] value
    pure $
      infer' ctx value' type'
        <&> (M.singleton (name :| []) . uncurry Context.Definition)
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