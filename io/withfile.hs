import System.IO

main :: IO()
main = withFile "file.txt" ReadMode (\handle -> do
        contents <- hGetContents handle
        putStr contents)

-- withFile' :: FilePath -> IOMode -> (Handle -> IO a) -> IO a
-- withFile' path mode f = do
--     handle <- openFile path mode
--     result <- f handle
--     hClose handle
--     return result  
