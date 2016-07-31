module LogAnalysis where
import Log

parseMessage :: String -> LogMessage
parseMessage message = makeLogMessage $ words message

makeLogMessage :: [String] -> LogMessage
makeLogMessage all@(x:y:xs)
  | x == "I" = LogMessage (Info (read y)) (unwords xs)
  | x == "E" = LogMessage (Error (read y)) (unwords xs)
  | x == "W" = LogMessage (Warning (read y)) (unwords xs)
  | otherwise = Unknown (unwords all)

parse :: String -> [LogMessage]
parse = map parseMessage . lines
