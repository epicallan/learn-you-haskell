-- Let's use algebraic data types to implement our own list then!
data List a = Empty | Cons a (List a) deriving (Show, Read, Eq, Ord)

-- in record syntax
-- data List a = Empty | Cons { listHead :: a, listTail :: List a} deriving (Show, Read, Eq, Ord)
-- cons is another word for :

-- ghci> Empty
-- Empty
-- ghci> 5 `Cons` Empty
-- Cons 5 Empty
-- ghci> 4 `Cons` (5 `Cons` Empty)
-- Cons 4 (Cons 5 Empty)
-- ghci> 3 `Cons` (4 `Cons` (5 `Cons` Empty))
-- Cons 3 (Cons 4 (Cons 5 Empty))
-- 4 `Cons` (5 `Cons` Empty) is like 4:(5:[]).

-- We can define functions to be automatically infix by making them comprised of only special characters. We can also do the same with constructors, since they're just functions that return a data type. So check this out.

infixr 5 :-:   --infix

data List' a = Empty' | a :-: (List a) deriving (Show, Read, Eq, Ord)
--ghci> 3 :-: 4 :-: 5 :-: Empty
-- (:-:) 3 ((:-:) 4 ((:-:) 5 Empty))
-- ghci> let a = 3 :-: 4 :-: 5 :-: Empty
-- ghci> 100 :-: a
-- (:-:) 100 ((:-:) 3 ((:-:) 4 ((:-:) 5 Empty)))

-- Let's make a function that adds two of our lists together.
-- This is how ++ is defined for normal lists:

-- infixr 5 ++
-- (++) :: [a] -> [a] -> [a]
-- [] ++ ys = ys
-- (x: xs) _++ ys = x : (xs ++ ys)

infixr 5 .++
(.++) :: List a -> List a -> List a
Empty .++ ys = ys
(x :-: xs) .++ ys = x :-: (xs .++ ys)
