-- 2022/10/25

-- IN-10

testpH :: (Ord a, Floating a) => a -> String
testpH concentration 
    | ph == 7 = "Neutral"
    | ph < 7 = "Acid"
    | otherwise = "Basic"
    where ph = -logBase 10 concentration   