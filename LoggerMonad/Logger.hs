{-# LANGUAGE InstanceSigs #-}
module Logger where
import Control.Monad

type Log = [String]

newtype Logger a = Logger { execLogger :: (a, Log)}

record :: String -> Logger ()
record s = Logger ((), [s])

instance Functor Logger where
  fmap = liftM

instance Applicative Logger where
  pure a = Logger (a, [])
  (<*>) = ap

instance Monad Logger where
  return a = Logger (a, [])
  (>>=) :: Logger a -> (a -> Logger b) -> Logger b
  m >>= k = let (a, w) = execLogger m
                n      = k a
                (b, x) = execLogger n
                in Logger (b, w ++ x)
