-- 2022/10/25

-- FT-1

myFst :: (a, b) -> a 
myFst (x, _) = x

-- FT-2

mySnd :: (a, b) -> b
mySnd (_, x) = x

-- FT-3

mySwap :: (a, b) -> (b, a)
mySwap (x, y) = (y,x)