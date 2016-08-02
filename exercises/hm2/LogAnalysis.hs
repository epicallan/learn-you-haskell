module LogAnalysis where
import Log

-- exercise 1
makeLogMessage :: [String] -> LogMessage
makeLogMessage all@(x:y:xs)
  | x == "I" = LogMessage (Info (read y)) (unwords xs)
  | x == "E" = LogMessage (Error (read y)) (unwords xs)
  | x == "W" = LogMessage (Warning (read y)) (unwords xs)
  | otherwise = Unknown (unwords all)

parseMessage :: String -> LogMessage
parseMessage message = makeLogMessage $ words message


parse :: String -> [LogMessage]
parse = map parseMessage . lines

-- exercise 2
-- sorting by type
insert ::LogMessage -> MessageTree -> MessageTree
insert (Unknown _) tree = tree
insert x Leaf = Node Leaf x Leaf
insert x@(LogMessage (Info levelX) _) (Node left a@(LogMessage (Info levelA) _) right)
  | levelX == levelA = Node left x right
  | levelX < levelA  = Node (insert x left) a right
  | levelX > levelA  = Node left a (insert x right)