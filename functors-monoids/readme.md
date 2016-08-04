
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
