 -- Functor typeclass, which is basically for things that can be mapped over.

class Functor' f where
    fmap' :: (a -> b) -> f a -> f b --f is a type constructor that takes one type

instance Functor' [] where
    fmap' = map

-- A list map takes a function from one type to another and a list of one type and returns a list of another type.

-- map :: (a -> b) -> [a] -> [b]
-- ghci> fmap (*2) [1..3]
-- [2,4,6]
-- ghci> map (*2) [1..3]
-- [2,4,6]

-- Functor wants a type constructor that takes one type and not a concrete type.

instance Functor' Maybe where
    fmap' f (Just x) = Just (f x)
    fmap' f Nothing = Nothing

instance Functor' (Either a) where
  fmap' f (Right x) = Right (f x)
  fmap' f (Left x) = Left x
