-- 2022/10/11

-- 4.1

data Arv a = Vazia | No a (Arv a) (Arv a)

sumArv :: (Num a) => Arv a -> a
sumArv Vazia = 0
sumArv No a l r = (sumArv l) + a + (sumArv r) 

