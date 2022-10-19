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

(@@) :: Integral b => [a] -> b -> a 
[] @@ n = error "Error: empty list or index too large"
(x:_) @@ 0 = x
(x:xs) @@ n
    | n > 0 = xs @@ (n-1)
    | otherwise = error "Error: n must be greater than 0"

(@@@) :: Integral b => [a] -> b -> a 
list @@@ n = head [x | (x,i) <- zip list [0..], i == n]

-- Time complexity = O(n^2)

myreverse1 :: [a] -> [a]
myreverse1 [] = []
myreverse1 (x:xs) = myreverse1 xs ++ [x]

reverse2Aux :: [a] -> [a] -> [a]
reverse2Aux [] acc = acc
reverse2Aux (x:xs) acc = reverse2Aux xs (x:acc)

myreverse2 :: [a] -> [a]
myreverse2 [] = []
myreverse2 list = reverse2Aux list []

-- reverse2Aux [1, 2, 3] []
-- reverse2Aux [2, 3] [1]
-- reverse2Aux [3] [2, 1]
-- reverse2Aux [] [3, 2, 1]
-- [3, 2, 1]

-- 2.6

sumsquares :: Integral a => a -> a
sumsquares n
    | n > 0 = sum [x^2 | x <- [1..n]]
    | otherwise = error "N must be a positive number"
