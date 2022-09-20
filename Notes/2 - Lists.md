# 2  - Lists

## 2.1 - Introdução

As listas em Haskell são implementadas com uma linked-list [x:xs]. [1, 2, 3, 4] = 1:2:3:4:[], segundo a notação em extensão. Sequências aritméticas:

```Haskell
[1..10] > [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
[1, 3..10] > [1, 3, 5, 7, 9]
[10, 9..1] > [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
take 10 [1, 3..] > [1, 3, 5, 7, 9, 11, 13, 15, 17,, 19]
```

## 2.2 - Definições recursivas

Os casos de paragem devem ser declarados antes da expressão recursiva. Em haskell, usar recursão é a única forma de implementar ciclos, uma vez que não se pode modificar o valor de variáveis em memória. Há também admissão de recursão mútua. Alguns exemplos de implementações recursivas de algumas funções do Prelude:

```Haskell
factorial :: Int -> Int
factorial 0 = 1
factorial number = number * factorial (number - 1)

product :: [Int] -> Int
product [] = 1
product [x:xs] = x * product xs

length :: [a] -> Int
length [] = 0
length [x:xs] = 1 + length xs

reverse :: [a] -> [a]
reverse [] = []
reverse [x:xs] = reverse xs ++ x

(++) :: [a] -> [a] -> [a]
[] ++ ys = ys
(x:xs) ++ ys = x : (xs ++ ys)

zip :: [a] -> [b] -> [(a, b)]
zip [] _ = []
zip _ [] = []
zip (x:xs) (y:ys) = (x,y) : zip xs ys

drop :: Int -> [a] -> [a]
drop 0 xs = xs
drop n [] = []
drop n (x:xs) | n > 0 = drop (n-1) xs

init :: [a] -> [a]
init [] = error 'Empty list'
init [_] = []
init [x:xs] = x : init xs
```

## 2.3 - Notações em compreensão

Todas as funções usando compreensão podem ser adaptadas com recursão, mas nem todas as recursões têm uma tradução em compreensões de listas. As definições recursivas são mais gerais mas mais complexas de entender.

```Haskell
squares :: Int -> [Int]
squares x = map (^2) [1..n]
squares x = [x * x | x <- [1..n]]

pairs :: Int -> Int -> [(Int, Int)]
pairs x y = [(a, b) | a <- [1..x], b <- [1..y]]
# length (pairs x y) = x * y

concat :: [[a]] -> [a]
concat lists = [valor | list <- lists, valor <- list]

pares :: Int -> [Int]
pares n = [x | x <- [1..n] , x `mod` 2 == 0]

primes :: Int -> [Int]
primes n = [x | x <- [1..n], n `mod` x == 0]
isPrime :: Int -> Bool
isPrime n = primes n == [1, n]
```

## 2.4 - Strings

Para processar strings (lista de caracteres), usar o módulo *Data.Char*

```Haskell
import Data.Char
toUpper
toLower
isLower
isUpper
countLetters
(...) #TODO
stringToUpper str = [toUpper x | x <- str]
stringToLower str = [toLower x | x <- str]
```
