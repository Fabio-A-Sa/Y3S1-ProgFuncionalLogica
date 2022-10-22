-- 2022/10/24

-- 3.1

-- expression :: map f $ filter p xs 

-- 3.2

dec2int :: [Int] -> Int
dec2int list = foldl (\acc x -> acc*10+x) 0 list

-- 3.3

