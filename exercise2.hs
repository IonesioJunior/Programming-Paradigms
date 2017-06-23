import Control.Monad
result :: Int -> Int  -> Int -> String
result ideal height  atual | ideal == atual = "OK"
			   | abs(ideal - atual) < abs(ideal - height) = "ADEQUADO"
			   | otherwise = "PERIGO"
main = do 
	ideal <- getLine
	height <- getLine
	let distance = read height
	let loop = do
		atual <- getLine
		putStrLn (result (read ideal) (read distance) (read atual))
		let distance = read atual
		when (ideal /= atual) loop
	loop
	
