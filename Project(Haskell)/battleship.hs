{-

 --- BattleShip ---

authors : Ionésio Junior
   	  Wesley Anibal
	  Agnaldo Junior
	  Rubens Batista
	  Davyson Weslley

-}

import System.IO.Unsafe
import System.Random

buildMat :: Int -> Int -> [[Int]]
buildMat n m = [     [0 | x <- [1,2 .. n] ]     |   y <- [1,2 .. m]       ]


showMat :: [[Int]] -> String
showMat m  = concat (concat [ [ "~ " | y <- x] ++ ["\n"] | x <- m])

generateRandomCoords :: Int -> Int -> [(Int,Int)]
generateRandomCoords a b =[ (unsafePerformIO (getStdRandom (randomR (a, b))),unsafePerformIO (getStdRandom (randomR (a, b)))) | y <- [1,2 .. 7]]

cruiserCoords :: [(Int,Int)] -> [[(Int,Int)]]
cruiserCoords a = [ [a !! 0 , a !! 1] , [a !! 2, a !! 3] ]


generateBattleShipsCoords :: [(Int,Int)] -> [[(Int,Int)]]
generateBattleShipsCoords randomCoord = do
					  let battleship = [ (x + i,y) | (x,y) <- [head randomCoord],i <- [0,1 .. 3]]
					  let cruiser = cruiserCoords $ [  (x,y + k)  | (x,y) <- [ randomCoord !! i | i <- [1,2] ] , k <- [0,1]  ]
					  [battleship] ++ cruiser ++ [ [(x,y)] | (x,y) <- [randomCoord !! i | i <- [3,4 .. 6]]]


coords = generateBattleShipsCoords (generateRandomCoords 0 5)


main = do
	  print $ coords
