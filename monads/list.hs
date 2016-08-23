-- determining the number of possible moves on a chesbord by a knight at
-- a given position
module KnightQuest where
  import  Control.Monad

  type KnightPos = (Int, Int)

  moveKnight :: KnightPos -> [KnightPos]
  moveKnight (c, r) = do
    (c', r') <- [(c+2,r-1),(c+2,r+1),(c-2,r-1),(c-2,r+1)
                ,(c+1,r-2),(c+1,r+2),(c-1,r-2),(c-1,r+2)
                ]
    guard (c' `elem` [1..8] && r' `elem` [1..8])
    return (c', r')

  in3 :: KnightPos -> [KnightPos]
  in3 start = do
      first <- moveKnight start
      second <- moveKnight first
      moveKnight second

  -- MUsing >>= once gives us all possible moves from the start and then when we use >>= the second time, for every possible first move, every possible next move is computed, and the same goes for the last move.
  in3' :: KnightPos -> [KnightPos]
  in3' start = return start >>= moveKnight >>= moveKnight >>= moveKnight

  canReachIn3 :: KnightPos -> KnightPos -> Bool
  canReachIn3 start end = end `elem` in3 start  
