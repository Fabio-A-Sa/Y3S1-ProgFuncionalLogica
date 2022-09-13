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

```Haskell
f g x equivale a f(g(x))
f (g x) (h x) equivale a f(g(x), h(x))
f x (y+1) equivale a f(x, y+1)
(+) x y equivale a x + y
(*) x 2 equivale a x * 2
x 'mod' y equivale a mod x y
f x 'div' n equivale a div (f x) n
```

## 1.2 - Funções padrão

