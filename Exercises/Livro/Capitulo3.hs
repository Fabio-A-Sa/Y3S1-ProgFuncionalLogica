-- LI-7

deleteOne :: Eq a => a -> [a] -> [a]
deleteOne value [] =  []
deleteOne value (x:xs) 
    | value == x = xs
    | otherwise = x : deleteOne value xs

deleteAll :: Eq a => a -> [a] -> [a]
deleteAll value [] = []
deleteAll value (x:xs)
    | value == x = deleteAll value xs
    | otherwise = x : deleteAll value xs

-- LI-8

myConcat :: [[a]] -> [a]
myConcat lists = [element | list <- lists, element <- list]

-- LI-9

myReplicate :: Int -> a -> [a]
myReplicate n value = [value | _ <- [1..n]]

-- LI-10

myCycle :: [a] -> [a]
myCycle list = [value | _ <- [1..], value <- list] 

-- LI-11

myInt :: a -> [a] -> [a]
myInt a [] = []
myInt a [x] = [x]
myInt a (x:xs) = x : a : myInt a xs

-- LI-12

myTake :: Int -> [a] -> [a]
myTake 0 _ = []
myTake n (x:xs) 
    | length (x:xs) < n = error "Large n"
    | otherwise = x : myTake (n-1) xs