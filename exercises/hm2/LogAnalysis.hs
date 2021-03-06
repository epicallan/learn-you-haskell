module LogAnalysis where
import Log

-- exercise 1
makeLogMessage :: [String] -> LogMessage
makeLogMessage all@(x:y:xs)
  | x == "I" = LogMessage Info (read y) (unwords xs)
  | x == "E" = LogMessage (Error $ read y) (read $ head xs) (unwords $ tail xs)
  | x == "W" = LogMessage Warning (read y) (unwords xs)
  | otherwise = Unknown (unwords all)

parseMessage :: String -> LogMessage
parseMessage message = makeLogMessage $ words message


parse :: String -> [LogMessage]
parse = map parseMessage . lines

insert ::LogMessage -> MessageTree -> MessageTree
insert (Unknown _) tree = tree
insert x Leaf = Node Leaf x Leaf
insert x@(LogMessage _ timeStampX _) (Node left a@(LogMessage _ timeStampA _) right)
  | timeStampX == timeStampA = Node left x right
  | timeStampX < timeStampA  = Node (insert x left) a right
  | timeStampX > timeStampA  = Node left a (insert x right)

build :: [LogMessage] -> MessageTree
build = foldr insert Leaf

inOrder :: MessageTree -> [LogMessage]
inOrder (Node Leaf x Leaf) =  [x]
inOrder (Node left x right) =  x : inOrder left ++ inOrder right

getErrors :: LogMessage -> Bool
getErrors (Unknown _) = False
getErrors (LogMessage messageType _ message)
  | messageType == Info     = False
  | messageType == Warning  = False
  | otherwise               = True

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong  = map(\(LogMessage _ _ x) -> x).filter getErrors
