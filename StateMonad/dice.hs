module Dice where
  import System.Random

  clumsyRollDice :: (Int, Int)
  clumsyRollDice = (n, m)
        where
        (n, g) = randomR (1,6) (mkStdGen 1)
        (m, _) = randomR (1,6) g
