module Term where

data Term = Con Integer | Div Term Term

eval :: Term -> Integer
eval (Con a) = a
eval (Div t u) = eval t `div` eval u

type M a = State -> (a, State)
type State = Integer
 -- adding state
eval' :: Term -> M Integer
eval' (Con a) x = (a, x)
-- keeping track the number of times we do division
eval' (Div t u) x = let (a, y) = eval' t x
                        (b, z) = eval' u y
                        in (a `div` b, z + 1)

-- generalization

-- unit :: a -> M a
-- unit (Con a) =  \s -> (Con a, s)
--
-- (*) :: M a -> (a -> M b) -> M b
--
-- eval :: Term → M Int
-- eval (Con a) = unit a
-- eval (Div t u) = eval t * λa. eval u * λb. unit (a ÷ b)
-- eval (Div t u) = ((eval t) * (λa.((eval u) * (λb.(unit (a ÷ b))))))
