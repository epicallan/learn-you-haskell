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
