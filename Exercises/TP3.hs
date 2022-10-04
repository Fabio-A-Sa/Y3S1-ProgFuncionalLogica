-- 2022/10/04

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

