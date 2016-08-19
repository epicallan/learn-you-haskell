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

```Just 9 >>= \x -> return (x*10)   == Just 90```
