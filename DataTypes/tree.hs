-- A tree is either an empty tree or it's an element that contains some value and two trees.
data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

--  Instead of manually building a tree, we're going to make a function that takes a tree and an element and inserts an element.
-- So, here are two functions. One is a utility function for making a singleton tree (a tree with just one node) and a function to insert an element into a tree.

singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
  | x == a = Node x left right
  | x < a  = Node a (treeInsert x left) right
  | x > a = Node a left (treeInsert x right)

treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
  | x == a = True
  | x < a  = treeElem x left
  | x > a  = treeElem x right

-- using a fold to insert a list into a tree
-- let nums = [8, 6, 4, 1, 7, 3, 5]
-- let numsTree = foldr treeInsert EmptyTree nums
