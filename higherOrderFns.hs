--- It turns out that if you want to define computations by defining what
--- stuff is instead of defining steps that change some state and maybe looping them,
--- higher order functions are indispensable

compareWithHundred :: (Num a, Ord a) => a -> Ordering
compareWithHundred = compare 100  --- compare 100 returns a function that takes x as a parameter
--
--- we need parathesis in the type declarations to indicate
--- that the first parameter is a function that takes something and returns that same thing
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)
