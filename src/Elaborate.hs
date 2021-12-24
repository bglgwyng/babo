{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE TupleSections #-}

module Elaborate where

import Common (Id)
import Context
import Control.Arrow ((&&&), (>>>))
import Control.Monad (foldM)
import Control.Monad.Gen (Gen, MonadGen (gen), runGen)
import Control.Monad.Trans (lift)
import Core.Client (infer')
import qualified Core.Term as T
import Core.Unification (UnifyM, runUnifyM)
import Data.Bifunctor
import Data.Functor
import Data.List.NonEmpty (NonEmpty (..))
import Data.Map (fromList)
import qualified Data.Map as M
import Data.Maybe (listToMaybe)
import Data.Traversable (forM)
import Data.Tuple (swap)
import Data.Tuple.Extra (both)
import Debug.Trace
import Syntax.AST
import qualified Syntax.AST as AST
import Syntax.Desugar

elaborate' :: GlobalContext -> AST.TopLevelStatement -> UnifyM (Maybe GlobalContext)
elaborate' ctx AST.DataDeclaration {name, args, maybeType, variants} =
  do
    (args', ctx') <- lift $ desugarArguments ctx [] args
    type' <- lift $ maybe (pure T.Type) (desugarExpression ctx []) maybeType
    pure $
      Just $
        fromList
          ( (name :| [], TypeConstructor $ foldr T.Pi type' args') :
            (variants <&> (\Variant {name = name'} -> (name' :| [], DataConstructor (T.Global (name :| [])))))
          )
elaborate' ctx AST.Declaration {name, args, type'} =
  do
    (args', ctx') <- lift $ desugarArguments ctx [] args
    type' <- lift $ desugarExpression ctx ctx' type'
    pure $
      infer' ctx mempty (foldr T.Pi type' args') T.Type
        <&> (fst >>> (M.singleton (name :| []) . Context.Declaration))
elaborate' ctx AST.Definition {name, args, maybeType, value} =
  do
    (args', ctx') <- lift $ desugarArguments ctx [] args
    type' <- foldr T.Pi `flip` args' <$> lift (maybe (T.Meta <$> gen) (desugarExpression ctx ctx') maybeType)
    value' <- foldr T.Lam `flip` args' <$> lift (desugarExpression ctx ctx' value)
    pure $
      infer' ctx mempty value' type'
        <&> (swap >>> (M.singleton (name :| []) . uncurry Context.Definition))
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