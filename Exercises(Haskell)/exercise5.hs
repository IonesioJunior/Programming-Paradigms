showDiff :: [Int] -> [Int] -> IO ()
showDiff [x] [y] = putStrLn(show (x - y))
showDiff (x:xs) (h:t) = do
			  putStrLn(show (x - h))
			  showDiff xs t

main = do
	 first <- getLine
	 second <- getLine
	 showDiff (map read $ words first :: [Int])  (map read $ words second :: [Int])
