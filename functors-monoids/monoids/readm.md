## Monoid

 A monoid is when you have an associative binary function and a value which acts as an identity with respect to that function.

 ``1 is the identity with respect to * and [] is the identity with respect to ++``

Monoid type class definition

```
class Monoid m where  
    mempty :: m  
    mappend :: m -> m -> m  
    mconcat :: [m] -> m  
    mconcat = foldr mappend mempty  
```
mempty represents the identity value for a particular monoid.

```
mempty `mappend` x = x
x `mappend` mempty = x
(x `mappend` y) `mappend` z = x `mappend` (y `mappend` z)
```

lists as monoids

```
instance Monoid [a] where  
    mempty = []  
    mappend = (++)  
```

```
ghci> [1,2,3] `mappend` [4,5,6]  
[1,2,3,4,5,6]  
ghci> ("one" `mappend` "two") `mappend` "tree"  
"onetwotree"  
```

Ordering as a monoid

```
instance Monoid Ordering where  
    mempty = EQ  
    LT `mappend` _ = LT  
    EQ `mappend` y = y  
    GT `mappend` _ = GT  
```
practical application

```
lengthCompare :: String -> String -> Ordering  
lengthCompare x y = let a = length x `compare` length y   
                        b = x `compare` y  
                    in  if a == EQ then b else a  
```
the above can be written as below

```
import Data.Monoid  

lengthCompare :: String -> String -> Ordering  
lengthCompare x y = (length x `compare` length y) `mappend`  
                    (vowels x `compare` vowels y) `mappend`  
                    (x `compare` y)  
    where vowels = length . filter (`elem` "aeiou")  
```

### creating foldables with monoids

One way to make a type constructor an instance of Foldable is to just directly implement foldr for it. But another, often much easier way, is to implement the foldMap function, which is also a part of the Foldable type class.


``foldMap :: (Monoid m, Foldable t) => (a -> m) -> t a -> m   ``

Given a tree

``data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)   ``

making it an instance of Foldable is as below

```
instance F.Foldable Tree where  
    foldMap f Empty = mempty  
    foldMap f (Node x l r) = F.foldMap f l `mappend`  
                             f x           `mappend`  
                             F.foldMap f r  
```
