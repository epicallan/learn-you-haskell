module FilterMTest where
  import Control.Monad.Writer

  keepSmall :: Int -> Writer [String] Bool
  keepSmall x
    | x < 4 = do
        tell ["Keeping " ++ show x]
        return True
    | otherwise = do
        tell [show x ++ " is too large, throwing it away"]
        return False

  -- ghci> fst $ runWriter $ filterM keepSmall [9,1,5,2,10,3]
  -- [1,2,3]
  -- mapM_ putStrLn $ snd $ runWriter $ filterM keepSmall [9,1,5,2,10,3]  
  -- 9 is too large, throwing it away
  -- Keeping 1
  -- 5 is too large, throwing it away
  -- Keeping 2
  -- 10 is too large, throwing it away
  -- Keeping 3
