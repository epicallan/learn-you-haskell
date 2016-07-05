doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y
doubleSmallNumber x = if x > 100
  then x
  else x*2

lucky :: (Integral a) => a -> String
lucky 7 = "lucky number seven"
lucky x = "sorry your are out of lucky"

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial(n - 1)

addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

capital :: String -> String
capital "" = "Empty String, whoops!"
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

bimTell :: (RealFloat a) => a -> a -> String
bimTell weight height
  | bmi <= skinny = "You are underweight"
  | bmi <= normal = " You ar normal"
  | bmi <= fat = "You are fat"
  | otherwise = "You are a whale"
  where bmi =  weight / height ^ 2
        skinny = 18.5
        normal = 25.0
        fat = 30

max' :: (Ord a) => a -> a -> a
max' a b
  | a > b = a
  | otherwise = b

myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
  | a > b = GT
  | a == b = EQ
  | otherwise = LT

initials :: String -> String -> String
initials firstname lastname = [f] ++ "." ++[l] ++ "."
  where (f: _) = firstname
        (l: _) = lastname

calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs]
  where bmi weight height = weight / height ^ 2
