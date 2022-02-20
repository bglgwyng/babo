module Syntax.Desugar where

import Common
import Context
import Control.Applicative
import Control.Arrow (Arrow (first, second, (&&&)), (>>>))
import Control.Monad (foldM, forM, guard, unless, (>=>))
import Control.Monad.Cont (Cont, ContT (ContT, runContT), MonadCont (callCC), MonadTrans (lift), cont, runCont)
import Control.Monad.Writer (MonadWriter (tell), WriterT)
import Core.Term (InductiveType (..), Plicity (..), Term (..))
import qualified Core.Term as T
import Core.Unification (UnifyEffect, genMeta)
import Data.Bifunctor (bimap)
import Data.Bool (bool)
import Data.Either (fromLeft)
import Data.Either.Extra (fromRight)
import Data.Function (on)
import Data.Functor ((<&>))
import Data.List (find, groupBy)
import Data.List.Extra (allSame, elemIndex)
import Data.List.NonEmpty (NonEmpty (..), groupWith, groupWith1, nonEmpty, toList, uncons)
import Data.List.NonEmpty.Extra (groupWith)
import Data.Map as M (Map, delete, fromList, lookup, member, singleton)
import Data.Maybe (catMaybes, fromMaybe, isNothing)
import Data.Tuple.Extra (dupe, firstM)
import Debug.Trace
import Effect.ElaborationError (ElaborationError (..))
import Effect.Gen (Gen, gen)
import Polysemy (Member, Members, Sem)
import Polysemy.Error (Error, throw)
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

-- type GlobalContext = Map QName ([(LocalName, Plicity)], Maybe InductiveType)

type Effects = '[Error ElaborationError, UnifyEffect]

