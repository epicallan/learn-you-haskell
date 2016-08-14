module Calc where
import ExprT

-- there should be a better way of doing this
eval :: ExprT -> Integer
eval (Add (Lit x) (Lit y)) = x + y
eval (Mul (Lit x) (Lit y)) = x * y
eval (Mul(Add (Lit xs) (Lit ys)) (Lit x)) = (xs + ys) * x
eval (Add(Mul (Lit xs) (Lit ys))(Lit x)) = (xs * ys) + x



-- not working
evalStr :: String -> Maybe Integer
evalStr "" = Nothing
evalStr n = Just (head.foldr foldFn [].words $ n)
  where foldFn "+" (x:y:xs) = x + y : xs
        foldFn "*" (x:y:xs) = x * y : xs
        foldFn xs acc = read xs : acc

class Expr a where
  lit   :: a -> Integer
  add   :: a -> a -> Integer
  mult  :: a -> a -> Integer


instance Expr ExprT where
  lit (Lit x) = x
  add (Lit x) (Lit y) = x + y
  mult (Lit x) (Lit y) = x * y


instance Expr Integer where
  lit x = x
  add x y = x + y
  mult x y = x * y

-- mult (Lit 4) (Lit ( add (Lit 2) (Lit 3) )  )
