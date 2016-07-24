
## A quick recap on typeclasses:

Typeclasses are like interfaces. A typeclass defines some behavior (like comparing for equality, comparing for ordering, enumeration) and then types that can behave in that way are made instances of that typeclass.

The behavior of typeclasses is achieved by defining functions or just type declarations that we then implement. So when we say that a type is an instance of a typeclass, we mean that we can use the functions that the typeclass defines with that type.

For example, the Eq typeclass is for stuff that can be equated. It defines the functions == and /=. If we have a type (say, Car) and comparing two cars with the equality function == makes sense, then it makes sense for Car to be an instance of Eq.

```
class Eq a where  
    (==) :: a -> a -> Bool  
    (/=) :: a -> a -> Bool  
    x == y = not (x /= y)  
    x /= y = not (x == y)  
```

 > The a is the type variable and it means that a will play the role of the type that we will soon be making an instance of Eq.
 Then, we define several functions. It's not mandatory to implement the function bodies themselves, we just have to specify the type declarations for the functions.
