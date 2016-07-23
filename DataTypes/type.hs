-- Type synonyms don't really do anything per se, they're just about giving some types different names so that they make more sense to someone reading our code and documentation.

-- Here's how the standard library defines String as a synonym for [Char].
-- type String = [Char]

-- making a phoneBook type
type PhoneNumber = String
type Name = String
type PhoneBook = [(Name, PhoneNumber)]

phoneBook :: PhoneBook
phoneBook =
    [("betty","555-2938")
    ,("bonnie","452-2928")
    ,("patsy","493-2928")
    ,("lucille","205-2928")
    ,("wendy","939-8282")
    ,("penny","853-2492")
    ]
inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool
inPhoneBook name pnumber pbook = (name,pnumber) `elem` pbook

-- Type synonyms can also be parameterized. So as to make them more general
type AssocList k v = [(k, v)]

-- Just like we can partially apply functions to get new functions, we can partially apply type parameters and get new type constructors from them.

--  If we wanted a type that represents a map (from Data.Map) from integers to something, we could either do this:
type IntMap v = Map Int v

-- It has two value constructors. If the Left is used, then its contents are of type a and if Right is used, then its contents are of type b
data Either a b = Left a | Right b deriving (Eq, Ord, Read, Show)
