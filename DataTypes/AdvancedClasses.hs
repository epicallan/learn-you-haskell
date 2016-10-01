-- https://en.wikibooks.org/wiki/Haskell/Advanced_type_classes
-- class Collection c where
--     insert :: c -> e -> c
--     member :: c -> e -> Bool
--
-- -- Make lists an instance of Collection:
-- instance Collection [a] where
--     insert xs x = x:xs
--     member = flip elem

-- This won't compile, however. The problem is that the 'e' type variable in the Collection operations comes from nowhere -

{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
-- the extra | c -> e should be read 'c uniquely identifies e', meaning for a given c, there will only be one e.
class Eq e => Collection c e | c -> e where
    insert :: c -> e -> c
    member :: c -> e -> Bool

-- Make lists an instance of Collection:
instance Eq a => Collection [a] a where
    insert = flip (:)
    member = flip elem


-- example
data Vector = Vector Int Int deriving (Eq, Show)
data Matrix = Matrix Vector Vector deriving (Eq, Show)

-- if what a multiplication function that overloads to different types

-- (*) :: Matrix -> Matrix -> Matrix
-- (*) :: Matrix -> Vector -> Vector
-- (*) :: Matrix -> Int -> Matrix
-- (*) :: Int -> Matrix -> Matrix
-- {- ... and so on ... -}

-- we specify a type class

class Mult a b c | a b -> c where
  (*) :: a -> b -> c

-- This tells Haskell that c is uniquely determined from a and b.
