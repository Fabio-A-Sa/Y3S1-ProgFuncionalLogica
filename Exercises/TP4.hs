-- 2022/10/11

-- 4.1

data Arv a = Vazia | No a (Arv a) (Arv a) deriving Show

sumArv :: (Num a) => Arv a -> a
sumArv Vazia = 0
sumArv (No a l r) = (sumArv l) + a + (sumArv r) 

-- 4.2

mapArv :: (a -> b) -> Arv a -> Arv b
mapArv function Vazia = Vazia
mapArv function (No a l r) = No (function a) (mapArv function l) (mapArv function r)

