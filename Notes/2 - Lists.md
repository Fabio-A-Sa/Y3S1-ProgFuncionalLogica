# 2  - Lists

As listas em Haskell são implementadas com uma linked-list [x:xs]. [1, 2, 3, 4] = 1:2:3:4:[], segundo a notação em extensão. Sequências aritméticas:

```Haskell
[1..10] > [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
[1, 3..10] > [1, 3, 5, 7, 9]
[10, 9..1] > [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
take 10 [1, 3..] > [1, 3, 5, 7, 9, 11, 13, 15, 17,, 19]
```

## 2.1 - Definições recursivas

Os casos de paragem devem ser declarados antes da expressão recursiva. Em haskell, usar recursão é a única forma de implementar ciclos. 

```Haskell
factorial :: Int -> Int
factorial 0 = 1
factorial number = number * factorial (number - 1)

product :: [Int] -> Int
product [] = 1
product [x:xs] = x * product xs
```



