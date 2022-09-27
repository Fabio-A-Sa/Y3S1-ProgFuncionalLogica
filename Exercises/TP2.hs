-- Aula TP2 2022/09/27

myconcat1 :: [[a]] -> [a]
myconcat1 [] = []
myconcat1 (h:t) = h ++ (myconcat1 t)

myconcat2 :: [[a]] -> [a]
myconcat2 lists = [value | list <- lists , value <- list]

myreplicate1 :: Integral a => a -> b -> [b]
myreplicate1 0 _ = []
myreplicate1 n x
    | n > 0 = x : myreplicate1 (n-1) x
    | n < 0 = error "myreplicate: n must be positive"

myreplicate2 :: Integral a => a -> b -> [b]
myreplicate2 n x = [x | _ <- [1..n]]

