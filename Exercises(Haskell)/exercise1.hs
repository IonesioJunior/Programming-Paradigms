
estacionamento :: String -> Int
estacionamento n | (n == "moto") = 5
		 | (n == "carro") = 10	
		 | (n == "largo") = 30

main = do
	 name <- getLine
	 putStrLn(show (estacionamento name))
	
