-- 2022/10/04

import Data.List (insert)

-- 3.1

mapFilter :: (a -> b) -> (a -> Bool) -> [a] -> [b]
mapFilter f p l = map f (filter p l)

-- 3.2

dec2int1 :: Integral a => [a] -> a
dec2int1 list = foldl (\acc x -> acc*10 + x) 0 list 

dec2int2 :: Integral a => [a] -> a
dec2int2 = foldl (\acc x -> acc*10 + x) 0 -- eta- reduction

dec2int3 :: Integral a => [a] -> a
dec2int3 = foldl (\acc x -> (+) (acc*10) x) 0 -- eta-reduction

dec2int4 :: Integral a => [a] -> a
dec2int4 = foldl (\acc -> (+) (acc*10)) 0 -- eta-reduction

dec2int5 :: Integral a => [a] -> a
dec2int5 = foldl (\acc -> (+) ((*10) acc)) 0 -- eta-reduction

dec2int6 :: Integral a => [a] -> a
dec2int6 = foldl (\acc -> (((+) . (*10)) acc)) 0 -- eta-reduction

dec2int7 :: Integral a => [a] -> a
dec2int7 = foldl ((+) . (*10)) 0 -- eta-reduction

-- 3.7.c

reverseRight :: [a] -> [a] -- Semelhante ao reverseNaive da aula TP2
reverseRight list = foldr (\x acc -> acc ++ [x]) [] list

-- 3.7.d

reverseLeft1 :: [a] -> [a] -- Semelhante ao reverseAccumulatorAux da aula TP2
reverseLeft1 list = foldl (\acc x -> [x] ++ acc) [] list

reverseLeft2 :: [a] -> [a] -- Append mais simplificado
reverseLeft2 list = foldl (\acc x -> x:acc) [] list

reverseLeft3 :: [a] -> [a] -- eta-reduction
reverseLeft3 list = foldl (\acc x -> x:acc) [] list

reverseLeft4 :: [a] -> [a] -- eta-reduction
reverseLeft4 list = foldl (\acc x -> (:) x acc) [] list

reverseLeft5 :: [a] -> [a] -- eta-reduction
reverseLeft5 list = foldl (\acc x -> flip (:) acc x) [] list

reverseLeft6 :: [a] -> [a] -- eta-reduction
reverseLeft6 = foldl (flip (:)) []

-- 3.3

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c] 
myZipWith function xs [] = []
myZipWith function [] ys = []
myZipWith function (x:xs) (y:ys) = (function x y) : myZipWith function xs ys

-- 3.4

myisort :: Ord a => [a] -> [a]
myisort list = foldr (\x acc -> insert x acc) [] list

-- 3.5.a

myMaximum :: Ord a => [a] -> a
myMaximum list = foldl1 (\acc x -> if x > acc then x else acc) list