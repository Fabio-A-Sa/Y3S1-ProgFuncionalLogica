# 2  - Lists

As listas em Haskell são implementadas com uma linked-list [x:xs]. [1, 2, 3, 4] = 1:2:3:4:[], segundo a notação em extensão. Sequências aritméticas:

```Haskell
[1..10] > [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
[1, 3..10] > [1, 3, 5, 7, 9]
[10, 9..1] > [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
take 10 [1, 3..] > [1, 3, 5, 7, 9, 11, 13, 15, 17,, 19]
```

## 2.1 - Definições recursivas

Os casos de paragem devem ser declarados antes da expressão recursiva. Em haskell, usar recursão é a única forma de implementar ciclos. Alguns exemplos:

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
[] ++
#TODO + zip + ...

```

Implementações recursivas do Prelude:

```Haskell

init :: [a] -> [a]
init [] = error 'Empty list'
init [_] = []
init [x:xs] = x : init xs
```

## 2.2 - Notações em compreensão

```Haskell
squares :: Int -> [Int]
squares x = map (^2) [1..n]
squares x = [x * x | x <- [1..n]]

pairs :: Int -> Int -> [(Int, Int)]
pairs x y = [(a, b) | a <- [1..x], b <- [1..y]]
# length (pairs x y) = x * y

concat :: [[a]] -> [a]
concat lists = [valor | list <- lists, valor <- list]
```
