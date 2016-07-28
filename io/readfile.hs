import System.IO

main :: IO()
main = do
    handle <- openFile "file.txt" ReadMode
    contents <- hGetContents handle
    putStr contents
    hClose handle



-- haskell has a helper readfile that sets up a file handle and closes the file
-- as well
-- readFile :: FilePath -> IO String
-- main = do
--     contents <- readFile "file.txt"
--     putStr contents
