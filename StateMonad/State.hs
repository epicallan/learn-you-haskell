module State where
import System.Random

newtype State s a = State {runState :: s -> (a, s)}

-- returnState is a function that lifts a plain value x into a computation that has result x and also *accepts* and yields a state value, which is what values of the State monad (State s a) should look like.
returnState :: a -> State s a
returnState a = State $ \s -> (a, s)

bindSate :: State s a -> (a -> State s b) -> State s b
bindSate m k = State $ \s -> let (a, s') = runState m s
                              in runState (k a) s'

get :: State s s
get = State $ \s -> (s, s)

put :: s -> State s ()
put s = State $ const ((), s)

-- random number example

twoGoodRandoms :: RandomGen g => g -> ((Int, Int), g)
twoGoodRandoms gen = let (a, gen') = random gen
                         (b, gen'') = random gen'
                     in ((a, b), gen'')

type RandomState a = State StdGen a

getRandom :: Random a => RandomState a
getRandom =
  get >>= \gen ->
  let (val, gen') = random gen in
  put gen' >>
  return val

getTwoRandoms :: Random a => RandomState (a, a)
getTwoRandoms = liftM2 (,) getRandom getRandom

-- ghci> (,) 1 2
-- ghci> (1,2) --output
