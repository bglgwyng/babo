module Core.Client (infer) where

import Common
import Context
import Control.Applicative
import Control.Arrow (Arrow (first, second, (&&&)), (***), (>>>))
import Control.Monad
import Control.Monad.Logic (Logic)
import Control.Monad.Trans
import Core.Term (InductiveType (..))
import qualified Core.Term as T
import Core.Unification
import qualified Core.Unification as U
import Data.Foldable (find)
import Data.Function ((&))
import Data.Functor
import Data.List (uncons)
import Data.List.Extra (snoc)
import Data.List.NonEmpty (NonEmpty)
import qualified Data.Map as M
import Data.Maybe
import Data.Monoid hiding (Ap)
import Data.Set (fromList)
import qualified Data.Set as S
import Effect.ElaborationError (ElaborationError (..))
import Effect.Gen (gen)
import Polysemy (Embed, Member, Members, Sem, embed)
import Polysemy.Error (throw)

typeOf :: Members U.Effects r => Level -> Context -> M.Map Id Term -> M.Map Id Term -> Term -> Sem r (Term, S.Set Constraint)
typeOf level gcxt@Context {globals} mcxt cxt t =
  case t of
    Local i -> mzero
    Free _ i -> maybe mzero (pure . (,S.empty)) $ M.lookup i cxt
    -- NOTE: really?
    Meta _ i -> maybe ((,S.empty) . T.Meta level <$> gen) (pure . (,S.empty)) $ M.lookup i mcxt
    Global i ->
      maybe
        undefined
        (pure . (type' >>> (,mempty)))
        $ M.lookup i globals
    Type -> pure (Type, S.empty)
    Ap l r -> do
      (lType, cs) <- typeOf' mcxt cxt l
      case lType of
        Pi from to ->
          (subst r 0 to,)
            . (cs <>)
            . (uncurry (<>) . first (S.singleton . (,from,level)))
            <$> typeOf' mcxt cxt r
        _ -> throw ApplyToNonFunction
    Lam arg b -> do
      v <- gen
      (toType, cs) <-
        typeOf
          (level + 1)
          gcxt
          mcxt
          (M.insert v arg cxt)
          (subst (Free level v) 0 b)
      pure
        (Pi arg (substFV (Local 0) v (raise 1 toType)), cs)
    Pi from to -> do
      v <- gen
      cs <-
        (uncurry (<>) . first (S.singleton . (Type,,level)) <$> typeOf' mcxt cxt from)
          <|> mzero
      (toType, toCs) <- typeOf (level + 1) gcxt mcxt (M.insert v from cxt) (subst (Free level v) 0 to)
      pure
        ( Type,
          cs
            <> toCs
            <> S.singleton (Type, toType, level + 1)
        )
    Case x (Just ind) cases -> do
      (xType, cs) <- typeOf' mcxt cxt x
      let InductiveType {qname = indName, params, indices, variants} = ind
          QName {namespace} = indName
      -- TODO: is reduce necessary?
      (spine, cs'') <- case peelApTelescope (reduce gcxt xType) of
        (Global name, spine)
          | name == indName -> pure (spine, mempty)
          | otherwise ->
            throw InvalidCase
        _ -> do
          paramMetas <- forM params (const $ T.Meta level <$> gen)
          indexMetas <- forM indices (const $ T.Meta level <$> gen)
          let spine = paramMetas <> indexMetas
          pure (spine, S.singleton (xType, applyApTelescope (Global indName) spine))
      (toTypes, cs') <-
        unzip
          <$> forM
            cases
            ( \(T.Constructor name, body) -> do
                let Just (_, (args, _)) = find (\(name', _) -> name' == name) variants
                let params' = zip (reverse (take (length params) spine)) [0 ..]
                vs <-
                  forM
                    (zip [0 ..] args)
                    ( \(i, T.Argument _ argType _) ->
                        (,foldr (uncurry subst) argType (second (+ i) <$> params'))
                          <$> gen
                    )
                let body' =
                      foldr
                        (\(i, v) -> subst (Free (level + length args + length params) v) i)
                        body
                        (zip [0 ..] (reverse (fst <$> vs)))
                typeOf' mcxt (cxt <> M.fromList vs) body'
            )
      let everyBranchReturnsSame = fromList $ foldMap (\(x, xs) -> (x,,level) <$> xs) $ uncons toTypes
      pure (head toTypes, foldl (<>) mempty cs' <> everyBranchReturnsSame)
    Case x _ cases -> undefined
  where
    typeOf' = typeOf level gcxt

infer :: Members U.Effects r => GlobalContext -> M.Map Id Term -> Term -> Term -> Sem r (Term, Term, Subst, S.Set Constraint)
infer gcxt cxt t1 t2 = go
  where
    go = do
      (tp, cs) <- typeOf 0 Context {metas = M.empty, globals = gcxt} M.empty cxt t1
      (subst, flexflex) <- unify Context {metas = M.empty, globals = gcxt} (cs <> S.singleton (t2, tp, 0))
      pure (manySubst subst t1, manySubst subst tp, subst, flexflex)
