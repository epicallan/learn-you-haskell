module Main (main) where -- main is exported

import SimpleJSON

main :: IO()
main = print (JObject [("foo", JNumber 1), ("bar", JBool False)])
