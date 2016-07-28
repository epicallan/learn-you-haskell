import Data.Char
main :: IO ();
--  writeFile :: FilePath -> String -> IO ()
main = do
    contents <- readFile "file.txt"
    writeFile "fileCaps.txt" (map toUpper contents)

-- runhaskell writefile.hs


-- main = do     
--   todoItem <- getLine
--   appendFile "todo.txt" (todoItem ++ "\n")
