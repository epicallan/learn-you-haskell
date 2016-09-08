module Stack where
import Control.Monad.State
import System.Random

type Stack = [Int]

pop :: Stack -> (Int, Stack)
pop [] = (0, [])
pop (x: xs) = (x, xs)

push :: Int -> Stack -> ((), Stack)
push a xs = ((), a:xs)

stackManip :: Stack -> (Int, Stack)
stackManip stack = let
  ((), newStack1) = push 3 stack
  (_, newStack2) = pop newStack1
  in pop newStack2
-- The Control.Monad.State module provides a newtype that wraps stateful computations. Here's its definition:

-- newtype State s a = State { runState :: s -> (a,s) }
--
-- instance Monad (State s) where
--     return x = State $ \s -> (x,s)
--     (State h) >>= f = State $ \s -> let (a, newState) = h s
--                                         (State g) = f a
--                                     in  g newState


pop' :: State Stack Int
pop' = State $ \(x:xs) -> (x,xs)

push' :: Int -> State Stack ()
push' a = State $ \xs -> ((),a:xs)

stackManip :: State Stack Int
stackManip = do
    push' 3
    pop'
    pop'

stackStuff :: State Stack ()
stackStuff = do
  a <- pop
  if a == 5
      then push 5
      else do
          push 3
          push 8


-- ghci> runState stackStuff [9,0,2,1,0]
-- ((),[8,3,0,2,1,0])


moreStack :: State Stack ()
moreStack = do
    a <- stackManip
    if a == 100
        then stackStuff
        else return ()
-- get function from MonadState takes the current state and presents it as the result. The put function takes some state and makes a stateful function that replaces the current state with it:
get = State $ \s -> (s,s)

put newState = State $ \s -> ((),newState)

stackyStack :: State Stack ()
stackyStack = do
    stackNow <- get
    if stackNow == [1,2,3]
        then put [8,3,1]
        else put [9,2,1]




threeCoins :: State StdGen (Bool,Bool,Bool)
threeCoins = do
    a <- randomSt
    b <- randomSt
    c <- randomSt
    return (a,b,c)

-- threeCoins passes the  initial random generator to the first randomSt, which produces a number and a new generator, which gets passed to the next one and so on.
-- ghci> runState threeCoins (mkStdGen 33)
-- ((True,False,True),680029187 2103410263)
