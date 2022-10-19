-- 2022/10/19

-- 1.1

testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c 
    | a + c > b = True
    | a + b > c = True
    | b + c > a = True
    | otherwise = False

-- 1.2

areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt (s*(s-a)*(s-b)*(s-c))
    where s = (a+b+c) / 2