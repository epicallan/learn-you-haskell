module LogMonad where
  import Data.Monoid
  isBigGang :: Int -> (Bool, String)
  isBigGang x = (x > 9, "Compared gang size to 9.")

  applyLog::(a, String) -> (a -> (b, String)) -> (b, String)
  applyLog (x, log') f = let (y, newLog) = f x in (y, log' ++ newLog)

  -- ghci> (3, "Smallish gang.") `applyLog` isBigGang
  -- (False,"Smallish gang.Compared gang size to 9")

  applyLog' :: (Monoid m ) => (a, m) ->(a -> (b, m)) -> (b, m)
  applyLog' (x, log') f = let(y, newLog) = f x in (y, log' `mappend` newLog)

  type Food = String
  type Price = Sum Int

  addDrink :: Food -> (Food,Price)
  addDrink "beans" = ("milk", Sum 25)
  addDrink "jerky" = ("whiskey", Sum 99)
  addDrink _ = ("beer", Sum 30)

  -- ghci> ("beans", Sum 10) `applyLog'` addDrink
  -- ("milk",Sum {getSum = 35})
