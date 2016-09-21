### Monads

if you have a value with a context, m a, how do you apply to it a function that takes a normal a and
returns a value with a context?

```
(>>=) :: (Monad m) => m a -> (a -> m b) -> m b  
```

If we have a fancy value and a function that takes a normal value but returns a fancy value,
how do we feed that fancy value into the function?

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

### Functors Applicative Functors & Mondads

- Functors are types that can be mapped over
- Applicative functors allow us to apply normal functions between several applicative values as well as to take a normal value and put it in some default context.
- Monads are improved applicative functors which added the ability for these values with context to somehow be fed into normal functions

But even though every monad is a functor, we don't have to rely on it having a Functor instance because of the liftM function. liftM takes a function and a monadic value and maps it over the monadic value. So it's pretty much the same thing as fmap! This is liftM's type:

```
liftM :: (Monad m) => (a -> b) -> m a -> m b  

-- fmap for functors
fmap :: (Functor f) => (a -> b) -> f a -> f b  

-- liftM definition
liftM :: (Monad m) => (a -> b) -> m a -> m b  
liftM f m = do  
    x <- m  
    return (f x)  
```

The liftA2 function is a convenience function for applying a function between two applicative values. It's defined simply like so:

```
liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c  
liftA2 f x y = f <$> x <*> y  
```
The liftM2 function does the same thing, only it has a Monad constraint. There also exist liftM3 and liftM4 and liftM5.

m >>= f always equals join (fmap f m) for

### composing monadic functions
\<=\< function is for composition in Monads

```
ghci> let f = (+1) . (*100)  
ghci> f 4  
401  
ghci> let g = (\x -> return (x+1)) <=< (\x -> return (x*100))  
ghci> Just 4 >>= g  
Just 401  
ghci> let f = foldr (.) id [(+1),(*100),(+1)]  
ghci> f 1  
201  
```

composing a bunch of monadic functions

```
in3 start = return start >>= moveKnight >>= moveKnight >>= moveKnight    
-- can be generalized as below

inMany :: Int -> KnightPos -> [KnightPos]  
inMany x start = return start >>= foldr (<=<) return (replicate x moveKnight)  

```

The (=<<) function shows up frequently whether or not we use do notiation. It is a flipped version of (>>=)

```
ghci> :type (>>=)
(>>=) :: (Monad m) => m a -> (a -> m b) -> m b
ghci> :type (=<<)
(=<<) :: (Monad m) => (a -> m b) -> m a -> m b

wordCount = print . length . words =<< getContents
```
