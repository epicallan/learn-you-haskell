module DiffList where

newtype DiffList a = DiffList {getDiffList :: [a] -> [a]}

-- Because a difference list is a function that prepends something to another list, if we just want that something, we apply the function to an empty list!

toDiffList :: [a] -> DiffList a
toDiffList xs = DiffList (xs++)

fromDiffList :: DiffList a -> [a]
fromDiffList (DiffList f) = f []

instance Monoid (DiffList a) where
  mempty = DiffList (\xs -> [] ++ xs)
  (DiffList f) `mappend` (DiffList g) = DiffList(f.g)

-- fromDiffList (toDiffList [1,2,3,4] `mappend` toDiffList [1,2,3])
-- [1,2,3,4,1,2,3]  
