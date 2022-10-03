# 3 - Higher Order Functions

Uma função é de ordem superior se receber como argumento pelo menos uma função. São exemplos as funções `map`, `filter`, `takeWhile`, `dropWhile`, `any`, `all`, `foldr` e `foldl`.

```Haskell
map (^2) [1,2,3,4] > [1,4,9,16]
filter (\n->n‘mod‘2==0) [1..10] > [2,4,6,8,10]
takeWhile isLetter "Hello, world!" > "Hello"
dropWhile isLetter "Hello, world!" > ", world!"
all (\n -> n‘mod‘2==0) [2,4,6,8] > True
any (\n -> n‘mod‘2/=0) [2,4,6,8] > False
```