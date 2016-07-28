import Control.Monad
import Data.Char

main :: IO()

main = forever $ do
    putStr "Give me some input: "
    l <- getLine
    putStrLn $ map toUpper l

-- $ cat file.txt | ./capslocker

-- can be rewritten as below

-- main = do
--     contents <- getContents
--     putStr (map toUpper contents)  
