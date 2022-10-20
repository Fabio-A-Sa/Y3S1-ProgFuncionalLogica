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

-- 2.2

myintersperse :: a -> [a] -> [a]
myintersperse c [x] = [x]
myintersperse c (x:xs) = x:c:(myintersperse c xs)

-- 2.3 

mdc :: Integer -> Integer -> Integer 
mdc a b 
    | b == 0 = a
    | otherwise = mdc b (a`mod`b)