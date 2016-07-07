--- Recursion is important to Haskell because unlike imperative languages,
--- you do computations in Haskell by declaring what something is
--- instead of declaring how you get it.

maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x: xs)
  | x > maxTail = x
  | otherwise = maxTail
  where maxTail = maximum' xs
