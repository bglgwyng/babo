{-# OPTIONS_GHC -fplugin=Polysemy.Plugin #-}

module Concrete.Desugar where

import Common
import Concrete.Literal
import Concrete.Pattern
import qualified Concrete.Pattern as P
import Concrete.Pretty
import Concrete.Syntax
import qualified Concrete.Syntax as C
import Context
import Control.Applicative
import Control.Arrow (Arrow (first, second, (&&&)), (>>>))
import Control.Monad (foldM, forM, forM_, guard, unless, when, (>=>))
import Control.Monad.Cont (Cont, ContT (ContT, runContT), MonadCont (callCC), MonadTrans (lift), cont, runCont)
import Control.Monad.Writer (MonadWriter (tell), WriterT)
import Core.Term (InductiveType (..), Plicity (..), Term (..), raise)
import qualified Core.Term as T
import Core.Unification (UnifyEffect, genMeta)
import Data.Bifunctor (bimap)
import Data.Bool (bool)
import Data.Either (fromLeft, partitionEithers)
import Data.Either.Extra (fromRight)
import Data.Function (on)
import Data.Functor ((<&>))
import Data.List (find, groupBy)
import Data.List.Extra (allSame, elemIndex, groupOn)
import Data.List.NonEmpty (NonEmpty ((:|)), groupWith, toList)
import Data.Map as M (Map, delete, fromList, lookup, member, singleton)
import Data.Maybe (catMaybes, fromJust, fromMaybe, isNothing)
import Data.Tuple.Extra (dupe, firstM, swap)
import Debug.Trace
import Effect.ElaborationError (ElaborationError (..))
import Effect.Gen (Gen, gen)
import Polysemy (Embed (unEmbed), Member, Members, Sem)
import Polysemy.Error (Error, throw)
import Polysemy.State (State, evalState, get, modify, runState)

pairNew :: T.Term
pairNew = T.Global (QName ["Prelude", "Pair"] "New")

listCons :: T.Term
listCons = T.Global (QName ["Prelude", "List"] "Cons")

listNil :: T.Term
listNil = T.Global (QName ["Prelude", "List"] "Nil")

setAt :: Int -> a -> [a] -> [a]
setAt i x xs = take i xs ++ [x] ++ drop (i + 1) xs

data Match = Constructor QName | Literal Literal | Self
  deriving (Eq, Ord, Show)

type Effects = '[Error ElaborationError, UnifyEffect]

extend :: Level -> LocalContext -> LocalContext
extend = (<>) . (`replicate` "_")

desugarExpression :: Members Effects r => GlobalContext -> LocalContext -> C.Expression -> Sem r T.Term
desugarExpression gcxt = desugar'
  where
    desugar' :: Members Effects r => LocalContext -> C.Expression -> Sem r T.Term
    desugar' cxt x = do
      (x, spine) <- desugarHead cxt x
      metas <- mapM (const $ insertMeta cxt) $ takeWhile ((== T.Implicit) . snd) spine
      pure $ foldl T.Ap x metas
    desugarHead :: Members Effects r => LocalContext -> C.Expression -> Sem r (T.Term, [(LocalName, Plicity)])
    desugarHead cxt = \case
      C.Application head spine -> do
        (head', args) <- desugarHead cxt head
        (spine, args') <- apply (toList spine) args
        pure (foldl T.Ap head' spine, args')
        where
          apply :: Members Effects r => [C.Disk] -> [(LocalName, Plicity)] -> Sem r ([T.Term], [(LocalName, Plicity)])
          apply [] args = pure ([], args)
          apply xs []
            | all (isNothing . fst) xs = (,[]) <$> forM xs (desugar'' . snd)
            | otherwise = error "?"
          apply xs'@((Just name, x) : xs) ((arg, _) : args)
            | name == arg = (first . (:) <$> desugar'' x) <*> apply xs args
            | otherwise = (first . (:) <$> insertMeta cxt) <*> apply xs' args
          apply ((Nothing, x) : xs) ((_, T.Explicit) : args) = (first . (:) <$> desugar'' x) <*> apply xs args
          apply xs ((_, T.Implicit) : args) = (first . (:) <$> insertMeta cxt) <*> apply xs args
      C.Identifier x -> lookup x
      C.Meta -> ((,[]) <$> insertMeta cxt)
      C.ForAll xs from to ->
        (,[]) <$> forall cxt (toList xs)
        where
          forall :: Members Effects r => LocalContext -> [LocalName] -> Sem r T.Term
          forall _ [] = desugar' (reverse (toList xs) <> cxt) to
          forall cxt (x : xs) =
            T.Pi <$> desugar'' from <*> forall (extend 1 cxt) xs
      C.Arrow from to ->
        (,[]) <$> (T.Pi <$> desugar'' from <*> desugar' (extend 1 cxt) to)
      C.Let name value body ->
        (,[]) <$> (T.Ap <$> (T.Lam <$> insertMeta cxt <*> desugar' (name : cxt) body) <*> desugar'' value)
      C.Case xs cases -> do
        xs' <- forM xs desugar''
        y <- go (zipWith const [0 ..] xs) ((extend (length xs') cxt,) . first (desugarPattern <$>) <$> cases)
        pure (foldr T.Let y xs', [])
        argTypes <- forM xs' (const $ insertMeta cxt)
        pure (foldr (flip T.Ap) (foldr T.Lam y argTypes) xs', [])
        where
          go :: Members Effects r => [Index] -> [(LocalContext, ([Pattern'], C.Expression))] -> Sem r T.Term
          go [] [(cxt, ([], body))] = desugar' cxt body
          go [] _ = throw InvalidPatterns
          go (x : xs) branches = do
            let (matches, bindings) =
                  partitionEithers $
                    ( \(cxt, (Pattern' binder subPattern : ps, body)) ->
                        let cxt' = setAt x binder cxt
                         in case subPattern of
                              Just (ctorName, argPatterns) -> Left (ctorName, (argPatterns, (cxt', (ps, body))))
                              _ -> Right (cxt', (ps, body))
                    )
                      <$> branches
            defaults <- if null bindings then pure Nothing else Just <$> go xs bindings
            if null matches
              then case defaults of
                Just x -> pure x
                _ -> error "not implemented"
              else do
                ind <- do
                  let constructors = fst <$> matches
                      lookupConstructor qname@QName {namespace, Common.name} =
                        maybe (throw $ ConstructorNotFound qname) pure $
                          M.lookup qname gcxt >>= (\case DataConstructor {ind} -> pure ind; _ -> Nothing)
                  -- FIXME:
                  indNominees <- forM constructors lookupConstructor
                  if allSame indNominees
                    then pure $ head indNominees
                    else throw InvalidPatterns
                ys <-
                  forM
                    (groupWith fst matches)
                    ( \ys@((QName {name}, _) :| _) -> do
                        let Just (args, _) = snd <$> find ((== name) . fst) (T.variants ind)
                            arity = length args
                            branches = snd <$> ys
                        forM_ branches \(argPatterns, _) -> unless (length argPatterns == arity) $ throw InvalidPatterns
                        (T.Constructor name,)
                          <$> go
                            -- FIXME: inefficiency
                            ([arity - 1, arity - 2 .. 0] ++ ((arity +) <$> xs))
                            ( toList $
                                ( \(argPatterns, (cxt, (patterns, body))) ->
                                    ( (binder <$> argPatterns) <> cxt,
                                      (argPatterns <> patterns, body)
                                    )
                                )
                                  <$> branches
                            )
                    )
                pure $ T.Case x (Just ind) ys defaults
          introduce argPatterns (cxt, (patterns, body)) =
            ((binder <$> argPatterns) <> cxt, (argPatterns <> patterns, body))
      C.Lambda args body -> (,[]) <$> lambda cxt (toList args) body
      C.LambdaCase args cases -> error "not implemented"
      C.Infix x op y ->
        (,[]) <$> (T.Ap <$> (T.Ap <$> (fst <$> lookup op) <*> desugar'' x) <*> desugar'' y)
      C.Tuple xs -> do
        xs' <- forM xs desugar''
        pure (foldl1 (T.Ap . T.Ap pairNew) xs', [])
      C.List xs -> do
        xs' <- forM xs desugar''
        pure (foldr (flip T.Ap . T.Ap listCons) listNil xs', [])
      C.Type -> pure (T.Type, [])
      C.Literal x -> error "not implemented"
      C.Parenthesized x -> desugarHead cxt x
      where
        scope = length cxt
        desugar'' :: Members Effects r => C.Expression -> Sem r Term
        desugar'' = desugar' cxt
        lookup :: Member (Error ElaborationError) r => QName -> Sem r (T.Term, [(LocalName, Plicity)])
        lookup qname@QName {namespace, Common.name} =
          maybe (throw $ NameNotFound qname) pure $
            ( if null namespace
                then (,[]) . T.Local <$> elemIndex name cxt
                else Nothing
            )
              <|> ( (T.Global qname,)
                      . Context.args
                      <$> M.lookup qname gcxt
                  )
    lambda :: Members Effects r => LocalContext -> [C.Argument] -> C.Expression -> Sem r T.Term
    lambda cxt args body = do
      (cxt', args) <- desugarArguments gcxt cxt ((Explicit,) . (: []) <$> args)
      let argTypes = T.type' <$> args
      body' <- desugarExpression gcxt cxt' body
      pure $ foldr T.Lam body' argTypes

insertMeta :: Members Effects r => LocalContext -> Sem r T.Term
insertMeta cxt = genMeta (length cxt)

desugarArguments :: Members Effects r => GlobalContext -> LocalContext -> [ArgumentGroup] -> Sem r (LocalContext, [T.Argument])
desugarArguments gcxt cxt xs = second concat <$> runState cxt (forM xs go)
  where
    go :: Members (State LocalContext : Effects) r => ArgumentGroup -> Sem r [T.Argument]
    go (plicity, args) =
      (concat <$>) <$> forM args $ \(names, type', _) -> do
        cxt <- get
        type'' <- maybe (insertMeta cxt) (desugarExpression gcxt cxt) type'
        modify (reverse (toList names) <>)
        let args' = (\name -> T.Argument {name, plicity, type' = type''}) <$> names
        pure $ toList args'

-- pure $ concat xs

-- FIXME: remove it
data Pattern' = Pattern'
  { binder :: LocalName,
    subPattern :: Maybe (QName, [Pattern'])
  }
  deriving (Show)

desugarPattern :: C.Pattern -> Pattern'
desugarPattern (Variable name) = Pattern' name Nothing
desugarPattern (Data name patterns) = Pattern' "" (Just (name, desugarPattern . fromRight (error "not implemented") <$> patterns))
desugarPattern Wildcard = Pattern' "" Nothing
desugarPattern _ = error "not implemented"
