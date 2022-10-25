-- 2022/10/25

import Data.List

-- LI-4

myReverse :: [a] -> [a]
myReverse [] = []
myReverse [x] = [x]
myReverse (x:xs) = (myReverse xs) ++ [x]

-- LI-6

conseq :: [a] -> [(a, a)]
conseq [] = []
conseq [x] = []
conseq [x, y] = [(x, y)]
conseq (x:y:resto) = [(x, y)] ++ conseq (y:resto)

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
    | length (x:xs) < n = (x:xs)
    | otherwise = x : myTake (n-1) xs

myTake' :: Int -> [a] -> [a]
myTake' n list 
    | length list < n = list
    | otherwise = [value | (value, index) <- zip (list) [1..], index <= n]

myDrop :: Int -> [a] -> [a]
myDrop n list
    | length list < n = []
    | otherwise = [value | (value, index) <- zip (list) [1..], index > n]

-- LI-13

mysplitAt :: Int -> [a] -> ([a], [a])
mysplitAt n list = (l1, l2)
    where l1 = [value | (value, index) <- zip (list) [1..], index <= n]
          l2 = [value | (value, index) <- zip (list) [1..], index > n]

-- LI-14

myGroup :: Eq a => [a] -> [[a]]
myGroup [] = []
myGroup list = list1 : list2
    where list1 = takeWhile (== head list) list
          list2 = myGroup $ dropWhile (== head list) list

-- LI-15

myInitsaux :: [a] -> [[a]]
myInitsaux [] = [[]]
myInitsaux list =  list : (myInitsaux (init list))

myInits :: [a] -> [[a]]
myInits list = reverse $ myInitsaux list

myTails :: [a] -> [[a]]
myTails list = reverse $ myInits list 

-- LI-16

myZip :: [a] -> [b] -> [(a, b)]
myZip [] [] = []
myZip [] b = []
myZip a [] = []
myZip (a:aa) (b:bb) = (a, b) : myZip aa bb

myZip3 :: [a] -> [b] -> [c] -> [(a, b, c)]
myZip3 [] [] [] = []
myZip3 [] b c = []
myZip3 a [] c = []
myZip3 a b [] = []
myZip3 (a:aa) (b:bb) (c:cc) = (a, b, c) : myZip3 aa bb cc

-- LI-17

differentFromNext :: Eq a => [a] -> [a]
differentFromNext [] = []
differentFromNext [x] = []
differentFromNext (x:y:resto) 
    | x /= y = x : differentFromNext (y:resto)
    | otherwise = differentFromNext (y:resto)

-- LI-18

myTransposeAux :: Int -> [[a]] -> [a]
myTransposeAux i lists = [list !! i | list <- lists]

myTranspose :: [[a]] -> [[a]]
myTranspose lists = [myTransposeAux i lists | i <- [0..(length $ head lists)-1]]

-- LI-19

myNub :: Eq a => [a] -> [a]
myNub [] = []
myNub list = (head list) : (myNub $ filter (/= value) (tail list))
    where value = head list 

-- LI-20

mySubsequences :: [a] -> [[a]]
mySubsequences [] = [[]]
mySubsequences (x:xs) = addOrNotToHead x (mySubsequences xs)

addOrNotToHead :: a -> [[a]] -> [[a]]
addOrNotToHead h [] = []
addOrNotToHead h (l:ls) = l:(h:l):(addOrNotToHead h ls)

-- LI-21

iSort :: Ord a => [a] -> [a]
iSort [] = []
iSort (x:xs) = insert x (iSort xs)

insert :: Ord a => a -> [a] -> [a]
insert v [] = [v]
insert v (x:xs)
    | v <= x = v:x:xs
    | otherwise = x:(insert v xs)

-- LI-22



-- LI-23

-- LI-24