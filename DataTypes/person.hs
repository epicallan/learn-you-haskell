-- record syntax
data Person = Person { firstName :: String
                     , lastName :: String
                     , age :: Int
                     , height :: Float
                     , phoneNumber :: String
                     , flavor :: String
                     } deriving (Show)

-- Definig data types this way means we get pre-made getters for the data fields

-- ghci> :t firstName
-- firstName :: Person -> String
