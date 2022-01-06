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
import Control.Arrow (Arrow (first, second, (&&&)), (>>>))
import Control.Monad (foldM, forM, unless)
import Control.Monad.Cont (Cont, ContT (ContT, runContT), MonadCont (callCC), MonadTrans (lift), cont, runCont)
import Control.Monad.Gen (Gen, GenT, gen)
import Core.Term (Inductive (..))
import qualified Core.Term as T
import Core.Unification (subst)
import Data.Bifunctor (bimap)
import Data.Bool (bool)
import Data.Either (fromLeft)
import Data.Either.Extra (fromRight)
import Data.Function (on)
import Data.Functor ((<&>))
import Data.List (groupBy)
import Data.List.Extra (allSame, elemIndex)
import Data.List.NonEmpty (NonEmpty (..), groupWith, groupWith1, nonEmpty, toList, uncons)
import Data.List.NonEmpty.Extra (groupWith)
import Data.Map as M (Map, delete, fromList, lookup, member, singleton)
import Data.Maybe (catMaybes, fromJust, fromMaybe)
import Data.Tuple.Extra (dupe, firstM)
import GHC.Base (undefined)
import GHC.Err (undefined)
import Syntax.AST (TopLevelStatement (..))
import qualified Syntax.AST as AST
import Syntax.Literal
import Syntax.Pattern
import qualified Syntax.Pattern as P
import Syntax.Pretty

pairNew :: T.Term
pairNew = T.Global (QName ["Prelude", "Pair"] "New")

listCons :: T.Term
listCons = T.Global (QName ["Prelude", "List"] "Cons")

listNil :: T.Term
listNil = T.Global (QName ["Prelude", "List"] "Nil")

extend :: [String] -> [String]
extend = ("_" :)

setAt :: Int -> a -> [a] -> [a]
setAt i x xs = take i xs ++ [x] ++ drop (i + 1) xs

data Match = Constructor QName | Literal Literal | Self
  deriving (Eq, Ord, Show)

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
        pure $ fromMaybe (error (show x)) (lookup x)
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
        T.Ap <$> (T.Lam <$> (T.Meta (length ctx + 1) <$> gen) <*> desugar' (name : ctx) body) <*> desugar'' value
      AST.Case xs cases -> do
        xs' <- forM xs desugar''
        let bounds = reverse [0 .. length xs' - 1]
        let scopeLevel = length ctx
        y <- go bounds ((ctx,) <$> cases)
        argTypes <- forM (zip [scopeLevel ..] xs') (T.Meta . fst >>> (<$> gen))
        -- pure (foldr (flip T.Ap) (foldr T.Lam y argTypes) xs')
        pure (foldr (uncurry (flip subst)) y (zip bounds xs'))
        where
          go :: [Int] -> [(LocalContext, AST.Case)] -> Gen Id T.Term
          go xs [(ctx, ([], body))] = desugar' ctx body
          go (x : xs) [(ctx, (Variable name : ys, body))] = go xs [(setAt x name ctx, (ys, body))]
          go (x : xs) branches =
            -- FIXME: remove fromJust
            T.Case (T.Local x) inductive
              <$> forM
                (groupBy (on equivalent (head . fst . snd)) branches)
                ( \cases ->
                    let ((_, (headCase : _, _)) : _) = cases
                     in case headCase of
                          Data x argPats ->
                            (T.Constructor x,)
                              <$> go ([arity - 1, arity - 2 .. 0] ++ ((arity +) <$> xs)) (introduce <$> cases)
                            where
                              -- FIXME:
                              arity = length argPats
                              introduce :: (LocalContext, AST.Case) -> (LocalContext, AST.Case)
                              introduce (locals, (Data _ argPats : patterns, body)) =
                                ( replicate arity "" <> locals,
                                  ((fromRight undefined <$> argPats) <> patterns, body)
                                )
                              introduce _ = undefined
                          Variable name -> (T.Self,) <$> go xs (introduce <$> cases)
                            where
                              introduce :: (LocalContext, AST.Case) -> (LocalContext, AST.Case)
                              introduce (locals, (Variable name : patterns, body)) =
                                (setAt x name locals, (patterns, body))
                              introduce _ = undefined
                          _ -> error "?"
                )
            where
              inductive =
                let headPatterns = head . fst . snd <$> branches
                    constructorPatterns = catMaybes ((\case Data name _ -> Just name; _ -> Nothing) <$> headPatterns)
                    inductives =
                      traverse
                        (\case Just (DataConstructor _ x) -> Just x; _ -> Nothing)
                        (flip M.lookup globalCtx <$> constructorPatterns)
                 in do
                      x : _ <- inductives
                      pure x
          go x y = error (show (x, y))
          equivalent :: AST.Pattern -> AST.Pattern -> Bool
          equivalent (Data x _) (Data y _) = x == y
          equivalent (P.Literal x) (P.Literal y) = x == y
          equivalent (Variable _) (Variable _) = True
          equivalent (Variable _) Wildcard = True
          equivalent Wildcard (Variable _) = True
          equivalent Wildcard Wildcard = True
          equivalent _ _ = False
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
      let argTypes = (\(T.Argument _ x _) -> x) <$> args
      body' <- desugarExpression globalCtx context body
      pure $ foldr T.Lam body' argTypes

desugarArguments :: GlobalContext -> LocalContext -> [AST.Argument] -> (Gen Id) ([T.Argument], LocalContext)
desugarArguments globalCtx = go
  where
    go :: LocalContext -> [AST.Argument] -> (Gen Id) ([T.Argument], LocalContext)
    go ctx [] = pure ([], [])
    go ctx ((names, type', _) : xs) = do
      type'' <- maybe (T.Meta (length ctx) <$> gen) (desugarExpression globalCtx ctx) type'
      (args, context) <- go (toList names <> ctx) xs
      pure
        ( toList ((\x -> T.Argument x type'' T.Explicit) <$> names) <> args,
          context <> reverse (toList names)
        )
