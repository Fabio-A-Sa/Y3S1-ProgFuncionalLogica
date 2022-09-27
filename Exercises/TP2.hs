-- Aula TP2 2022/09/27

myconcat1 :: [[a]] -> [a]
myconcat1 [] = []
myconcat1 (h:t) = h ++ (myconcat1 t)

myconcat2 :: [[a]] -> [a]
myconcat2 lists = [value | list <- lists , value <- list]