desugarExpression :: Members Effects r => GlobalContext -> LocalContext -> AST.Expression -> Sem r T.Term
desugarExpression gcxt = desugar'
  where
    desugar' :: Members Effects r => LocalContext -> AST.Expression -> Sem r T.Term
    desugar' cxt x = fst <$> desugarHead cxt x
    desugarHead :: Members Effects r => LocalContext -> AST.Expression -> Sem r (T.Term, [(LocalName, Plicity)])
    desugarHead cxt = \case
      AST.Application head spine -> do
        (head', args) <- desugarHead cxt head
        (spine, args') <- apply (toList spine) args
        pure (foldl T.Ap head' spine, args')
        where
          apply :: Members Effects r => [AST.Disk] -> [(LocalName, Plicity)] -> Sem r ([T.Term], [(LocalName, Plicity)])
          apply [] args = pure ([], args)
          apply xs []
            | all (isNothing . fst) xs = (,[]) <$> forM xs (desugar'' . snd)
            | otherwise = error "?"
          apply xs'@((Just name, x) : xs) ((arg, _) : args)
            | name == arg = (first . (:) <$> desugar'' x) <*> apply xs args
            | otherwise = (first . (:) <$> insertMeta cxt) <*> apply xs' args
          apply ((Nothing, x) : xs) ((_, T.Explicit) : args) = (first . (:) <$> desugar'' x) <*> apply xs args
          apply xs ((_, T.Implicit) : args) = (first . (:) <$> insertMeta cxt) <*> apply xs args
      AST.Identifier x -> (lookup x)
      AST.Meta -> ((,[]) <$> insertMeta cxt)
      AST.ForAll xs from to ->
        (,[]) <$> forall cxt (toList xs)
        where
          forall :: Members Effects r => LocalContext -> [LocalName] -> Sem r T.Term
          forall _ [] = desugar' (reverse (toList xs) <> cxt) to
          forall cxt (x : xs) =
            T.Pi <$> desugar'' from <*> forall (extend cxt) xs
      AST.Arrow from to ->
        (,[]) <$> (T.Pi <$> desugar'' from <*> desugar' (extend cxt) to)
      AST.Let name value body ->
        (,[]) <$> (T.Ap <$> (T.Lam <$> insertMeta cxt <*> desugar' (name : cxt) body) <*> desugar'' value)
      AST.Case xs cases -> do
        xs' <- forM xs desugar''
        let bounds = reverse [0 .. length xs' - 1]
        y <- go bounds ((cxt,) <$> cases)
        argTypes <- forM xs' (const $ insertMeta cxt)
        pure (foldr (flip T.Ap) (foldr T.Lam y argTypes) xs', [])
        where
          go :: Members Effects r => [Int] -> [(LocalContext, AST.Case)] -> Sem r T.Term
          go xs [(cxt, ([], body))] = desugar' cxt body
          go (x : xs) [(cxt, (Variable name : ys, body))] = go xs [(setAt x name cxt, (ys, body))]
          go (x : xs) branches =
            T.Case (T.Local x) . Just <$> ind
              <*> forM
                (groupBy (on equivalent (head . fst . snd)) branches)
                ( \cases ->
                    let ((_, (headCase : _, _)) : _) = cases
                     in case headCase of
                          Data QName {name} argPats ->
                            (T.Constructor name,)
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
              ind :: Member (Error ElaborationError) r => Sem r InductiveType
              ind = do
                let headPatterns = head . fst . snd <$> branches
                    constructorPatterns = catMaybes ((\case Data name _ -> Just name; _ -> Nothing) <$> headPatterns)
                -- FIXME:
                indNominees <- forM constructorPatterns lookupConstructor
                if allSame indNominees
                  then pure $ head indNominees
                  else throw InvalidPatterns
              lookupConstructor :: Member (Error ElaborationError) r => QName -> Sem r InductiveType
              lookupConstructor qname@QName {namespace, Common.name} =
                maybe (throw $ ConstructorNotFound qname) pure $
                  M.lookup qname gcxt >>= (\case DataConstructor {ind} -> pure ind; _ -> Nothing)
          go x y = error (show (x, y))
          equivalent :: AST.Pattern -> AST.Pattern -> Bool
          equivalent (Data x _) (Data y _) = x == y
          equivalent (P.Literal x) (P.Literal y) = x == y
          equivalent (Variable _) (Variable _) = True
          equivalent (Variable _) Wildcard = True
          equivalent Wildcard (Variable _) = True
          equivalent Wildcard Wildcard = True
          equivalent _ _ = False
      AST.Lambda args body -> (,[]) <$> lambda cxt (toList args) body
      AST.LambdaCase args cases -> undefined
      AST.Infix x op y ->
        (,[]) <$> (T.Ap <$> (T.Ap <$> (fst <$> lookup op) <*> desugar'' x) <*> desugar'' y)
      AST.Tuple xs -> do
        xs' <- forM xs desugar''
        pure (foldl1 (T.Ap . T.Ap pairNew) xs', [])
      AST.List xs -> do
        xs' <- forM xs desugar''
        pure (foldr (flip T.Ap . T.Ap listCons) listNil xs', [])
      AST.Type -> pure (T.Type, [])
      AST.Literal x -> undefined
      AST.Parenthesized x -> desugarHead cxt x
      where
        scope = length cxt
        desugar'' :: Members Effects r => AST.Expression -> Sem r Term
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
    lambda :: Members Effects r => LocalContext -> [AST.Argument] -> AST.Expression -> Sem r T.Term
    lambda cxt args body = do
      (args, cxt') <- desugarArguments gcxt cxt args
      let argTypes = T.type' <$> args
      body' <- desugarExpression gcxt (cxt' <> cxt) body
      pure $ foldr T.Lam body' argTypes

insertMeta :: Members Effects r => LocalContext -> Sem r T.Term
insertMeta cxt = genMeta (length cxt)

desugarArguments :: Members Effects r => GlobalContext -> LocalContext -> [AST.Argument] -> Sem r ([T.Argument], LocalContext)
desugarArguments gcxt = go
  where
    go :: Members Effects r => LocalContext -> [AST.Argument] -> Sem r ([T.Argument], LocalContext)
    go cxt [] = pure ([], [])
    go cxt ((names, type', _) : args) = do
      type'' <- maybe (insertMeta cxt) (desugarExpression gcxt cxt) type'
      let args' = bindName type'' <$> names
          names' = reverse $ toList (T.name <$> args')
      (args, context) <- go (names' <> cxt) args
      pure
        ( toList args' <> args,
          context <> names'
        )
      where
        bindName :: T.Term -> LocalName -> T.Argument
        bindName type' ('\'' : name) = T.Argument {name, plicity = T.Implicit, type'}
        bindName type' name = T.Argument {name, plicity = T.Explicit, type'}
