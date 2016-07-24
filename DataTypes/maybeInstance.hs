-- Maybe isn't a concrete type. It's a type constructor that takes one parameter and then produces a concrete type

class Eq a where
    (==) :: a -> a -> Bool
    (/=) :: a -> a -> Bool
    x == y = not (x /= y)
    x /= y = not (x == y)

-- We had to add a class constraint! With this instance declaration, we say this: we want all types of the form Maybe m to be part of the Eq typeclass,

instance (Eq m) => Eq (Maybe m) where
  Just x == Just y = x == y
  Nothing == Nothing = True
  _ == _ = False
