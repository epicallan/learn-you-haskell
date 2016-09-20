module TreeFold where

data Tree a = Empty | Node (Tree a) a (Tree a)
  deriving (Show, Eq)

-- TreeFold function

treeFold :: b -> (b -> a -> b -> b) -> Tree a ->b
treeFold e _ Empty = e
treeFold e f (Node l x r) = f (treeFold e f l) x (treeFold e f r)

treeSize :: Tree a -> Integer
treeSize = treeFold 0 (\l _ r -> 1 + l + r)

treeSum :: Tree Integer -> Integer
treeSum = treeFold 0 (\l x r -> l + x + r)

treeDepth :: Tree a -> Integer
treeDepth = treeFold 0 (\l _ r -> 1 + max l r)


flatten' :: Tree a -> [a]
flatten' = treeFold [] (\l x r -> l ++ [x] ++ r)
