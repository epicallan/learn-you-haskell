data TrafficLight = Red | Yellow | Green

-- making type instaces of the Eq class instead of deriving
-- To fulfill the minimal complete definition for Eq, we have to overwrite either one of == or /=

instance Eq TrafficLight where
  Red == Red = True
  Green == Green = True
  Yellow == Yellow = True
  _ == _ = False

-- To satisfy the minimal complete definition for Show, we just have to implement its show function, which takes a value and turns it into a string.

instance Show TrafficLight where
    show Red = "Red light"
    show Yellow = "Yellow light"
    show Green = "Green light"

-- Subclassing is puting a class constraint on a class declaration! When defining function bodies in the class declaration or when defining them in instance declarations
