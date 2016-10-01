module VCard where
import Control.Monad

data Context = Home | Mobile | Business
               deriving (Eq, Show)

type Phone = String

albulena :: [(Context, String)]
albulena = [(Home, "+355-652-55512")]

nils :: [(Context, String)]
nils = [(Mobile, "+47-922-55-512"), (Business, "+47-922-12-121"),
        (Home, "+47-925-55-121"), (Business, "+47-922-25-551")]

twalumba :: [(Context, String)]
twalumba = [(Business, "+260-02-55-5121")]

onePersonalPhone :: [(Context, Phone)] -> Maybe Phone
onePersonalPhone ps = case lookup Home ps of
                        Nothing -> lookup Mobile ps
                        Just n -> Just n

allBusinessPhones :: [(Context, Phone)] -> [Phone]
allBusinessPhones ps = map snd numbers
    where numbers = case filter (contextIs Business) ps of
                      [] -> filter (contextIs Mobile) ps
                      ns -> ns

contextIs :: Context -> (Context, String) -> Bool
contextIs a (b, _) = a == b

-- let's fetch one business and all personal phone numbers using monadplus

businessPhone :: [(Context, Phone)] -> Maybe Phone
businessPhone ps = lookup Business ps `mplus` lookup Mobile ps


allPersonalPhones :: [(Context, Phone)] -> [Phone]
allPersonalPhones ps = map snd $  filter (contextIs Mobile) ps `mplus`
                                  filter (contextIs Mobile) ps


-- generalising lookup
lookupM :: (MonadPlus m, Eq a) => a -> [(a, b)] -> m b
lookupM _ []    = mzero
lookupM k ((x,y):xys)
    | x == k    = return y `mplus` lookupM k xys
    | otherwise = lookupM k xys

-- failing with gurd
-- guard        :: (MonadPlus m) => Bool -> m ()
-- guard True   =  return ()
-- guard False  =  mzero

zeroMod:: (Integral a,MonadPlus m) => a -> a -> m a
x `zeroMod` n = guard ((x `mod` n) == 0) >> return x

-- 10 `zeroMod` 3 :: Maybe Int -- Nothing
-- 10 `zeroMod` 3 :: [Int] -- []
-- Just _ >> k = k
-- Nothing >> _ = Nothing
