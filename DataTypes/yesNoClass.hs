-- The YesNo typeclass defines one function. That function takes one value of a type that can be considered to hold some concept of true-ness and tells us for sure if it's true or not.
class YesNo a where
  yesno :: a -> Bool

instance YesNO Int where
  yesno 0 = False
  yesno _ = True

instance YesNo [a] where
  yesno [] = False
  yesno _ = True

instance YesNo Bool where
  yesno = id

instance YesNo (Maybe a) where  
    yesno (Just _) = True
    yesno Nothing = False
