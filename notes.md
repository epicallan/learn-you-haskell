## Random Notes

folds simplification

```
foldr f z [a,b,c] == a `f` (b `f` (c `f` z))
foldl f z [a,b,c] == ((z `f` a) `f` b) `f` c
```

case syntax

```case exp of
  pat1 -> exp1
  pat2 -> exp2
  ...```

recursive data types

We can define a type of binary trees with an Int value stored at each internal node, and a Char stored at each leaf:

```

data Tree = Leaf Char
          | Node Tree Int Tree
  deriving Show

tree :: Tree
tree = Node (Leaf 'x') 1 (Node (Leaf 'y') 2 (Leaf 'z'))

```

We often use recursive functions to process recursive data types:

```

data IntList = Empty | Cons Int IntList

intListProd :: IntList -> Int
intListProd Empty      = 1
intListProd (Cons x l) = x * intListProd l
```
