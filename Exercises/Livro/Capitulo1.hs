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