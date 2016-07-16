-- defining the bool data type
-- data Bool = True | False
module Shapes
( Point(..)
, Shape(..)
, surface
) where
data Point = Point Float Float deriving (Show)
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

-- Circle value constructor has three fields, which take floats. So when we write a value constructor, we can optionally add some types after it and those types define the values it will contain.

-- ghci> :t Circle
-- Circle :: Float -> Float -> Float -> Shape
-- ghci> :t Rectangle
-- Rectangle :: Float -> Float -> Float -> Float -> Shape
surface :: Shape -> Float
surface (Circle _ r) = pi * r ^ 2
surface (Rectangle (Point x1 y1) (Point x2 y2)) = abs (x2 - x1) * abs (y2 - y1)

-- map (Circle 10 20) [4,5,6,6]
-- [Circle 10.0 20.0 4.0,Circle 10.0 20.0 5.0,Circle 10.0 20.0 6.0,Circle 10.0 20.0 6.0]
