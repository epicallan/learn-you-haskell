--  a monad that supplies unique values of any kind
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Supply
    (
      Supply
    , next
    , runSupply
    ) where

import Control.Monad.State
import System.Random hiding (next)

newtype Supply s a = S (State [s] a) deriving
                                    (Functor, Applicative, Monad)

runSupply :: Supply s a -> [s] -> (a, [s])
runSupply (S m) = runState m

next :: Supply s (Maybe s)
next = S $ do st <- get
              case st of
                [] -> return Nothing
                (x : xs) -> do  put xs
                                return (Just x)

randomsIO :: Random a => IO [a]
randomsIO =
  getStdRandom $ \g ->
      let (a, b) = split g
      in (randoms a, b)

-- (fst . runSupply next) `fmap` randomsIO

randomsIOGolfed :: Random a => IO [a]
randomsIOGolfed = getStdRandom (first randoms . split)
