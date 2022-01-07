module Elaborate where

import Common (Id, QName (QName))
import Context
import Control.Arrow ((&&&), (>>>))
import Control.Monad (foldM)
import Control.Monad.Gen (Gen, MonadGen (gen), runGen)
import Control.Monad.Trans (lift)
import Core.Client (infer)
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
import Syntax.AST
import qualified Syntax.AST as AST
import Syntax.Desugar

elaborate' :: GlobalContext -> AST.TopLevelStatement -> UnifyM (Maybe GlobalContext)
elaborate' cxt AST.DataDeclaration {name, args = params, maybeType, variants} =
  do
    (params', cxt') <- lift $ desugarArguments cxt [] params
    let paramsArity = length params'
    bodyType <- lift $ maybe (pure T.Type) (desugarExpression cxt []) maybeType
    -- FIXME:
    let namespace = []
        type' = foldr T.Pi bodyType ((\(T.Argument _ x _) -> x) <$> params')
        typeName = QName namespace name
        typeDefinition = singleton typeName (Context.Definition {type' = type', value = T.TypeConstructor undefined})
    variants' <-
      forM
        variants
        ( \Variant {name = name', args} -> do
            (argTypes, cxt') <- lift $ desugarArguments (cxt <> typeDefinition) ((\(T.Argument x _ _) -> x) <$> params') args
            pure
              ( name',
                argTypes,
                foldl
                  T.Ap
                  (T.Global (QName [] name))
                  (T.Local . (+ length argTypes) <$> [paramsArity - 1, paramsArity - 2 .. 0])
              )
        )
    let ind =
          T.InductiveType
            { qname = typeName,
              T.variants = variants',
              T.params = params',
              T.indices = []
            }
    pure $
      Just $
        fromList
          ( (typeName, Context.Definition type' (T.TypeConstructor ind)) :
            ( ( \(x, _, y) ->
                  (QName namespace x, Context.Definition y (T.DataConstructor ind x))
              )
                <$> variants'
            )
          )
elaborate' cxt AST.Declaration {name, args, type'} =
  do
    (args', cxt') <- lift $ desugarArguments cxt [] args
    -- FIXME:
    let argTypes = (\(T.Argument _ x _) -> x) <$> args'
    type' <- lift $ desugarExpression cxt cxt' type'
    pure $
      infer cxt mempty (foldr T.Pi type' argTypes) T.Type
        <&> (fst >>> (M.singleton (QName [] name) . Context.Declaration))
elaborate' cxt AST.Definition {name, args, maybeType, value} =
  do
    (args', cxt') <- lift $ desugarArguments cxt [] args
    -- FIXME:
    let argTypes = (\(T.Argument _ x _) -> x) <$> args'
    type' <- foldr T.Pi `flip` argTypes <$> lift (maybe (T.Meta (length argTypes) <$> gen) (desugarExpression cxt cxt') maybeType)
    value' <- foldr T.Lam `flip` argTypes <$> lift (desugarExpression cxt cxt' value)
    pure $
      infer cxt mempty value' type'
        <&> (swap >>> (M.singleton (QName [] name) . uncurry Context.Definition))
elaborate' cxt AST.Import {} = undefined

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