-- 2022/10/19

-- 1.1

testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c 
    | (a + c) > b = True
    | (a + b) > c = True
    | (b + c) > a = True
    | otherwise = False

-- 1.2

areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt (s*(s-a)*(s-b)*(s-c))
    where s = (a+b+c) / 2

-- 1.3

metades :: [a] -> ([a], [a])
metades list = (a, b)
        where middle = length list `div` 2
              a = take middle list 
              b = drop middle list

-- 1.4.a

mylast :: [a] -> a 
mylast list = head $ reverse list 

-- 1.4.b

myinit :: [a] -> [a]
myinit list = reverse $ tail $ reverse list 