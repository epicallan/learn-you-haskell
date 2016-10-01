-- take in some configs and return them in a new type
module Reader where

newtype Reader e a = R {runReader :: e -> a}

instance Monad (Reader e) where
  return a = R $ \_ -> a
  --  (>>=) :: m a -> (a -> m b) -> m b
  -- we have to make the environment—here the variable r—available both in the current computation and in the computation we're chaining into.
  m >>= k = R $ \r -> runReader (k (runReader m r)) r
