module Golf where

-- skips "ABCD" == ["ABCD", "BD", "C", "D"]
skips :: [a] -> [[a]]
skips [] = []
skips a@(_:xs) = a: skips xs

-- localMaxima [2,9,5,6,1] == [9,6]
localMaxima :: [Integer] -> [Integer]
localMaxima [] = []
localMaxima [_] = []
localMaxima [_,_] = []
localMaxima (x:y:xy)
  | y > x && y > head xy = y :localMaxima xy
  | otherwise  = localMaxima xy

-- histogram :: [Integer] -> String
-- histogram [] = []
-- histogram (x:y:xs)
--   | x == y = 1
--
