-- 2022/10/18

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

myPermutations :: [a] -> [[a]]
myPermutations [] = [[]]
myPermutations list = 

