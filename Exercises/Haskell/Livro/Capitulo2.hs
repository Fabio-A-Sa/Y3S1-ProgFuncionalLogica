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

-- FT-4

distance2 :: (Ord a, Floating a) => (a, a) -> (a, a) -> a 
distance2 (x1, y1) (x2, y2) = sqrt $ sum [(x1-x2)^2, (y1-y2)^2]

distanceInf :: (Ord a, Floating a) => (a, a) -> (a, a) -> a 
distanceInf (x1, y1) (x2, y2) = max (abs (x1-x2)) (abs (y1-y2))

-- FT-14

scalarProduct :: Num a => [a] -> [a] -> a 
scalarProduct vector1 vector2 = sum $ zipWith (*) vector1 vector2

-- FT-25

average :: Fractional a => [a] -> a 
average vector = sum vector / (fromIntegral (length vector))