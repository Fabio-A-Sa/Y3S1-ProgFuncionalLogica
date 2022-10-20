-- 2022/10/20

-- 2.1

myand :: [Bool] -> Bool
myand [] = False
myand (a:b) = a && myand b 

myor :: [Bool] -> Bool
myor [] = False 
myor (a:b) = a || myor b

myconcat :: [[a]] -> [a]
myconcat [] = []
myconcat (x:xs) = x ++ myconcat xs

myreplicate :: Int -> a -> [a]
myreplicate i l = [l] ++ myreplicate (i-1) l

(!!!) :: [a] -> Int -> a
(!!!) list 0 = head list
(!!!) list n = (!!!) (tail list) (n-1)

myelem :: Eq a => a -> [a] -> Bool
myelem _ [] = False 
myelem c (x:xs) = c == x || myelem c xs
