
Functors are things that can be mapped over, like lists, Maybes, trees, and such.

In Haskell, they're described by the typeclass Functor, which has only one typeclass method, namely fmap, which has a type of

```fmap :: (a -> b) -> f a -> f b```

It says: give me a function that takes an a and returns a b and a box with an a


how IO is an instance of a Functor

```
instance Functor IO where  
    fmap f action = do  
        result <- action  
        return (f result)  
```

fmap is alot more like explicit function composition when used with partial functions

```
instance Functor ((->) r) where  
    fmap = (.)  
```

```
ghci> :t fmap (*3) (+100)  
fmap (*3) (+100) :: (Num a) => a -> a  
ghci> fmap (*3) (+100) 1  
303  
ghci> (*3) `fmap` (+100) $ 1  
303  
ghci> (*3) . (+100) $ 1  
303  
ghci> fmap (show . (*3)) (*100) 1  
"300"  
```

You can think of fmap as either a function that takes a function and a functor and then maps that function over the functor, or you can think of it as a function that takes a function and lifts that function so that it operates on functors. Both views are correct and equivalent in Haskell.


When we do fmap (+3) (*3), we attach the transformation (+3) to the eventual output of (*3). Looking at it this way gives us some intuition as to why using fmap on functions is just composition (fmap (+3) (*3) equals (+3) . (*3), which equals \x -> ((x*3)+3)),


We see how by mapping "multi-parameter" functions over functors, we get functors that contain functions inside them. So now what can we do with them? Well for one, we can map functions that take these functions as parameters over them, because whatever is inside a functor will be given to the function that we're mapping over it as a parameter.

```
ghci> let a = fmap (*) [1,2,3,4]  
ghci> :t a  
a :: [Integer -> Integer]  
ghci> fmap (\f -> f 9) a  
[9,18,27,36]  

```

But what if we have a functor value of Just (3 *) and a functor value of Just 5 and we want to take out the function from Just (3 *) and map it over Just 5? With normal functors, we're out of luck, because all they support is just mapping normal functions over existing functors.

Let's take a look at the Applicative instance implementation for Maybe.

```
instance Applicative Maybe where  
    pure = Just  
    Nothing <*> _ = Nothing  
    (Just f) <*> something = fmap f something  
```


```  
ghci> Just (+3) <*> Just 9  
Just 12  
ghci> pure (+3) <*> Just 10  
Just 13  
ghci> pure (+3) <*> Just 9  
Just 12  
ghci> Just (++"hahah") <*> Nothing  
Nothing  
ghci> Nothing <*> Just "woot"  
Nothing

```
``<*> is left associative``

```
ghci> pure (+) <*> Just 3 <*> Just 5  
Just 8  
ghci> pure (+) <*> Just 3 <*> Nothing  
Nothing  
ghci> pure (+) <*> Nothing <*> Just 5  
Nothing  

```
 Applicative functors and the applicative style of doing pure f <\*> x <\*> y <\*> ... allow us to take a function that expects parameters that aren't necessarily wrapped in functors and use that function to operate on several values that are in functor contexts.

 ``pure f <*> x equals fmap f x``
 Instead of writing pure ``f <\*> x <\*> y <\*> ...``, we can write fmap ``f x <*> y <*> ....`` This is why Control.Applicative exports a function called <$>, which is just fmap as an infix operator. Here's how it's defined:


```
 (<$>) :: (Functor f) => (a -> b) -> f a -> f b  
 f <$> x = fmap f x  
```


```
 ghci> (++) <$> Just "johntra" <*> Just "volta"  
 Just "johntravolta"  
```
lists as an applicative

```
instance Applicative [] where  
  pure x = [x]  
  fs <*> xs = [f x | f <- fs, x <- xs]  
```

```
ghci> (++) <$> ["ha","heh","hmm"] <*> ["?","!","."]  
["ha?","ha!","ha.","heh?","heh!","heh.","hmm?","hmm!","hmm."]  
```

