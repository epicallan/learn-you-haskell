--- It turns out that if you want to define computations by defining what
--- stuff is instead of defining steps that change some state and maybe looping them,
--- higher order functions are indispensable

compareWithHundred :: (Num a, Ord a) => a -> Ordering
compareWithHundred = compare 100  --- compare 100 returns a function that takes x as a parameter
--
--- we need parathesis in the type declarations to indicate
--- that the first parameter is a function that takes something and returns that same thing
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

zipWith' :: (a -> b -> c) -> [a]->[b]->[c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

flip' :: (a -> b -> c) -> b -> a -> c
flip' f y x = f x y

--- zipWith' (flip' div) [2,2..] [10,8,6,4,2]

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x : xs) = f x : map' f xs
---  map (replicate 3) [3..6]

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' p (x : xs)
  | p x       = x : filter' p xs
  | otherwise = filter' p xs

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x : xs) =
  let smallerSorted = quicksort (filter (<=x) xs)
      biggerSorted = quicksort (filter (>x) xs)
  in smallerSorted ++ [x] ++ biggerSorted

chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
  | even n  = n : chain(n `div` 2)
  | odd n   = n : chain(n * 3 + 1)

numLongChains :: Int
numLongChains = length (filter isLong (map chain [1..100]))
  where isLong xs = length xs > 15
