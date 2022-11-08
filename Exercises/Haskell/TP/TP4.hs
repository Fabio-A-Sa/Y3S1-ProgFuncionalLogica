-- 2022/10/11

-- 4.1

data Arv a = Vazia | No a (Arv a) (Arv a) deriving Show

sumArv :: (Num a) => Arv a -> a
sumArv Vazia = 0
sumArv (No a l r) = (sumArv l) + a + (sumArv r) 

-- 4.4

mapArv :: (a -> b) -> Arv a -> Arv b
mapArv function Vazia = Vazia
mapArv function (No a l r) = No (function a) (mapArv function l) (mapArv function r)

-- Infinit lists

calcPi1 :: (Floating b, Enum b) => Int -> Int -> b 
calcPi1 1 n = sum [fromIntegral(4*(-1)^i) / fromIntegral(1+2*i) | i <- [0..n]]

calcPi2 2 n = sum $ take n $ zipWith (/) (cycle [4, -4]) [1 + 2*i | i <- [0 ..]]

calcPi2 :: (Floating b, Enum b) => Int -> Int -> b 
calcPi2 1 n = 3 + sum [fromIntegral(4*(-1)^i) / fromIntegral(product [(2*(i+1)) .. (2*(i+1)+2)]) | i <- [0..n-1]]