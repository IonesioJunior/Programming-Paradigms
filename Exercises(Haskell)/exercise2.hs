import Data.List
import System.IO

aviao :: Int -> Int -> IO()
aviao adequado inicial = do
  z <- getLine
  let atual = read z
  if (inicial == adequado) || (atual == adequado) then putStrLn "OK"
    else if (abs(adequado - inicial)) > (abs(adequado - atual)) then do putStrLn "ADEQUADO"
                                                                        aviao adequado atual
      else do putStrLn "PERIGO"
              aviao adequado atual

main = do
  x <- getLine
  y <- getLine
  let adequado = read x
  let anterior = read y
  aviao adequado anterior
