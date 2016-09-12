
### A quick recap on typeclasses:

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

#### The type and newtype keywords
Although their names are similar, the type and newtype keywords have different purposes. The type keyword gives us another way of referring to a type, like a nickname for a friend. Both we and the compiler know that [Char] and String names refer to the same type. 3 comments

In contrast, the newtype keyword exists to hide the nature of a type. Consider a UniqueID type. No comments

#### Here's a brief recap of Haskell's three ways to introduce new names for types

> The data keyword introduces a truly new albegraic data type. 3 comments

> The type keyword gives us a synonym to use for an existing type. We can use the type and its synonym interchangeably. 1 comment

> The newtype keyword gives an existing type a distinct
