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

## 1.3 - Definir funções

