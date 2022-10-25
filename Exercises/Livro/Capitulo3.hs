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