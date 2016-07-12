-- We do function composition with the . function, which is defined like so:
(.) :: (b -> c) -> (a -> b) -> a -> c
f . g = \x -> f (g x)

-- example
-- map (negate . sum . tail) [[1..5],[3..6],[1..7]]

 -- function application with $
 ($) :: (a -> b) -> a -> b
 f $ x = f x
--- sum (filter (> 10) (map (*2) [2..10]))
--- sum $ filter (> 10) $ map (*2) [2..10].

 sum (replicate 5 (max 6.7 8.9))
(sum . replicate 5 . max 6.7) 8.9
sum . replicate 5 . max 6.7 $ 8.9

oddSquareSum :: Integer
oddSquareSum =
    let oddSquares = filter odd $ map (^2) [1..]
        belowLimit = takeWhile (<10000) oddSquares
    in  sum belowLimit  
