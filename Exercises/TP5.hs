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