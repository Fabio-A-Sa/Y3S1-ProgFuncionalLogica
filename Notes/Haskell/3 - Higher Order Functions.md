# 3 - Higher Order Functions

Uma função é de ordem superior se receber como argumento pelo menos uma função. São exemplos as funções `map`, `filter`, `takeWhile`, `dropWhile`, `any`, `all`, `foldr`, `foldl` e `composition`.

```Haskell
map (^2) [1,2,3,4] > [1,4,9,16]
filter (\n->n‘mod‘2==0) [1..10] > [2,4,6,8,10]
takeWhile isLetter "Hello, world!" > "Hello"
dropWhile isLetter "Hello, world!" > ", world!"
all (\n -> n‘mod‘2==0) [2,4,6,8] > True
any (\n -> n‘mod‘2/=0) [2,4,6,8] > False
foldr (+) 0 [1..3] > 6  
foldl (*) 1 [1..3] > 6  
par x = mod x 2 == 0
impar x = not . par x -- igual a not (par x)
```

## Listas infinitas

Em Haskell há possibilidade de criar listas infinitas sem comprometer a memória (*lazy evaluation*, só computa quando necessita dos valores). Há também funções do Prelúdio-padrão que produzem listas com esta característica:

```haskell
-- listas
natural_numbers = [1..]
pares = [0, 2..]
uns = 1 : uns
integers n = [n..]

-- funções
repeat x 10 > [x,x,x,x,x,x,x,x,x,x,x]
cycle [x] > [x,x,x,x,x,...]
iterate (^2) 4 > [4, 16, 16^2...]
take 10 (iterate (2*) 1) > [1,2,4,8,16,32,64,128,256,512]
```

### Exemplos

```haskell
preencher n text = take n (text ++ repeat ' ')
fibs = 0 : 1 : [a+b | (a,b)<-zip fibs (tail fibs)]
crivo (p:xs) = p : crivo [x | x<-xs, x‘mod‘p/=0]
```