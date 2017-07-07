import System.IO.Unsafe
import System.Random

buildMat :: Int -> Int -> [[Int]]
buildMat n m = [     [0 | x <- [1,2 .. n] ]     |   y <- [1,2 .. m]       ]


showMat :: [[Int]] -> String
showMat m  = concat (concat [ [ "~ " | y <- x] ++ ["\n"] | x <- m])

generateRandomCoords :: Int -> Int -> [(Int,Int)]
generateRandomCoords a b =[ (unsafePerformIO (getStdRandom (randomR (a, b))),unsafePerformIO (getStdRandom (randomR (a, b)))) | y <- [1,2 .. 12]]


coords = generateRandomCoords 0 9


main = do
	  print $ coords
