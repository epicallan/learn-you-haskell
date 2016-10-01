main :: IO ()
main = do let get2chars = getChar >> getChar
          putStr "Press two keys"
          get2chars
          return ()

-- main world0 = let get2chars = getChar >> getChar
--                   ((), world1) = putStr "Press two keys" world0
--                   (answer, world2) = get2chars world1
--               in ((), world2)
