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

-- 2.4.a

myinsert :: Ord a => a -> [a] -> [a]
myinsert value [] = [value]
myinsert value (x:xs)
    | value >= x = x : myinsert value xs
    | otherwise = value:x:xs

-- 2.4.b

myord :: Ord a => [a] -> [a]
myord [] = []
myord (x:xs) = myinsert x (myord xs)

-- 2.5.a

myminimum :: Ord a => [a] -> a
myminimum [x] = x
myminimum (x:xs) if value < x then value else x
    where  value = myMinimum xs

-- 2.5.b

mydelete :: Eq a => a -> [a] -> [a]
mydelete value [] = []
mydelete value (x:xs)
    | value == x = xs
    | otherwise = x : mydelete value xs
