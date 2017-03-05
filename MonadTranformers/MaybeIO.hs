module MaybeIO where

import Control.Applicative

newtype MaybeIO a = MaybeIO {
  runMaybeIO :: IO (Maybe a)
}

instance Functor MaybeIO where
  fmap f (MaybeIO m) = MaybeIO $ (fmap.fmap) f m

instance Applicative MaybeIO where
  pure = MaybeIO . pure . Just
  -- λ> :t liftA2 (<*>)
  -- :: (Applicative f, Applicative g) => f (g (a -> b)) -> f (g a) -> f (g b)
  -- liftA2 (<*>)
  -- :: IO (Maybe (a -> b)) -> IO (Maybe a) -> IO (Maybe b)
  MaybeIO f <*> MaybeIO m = MaybeIO $ liftA2 (<*>) f m

instance Monad MaybeIO where
  return = pure
  -- m :: IO (Maybe a)
  -- f :: a -> MaybeIO b
  -- x :: Maybe a
  MaybeIO m >>= f = MaybeIO $ m >>= \x -> case x of
    Nothing -> return Nothing
    Just val -> runMaybeIO $ f val  -- unwrapping the MaybeIO b  so that we have a return value of IO

-- application of our monad that combines IO and Maybe
data User = User deriving Show


findById :: Int -> IO (Maybe User)
findById 1 = return $ Just User
findById _ = return Nothing

findUsers :: Int -> Int -> IO (Maybe (User, User))
findUsers x y = do
    muser1 <- findById x

    case muser1 of
        Nothing -> return Nothing
        Just user1 -> do
            muser2 <- findById y

            case muser2 of
                Nothing -> return Nothing
                Just user2 -> return Just (user1, user2)

smartFindUsers :: Int -> Int -> MaybeIO (User, User)
smartFindUsers x y = do
  user1 <- MaybeIO $ findById x
  user2 <- MaybeIO $ findById y
  return (user1, user2)

-- MaybeIO $ findById X  >>= (\user1 ->
-- MaybeIO $ findById y >> = (\user2 ->
-- return (user1, user2)))

smartFindUsers' :: Int -> Int -> IO ( Maybe (User, User) )
smartFindUsers' x y = runMaybeIO $ do
    userA <- MaybeIO $ findById x
    userB <- MaybeIO $ findById y

    return (userA, userB)

newtype MaybeT m a = Maybe { runMaybeT :: m (Maybe a)}