Using the applicative style on lists is often a good replacement for list comprehensions.

```
ghci> [ x*y | x <- [2,5,10], y <- [8,10,11]]     
[16,20,22,40,50,55,80,100,110]   

ghci> filter (>50) $ (*) <$> [2,5,10] <*> [8,10,11]  
[55,80,100,110]  
```

IO as an applicative

```
instance Applicative IO where  
    pure = return  
    a <*> b = do  
        f <- a  
        x <- b  
        return (f x)  
```
<\*> for IO
``(<*>) :: IO (a -> b) -> IO a -> IO b ``

IO example
```
myAction :: IO String  
myAction = do  
    a <- getLine  
    b <- getLine  
    return $ a ++ b  
```
this can be written as below

```
myAction :: IO String  
myAction = (++) <$> getLine <*> getLine  
```

The ziplist type
where  [(+3),(*2)] <*> [1,2]  = [1 + 3, 2 * 2].

```
instance Applicative ZipList where  
        pure x = ZipList (repeat x)  
        ZipList fs <*> ZipList xs = ZipList (zipWith (\f x -> f x) fs xs)  

```
Not ziplist doesnt have a show class so we use getZipList function to extract a raw list out of a zip list.
```
ghci> getZipList $ (+) <$> ZipList [1,2,3] <*> ZipList [100,100,100]  
[101,102,103]  
ghci> getZipList $ (+) <$> ZipList [1,2,3] <*> ZipList [100,100..]  
[101,102,103]  
ghci> getZipList $ max <$> ZipList [1,2,3,4,5,3] <*> ZipList [5,3,1,2]  
[5,3,3,4]  
ghci> getZipList $ (,,) <$> ZipList "dog" <*> ZipList "cat" <*> ZipList "rat"  
[('d','c','r'),('o','a','a'),('g','t','t')]  
```
ziplist is a good substitute for  zipWith3, zipWith4 etc

Control.Applicative defines a function that's called liftA2, which has a type of liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c . It's defined like this:
(a -> b -> c) -> (f a -> f b -> f c). When we look at it like this, we can say that liftA2 takes a normal binary function and promotes it to a function that operates on two functors.

```
liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c  
liftA2 f a b = f <$> a <*> b  
```
OK, so let's say we have Just 3 and Just [4]. How do we get Just [3,4]? Easy.

```
ghci> liftA2 (:) (Just 3) (Just [4])  
Just [3,4]  
ghci> (:) <$> Just 3 <*> Just [4]  
Just [3,4]  
```
 Let's try implementing a function that takes a list of applicatives and returns an applicative that has a list as its result value. We'll call it sequenceA.

 ```
 sequenceA :: (Applicative f) => [f a] -> f [a]  
 sequenceA [] = pure []  
 sequenceA (x:xs) = (:) <$> x <*> sequenceA xs  
 ```

Another way to implement sequenceA is with a fold. Remember, pretty much any function where we go over a list element by element and accumulate a result along the way can be implemented with a fold.

```
sequenceA :: (Applicative f) => [f a] -> f [a]  
sequenceA = foldr (liftA2 (:)) (pure [])  

```

```
ghci> sequenceA [Just 3, Just 2, Just 1]  
Just [3,2,1]  
ghci> sequenceA [Just 3, Nothing, Just 1]  
Nothing  
ghci> sequenceA [(+3),(+2),(+1)] 3  
[6,5,4]  
ghci> sequenceA [[1,2,3],[4,5,6]]  
[[1,4],[1,5],[1,6],[2,4],[2,5],[2,6],[3,4],[3,5],[3,6]]  
ghci> sequenceA [[1,2,3],[4,5,6],[3,4,4],[]]  
[]  
```
Using sequenceA is cool when we have a list of functions and we want to feed the same input to all of them and then view the list of results
```
ghci> map (\f -> f 7) [(>4),(<10),odd]  
[True,True,True]  
ghci> and $ map (\f -> f 7) [(>4),(<10),odd]  
True  
```
