module Core.Client (infer) where

import Common
import Context
import Control.Applicative
import Control.Arrow (Arrow (first, second), (***), (>>>))
import Control.Monad
import Control.Monad.Gen
import Control.Monad.Trans
import Core.Term (InductiveType (..))
import qualified Core.Term as T
import Core.Unification
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
import Debug.Trace (traceShowM)

typeOf :: Level -> GlobalContext -> M.Map Id Term -> M.Map Id Term -> Term -> UnifyM (Term, S.Set Constraint)
typeOf level gcxt mcxt cxt t =
  case t of
    Local i -> mzero
    Free _ i -> foldMap (pure . (,S.empty)) $ M.lookup i cxt
    Meta _ i -> mzero
    Global i ->
      maybe
        undefined
        (pure . (type' >>> (,mempty)))
        $ M.lookup i gcxt
    Type -> pure (Type, S.empty)
    TypeConstructor InductiveType {params, indices} -> pure (foldr T.Pi Type (T.type' <$> (params <> indices)), mempty)
    DataConstructor InductiveType {params, variants} qname ->
      let Just (_, args, toType) = find (\(x, _, _) -> x == qname) variants
       in pure (foldr T.Pi toType (T.type' <$> args), mempty)
    Ap l r -> do
      (lType, cs) <- typeOf' mcxt cxt l
      case lType of
        Pi from to ->
          optional (typeOf' mcxt cxt r)
            <&> ( (subst r 0 to,)
                    . (cs <>)
                    . foldMap (uncurry (<>) . first (S.singleton . (from,,level)))
                )
        _ -> error "typeOf: Ap: not a Pi"
    Lam arg b -> do
      v <- lift gen
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
      v <- lift gen
      cs <-
        (uncurry (<>) . first (S.singleton . (Type,,level)) <$> typeOf' mcxt cxt from)
          <|> pure mempty
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
      (spine, cs'') <- case peelApTelescope (reduce xType) of
        (Global name, spine)
          | name == indName -> pure (spine, mempty)
          | otherwise ->
            error (show indName <> " != " <> show name)
        _ -> do
          paramMetas <- forM params (const $ T.Meta level <$> lift gen)
          indexMetas <- forM indices (const $ T.Meta level <$> lift gen)
          let spine = paramMetas <> indexMetas
          pure (spine, S.singleton (xType, applyApTelescope (Global indName) spine))
      (toTypes, cs') <-
        unzip
          <$> forM
            cases
            ( \(T.Constructor qname, body) -> do
                let Just (_, args, _) = find (\(qname', _, _) -> qname == QName namespace qname') variants
                let params' = zip (reverse (take (length params) spine)) [0 ..]
                vs <-
                  forM
                    (zip [0 ..] args)
                    ( \(i, T.Argument _ argType _) ->
                        (,foldr (uncurry subst) argType (second (+ i) <$> params'))
                          <$> lift gen
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

infer :: GlobalContext -> M.Map Id Term -> Term -> Term -> Maybe (Term, Term)
infer gcxt cxt t1 t2 = listToMaybe . runUnifyM $ go
  where
    go = do
      (tp, cs) <- typeOf 0 gcxt M.empty cxt t1
      (subst, flexflex) <- unify Context {metas = M.empty} (cs <> S.singleton (tp, t2, 0))
      pure (manySubst subst t1, manySubst subst tp)
