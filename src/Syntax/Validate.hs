{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}

module Syntax.Validate where

import Control.Arrow
import Control.Monad
import Data.Function
import Data.Functor
import Data.List
import Data.List.Extra
import Data.Maybe (catMaybes)
import Data.Tuple.Extra (snd3)
import Syntax.AST (Expression (..), Source (..), TopLevelStatement (..), name)

data Error
  = DuplicateName
  | DuplicateVariantName
  | DifferentNumberOfPatterns
  deriving (Show)

validate :: Source -> Either Error ()
validate (Source xs) = do
  let names = name <$> xs
  when (anySame names) (Left DuplicateName)
  forM_ xs $ \case
    DataDeclaration {args, maybeType, variants} -> do
      let names = variants <&> (\(_, x, _, _) -> x)
      when (anySame names) (Left DuplicateVariantName)
      forM_ (args <&> snd3) validate'
      forM_ maybeType validate'
      forM_
        variants
        $ \(_, _, args, xs) -> do
          forM_ args (snd3 >>> validate')
          forM_ xs validate'
    Definition {name, args, maybeType, value} -> do
      forM_ (args <&> snd3) validate'
      forM_ maybeType validate'
      validate' value
    Declaration {args, type'} -> do
      forM_ (args <&> snd3) validate'
      validate' type'
    _ -> pure ()
  where
    validate' :: Expression -> Either Error ()
    validate' (LambdaCase args cases) =
      unless (allSame (length . fst <$> cases)) (Left DifferentNumberOfPatterns)
        >> validateAll (catMaybes (args <&> snd))
        >> validateAll (cases <&> snd)
    validate' (Application head spine) = validate' head >> validateAll (spine <&> snd)
    validate' (ForAll _ type' body) = validateAll [type', body]
    validate' (Arrow x y) = validateAll [x, y]
    validate' (Let _ value body) = validateAll [value, body]
    validate' (Lambda args body) =
      forM_ args (snd >>> validateAll) >> validateAll [body]
    validate' (Infix x _ y) = validateAll [x, y]
    validate' (Tuple xs) = validateAll xs
    validate' (List xs) = validateAll xs
    validate' (Parenthesized x) = validate' x
    validate' _ = pure ()
    validateAll :: Traversable t => t Expression -> Either Error ()
    validateAll = mapM_ validate'
