result :: Double -> Double -> Double -> Double
result alcool gasolina litros | gasolina * 0.7 <= alcool = gasolina * litros
			      | otherwise = alcool * litros

main = do
	alcool <- getLine
	gasolina <- getLine
	litros <- getLine
	putStrLn (show (result (read alcool) (read gasolina) (read litros)))
