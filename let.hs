--- let bindings are expressions
--- are fairly local in their scope and they can't be used across guards
cylinder :: (RealFloat a) => a -> a -> a
cylinder h r =
  let sideArea = 2 * pi * r * h
      topArea = pi * r ^ 2
  in  sideArea + 2 *  topArea

calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h^2, bmi >= 24]
