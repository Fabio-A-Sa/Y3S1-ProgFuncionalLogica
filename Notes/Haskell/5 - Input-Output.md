# Input and Output

Para podermos ter programas interativos, ou seja, sem funções puras (que recebem parâmetros sem side-efects).

## Ações básicas

Usando o novo tipo `IO`:

```haskell
getChar :: IO Char
putChar :: Char -> IO ()
return :: a -> IO a
```

## Ações encadeadas

Todas as ações devem estar alinhadas à mesma coluna.

```haskell
action = do x <- getChar
            putChar x
            putChar x

putStr :: String -> IO ()
putStr [] = return ()
putStr (x:xs) = do putChar x
                   putStr xs

getLine :: IO String
getLine = do x <- getChar
             if x==’\n’ then return []
             else
             do xs <- getLine
                return (x:xs)
```