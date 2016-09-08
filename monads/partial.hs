module Partial where
-- not only is the function type (->) r a functor and an applicative functor, but it's also a monad

-- instance Monad ((->) r) where
--   return x = \_ -> x
--   h >>= f = \w -> f (h w) w

addStuff :: Int -> Int
addStuff = do
  a <- (*2)
  b <- (+10)
  return (a + b)

-- ghci> addStuff 3
-- 19
-- Both (*2) and (+10) get applied to the number 3 in this case. return (a+b)
