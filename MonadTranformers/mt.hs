{-# LANGUAGE OverloadedStrings #-} --turns regular strings to text
module Mt where
import Data.Text
import qualified Data.Text.IO as T
import Data.Map as Map
import Control.Applicative

data LoginError = InvalidEmail
                | NoSuchUser
                | WrongPassword
  deriving Show

getDomain :: Text -> Either LoginError Text
getDomain email =
  case splitOn "@" email of
    [name, domain] -> Right domain
    _              -> Left InvalidEmail

printResult' :: Either LoginError Text -> IO ()
printResult' domain =
  case domain of
    Right text        -> T.putStrLn (append "Domain: " text)
    Left InvalidEmail -> T.putStrLn "ERROR: Invalid domain"

-- either :: (a -> c) -> (b -> c) -> Either a b -> c
-- either :: (LoginError -> Text) -> (Text -> Text) -> (Either LoginError Text -> Text)

printResult :: Either LoginError Text -> IO ()
printResult = T.putStrLn . either
  (const "Error: Invalid domain")
  (append "Domain: ")


getToken :: IO (Either LoginError Text)
getToken = do
  T.putStrLn "Enter email address:"
  email <- T.getLine
  return (getDomain email)

users :: Map Text Text
users = Map.fromList [("example.com", "qwerty123"), ("localhost", "password")]

-- authentication
userLogin :: IO (Either LoginError Text)
userLogin = do
  token <- getToken

  case token of
    Right domain ->
      case Map.lookup domain users of
        Just userpw -> do
          T.putStrLn "Enter password:"
          password <- T.getLine

          if userpw == password
             then return token

             else return (Left WrongPassword)
        Nothing -> return (Left NoSuchUser)
    left -> return left

newtype EitherIO e a = EitherIO {
  runEitherIO :: IO (Either e a)
}
