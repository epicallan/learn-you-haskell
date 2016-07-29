import System.Environment
import System.IO
import System.IO.Error
import Prelude hiding (catch)
-- catch is deprecated should use better error handling
main :: IO ()
main = toTry `catch` handler

toTry :: IO()
toTry = do
  (fileName: _) <- getArgs
  contents <- readFile fileName
  putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"

handler :: IOError -> IO ()
handler e
  | isDoesNotExistError e = putStrLn "The file doesnt exist!"
  | otherwise = ioError e
