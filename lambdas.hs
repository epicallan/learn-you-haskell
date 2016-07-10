-- Lambdas are basically anonymous functions
-- that are used because we need some functions only once.
chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
  | even n  = n : chain(n `div` 2)
  | odd n   = n : chain(n * 3 + 1)

numLongChains :: Int
numLongChains = length (filter (\xs -> length xs > 15) (map chain [1..100]))

-- lambda example
-- zipWith (\a b -> (a * 30)/b) [2,3,4] [4, 3, 4]

--- patttern matching in lambdas
-- map (\(a, b) -> a + b) [(1, 2), (4, 5)]
