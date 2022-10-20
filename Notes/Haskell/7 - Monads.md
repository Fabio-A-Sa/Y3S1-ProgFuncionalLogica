# 7 - Monads

## Expressions vs. Commands

As expressões retornam valores 

```python
2+3
2<3 and 4>1 
```

Os comandos não retornam valores mas alteram o estado de algumas variáveis

```python
x = 2
while (y < 2)
    x += 1
    y -= 2
print (2)
```

Em Haskell não existem comandos, apenas traduz os comandos em expressões.

```Haskell
(>>) :: IO() -> IO() -> IO() -- Prelude
(>>=) :: IO a -> (a -> IO b) -> IO b -- Bind operator
done :: IO() -- usada para funções recursivas IO()
return :: a -> IO a -- usada para funções recursivas IO type

putStr1 :: String -> IO()
putStr1 [] = done
putStr1 (x:xs) = putChar x >> putStr xs

putStr2 :: String -> IO()
putStr2 str = foldl (>>) (done . map putChar) str

getLine :: IO [Char]
getLine = getChar >>= \x -> if x /= "\n" then return []
                            else getLine >>= \xs -> return (x:xs)

putChar 'F' >> putChar 'C' -- "FC"
getChar "FEUP" >>= putChar x -- "F"
getChar "FEUP" >>= \x -> return x

x1 <- e1 -- e1 >>= \x1 ->
e3 -- e3 >>
```

## Using Monads

Using DO operator

```haskell
do { x'<-return x ; f x' } = do { f x }
do { x <- m; return x } = do { m }
```

### Propriedades das expressões

- Left-identity return a >>= f = f a
- Right-identity m >>= return = m
- Associativity (m >>= f) >>= g = m >>= (\x -> f x >>= g)

### Monads Types

- Maybe (Nothing, Just);
- Either (Left a, Right b), com Left a ser uma tag de erro e Right o valor correcto da operação;
- State (Result, State);

```haskell
instance Monad (State s) 
    where
        return a = State (\s -> (a, s))
        m >>= k = State (\s ->
        let (x, s') = run m s
        in run (k x) s')
```