module Elaborate where

import Common (Id, Level, LocalName, QName (QName, name))
import Context (GlobalContext, Inhabitant (..), LocalContext)
import qualified Context
import Control.Arrow (Arrow ((***)), (&&&), (>>>))
import Control.Monad (foldM)
import Control.Monad.Identity (Identity (Identity), IdentityT (runIdentityT), runIdentity)
import Control.Monad.Logic
import Control.Monad.Trans (lift)
import Core.Client (infer)
import qualified Core.Term as T
import Core.Unification (Context (..), UnifyM, manySubst, reduce, runUnifyM, subst, substFV, unify)
import Data.Bifunctor
import Data.Foldable (Foldable (toList), fold)
import Data.Functor
import Data.List.NonEmpty (NonEmpty (..))
import Data.Map (assocs, fromList, singleton)
import qualified Data.Map as M
import Data.Maybe (listToMaybe)
import qualified Data.Set as S
import Data.Traversable (forM)
import Data.Tuple (swap)
import Data.Tuple.Extra (both)
import Effect.Gen (gen)
import Polysemy (Embed, Member, Members, Sem, embed, run)
import Polysemy.Trace (Trace, trace)
import Syntax.AST
import qualified Syntax.AST as AST
import Syntax.Desugar (desugarArguments, desugarExpression)
import qualified Syntax.Desugar as D

-- foo :: GlobalContext -> D.GlobalContext
-- foo xs = bar <$> xs
--   where
--     bar (DataConstructor args _ ind) = (args, Just ind)
--     bar x = (args x, Nothing)

elaborate' :: Members (Trace ': UnifyM) r => GlobalContext -> AST.TopLevelStatement -> Sem r GlobalContext
elaborate' cxt AST.DataDeclaration {name, args = params, maybeType, variants} =
  do
    (params', cxt') <- desugarArguments cxt [] params
    let paramsArity = length params'
        (paramBinds, paramTypes) = unzipArgs params'
    type' <- foldr T.Pi `flip` paramTypes <$> maybe (pure T.Type) (desugarExpression cxt []) maybeType
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
            (args', cxt') <- desugarArguments (cxt <> typeDefinition) (fst <$> paramBinds) args
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
elaborate' gcxt AST.Declaration {name, args, type'} = do
  (args', cxt') <- desugarArguments gcxt [] args
  -- FIXME:
  let (argBinds, argTypes) = unzipArgs args'
  type' <- foldr T.Pi `flip` argTypes <$> desugarExpression gcxt cxt' type'
  (type', _, _, _) <- infer gcxt mempty type' T.Type
  pure
    ( M.singleton
        (QName [] name)
        ( Context.Declaration
            { args = argBinds,
              Context.type' = type'
            }
        )
    )
elaborate' gcxt AST.Definition {name, args, maybeType, value} = do
  (args', cxt') <- desugarArguments gcxt [] args
  -- FIXME:
  let (argBinds, argTypes) = unzipArgs args'
  type' <-
    foldr T.Pi `flip` argTypes
      <$> maybe (T.Meta (length argTypes) <$> gen) (desugarExpression gcxt cxt') maybeType
  value' <-
    foldr T.Lam `flip` argTypes
      <$> desugarExpression gcxt cxt' value
  (value', type', _, _) <- infer gcxt mempty value' type'
  pure
    ( M.singleton
        (QName [] name)
        ( Context.Definition
            { args = argBinds,
              type' = type',
              value = value'
            }
        )
    )
elaborate' gcxt (Eval x) = do
  meta <- T.Meta 0 <$> gen
  value <- desugarExpression gcxt mempty x
  trace (show $ ("%eval ", value))
  (value', _, _, _) <- infer gcxt mempty value meta
  trace ("%eval " <> show value <> " = " <> show (reduce Context {metas = mempty, globals = gcxt} value'))
  pure mempty
elaborate' gcxt (TypeOf x) = do
  meta <- T.Meta 0 <$> gen
  value <- desugarExpression gcxt mempty x
  (_, type', _, _) <- infer gcxt mempty value meta
  trace ("%check " <> show value <> " : " <> show type')
  pure mempty
elaborate' gcxt (CheckUnify x y) = do
  x <- desugarExpression gcxt mempty x
  y <- desugarExpression gcxt mempty y
  (subst, _) <- unify (Context {metas = mempty, globals = gcxt}) $ S.singleton (x, y, 0)
  trace ("%check " <> show x <> " = " <> show y)
  forM_ (assocs subst) $
    trace . ("  " <>) . uncurry ((<>) . (<> " = ")) . (show . T.Meta undefined *** show)
  pure mempty
elaborate' gcxt (CheckTypeOf value type') = do
  value <- desugarExpression gcxt mempty value
  type' <- desugarExpression gcxt mempty type'
  (_, _, subst, _) <- infer gcxt mempty value type'
  trace ("%check " <> show value <> " : " <> show type')
  forM_ (assocs subst) $
    trace . ("  " <>) . uncurry ((<>) . (<> " = ")) . (show . T.Meta undefined *** show)
  pure mempty
elaborate' gcxt _ = pure mempty

unzipArgs :: [T.Argument] -> ([(LocalName, T.Plicity)], [T.Term])
unzipArgs args = unzip $ (\(T.Argument name type' plicity) -> ((name, plicity), type')) <$> args

elaborate :: Member Trace r => AST.Source -> Sem r GlobalContext
elaborate (AST.Source xs) = do
  foldM
    ( \xs y ->
        do
          x <- (listToMaybe <$>) . runUnifyM $ elaborate' xs y
          case x of
            Nothing -> error "!"
            Just x -> pure $ xs <> x
    )
    mempty
    xs
