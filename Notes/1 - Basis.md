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

## 1.3 - Definição de funções e tipos

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
minuscula :: Char -> Bool
minuscula c = c>=’a’ && c<=’z’
```

## 1.4 - Currying

É preferível usar Currying do que tuplos como argumentos. De acordo com as convenções sintáticas que prescindem de parêntises o processamento dos tipos é efetuado da direita para a esquerda e a compilação/aplicação da esquerda para a direita. 

```Haskell
soma' :: (Int, Int) -> Int -- tuple based
soma' (x, y) = x + y

soma  :: Int -> Int -> Int -- currying
soma  x y = x + y
{-
    soma  :: Int -> (Int -> Int)
    (soma  x) y = x + y, retorna uma função f como resultado de (soma x) e depois computa (f y)
    function x y z = (((f x) y) z)
-}
```

## 1.5 - Funções polimórficas

Uma função diz-se polimórfica se admite um ou mais tipos como variáveis. 

```Haskell
length :: [a] -> Int
length [1, 2, 3, 5] > 4                         -- 'a' é do tipo Int
length "FeupLEIC" > 8                           -- 'a' é do tipo Char
length [("a", 1), ("b", 2), ("c", 3)] > 3       -- 'a' é do tipo (Char, Int)
```

No entanto há certas funções que não têm sentido ao serem aplicadas com determinados tipos, por exemplo a soma do conteúdo de uma lista de booleanos. Então não pode haver uma generalização da declaração para todos os tipos existentes, que resulta em erro (overloading). Uma solução é dar ao valor arbitrário 'a' um tipo genérico:

- Num (Int, Integer, Float, Double);
- Integral (Int, Integer);
- Fractional (Float, Double);
- Eq (tipos que admitem comparação);
- Ord (elementos que admitem uma ordenação);

Note-se que Integral e Fractional são subclasses de Num e Ord é uma subclasse de Eq. Para não ocorrer erros desnecessários, aconselha-se a declarar as funções com tipos menos genéricos possível, mas mantendo o polimorfismo quando necessário. Alguns exemplos:

```Haskell
-- Definições que constam no Prelude
sum :: Num a => [a] -> a
mod :: Integral a => a -> a -> a
(/) :: Fractional a => a -> a -> a
(==) :: Eq a => a -> a -> Bool
(<) :: Ord a => a -> a -> Bool
max :: Ord a => a -> a -> a

-- Exemplos concretos:
1/3 :: Float
(1 + 1.5 + 2) :: Float

-- Casting de variáveis
--  Não podia ser Num pois nem sempre o resultado da média é um valor inteiro
media :: Fractional a => [a] -> a
-- Em vez de escrever o tipo que queremos, colocamos o tipo retornado pela função a dar cast
media xs = sum xs / fromIntegral(length xs)
```

## 1.6 - Expressões condicionais

A alternativa 'else' é obrigatória e as condições podem ser imbricadas. Outra alternativa de notação é usar guardas, que são verificações que são testadas em ordem e retorna a primeira de condição verdadeira:

```Haskell
sinal x = if x > 0 then 1 else (if x == 0 then 0 else -1)
sinal     x | x > 0      = 1
            | x == 0     = 0
            | otherwise  = -1
```

## 1.7 - Definição de Padrões

```Haskell
-- Uma definição completa do Prelude
(&&) :: Bool -> Bool -> Bool
True && True   = True
True && False  = False
False && True  = False
False && False = False

-- Uma definição alternativa do AND, onde _ pode ser qualquer valor
(&&) :: Bool -> Bool -> Bool
False && _  = False
True && x   = x

-- Não se pode repetir variáveis nos padrões
_ && _ = False
x && x = x

-- Mas podemos usar guardas para impor a condição de igualdade
x && y | x == y  = x
_ && _           = False

-- Padrões sobre tuplos e listas
#TODO
```