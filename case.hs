--- case statements are like let and if else expressionss
head' :: [a] -> a
head' xs = case xs of [] -> error "No head for empty lists"
                      (x: _) -> x

--- case statments can be used anywhere in a function

describeList :: [a] -> String
describeList xs = "The list is " ++ case xs of [] -> "Empty"
                                               [x] -> "a signleton list"
                                               xs -> "a long list"
