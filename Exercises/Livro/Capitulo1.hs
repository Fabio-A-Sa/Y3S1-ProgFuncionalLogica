-- 2022/10/25

-- IN-10

testpH :: (Ord a, Floating a) => a -> String
testpH concentration 
    | ph == 7 = "Neutral"
    | ph < 7 = "Acid"
    | otherwise = "Basic"
    where ph = -logBase 10 concentration   

-- IN-16

mPower :: (Fractional a, Integral t) => a -> t -> a 
mPower _ 0 = 1
mPower x n = x * mPower x (n-1)

-- IN-17

fib :: (Num a, Ord a, Num p) => a -> p
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

-- IN-18

ack :: (Num a, Ord a) => a -> a -> a
ack 0 n = n + 1
ack m n 
    | n == 0 && m > 0 = ack (m-1) 1
    | otherwise = ack (m-1) (ack m (n-1))