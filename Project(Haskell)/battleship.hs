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

-- static random coords format [ [battleship],[cruiser],[cruiser],[mines],[mines],[mines],[mines] ]
coords = generateBattleShipsCoords (generateRandomCoords 0 5)

-----------------------------------------------------	Build Functions    ----------------------------------------------------------------------

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


-- Build Matrix with value and position of the hiden ships
buildMat :: Int -> Int -> [[(Int,Int)]] -> [[Int]]
buildMat n m coords = [     [ 0 | x <- [1,2 .. n] ]     |   y <- [1,2 .. m]       ]




--------------------------------------------------------- 	Update Matrix	--------------------------------------------------------------------

containsShip :: [[Int]] -> (Int,Int) -> [[Int]]
containsShip m coord_shot | containsBattleShip (coords !! 0) coord_shot = replace2D 1 coord_shot m
			  | containsCruiser [coords !! 1 , coords !! 2] coord_shot = replace2D 2 coord_shot m
			  | containsMineswepper [coords !! 3, coords !! 4, coords !! 5, coords !! 6] coord_shot = replace2D 3 coord_shot m
			  | otherwise = replace2D 5 coord_shot m

containsBattleShip :: [(Int,Int)] -> (Int,Int) -> Bool
containsBattleShip ships tuple = elem tuple ships

containsCruiser :: [[(Int,Int)]] -> (Int,Int) -> Bool
containsCruiser cruiser_coords coord_shot | elem coord_shot (cruiser_coords !! 0) =  True
					  | elem coord_shot (cruiser_coords !! 1) = True
					  | otherwise = False					


containsMineswepper :: [[(Int,Int)]] -> (Int,Int) -> Bool
containsMineswepper ships_coords coord_shot | elem [coord_shot] ships_coords = True
					    | otherwise = False




----------------------------------------------	Auxiliar Functions	---------------------------------------------------------------------------

replace p f xs = [ if i == p then f x else x | (x, i) <- zip xs [0..] ]
-- replace y element in (x,y) coordinate of matrix
replace2D v (x,y) = replace y (replace x (const v))

-- Increase hit value if shot equals of some coordinate in ship coords
increaseAcc :: Int -> (Int,Int) -> [[(Int,Int)]] -> Int
increaseAcc hit shot_coord coords | containsBattleShip (coords !! 0) shot_coord  = hit + 1
				  | containsCruiser [coords !! 1, coords !! 2] shot_coord  = hit + 1
				  | containsMineswepper [coords !! 3 , coords !! 4 ,  coords !! 5 , coords !! 6] shot_coord = hit + 1
				  | otherwise = hit



-------------------------------------------------------------------	IOFunctions	-----------------------------------------------------------


--show matrix to player
showMat :: [[Int]] -> String
showMat m  = concat (concat [ [ mapMat y | y <- x] ++ ["\n"] | x <- m])

mapMat :: Int -> String
mapMat value | (value == 1) = "1 "
	           | (value == 2) = "2 "
	           | (value == 3) = "3 "
	           | (value == 5) = "X "
             	   | otherwise = "~ "


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
							  let coordinates = (map read $ words shot :: [Int])
			                                  loop (containsShip matrix ( (coordinates !!  0),(coordinates !! 1) ) ) shots (fired + 1) (increaseAcc hit (coordinates !! 0,coordinates !! 1) coords)



--Define if you win or loose
getResult :: Int -> String
getResult hit | (hit == 12) = "You Win!\n"
	      | otherwise = "You Lose!\n You hit only " ++ show hit ++ " ships!!\n"

main = do
	   displayMenu
	   input <- getLine
	   putStrLn(show $ coords)
	   let shots = (map read $ words input :: [Int])
	   let matrix = buildMat 9 9 coords
	   loop matrix (shots !! 0) 0 0
