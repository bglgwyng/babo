{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TupleSections #-}

module Syntax.Desugar where

import Common
import Context
import Control.Applicative
import Control.Arrow (Arrow (first, (&&&)), (>>>))
import qualified Control.Exception as T
import Control.Monad (foldM, forM, unless)
import Control.Monad.Cont (Cont, ContT (ContT, runContT), MonadCont (callCC), MonadTrans (lift), cont, runCont)
import Control.Monad.Gen (Gen, GenT, gen)
import qualified Core.Term as T
import Data.Bifunctor (bimap)
import Data.Functor ((<&>))
import Data.List.Extra (elemIndex)
import Data.List.NonEmpty (NonEmpty (..), groupBy, groupWith, groupWith1, head, nonEmpty, tail, toList, uncons)
import Data.List.NonEmpty.Extra (groupWith)
import Data.Map (Map, fromList, member, singleton)
import Data.Maybe (fromJust)
import Data.Tuple.Extra (dupe, firstM)
import Debug.Trace
import GHC.Base (undefined)
import GHC.Err (undefined)
import Syntax.AST (TopLevelStatement (..))
import qualified Syntax.AST as AST
import Syntax.Literal
import Syntax.Pattern
import Prelude hiding (head, tail)

pairNew = T.Global (QName ["Prelude", "Pair"] "New")

listCons = T.Global (QName ["Prelude", "List"] "Cons")

listNil = T.Global (QName ["Prelude", "List"] "Nil")

extend = ("_" :)

-- groupKV :: (a -> (k, v)) -> [a] -> [(k, NonEmpty v)]
-- groupKV f = (f <$>) >>> groupWith fst >>> ((fst . head &&& (snd <$>)) <$>)

desugarExpression :: GlobalContext -> LocalContext -> AST.Expression -> Gen Id T.Term
desugarExpression globalCtx = desugar'
  where
    desugar' :: LocalContext -> AST.Expression -> Gen Id T.Term
    desugar' ctx = \case
      AST.Application head spine -> do
        head' <- desugar' ctx head
        spine <- forM spine (desugar'' . snd)
        pure $ foldl T.Ap head' spine
      AST.Identifier x ->
        pure $ fromJust (lookup x)
      AST.ForAll xs type' body ->
        forall ctx (toList xs)
        where
          forall :: LocalContext -> [LocalName] -> Gen Id T.Term
          forall _ [] = desugar' (toList xs <> ctx) body
          forall ctx (x : xs) =
            T.Pi <$> desugar'' type' <*> forall (extend ctx) xs
      AST.Arrow x y ->
        T.Pi <$> desugar'' x <*> desugar' (extend ctx) y
      AST.Let name value body ->
        T.Ap <$> (T.Lam <$> (T.Meta <$> gen) <*> desugar' (name : ctx) body) <*> desugar'' value
      AST.Case x cases -> do
        x' <- desugar'' x
        T.Case x'
          <$> forM
            cases
            ( \(pattern, y) ->
                ( (,)
                    <$> ( case pattern of
                            Data con xs -> pure $ T.Constructor con
                            _ -> undefined
                        )
                )
                  <*> desugar'' y
            )
        where
          desugarPattern :: LocalContext -> AST.Pattern -> T.Pattern
          desugarPattern ctx = \case
            Data con xs ->
              T.Constructor con
            Wildcard ->
              T.Self
            _ ->
              undefined
          go :: LocalContext -> Int -> NonEmpty AST.Expression -> [(NonEmpty AST.Pattern, AST.Expression)] -> Gen Id T.Term
          go ctx shift (x :| xs) cases = do
            let (patterns, bodies) = unzip cases
            let key :: AST.Pattern -> T.Pattern
                key = desugarPattern ctx
            let groupedCases =
                  groupBy
                    ( \(x :| _, _) (y :| _, _) ->
                        case (x, y) of
                          (Data x _, Data y _) -> x == y
                          (Variable _, Variable _) -> True
                          (Literal x, Literal y) -> x == y
                          (Wildcard, Wildcard) -> True
                          _ -> undefined
                    )
                    cases
            T.Case
              <$> desugar'' x
              <*> forM
                groupedCases
                ( \ys -> do
                    let ((y :| _, _) :| _) = ys
                    let branches = traverse (firstM (nonEmpty . tail)) ys
                    let k :: LocalContext -> Int -> Gen Id T.Term
                        k cxt shift = case (xs, branches) of
                          (x : xs, Just branches') ->
                            go ctx 0 (x :| xs) (toList branches')
                          ([], Nothing) ->
                            desugar' cxt (snd (head ys))
                          _ -> undefined
                    case y of
                      Data x _ -> (T.Constructor x,) <$> k [] 0
                      Variable x -> (T.Self,) <$> k (setAt shift x ctx) 0
                        where
                          setAt i x xs = take i xs ++ x : drop (i + 1) xs
                      _ -> undefined
                )
      AST.Lambda args body -> lambda ctx (toList args) body
      AST.LambdaCase args cases -> lambda ctx args undefined
      AST.Infix x op y ->
        T.Ap . T.Ap (fromJust $ lookup op) <$> desugar'' x <*> desugar'' y
      AST.Tuple xs -> do
        xs' <- forM xs desugar''
        pure $ foldl1 (T.Ap . T.Ap pairNew) xs'
      AST.List xs -> do
        xs' <- forM xs desugar''
        pure $ foldr (flip T.Ap . T.Ap listCons) listNil xs'
      AST.Type -> pure T.Type
      AST.Literal x -> undefined
      AST.Parenthesized x -> desugar'' x
      where
        desugar'' = desugar' ctx
        lookup :: QName -> Maybe T.Term
        lookup qname@QName {namespace, Common.name} =
          ( if null namespace
              then T.Local <$> elemIndex name ctx
              else Nothing
          )
            <|> if qname `member` globalCtx then Just (T.Global qname) else Nothing
    lambda :: LocalContext -> [AST.Argument] -> AST.Expression -> (Gen Id) T.Term
    lambda ctx xs body = do
      (args, context) <- desugarArguments globalCtx ctx xs
      body' <- desugarExpression globalCtx context body
      pure $ foldr T.Lam body' args

-- lambda ctx ((names, type') : xs) = do
--   type'' <- lift $ maybe (T.Meta <$> gen) (desugar' ctx) type'
--   ContT $ fmap (T.Lam type'') . runContT (lambda (toList names <> ctx) xs)

desugarArguments :: GlobalContext -> LocalContext -> [AST.Argument] -> (Gen Id) ([T.Term], LocalContext)
desugarArguments globalCtx = go
  where
    go :: LocalContext -> [AST.Argument] -> (Gen Id) ([T.Term], LocalContext)
    go ctx [] = pure ([], [])
    go ctx ((names, type', _) : xs) = do
      type'' <- maybe (T.Meta <$> gen) (desugarExpression globalCtx ctx) type'
      (args, context) <- go (toList names <> ctx) xs
      pure $ (replicate (length names) type'' <> args, context <> reverse (toList names))

-- ContT $ fmap (T.Lam type'') . runContT (go (toList names <> ctx) xs)

-- desugar :: AST.Source -> Gen Id GlobalContext
-- desugar (AST.Source xs) = foldM (\xs y -> (xs <>) <$> desugar' xs y) mempty xs
--   where
-- desugar' :: GlobalContext -> AST.TopLevelStatement -> Gen Id GlobalContext
-- desugar' ctx AST.DataDeclaration {name, variants} =
--   pure $
--     fromList $
--       (name :| [], TypeConstructor T.Uni) :
--       (variants <&> (\(_, x, _, _) -> (x :| [], DataConstructor T.Uni)))
-- desugar' ctx AST.Declaration {name, type'} =
--   singleton (name :| []) . Context.Declaration <$> desugarExpression ctx type'
-- desugar' ctx AST.Definition {name, maybeType, value} = do
--   x <- forM maybeType (desugarExpression ctx)
--   y <- desugarExpression ctx value
--   pure $
--     singleton
--       (name :| [])
--       (Context.Definition x y)
-- desugar' ctx AST.Import {} = undefined
