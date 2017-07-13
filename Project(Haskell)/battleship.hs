{-

 --- BattleShip ---

authors : Ionésio Junior
   	  Wesley Anibal
	  Agnaldo Junior
	  Rubens Batista
	  Dayvson Weslley

-}

import System.IO.Unsafe
import System.Random
import Control.Monad


-- Build Matrix with value and position of the hiden ships
buildMat :: Int -> Int -> [[(Int,Int)]] -> [[Int]]
buildMat n m coords = [     [ 0 | x <- [1,2 .. n] ]     |   y <- [1,2 .. m]       ]

containsBattleShip :: (Int, Int) -> [(Int, Int)] -> Bool
containsBattleShip tupla coords1 | (coords1 !! 0) == tupla = True
                                | (coords1 !! 1) == tupla = True
                                | (coords1 !! 2) == tupla = True
                                | (coords1 !! 3) == tupla = True
                                | otherwise = False

fillMat :: Int -> Int -> [(Int, Int)] -> Int
fillMat x y coords | containsBattleShip (x,y) (coords !! 0) = 1
                   | containsCruiser (x,y) (coords !! 1) (coords !! 2) = 2
                   | containsMinesweeper (x,y) (coords !! 3) (coords !! 4) (coords !! 5) (coords !! 6) = 3
                   | otherwise = 5


containsCruiser :: (Int,Int) -> [(Int,Int)] -> [(Int, Int)] -> Bool
containsCruiser tupla coords1 coords2 | (coords1 !! 0) == tupla || (coords2 !! 0 ) == tupla = True
                                      | (coords1 !! 1) == tupla || (coords2 !! 1 ) == tupla = True
                                      | otherwise = False

containsMinesweeper :: (Int,Int) -> [(Int,Int)] -> [(Int, Int)] -> [(Int, Int)] -> [(Int, Int)] -> Bool
containsMinesweeper tupla coords1 coords2 coords3 coords4 | (coords1 !! 0) == tupla || (coords2 !! 0 ) == tupla || (coords3 !! 0) == tupla || (coords4 !! 0 ) == tupla = True
                                                          | otherwise = False


--show matrix to player
showMat :: [[Int]] -> String
showMat m  = concat (concat [ [ mapMat y | y <- x] ++ ["\n"] | x <- m])

mapMat :: Int -> String
mapMat value | (value == 1) = "1 "
	           | (value == 2) = "2 "
	           | (value == 3) = "3 "
	           | (value == 5) = "X "
             | otherwise = "~ "

--Generate random coords for first position of ships
generateRandomCoords :: Int -> Int -> [(Int,Int)]
generateRandomCoords a b =[ (unsafePerformIO (getStdRandom (randomR (a, b))),unsafePerformIO (getStdRandom (randomR (a, b)))) | y <- [1,2 .. 7]]

--Generate coord for cruiser using random seed
cruiserCoords :: [(Int,Int)] -> [[(Int,Int)]]
cruiserCoords a = [ [a !! 0 , a !! 1] , [a !! 2, a !! 3] ]

--Generate coord for battleship  using random seed
generateBattleShipsCoords :: [(Int,Int)] -> [[(Int,Int)]]
generateBattleShipsCoords randomCoord = do
					  let battleship = [ (x + i,y) | (x,y) <- [head randomCoord],i <- [0,1 .. 3]]
					  let cruiser = cruiserCoords $ [  (x,y + k)  | (x,y) <- [ randomCoord !! i | i <- [1,2] ] , k <- [0,1]  ]
					  [battleship] ++ cruiser ++ [ [(x,y)] | (x,y) <- [randomCoord !! i | i <- [3,4 .. 6]]]


-- static value
coords = generateBattleShipsCoords (generateRandomCoords 0 5)


--Show simple legends
displayMenu :: IO()
displayMenu = putStrLn("======= Batalha Naval ========\n"++
  "O - Desconhecido\n"++
	"X - Erro\n"++
	"1 - Battleship\n"++
	"2 - Cruiser\n"++
	"3 - Minesweeper\n\n"++
	"Quantos disparos deseja ter?\n")

--Game loop
loop :: [[Int]] -> Int -> Int -> Int -> IO()
loop matrix shots fired hit | (shots == fired)  = putStrLn $ (getResult hit)
		                        | otherwise = do
						                                  putStrLn(" ========  BattleShip  ======== \n\n")
						                                  putStrLn $ showMat $ matrix
						                                  putStrLn(" Onde deseja atirar? \n")
						                                  shot <- getLine
						                                  loop matrix shots (fired + 1) hit



--Define if you win or loose
getResult :: Int -> String
getResult hit | (hit == 12) = "You Win!\n"
	      | otherwise = "You Lose!\n"


main = do
	   displayMenu
	   input <- getLine
	   let shots = (map read $ words input :: [Int])
	   let matrix = buildMat 9 9 coords
	   loop matrix (shots !! 0) 0 0
