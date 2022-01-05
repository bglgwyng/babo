{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE TupleSections #-}

module Elaborate where

import Common (Id, QName (QName))
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
import Data.Map (fromList, singleton)
import qualified Data.Map as M
import Data.Maybe (listToMaybe)
import Data.Traversable (forM)
import Data.Tuple (swap)
import Data.Tuple.Extra (both)
import Debug.Trace (traceShowM)
import Syntax.AST
import qualified Syntax.AST as AST
import Syntax.Desugar

elaborate' :: GlobalContext -> AST.TopLevelStatement -> UnifyM (Maybe GlobalContext)
elaborate' ctx AST.DataDeclaration {name, args = params, maybeType, variants} =
  do
    (params', ctx') <- lift $ desugarArguments ctx [] params
    let paramsArity = length params'
    bodyType <- lift $ maybe (pure T.Type) (desugarExpression ctx []) maybeType
    let type' = foldr T.Pi bodyType ((\(T.Argument _ x _) -> x) <$> params')
        typeName = QName [] name
        typeDefinition = singleton typeName TypeConstructor {type'}
    variants' <-
      forM
        variants
        ( \Variant {name = name', args} -> do
            (argTypes, ctx') <- lift $ desugarArguments (ctx <> typeDefinition) ((\(T.Argument x _ _) -> x) <$> params') args
            pure
              ( QName [] name',
                argTypes,
                foldl
                  T.Ap
                  (T.Global (QName [] name))
                  (T.Local . (+ length argTypes) <$> [paramsArity - 1, paramsArity - 2 .. 0])
              )
        )
    let inductive =
          T.Inductive
            { name = typeName,
              T.variants = variants',
              T.parameters = params',
              T.indices = []
            }
    pure $
      Just $
        fromList
          ((typeName, TypeConstructor {type', inductive}) : ((\(x, _, y) -> (x, DataConstructor y inductive)) <$> variants'))
elaborate' ctx AST.Declaration {name, args, type'} =
  do
    (args', ctx') <- lift $ desugarArguments ctx [] args
    -- FIXME:
    let argTypes = (\(T.Argument _ x _) -> x) <$> args'
    type' <- lift $ desugarExpression ctx ctx' type'
    pure $
      infer' ctx mempty (foldr T.Pi type' argTypes) T.Type
        <&> (fst >>> (M.singleton (QName [] name) . Context.Declaration))
elaborate' ctx AST.Definition {name, args, maybeType, value} =
  do
    (args', ctx') <- lift $ desugarArguments ctx [] args
    -- FIXME:
    let argTypes = (\(T.Argument _ x _) -> x) <$> args'
    type' <- foldr T.Pi `flip` argTypes <$> lift (maybe (T.Meta <$> gen) (desugarExpression ctx ctx') maybeType)
    value' <- foldr T.Lam `flip` argTypes <$> lift (desugarExpression ctx ctx' value)
    traceShowM ("===============", name, value', type')
    let f = infer' ctx mempty value' type' <&> (swap >>> (M.singleton (QName [] name) . uncurry Context.Definition))
    traceShowM ("|||||||||||||||", f)
    pure f
elaborate' ctx AST.Import {} = undefined

elaborate :: AST.Source -> Maybe GlobalContext
elaborate (AST.Source xs) =
  foldM
    ( \xs y ->
        do
          Just ys <- listToMaybe . runUnifyM $ elaborate' xs y
          traceShowM (ys, "???")
          pure $ xs <> ys
    )
    mempty
    xs