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
myminimum (x:xs) = if value < x then value else x
    where  value = myminimum xs

-- 2.5.b

mydelete :: Eq a => a -> [a] -> [a]
mydelete value [] = []
mydelete value (x:xs)
    | value == x = xs
    | otherwise = x : mydelete value xs

-- 2.5.c

ssort :: Ord a => [a] -> [a]
ssort [] = []
ssort list = m : ssort (mydelete m list)
    where m = myminimum list

-- 2.6

expression = sum $ map (^2) [1..100]

-- 2.7

aprox :: Int -> Double
aprox n = sum [((-1)^x) / fromIntegral (2*x+1) | x <- [0..n]] * 4

-- 2.8

dotprod :: [Float] -> [Float] -> Float
dotprod list1 list2 = sum $ zipWith (*) list1 list2

-- 2.9

divprop :: Integer -> [Integer]
divprop n = [x | x <- [1..(n-1)], n `mod` x == 0]

-- 2.10

perfeitos :: Integer -> [Integer]
perfeitos n = [x | x <- [1..n], sum (divprop x) == x]