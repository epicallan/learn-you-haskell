-- foldl folds a list from left
-- A binary function is applied between the starting value and the head of the list.

sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x-> acc + x) 0 xs
-- sum' = foldl (+) 0

elem' ::(Eq a)=> a -> [a] -> Bool
-- elem' y ys = foldl(\acc x -> if x == y then True else acc) False ys
elem' y = foldl(\acc x -> if x == y then True else acc) False

--- The right fold, foldr works in a similar way to the left fold, only the accumulator eats up the values from the right.

map' :: (a -> b) -> [a] -> [b]
map' xs f = foldr(\x acc -> f x : acc) [] xs
-- map' f xs = foldl (\acc x -> acc ++ [f x]) [] xs

-- The foldl1 and foldr1 functions work much like foldl and foldr,
-- only you don't need to provide them with an explicit starting value.
-- They assume the first (or last) element of the list to be the starting
-- value and then start the fold with the element next to it.

--- sum = foldl1 (+)

maximum' :: (Ord a) => [a] -> [a]
maximum' = foldr(\x acc -> if x > acc then x else acc)

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x acc -> if p x then x : acc else acc) []
