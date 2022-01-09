module Syntax.Desugar where

import Common
import Context
import Control.Applicative
import Control.Arrow (Arrow (first, second, (&&&)), (>>>))
import Control.Monad (foldM, forM, unless)
import Control.Monad.Cont (Cont, ContT (ContT, runContT), MonadCont (callCC), MonadTrans (lift), cont, runCont)
import Control.Monad.Gen (Gen, GenT, gen)
import Core.Term (InductiveType (..), Term (..))
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
desugarExpression gcxt = desugar'
  where
    desugar' :: LocalContext -> AST.Expression -> Gen Id T.Term
    desugar' cxt = \case
      AST.Application head spine -> do
        head' <- desugar' cxt head
        spine <- forM spine (desugar'' . snd)
        pure $ foldl T.Ap head' spine
      AST.Identifier x ->
        pure $ fromMaybe (error (show x)) (lookup x)
      AST.ForAll xs from to ->
        forall cxt (toList xs)
        where
          forall :: LocalContext -> [LocalName] -> Gen Id T.Term
          forall _ [] = desugar' (toList xs <> cxt) to
          forall cxt (x : xs) =
            T.Pi <$> desugar'' from <*> forall (extend cxt) xs
      AST.Arrow from to ->
        T.Pi <$> desugar'' from <*> desugar' (extend cxt) to
      AST.Let name value body ->
        T.Ap <$> (T.Lam <$> (T.Meta (length cxt + 1) <$> gen) <*> desugar' (name : cxt) body) <*> desugar'' value
      AST.Case xs cases -> do
        xs' <- forM xs desugar''
        let bounds = reverse [0 .. length xs' - 1]
        let scopeLevel = length cxt
        y <- go bounds ((cxt,) <$> cases)
        argTypes <- forM (zip [scopeLevel ..] xs') (T.Meta . fst >>> (<$> gen))
        pure (foldr (flip T.Ap) (foldr T.Lam y argTypes) xs')
        where
          -- pure (foldr (uncurry (flip subst)) y (zip bounds xs'))
          go :: [Int] -> [(LocalContext, AST.Case)] -> Gen Id T.Term
          go xs [(cxt, ([], body))] = desugar' cxt body
          go (x : xs) [(cxt, (Variable name : ys, body))] = go xs [(setAt x name cxt, (ys, body))]
          go (x : xs) branches =
            T.Case (T.Local x) ind
              <$> forM
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
              ind =
                let headPatterns = head . fst . snd <$> branches
                    constructorPatterns = catMaybes ((\case Data name _ -> Just name; _ -> Nothing) <$> headPatterns)
                    indNominees =
                      traverse
                        (\case Just (Context.DataConstructor _ type' value) -> Just value; _ -> Nothing)
                        (flip M.lookup gcxt <$> constructorPatterns)
                 in do
                      undefined
          --  FIXME:
          -- DataConstructor ind _ : _ <- indNominees
          -- pure ind
          go x y = error (show (x, y))
          equivalent :: AST.Pattern -> AST.Pattern -> Bool
          equivalent (Data x _) (Data y _) = x == y
          equivalent (P.Literal x) (P.Literal y) = x == y
          equivalent (Variable _) (Variable _) = True
          equivalent (Variable _) Wildcard = True
          equivalent Wildcard (Variable _) = True
          equivalent Wildcard Wildcard = True
          equivalent _ _ = False
      AST.Lambda args body -> lambda cxt (toList args) body
      AST.LambdaCase args cases -> lambda cxt args undefined
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
        desugar'' = desugar' cxt
        lookup :: QName -> Maybe T.Term
        lookup qname@QName {namespace, Common.name} =
          ( if null namespace
              then T.Local <$> elemIndex name cxt
              else Nothing
          )
            <|> if qname `member` gcxt then Just (T.Global qname) else Nothing
        definition :: QName -> Maybe (T.Argument, T.Term)
        definition qname@QName {namespace, Common.name} =
          if null namespace && name `elem` cxt
            then Nothing
            else undefined
    -- )
    --   <|> if qname `member` gcxt then Just (T.Global qname, T.Global qname) else Nothing
    lambda :: LocalContext -> [AST.Argument] -> AST.Expression -> (Gen Id) T.Term
    lambda cxt xs body = do
      (args, context) <- desugarArguments gcxt cxt xs
      let argTypes = (\(T.Argument _ x _) -> x) <$> args
      body' <- desugarExpression gcxt context body
      pure $ foldr T.Lam body' argTypes

desugarArguments :: GlobalContext -> LocalContext -> [AST.Argument] -> Gen Id ([T.Argument], LocalContext)
desugarArguments gcxt = go
  where
    go :: LocalContext -> [AST.Argument] -> (Gen Id) ([T.Argument], LocalContext)
    go cxt [] = pure ([], [])
    go cxt ((names, type', _) : xs) = do
      type'' <- maybe (T.Meta (length cxt) <$> gen) (desugarExpression gcxt cxt) type'
      (args, context) <- go (toList names <> cxt) xs
      let bindName :: LocalName -> T.Argument
          bindName ('\'' : name) = T.Argument name type'' T.Implicit
          bindName name = T.Argument name type'' T.Explicit
      pure
        ( toList (bindName <$> names) <> args,
          context <> reverse (toList names)
        )
