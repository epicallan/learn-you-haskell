module ApplyMaybe where
  applyMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
  applyMaybe Nothing _ = Nothing
  applyMaybe (Just x) f = f x

  -- Just 3 `applyMaybe` \x -> Just (x+1)   == Just 4

  --- monads do epxression

  foo :: Maybe String
  foo = Just 3    >>= (\x ->
        Just "!"  >>= (\y ->
        Just (show x ++ y)))
  -- foo can be written with do as below

  foo' :: Maybe String
  foo' = do
    x <- Just 3
    y <- Just "!"
    Just (show x ++ y)

  -- pattern matching in do notation
  justH :: Maybe Char
  justH = do
      (x:_) <- Just "hello"
      return x

  type Birds = Int
  type Pole = (Birds,Birds)

  landLeft :: Birds -> Pole -> Maybe Pole
  landLeft n (left,right)
      | abs ((left + n) - right) < 4 = Just (left + n, right)
      | otherwise                    = Nothing

  landRight :: Birds -> Pole -> Maybe Pole
  landRight n (left,right)
      | abs (left - (right + n)) < 4 = Just (left, right + n)
      | otherwise                    = Nothing

  routine :: Maybe Pole
  routine = do
      start <- return (0,0)
      first <- landLeft 2 start
      Nothing   -- equivalency of  putting >>
      second <- landRight 2 first
      landLeft 1 second
