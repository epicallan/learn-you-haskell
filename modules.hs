-- loading up modules
-- https://downloads.haskell.org/~ghc/latest/docs/html/libraries/
-- https://www.haskell.org/hoogle/
-- in GHCI :m + Data.List  or :m + Data.List Data.Map Data.Set

--- importing just a few fns from a module
import Data.List (nub, sort)

-- import all except nub
import Data.List hiding (nub)

-- to avoid name clashing

import qualified Data.Map as M

-- Now, to reference Data.Map's filter function, we just use M.filter

-- about folds
-- foldl' and foldl1' are stricter versions of their respective lazy incarnations. When using lazy folds on really big lists, you might often get a stack overflow error. The culprit for that is that due to the lazy nature of the folds, the accumulator value isn't actually updated as the folding happens.

-- searching for sublist with in a List

search :: (Eq a) => [a] -> [a] -> Bool
search needle haystack =
    let nlen = length needle
    in  foldl (\acc x -> if take nlen x == needle then True else acc) False (tails haystack)

-- alot of list functions have generic counter parts to enable
-- them work with floats in some case
--  genericLength, genericTake, genericDrop, genericSplitAt, genericIndex and genericReplicate.
-- let xs = [1..6] in sum xs / genericLength xs

-- on function is used alot for comparisons
on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
f `on` g = \x y -> f (g x) (g y)
-- (==) `on` (> 0) returns an equality function that looks like \x y -> (x > 0) == (y > 0)
-- let values = [-4.3, -2.4, -1.2, 0.4, 2.3, 5.9, 10.5, 29.1, 5.3, -2.4, -14.5, 2.9, 2.3]
-- groupBy ((==) `on` (> 0)) values

let xs = [[5,4,5,4,4],[1,2,3],[3,5,4,3],[],[2],[2,2]]
sortBy (compare `on` length) xs
-- compare `on` length is the equivalent of \x y -> length x `compare` length y
import Data.Char

-- ord 'a'  = 97
-- chr 97  = 'a'

encode :: Int -> String -> String
encode shift msg =
    let ords = map ord msg
        shifted = map (+ shift) ords
    in  map chr shifted

decode :: Int -> String -> String
decode shift msg = encode (negate shift) msg

import qualified Data.Map as Map


--- The Data.Set module offers us, well, sets. Like sets from mathematics. Sets are kind of like a cross between lists and maps. All the elements in a set are unique. And because they're internally implemented with trees (much like maps in Data.Map), they're ordered.

-- Sets are often used to weed a list of duplicates from a list by first making it into a set with fromList and then converting it back to a list with toList. The Data.List function nub already does that, but weeding out duplicates for large lists is much faster 
