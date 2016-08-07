### type vs. newtype vs. data

The newtype keyword in Haskell is made exactly for these cases when we want to just take one type and wrap it in something to present it as another type. In the actual libraries, ZipList a is defined like this:

```
newtype ZipList a = ZipList { getZipList :: [a] }  
```

So why not just use newtype all the time instead of data then? Well, when you make a new type from an existing type by using the newtype keyword, you can only have one value constructor and that value constructor can only have one field. But with data, you can make data types that have several value constructors and each constructor can have zero or more fields:

```
data Profession = Fighter | Archer | Accountant  

data Race = Human | Elf | Orc | Goblin  

data PlayerCharacter = PlayerCharacter Race Profession  
```


The type keyword is for making type synonyms. What that means is that we just give another name to an already existing type so that the type is easier to refer to. Say we did the following:

``type IntList = [Int]  ``

We use type synonyms when we want to make our type signatures more descriptive by giving types names that tell us something about their purpose in the context of the functions where they're being used.


The newtype keyword is for taking existing types and wrapping them in new types, mostly so that it's easier to make them instances of certain type classes.


The data keyword is for making your own data types and with them, you can go hog wild. They can have as many constructors and fields as you wish and can be used to implement any algebraic data type by yourself. Everything from lists and Maybe-like types to trees.
