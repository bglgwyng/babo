{-# OPTIONS_GHC -fplugin=Polysemy.Plugin #-}

module Elaborate where

import Common (Id, Level, LocalName, QName (QName, name))
import Context (GlobalContext, Inhabitant (..), LocalContext)
import qualified Context
import Control.Arrow (Arrow ((***)), (&&&), (>>>))
import Control.Monad (foldM)
import Control.Monad.Identity (Identity (Identity), IdentityT (runIdentityT), runIdentity)
import Control.Monad.Logic
import Control.Monad.Trans (lift)
import qualified Core.Term as T
import Core.Unification
import qualified Core.Unification as U
import Data.Bifunctor
import Data.Foldable (Foldable (toList), fold)
import Data.Functor
import Data.List.NonEmpty (NonEmpty (..))
import Data.Map (assocs, fromList, singleton)
import qualified Data.Map as M
import Data.Maybe (fromJust, listToMaybe)
import qualified Data.Set as S
import Data.Traversable (forM)
import Data.Tuple (swap)
import Data.Tuple.Extra (both)
import Effect.ElaborationError (ElaborationError (..))
import Effect.Gen (gen)
import Polysemy (Embed, Member, Members, Sem, embed, run)
import Polysemy.Error (Error, throw)
import Polysemy.NonDet
import Polysemy.Reader (Reader, ask, runReader)
import Polysemy.State (evalState, runState)
import Polysemy.Trace (Trace, trace)
import Syntax.AST
import qualified Syntax.AST as AST
import Syntax.Desugar (desugarArguments, desugarExpression, fillHole)

elaborate' :: Members (Trace ': Error ElaborationError ': U.Effects) r => AST.TopLevelStatement -> Sem r GlobalContext
elaborate' AST.DataDeclaration {name, args = params, maybeType, variants} = do
  gcxt <- ask
  (params', cxt') <- desugarArguments gcxt [] params
  let paramsArity = length params'
      (paramBinds, paramTypes) = unzipArgs params'
  type' <- foldr T.Pi `flip` paramTypes <$> maybe (pure T.Type) (desugarExpression gcxt []) maybeType
  v <- gen
  -- FIXME:
  let namespace = []
      typeName = QName namespace name
      typeCon = T.Global typeName
      typeDefinition =
        singleton
          typeName
          ( Context.TypeConstructor
              { args = paramBinds,
                type' = foldr T.Pi `flip` paramTypes $ T.Type,
                -- FIXME:
                ind = undefined
              }
          )
  let bindParams = foldr T.Pi `flip` paramTypes
  variants' <-
    forM
      variants
      ( \Variant {name, args} -> do
          (args', cxt') <- desugarArguments (gcxt <> typeDefinition) (fst <$> reverse paramBinds) args
          let (argBinds, argTypes) = unzipArgs args'
          pure
            ( name,
              ( args',
                bindParams $
                  foldr T.Pi `flip` argTypes $
                    foldl
                      T.Ap
                      typeCon
                      (T.Local . (+ length argTypes) <$> [paramsArity - 1, paramsArity - 2 .. 0])
              )
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
    fromList
      ( ( typeName,
          TypeConstructor
            { args = paramBinds,
              type' = bindParams T.Type,
              ind
            }
        ) :
        ( ( \(name, (args, type')) ->
              ( QName namespace name,
                DataConstructor
                  { args = (second (const T.Implicit) <$> paramBinds) <> fst (unzipArgs args),
                    type',
                    ind
                  }
              )
          )
            <$> variants'
        )
      )
elaborate' AST.Declaration {name, args, type'} = do
  gcxt <- ask
  (args', cxt') <- desugarArguments gcxt [] args
  -- FIXME:
  let (argBinds, argTypes) = unzipArgs args'
  type' <- foldr T.Pi `flip` argTypes <$> desugarExpression gcxt cxt' type'
  resolve <- unifyAll $ S.singleton $ [] |- type' ?: T.Type
  pure
    ( M.singleton
        (QName [] name)
        ( Context.Declaration
            { args = argBinds,
              Context.type' = resolve type'
            }
        )
    )
elaborate' AST.Definition {name, args, maybeType, value} = do
  gcxt <- ask
  (args', cxt') <- desugarArguments gcxt [] args
  -- FIXME:
  let (argBinds, argTypes) = unzipArgs args'
  type' <-
    foldr T.Pi `flip` argTypes
      <$> maybe (fillHole cxt') (desugarExpression gcxt cxt') maybeType
  value' <-
    foldr T.Lam `flip` argTypes
      <$> desugarExpression gcxt cxt' value
  resolve <- unifyAll $ S.singleton $ [] |- value' ?: type'
  pure
    ( M.singleton
        (QName [] name)
        ( Context.Definition
            { args = argBinds,
              type' = resolve type',
              value = resolve value'
            }
        )
    )
elaborate' (Eval x) = do
  gcxt <- ask
  metaId <- gen
  let meta = T.Meta metaId
  value <- desugarExpression gcxt mempty x
  resolve <- unifyAll $ S.singleton $ [] |- value ?: meta
  let value' = reduce gcxt mempty True $ resolve value
  trace ("%eval " <> show value <> " = " <> show value')
  pure mempty
elaborate' (AST.TypeOf x) = do
  gcxt <- ask
  metaId <- gen
  let meta = T.Meta metaId
  value <- desugarExpression gcxt mempty x
  resolve <- unifyAll $ S.singleton ([] |- value ?: meta)
  trace ("%typeof " <> show (resolve value) <> " : " <> show (resolve meta))
  pure mempty
elaborate' (CheckUnify x y) = do
  gcxt <- ask
  x <- desugarExpression gcxt mempty x
  y <- desugarExpression gcxt mempty y
  type' <- T.Meta <$> gen
  (substs, _) <- unify $ S.singleton $ [] |- x ?= y
  trace ("%check " <> show x <> " = " <> show y)
  forM_ (assocs substs) $
    trace . ("  " <>) . uncurry ((<>) . (<> " = ")) . (show . T.Meta *** show)
  pure mempty
elaborate' (CheckTypeOf value type') = do
  gcxt <- ask
  value <- desugarExpression gcxt mempty value
  type' <- desugarExpression gcxt mempty type'
  (substs, _) <- unify (S.singleton $ [] |- value ?: type')
  trace ("%check " <> show value <> " : " <> show type')
  forM_ (assocs substs) $
    trace . ("  " <>) . uncurry ((<>) . (<> " = ")) . (show . T.Meta *** show)
  pure mempty
elaborate' _ = pure mempty

unzipArgs :: [T.Argument] -> ([(LocalName, T.Plicity)], [T.Term])
unzipArgs args = unzip $ (\(T.Argument name plicity type') -> ((name, plicity), type')) <$> args

elaborate :: Members '[Trace, Error ElaborationError] r => AST.Source -> Sem r GlobalContext
elaborate (AST.Source xs) = do
  foldM
    ( \xs y ->
        do
          x <- runUnifyM xs initialState $ elaborate' y
          pure $ xs <> x
    )
    mempty
    xs
