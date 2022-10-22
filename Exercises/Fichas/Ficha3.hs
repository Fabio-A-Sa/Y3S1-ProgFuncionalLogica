-- 2022/10/24

import Data.List

-- 3.1

-- expression :: map f $ filter p xs 

-- 3.2

dec2int :: [Int] -> Int
dec2int list = foldl (\acc x -> acc*10+x) 0 list

-- 3.3

recZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
recZipWith function [] [] = []
recZipWith function a [] = []
recZipWith function [] b = []
recZipWith function (x:xs) (y:ys) = [function x y] ++ recZipWith function xs ys 

-- 3.4

myisort :: Ord a => [a] -> [a]
myisort list = foldl (\acc x -> insert x acc) [] list

-- 3.5.a

mymaximuml :: Ord a => [a] -> a 
mymaximuml list = foldl1 (\acc x -> if acc > x then acc else x) list 

myminimuml :: Ord a => [a] -> a 
myminimuml list = foldl1 (\acc x -> if acc < x then acc else x) list 

mymaximumr :: Ord a => [a] -> a 
mymaximumr list = foldr1 (\x acc -> if acc > x then acc else x) list 

myminimumr :: Ord a => [a] -> a 
myminimumr list = foldr1 (\x acc -> if acc < x then acc else x) list 

-- 3.5.b

myfoldl1 :: (a -> a -> a) -> [a] -> a 
myfoldl1 function [] = error "Empty list"
myfoldl1 function list = foldl (\acc x -> function acc x) (head list) (tail list)

myfoldr1 :: (a -> a -> a) -> [a] -> a 
myfoldr1 function [] = error "Empty list"
myfoldr1 function list = foldr (\x acc -> function acc x) (last list) (init list)

-- 3.6

mdc :: Int -> Int -> Int
mdc a b = fst $ until (\(a, b) -> b == 0) (\(a, b) -> (b, mod a b)) (a, b)

-- 3.7.a

(+++) :: [a] -> [a] -> [a]
(+++) list1 list2 = foldr (\x acc -> [x] ++ acc) list1 list2

-- 3.7.b

concate :: [[a]] -> [a]
concate list = foldr (\x acc -> x ++ acc) [] list

-- 3.7.c

reverser :: [a] -> [a]
reverser list = foldr (\x acc -> acc ++ [x]) [] list

-- 3.7.d

reversel :: [a] -> [a]
reversel list = foldl (\acc x -> [x] ++ acc) [] list

-- 3.7.e

myelem :: Eq a => a -> [a] -> Bool
myelem element list = any (\x -> x == element) list

-- 3.8.a

palavras :: String -> [String]
palavras [] = [[]]
palavras (' ':something) = palavras something
palavras list = [i | i<- [takeWhile (/=' ') list]] ++ palavras (dropWhile (/=' ') list)

-- 3.8.b

despalavras :: [String] -> String
despalavras [[]] = []
despalavras [x] = x
despalavras (x:xs) = x ++ " " ++ despalavras xs

-- 3.9

