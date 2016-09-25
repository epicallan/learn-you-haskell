import System.Random
import Control.Monad.State

type RandomState a = State StdGen a

getRandom :: Random a => RandomState a
getRandom =
  get >>= \gen ->
  let (val, gen') = random gen in
  put gen' >> return val

-- sg <-getStdGen
-- runState getRandom sg :: (Integer, StdGen)
getRandom' :: Random a => RandomState a
getRandom' = do
  gen <- get
  let (val, gen') = random gen
  put gen'
  return val

-- find the random return type confusing
getTwoRandoms :: Random a => RandomState (a, a)
getTwoRandoms = liftM2 (,) getRandom getRandom

--std <-getStdGen
--  runState getTwoRandoms std  :: ((Integer, Integer), StdGen)

runTwoRandoms :: IO (Int, Int)
runTwoRandoms = do
  oldState <- getStdGen
  let (result, newState) = runState getTwoRandoms oldState
  setStdGen newState
  return result

-- a <- runTwoRandoms
-- a or
-- runTwoRandoms

data CountedRandom = CountedRandom {
    crGen :: StdGen,
    crCount :: Int
  }

type CRState = State CountedRandom

getCountedRandom :: Random a => CRState a
getCountedRandom = do
  st <- get
  let (val, gen') = random (crGen st) -- extracts value
  put CountedRandom {crGen = gen',  crCount = crCount st + 1 }
  return val
