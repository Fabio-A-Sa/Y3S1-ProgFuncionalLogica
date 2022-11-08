-- 2022/10/19

import Data.List

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

-- 1.15.a

mediana :: Ord a => a -> a -> a -> a 
mediana a b c = (sort [a, b, c]) !! 1

-- 1.15.b

mediana' :: (Num a, Ord a) => a -> a -> a -> a
mediana' a b c = (a+b+c) - min a (min b c) - max a (max b c)

-- 1.16

unidades :: [String]
unidades =
  [ "zero"
  , "um"
  , "dois"
  , "tres"
  , "quatro"
  , "cinco"
  , "seis"
  , "sete"
  , "oito"
  , "nove"
  ]

dez_a_dezanove :: [String]
dez_a_dezanove =
  [ "dez"
  , "onze"
  , "doze"
  , "treze"
  , "quatorze"
  , "quinze"
  , "dezasseis"
  , "dezassete"
  , "dezoito"
  , "dezanove"
  ]

dezenas :: [String]
dezenas =
  [ "vinte"
  , "trinta"
  , "quarenta"
  , "cinquenta"
  , "sessenta"
  , "setenta"
  , "oitenta"
  , "noventa"
  ]

converte2 :: Int -> String
converte2 n | n<100 = combina2 (divide2 n)

divide2 :: Int -> (Int, Int)
divide2 n = (n`div`10, n`mod`10)

combina2 :: (Int, Int) -> String
combina2 (0, u) = unidades !! u
combina2 (1, u) = dez_a_dezanove !! u
combina2 (d, 0) = dezenas !! (d-2)
combina2 (d, u) = dezenas !! (d-2) ++ " e " ++ unidades !! u

centenas :: [String]
centenas =
  [ "cento"
  , "duzentos"
  , "trezentos"
  , "quatrocentos"
  , "quinhentos"
  , "seiscentos"
  , "setecentos"
  , "oitocentos"
  , "novecentos"
  ]

converte3 :: Int -> String
converte3 n | n<1000 = combina3 (divide3 n)

divide3 :: Int -> (Int, Int)
divide3 n = (n`div`100, n`mod`100)

combina3 :: (Int, Int) -> String
combina3 (0, n) = converte2 n
combina3 (1, 0) = "cem"
combina3 (c, 0) = centenas !! (c-1)
combina3 (c, n) = centenas !! (c-1) ++ " e " ++ converte2 n

converte6 :: Int -> String
converte6 n | n<1000000 = combina6 (divide6 n)

divide6 n = (n `div` 1000, n `mod` 1000)

combina6 (0, n) = converte3 n
combina6 (1, 0) = "mil"
combina6 (1, n) = "mil" ++ ligar n ++ converte3 n
combina6 (m, 0) = converte3 m ++ " mil"
combina6 (m, n) = converte3 m ++ " mil" ++ ligar n ++ converte3 n

ligar :: Int -> String
ligar r
  | r < 100 || r `mod` 100 == 0 = " e "
  | otherwise                   = " "

converte :: Int -> String
converte = converte6