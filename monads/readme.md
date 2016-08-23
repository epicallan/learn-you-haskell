### Monads

Monads are a natural extension of applicative functors and with them we're concerned with this: if you have a value with a context, m a, how do you apply to it a function that takes a normal a and returns a value with a context?

```
(>>=) :: (Monad m) => m a -> (a -> m b) -> m b  
```

If we have a fancy value and a function that takes a normal value but returns a fancy value, how do we feed that fancy value into the function?

```

class Monad m where  
    return :: a -> m a  

    (>>=) :: m a -> (a -> m b) -> m b  

    (>>) :: m a -> m b -> m b  
    x >> y = x >>= \_ -> y  

    fail :: String -> m a  
    fail msg = error msg  

```

Maybe as a Monad

```
instance Monad Maybe where  
    return x = Just x  
    Nothing >>= f = Nothing  
    Just x >>= f  = f x  
    fail _ = Nothing  
```

```
Just 9 >>= \x -> return (x*10)   == Just 90
```

Lists as Monads
```
instance Monad [] where  
    return x = [x]  
    xs >>= f = concat (map f xs)  
    fail _ = []  
```

\>>= is about taking a value with a context (a monadic value) and feeding it to a function that takes a normal value and returns one that has context.

```
ghci> [3,4,5] >>= \x -> [x,-x]  
[3,-3,4,-4,5,-5]  
```
lists monads chained with do notation

```
listOfTuples :: [(Int,Char)]  
listOfTuples = do  
    n <- [1,2]  
    ch <- ['a','b']  
    return (n,ch)  
```

Lists chaining with do notation can also be done with list comprehesions

```
[ [n, ch]| n <-[1,2] ,ch <- ['a', 'b']] == [(1,'a'),(1,'b'),(2,'a'),(2,'b')]  

```
The MonadPlus type class is for monads that can also act as monoids. Here's its definition

```
class Monad m => MonadPlus m where  
    mzero :: m a  
    mplus :: m a -> m a -> m a  
```
List as an instance of monad plus
```
instance MonadPlus [] where  
    mzero = []  
    mplus = (++)  
```

Guard function
It takes a boolean value and if it's True, takes a () and puts it in a minimal default context that still succeeds.
```
guard :: (MonadPlus m) => Bool -> m ()  
guard True = return ()  
guard False = mzero  

```
examples
```
ghci> guard (5 > 2) :: Maybe ()  
Just ()  
ghci> guard (1 > 2) :: Maybe ()  
Nothing  
ghci> guard (5 > 2) :: [()]  
[()]  
ghci> guard (1 > 2) :: [()]  
[]
ghci> guard (5 > 2) >> return "cool" :: [String]  
["cool"]  
```

in the list monad we use it to filter out  non-deterministic computations

```
[1..50] >>= \x -> guard ( `7`  `elem` show x >> return x) == [7,17,27,37,47]  

```
in do notation

```
sevensOnly :: [Int]  
sevensOnly = do  
    x <- [1..50]  
    guard ('7' `elem` show x)  
    return x  
```
in list comprehensions

```
ghci> [ x | x <- [1..50], '7' `elem` show x ]  
[7,17,27,37,47]  
```
So filtering in list comprehensions is the same as using guard.

monadic composition
```
(<=<) :: (Monad m) => (b -> m c) -> (a -> m b) -> (a -> m c)  
f <=< g = (\x -> g x >>= f)  
```
Example
```
ghci> let f x = [x,-x]  
ghci> let g x = [x*3,x*2]  
ghci> let h = f <=< g  
ghci> h 3  
[9,-9,6,-6]  

```
