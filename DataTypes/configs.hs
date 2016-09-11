-- more on record syntax
data Configuration = Configuration
    { username      :: String
    , localHost     :: String
    , remoteHost    :: String
    , isGuest       :: Bool
    , isSuperuser   :: Bool
    , currentDir    :: String
    , homeDir       :: String
    , timeConnected :: Integer
    }

-- username :: Configuration -> String
-- localHost :: Configuration -> String
-- -- etc.

changeDir :: Configuration -> String -> Configuration
changeDir cfg newDir =
  if directoryExists newDir -- make sure the directory exists
      then cfg { currentDir = newDir } -- updating data type
      else error "Directory does not exist"

postWorkingDir :: Configuration -> String
postWorkingDir cfg = currentDir cfg
postWorkingDir' = currentDir
