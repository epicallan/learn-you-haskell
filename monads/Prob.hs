module Prob where
  import Data.Ratio
  -- import Control.Monad

  newtype Prob a = Prob { getProb :: [(a, Rational)]} deriving Show

  instance Functor Prob where
    fmap f (Prob xs) = Prob $ map (\(x, p) -> (f x, p)) xs

  -- ghci> fmap negate (Prob [(3,1%2),(5,1%4),(9,1%4)])
  -- Prob {getProb = [(-3,1 % 2),(-5,1 % 4),(-9,1 % 4)]}
  thisSituation :: Prob (Prob Char)
  thisSituation = Prob
      [( Prob [('a',1%2),('b',1%2)] , 1%4 )
      ,( Prob [('c',1%2),('d',1%2)] , 3%4)
      ]

  -- flattening a nexted Prob
  flatten :: Prob (Prob a) -> Prob a
  flatten (Prob xs) = Prob $ concat $ map multAll xs
    where multAll (Prob innerxs,p) = map (\(x,r) -> (x,p*r)) innerxs

  instance Monad Prob where
    return x = Prob [(x, 1%1)]
    m >>= f = flatten (fmap f m)
    fail _ = Prob []
