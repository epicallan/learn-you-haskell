--- haskell gurds are like long if constructs
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
