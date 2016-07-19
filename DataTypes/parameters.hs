-- A value constructor can take some values parameters and then produce a new value.
-- For instance, the Car constructor takes three values and produces a car value.
-- In a similar manner, type constructors can take types as parameters to produce new types.

data Car = Car { company :: String
               , model :: String
               , year :: Int
               } deriving (Show)

-- car can be rewritten as
data Car2 a b c = Car2 { company2 :: a
                     , model2 :: b
                     , year2 :: c
                     } deriving (Show)

--- vector data type with parameterised types
data Vector a = Vector a a a deriving (Show)

vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)

vectMult :: (Num t) => Vector t -> t -> Vector t
(Vector i j k) `vectMult` m = Vector (i*m) (j*m) (k*m)

scalarMult :: (Num t) => Vector t -> Vector t -> t
(Vector i j k) `scalarMult` (Vector l m n) = i*l + j*m + k*n

-- in order to make the person data types equatable we derive from the Eq type
-- and to make them printable on the terminal we derive the show type.(interface)
data Person = Person { firstName :: String
                     , lastName :: String
                     , age :: Int
                     } deriving (Eq, Show, Read)

--  Bool type, which can have a value of either False or True.
-- For the purpose of seeing how it behaves when compared, we can think of it as being implemented like this:

data Bool' = False | True deriving (Ord)

-- Because the False value constructor is specified first and the True value constructor is specified after it, we can consider True as greater than False.

-- ghci> True `compare` False
-- GT
-- ghci> True > False
-- True
-- ghci> True < False
-- False  
