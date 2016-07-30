-- A Haskell function that takes as its parameter a string that contains a RPN expression,
-- like "10 4 3 + 2 * -" and gives us back its result.

solveRPN :: (Num a, Read a) => String -> a
solveRPN = head . foldl foldingFn [] . words
  where foldingFn (x:y:ys) "*" = (x * y):ys
        foldingFn (x:y:ys) "+" = (x + y):ys
        foldingFn (x:y:ys) "-" = (y - x):ys
        foldingFn xs numberString = read numberString:xs
