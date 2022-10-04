-- 2022/10/04

-- 3.1

mapFilter :: (a -> b) -> (a -> Bool) -> [a] -> [b]
mapFilter f p l = map f (filter p l)

-- 3.2

dec2int :: Integral a => [a] -> a
dec2int list = foldl (\acc x -> acc*10 + x) 0 list 

