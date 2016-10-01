{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
module MonadSupply where
import qualified Supply as S

class (Monad m) => MonadSupply s m | m -> s where
    next :: m (Maybe s)

instance MonadSupply s (S.Supply s) where
  next = S.next
