showElements :: [String] -> [String] -> IO ()
showElements [t] [h] = do
			 let string = t ++ " " ++ h
			 putStrLn(string)
showElements (x:xs) (h:t) = do 
			      let string = x ++ " " ++ h
			      putStrLn(string) 
			      showElements xs t


main = do
	 first <- getLine
	 second <- getLine
	 showElements (words first) (words second) 
