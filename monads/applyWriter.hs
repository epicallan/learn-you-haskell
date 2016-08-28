import Control.Monad.Trans.Writer

logNumber :: (Show a, Monad m) => a -> WriterT [String] m
logNumber x = writer (x, ["Got number: " ++ show x])

multWithLog :: MonadWriter [String] m
multWithLog = do
    a <- logNumber 3
    b <- logNumber 5
    return (a*b)
