-- The Fibonacci numbers Fn are defined as the sequence of integers,
-- beginning with 0 and 1, where every integer in the sequence is the
-- sum of the previous two.

module Fibonacci where
  fib :: Integer -> Integer
  fib 0 = 0
  fib 1 = 1
  fib n = fib (n - 1) + fib (n - 2)

  fibs1 :: [Integer] -> [Integer]
  fibs1 = map fib
  -- • Define a data type of polymorphic streams, Stream.
  data Stream a = Stream [a]

  streamToList :: Stream a -> [a]
  streamToList (Stream x) = x
