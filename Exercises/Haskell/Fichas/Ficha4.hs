-- 2022/10/24

data Arv a = Vazia | No a (Arv a) (Arv a) deriving (Show)

-- 4.1

sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No n left right) = n + sumArv left + sumArv right

-- 4.2

listar :: Arv a -> [a]
listar Vazia = []
listar (No n left right) = listar right ++ [n] ++ listar left

-- 4.3

nivel :: Int -> Arv a -> [a]
nivel _ Vazia = []
nivel 0 (No x _ _ ) = [x]
nivel n (No _ left right) = nivel (n-1) left ++ nivel (n-1) right

-- 4.4

mapArv :: (a -> b) -> Arv a -> Arv b
mapArv _ Vazia = Vazia
mapArv f (No x left right) = No (f x) (mapArv f left) (mapArv f right)

-- 4.5.a

construir :: Ord a => [a] -> Arv a
construir [] = Vazia
construir [x] = No x Vazia Vazia
construir list = No middle (construir left) (construir right)
    where 
        index = length list `div` 2
        middle = list !! index
        left = take index list
        right = drop (index+1) list

-- 4.5.b

inserir :: Ord a =>  a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y left right) 
    | x == y = No y left right
    | x < y = No y (inserir x left) right
    | otherwise = No y left (inserir x right)

construirLinear :: Ord a => [a] -> Arv a
construirLinear = foldr inserir Vazia

altura :: Arv a -> Int
altura Vazia = 0
altura (No _ Vazia Vazia) = 0
altura (No _ left right) = 1 + max(altura left) (altura right)

testHeight :: ([Int] -> Arv Int) -> [Int] -> [Int]
testHeight constructTree xs = [(altura . constructTree)[1..x] | x <-xs] 

-- 4.6.a

maisDir :: Arv a -> a
maisDir Vazia = error "Empty Tree"
maisDir (No x _ Vazia) = x
maisDir (No _ _ right) = maisDir right

-- 4.6.b

remover :: Ord a => a -> Arv a -> Arv a
remover _ Vazia = Vazia
remover x (No y left right) 
    | x < y = No y (remover x left) right
    | x > y = No y left (remover x right)
    | otherwise = removerNo (No y left right)

removerNo :: Ord a=> Arv a  -> Arv a
removerNo Vazia = error "Empty Tree"
removerNo (No _ Vazia right) = right
removerNo (No _  left Vazia) = left
removerNo (No _  left right) = No n (remover n left) right
    where n = maisDir left

-- 4.7

invertInput :: IO ()
invertInput = do 
    str <- getLine
    putStrLn $ reverse str

invertInput' :: IO ()
invertInput' = do 
    str <- getLine
    if (null str) then return ()
    else do
        putStrLn $ reverse str
        invertInput'

-- 4.9

elefantes :: Int -> IO ()
elefantes n = elefantesAux 2 n 

elefantesAux :: Int -> Int -> IO ()
elefantesAux i n
    | i < n = do
        putStrLn $ "Se " ++ (show i) ++ " elefantes incomodam muita gente,"
        putStrLn $ (show $ i+1) ++ " elefantes incomodam muito mais"
        elefantesAux (i+1) n
    | otherwise = do
        return ()