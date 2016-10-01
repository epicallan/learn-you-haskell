main :: IO ()
main = do putStr "What is your name?"
          a <- readLn
          putStr "How old are you?"
          b <- readLn
          print (a,b)

main' :: IO ()
main' = putStr "whats your name"
        >> readLn
        >>= \a -> putStr "How old are you"
        >> readLn
        >>= \b -> print (a, b)
