{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE TupleSections #-}

module Syntax.Desugar where

import Common
import Context
import Control.Applicative
import Control.Arrow ((>>>))
import Control.Monad (foldM, forM)
import Control.Monad.Cont (Cont, ContT (ContT, runContT), MonadCont (callCC), MonadTrans (lift), cont, runCont)
import Control.Monad.Gen (Gen, GenT, gen)
import qualified Core.Term as T
import Data.Functor ((<&>))
import Data.List.Extra (elemIndex)
import Data.List.NonEmpty (NonEmpty (..), toList, uncons)
import Data.Map (Map, fromList, member, singleton)
import Data.Maybe (fromJust)
import Debug.Trace
import Syntax.AST (TopLevelStatement (..))
import qualified Syntax.AST as AST
import Syntax.Literal

pairNew = T.GlobalVar ("Prelude" :| ["Pair", "New"])

listCons = T.GlobalVar ("Prelude" :| ["List", "Cons"])

listNil = T.GlobalVar ("Prelude" :| ["List", "Nil"])

extend = ("_" :)

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
        T.Ap <$> (T.Lam <$> (T.MetaVar <$> gen) <*> desugar' (name : ctx) body) <*> desugar'' value
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
      AST.Type -> pure T.Uni
      AST.Literal x -> undefined
      AST.Parenthesized x -> desugar'' x
      where
        desugar'' = desugar' ctx
        lookup :: Name -> Maybe T.Term
        lookup x'@(x :| xs) =
          ( if null xs
              then T.LocalVar <$> elemIndex x ctx
              else Nothing
          )
            <|> if x' `member` globalCtx then Just (T.GlobalVar x') else Nothing
    lambda :: LocalContext -> [AST.Argument] -> AST.Expression -> (Gen Id) T.Term
    lambda ctx xs body = do
      (args, context) <- desugarArguments globalCtx ctx xs
      body' <- desugarExpression globalCtx context body
      pure $ foldr T.Lam body' args

-- lambda ctx ((names, type') : xs) = do
--   type'' <- lift $ maybe (T.MetaVar <$> gen) (desugar' ctx) type'
--   ContT $ fmap (T.Lam type'') . runContT (lambda (toList names <> ctx) xs)

desugarArguments :: GlobalContext -> LocalContext -> [AST.Argument] -> (Gen Id) ([T.Term], LocalContext)
desugarArguments globalCtx = go
  where
    go :: LocalContext -> [AST.Argument] -> (Gen Id) ([T.Term], LocalContext)
    go ctx [] = pure ([], [])
    go ctx ((names, type', _) : xs) = do
      type'' <- maybe (T.MetaVar <$> gen) (desugarExpression globalCtx ctx) type'
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