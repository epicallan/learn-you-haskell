module Dice where
  import System.Random
  import Control.Monad.Trans.State

  clumsyRollDice :: (Int, Int)
  clumsyRollDice = (n, m)
        where
        (n, g) = randomR (1,6) (mkStdGen 1)
        (m, _) = randomR (1,6) g

  
