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

-- 1.5.a

binom :: Integer -> Integer -> Integer
binom n k = div (product [1..n]) ((product [1..k]) * (product [1..(n-k)]))

-- 1.5.b

binom' :: Integer -> Integer -> Integer
binom' n k 
    | k < (n-k) = product [(n-k+1)..n] `div` (product [1..k])
    | otherwise = product [(k+1)..n]  `div` (product [1..(n-k)])

-- 1.6

raizes :: Float -> Float -> Float -> (Float, Float)
raizes a b c = (((-b) + delta) / (2*a),((-b) - delta) / (2*a))
    where delta = sqrt (b*b - 4*a*c)

-- 1.7

-- [Char]
-- (Char, Char, Char)
-- [(Bool, Char)]
-- ([Bool], [Char])
-- [([a] -> [a])]
-- [(a -> a)]

-- 1.8

-- segundo :: [a] -> a
-- trocar :: (a, b) -> (b, a)
-- par :: a -> b -> (a, b)
-- dobro :: Num a => a -> a
-- metade :: Fractional -> Fractional
-- minuscula :: Char -> Bool
-- intervalo -> Ord a => a -> a -> a -> Bool
-- palindromo :: Eq a => [a] -> Bool
-- twice :: (a -> a) -> a -> a

-- 1.9

classifica :: Int -> String
classifica n 
    | n < 0 || n > 20 = "Erro"
    | n <= 9 = "Reprovado"
    | n >= 10 && n <=12 = "Suficiente"
    | n >= 13 && n <=15 = "Bom"
    | n >= 16 && n <= 18 = "Muito bom"
    | n >= 20 = "Muito bom com distinção"

-- 1.10

imc :: Float -> Float -> String
imc peso altura
    | n < 18.5 = "Baixo peso"
    | n >= 18.5 && n <25 = "Peso normal"
    | n >= 25 && n < 30 = "Excesso de peso"
    | n >= 30 = "Obesidade"
    where n = peso / (altura * altura)

-- 1.11.a

max3 :: Ord a => a -> a -> a -> a
max3 x y z = if x>=y && x >=z then x
             else if y >= x && y >= z then y
             else  z

min3 :: Ord a => a -> a -> a -> a
min3 x y z = if x<=y && x <= z then x 
             else if y <= x && y <= z then y
             else z

-- 1.11.b 

max3' :: Ord a => a -> a -> a -> a
max3' x y z = max2' x (max2' y z)
                where max2' c d 
                        | c >= d = c 
                        | otherwise = d 

             
min3' :: Ord a => a -> a -> a -> a
min3' x y z = min2' x (min2' y z)
                where min2' c d 
                        | c >= d = d 
                        | otherwise = c 

-- 1.12

xor :: Bool -> Bool -> Bool
xor a b 
    | a == False && b == True = True
    | a == True && b == False = True
    | a == False && b == False = False
    | a == True && b == True = False

-- 1.13

safetail :: [a] -> [a]
safetail [] = []
safetail list = tail list

safetail' :: [a] -> [a]
safetail' list = if length list == 0 then [] else tail list

safetail'' :: [a] -> [a]
safetail'' list 
    | length list == 0 = []
    | otherwise = tail list

-- 1.14

curta :: [a] -> Bool
curta list = length list < 3 

curta' :: [a] -> Bool
curta' [] = True 
curta' [x] = True
curta' (_:_) = True
curta' (_:_:_) = True
curta' list = False