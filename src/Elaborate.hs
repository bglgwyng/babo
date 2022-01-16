module Elaborate where

import Common (Id, Level, LocalName, QName (QName, name))
import Context (GlobalContext, Inhabitant (..), LocalContext)
import qualified Context
import Control.Arrow ((&&&), (>>>))
import Control.Monad (foldM)
import Control.Monad.Identity (Identity (Identity), IdentityT (runIdentityT), runIdentity)
import Control.Monad.Logic
import Control.Monad.Trans (lift)
import Core.Client (infer)
import qualified Core.Term as T
import Core.Unification (Context (..), UnifyM, manySubst, reduce, runUnifyM, subst, substFV, unify)
import Data.Bifunctor
import Data.Functor
import Data.List.NonEmpty (NonEmpty (..))
import Data.Map (fromList, singleton)
import qualified Data.Map as M
import Data.Maybe (listToMaybe)
import qualified Data.Set as S
import Data.Traversable (forM)
import Data.Tuple (swap)
import Data.Tuple.Extra (both)
import Debug.Trace (traceM)
import Effect.Gen (gen)
import Polysemy (Member, Members, Sem, run)
import Syntax.AST
import qualified Syntax.AST as AST
import Syntax.Desugar (desugarArguments, desugarExpression)
import qualified Syntax.Desugar as D

-- foo :: GlobalContext -> D.GlobalContext
-- foo xs = bar <$> xs
--   where
--     bar (DataConstructor args _ ind) = (args, Just ind)
--     bar x = (args x, Nothing)

elaborate' :: Members UnifyM r => GlobalContext -> AST.TopLevelStatement -> Sem r GlobalContext
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
  type' <- foldr T.Pi `flip` argTypes <$> (maybe (T.Meta (length argTypes) <$> gen) (desugarExpression gcxt cxt') maybeType)
  value' <- foldr T.Lam `flip` argTypes <$> (desugarExpression gcxt cxt' value)
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
  (value', _, _, _) <- infer gcxt mempty value meta
  traceM ("%eval " <> show value <> " = " <> show (reduce Context {globals = gcxt} value'))
  pure mempty
elaborate' gcxt (TypeOf x) = do
  meta <- T.Meta 0 <$> gen
  value <- desugarExpression gcxt mempty x
  (_, type', _, _) <- infer gcxt mempty value meta
  traceM ("%check " <> show value <> " : " <> show type')
  pure mempty
elaborate' gcxt (CheckUnify x y) = do
  x <- desugarExpression gcxt mempty x
  y <- desugarExpression gcxt mempty y
  (subst, _) <- unify (Context {metas = mempty}) $ S.singleton (x, y, 0)
  traceM ("%check " <> show x <> " = " <> show y)
  pure mempty
elaborate' gcxt (CheckTypeOf value type') = do
  value <- desugarExpression gcxt mempty value
  type' <- desugarExpression gcxt mempty type'
  (_, _, subst, _) <- infer gcxt mempty value type'
  traceM ("%check " <> show value <> " : " <> show type')
  pure mempty
elaborate' gcxt _ = pure mempty

unzipArgs :: [T.Argument] -> ([(LocalName, T.Plicity)], [T.Term])
unzipArgs args = unzip $ (\(T.Argument name type' plicity) -> ((name, plicity), type')) <$> args

elaborate :: AST.Source -> Maybe GlobalContext
elaborate (AST.Source xs) =
  foldM
    ( \xs y ->
        do
          ys <- listToMaybe . run . runUnifyM $ elaborate' xs y
          pure $ xs <> ys
    )
    mempty
    xs
