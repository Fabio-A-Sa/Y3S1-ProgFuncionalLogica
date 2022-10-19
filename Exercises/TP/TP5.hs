-- 2022/10/18

import Data.List (delete)

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

-- L1 39

permIO :: IO ()
permIO = do
    putStrLn "Input max Integers: "
    input <- getLine
    let num = read input :: Int
    if (num >= 1) then
        putStrLn $ show $ myPermutations [1..num]
    else do 
        putStrLn "Input must be > 0"

myPermutations :: (Eq a) => [a] -> [[a]]
myPermutations [] = [[]]
myPermutations list = [(i:j) | i <- list, j <- (myPermutations $ delete i list)]

myScanlRec :: (a -> a -> a) -> a -> [a] -> [a]
myScanlRec function acc list = [acc] ++ myScanlAux function acc list

myScanlAux :: (a -> a -> a) -> a -> [a] -> [a]
myScanlAux _ _ [] = []
myScanlAux function acc (x:xs) = (new) : myScanlAux function new xs
    where new = function acc x

myScanlFold :: (a -> a -> a) -> a -> [a] -> [a]
myScanlFold function n list = foldl (\acc x -> acc ++ [function (head $ reverse acc) x]) [n] list

{--

"abc"

a ++ perm "bc"
b ++ perm "ac"
c ++ perm "ab"

"bc" 

b ++ perm "c"
c ++ perm "b "

--}
