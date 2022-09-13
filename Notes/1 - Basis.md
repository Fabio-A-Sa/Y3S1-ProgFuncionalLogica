# 1 - Haskell Introduction

Haskell é uma linguagem funcional criada em 1987, ao contrário de outras como C ou Java que são linguagens imperativas, ou seja, são sequências de comandos que manipulam variáveis em memória. É uma programação com base na composição de funções. O compilador mais recomendado é o GHC, Glasgow Haskell Compiler. <br>
Outros exemplos de linguagens de programação funcionais: Scheme, ML, OCaml, F#, Scala.

```Haskell
-- Example
myFunction = print (sum (map (^2) [1..10]))
```

### Vantagens da programação funcional:

- Ter programas mais concisos e próximos de uma expecificação matemática;
- Tem mais modularidade, é necessário decompor o problema em subproblemas reutilizáveis;
- É possível demonstrar a correção do algoritmo com base em provas matemáticas;
- É mais fácil fazer testes automáticos;
- A ordem de execução não afeta os resultados. Vários processos podem executar partes do código e não comprometer o output uma vez que não há manipulação de variáveis em memória;

### Desvantagens da programação funcional:

- Os compiladores são mais complexos, uma vez que há omissão dos tipos de variáveis;
- Precisam de mais tempo/espaço e esses critérios são difíceis de estimar;
- Há algoritmos mais eficientes quando implementados de forma imperativa;

## 1.1 - Convenções sintáticas

Um operador pode ser usado como uma função e uma função pode ser usada como um operador:

<div align="center">

|     f g x     |    f(g(x))    |
|:-------------:|:-------------:|
| f (g x) (h x) | f(g(x), h(x)) |
| f x (y+1)     | f(x, y+1)     |
| (+) x y       | x + y         |
| (*)           | x * y         |
| x 'mod' y     | mod x y       |
| f x 'div' n   | div (f x) n   |

</div>

## 1.2 - Funções padrão

No módulo *Prelude* já há bastantes funções predefinidas, como os operadores e funções aritméticas e as funções genéricas entre listas. Pode e deve ser usado em qualquer programa haskell.

```Haskell
div 6 3 > 2                                 -- quociente da divisão inteira
mod 6 3 > 0                                 -- resto da divisão inteira
sqrt 9 > 3                                  -- raiz quadrada
head [1, 2, 3, 4] > 1                       -- obter o primeiro elemento
tail [1, 2, 3, 4] > [2, 3, 4]               -- remover o primeiro elemento
length [1, 2, 3] > 3                        -- tamanho da lista
take 3 [1, 2, 3, 4, 5] > [1, 2, 3]          -- obter os X primeiros elementos
drop 2 [1, 2, 3, 4] > [3, 4]                -- remover os X primeiros elementos
[1, 2, 3] ++ [4, 3] > [1, 2, 3, 4, 3]       -- concatenar listas ou strings
reverse [3, 4, 6] > [6, 5, 4]               -- inverter a ordem da lista
[1, 2, 3, 4, 5] !! 3 > 4                    -- escolhe o elemento de index 3 da lista
sum [1, 2, 3] > 6                           -- soma todos os elementos da lista
product [1, 2, 3, 4]                        -- multiplica todos os elementos da lista
```

## 1.3 - Definição de funções

O compilador infere os tipos omitidos mas é sempre boa norma por motivos sintáticos declará-los antes de cada função. Os erros de tipo são assinalados em runtime e antes da execução. <br>
Tipos em Haskell:

- Bool (True, False);
- Char;
- String;
- Int (inteiros de precisão fixa, 64 bits);
- Integers (inteiros de precisão arbitrária, é até existir memória);
- Float (vírgula flutuante de precisão simples, 32 bits);
- Double (vírgula flutuante de precisão dupla, 64 bits);

**Notas relevantes**:

- [x] Listas de tamanhos diferentes podem ter o mesmo tipo, mas tuplos de tamanhos diferentes têm sempre tipos diferentes;
- [x] A lista vazia [T] admite qualquer tipo, enquanto o tuplo vazio () apenas tem o tipo unitário ();
- [x] Não existem tuplos com apenas um elemento;

Alguns exemplos de definições:

```Haskell
-- Lists
[False, True, False] :: [Bool]
['f', 'E', 'u', 'P'] :: [Char] ou String 

-- Tuples
(3.14, 'P') :: [Double, Char]
(False,’b’,True) :: (Bool,Char,Bool)

-- Casos mistos
[[’a’], [’b’,’c’]] :: [[Char]]
(1,(’a’,2)) :: (Int,(Char,Int))
(1, [’a’,’b’]) :: (Int,[Char])

-- Funções
not :: Bool -> Bool
isDigit :: Char -> Bool
soma :: (Int, Int) -> Int ou então soma :: Int -> Int -> Int
contar :: Int -> [Int], com contar n = [1..n]
```

## 1.4 - Currying

