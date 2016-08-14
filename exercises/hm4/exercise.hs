module Exercise where
  -- . Use wholemeal programming practices, breaking each
  -- function into a pipeline of incremental transformations to an entire
  -- data structure. Name your functions fun1’ and fun2’ respectively.


  fun1 :: [Integer] -> Integer
  fun1 [] = 1
  fun1 (x:xs)
    | even x = (x - 2) * fun1 xs
    | otherwise = fun1 xs

  fun1' :: [Integer] -> Integer
  fun1' = product.map(subtract 1).takeWhile even

  -- not sure how to do this
  fun2 :: Integer -> Integer
  fun2 1 = 0
  fun2 n
    | even n = n + fun2 (n `div` 2)
    | otherwise = fun2 (3 * n + 1)

  -- not sure how to do this
  data Tree a = Leaf
              | Node Integer (Tree a) a (Tree a)
              deriving (Show, Eq)

  -- foldTree :: [a] -> Tree a
  -- foldTree [] = Leaf
  -- foldTree [x] = Node 0 Leaf x Leaf
  -- foldTree (x:xs)= foldr(\x acc -> )
  xor :: [Bool] -> Bool
  xor = odd.length.foldr(\x acc -> if x then x:acc else acc) []

  map' :: (a -> b) -> [a] -> [b]
  map' f = foldr(\x acc -> f x : acc)[]

  
