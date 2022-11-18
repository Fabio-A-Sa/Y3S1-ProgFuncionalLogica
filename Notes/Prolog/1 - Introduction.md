# Introduction to Prolog

Prolog é uma linguagem de programação declarativa, tal como SQL. O mecanismo de execução é sempre de cima para baixo, da esquerda para a direita e com backtracking.

#### Vantagens

- Rápidos protótipos;
- É necessário pouco código;
- É flexível e intuitiva;

## Termos

Tudo em Prolog são termos. Podem ser:

- `Constants`: numbers (integers, floats), atoms (strings com plicas, antonio, zero);
- `Variables`: começadas com letra minúscula, como antonio_silva, ou underscore _. As variáveis são sempre locais;
- `Compound/structured terms`: suc(0), parent(person1, person2);

### Factos

```prolog
female(poppy).
male(pameron).
parent(grace,phil).
```

### Regras

```prolog
is_married(X, Y, CurrentYear):-
    married(X, Y, Year1),
    Year >= Year1,
    \+divorce(X, Y, Year2),
    Year < Year2.
```

### Operadores

- Negação: '\\+'
- Disjunção: ';'
- Conjunção: ','
- Igual: '='. Não faz computações, ou seja, X = 1+1 resultará em X = 1+1.
- Is: 'is'. Funciona com 'Variável is <Expressão Matemática>', atribui valor ao cálculo;
- '=:=', X = 40, 1 =:= X mod 2, serve para comparar expressões matemáticas 
- '==', serve para comparar valores do mesmo tipo. Não funciona como '2-1 == 1' ou 'X == 1' ou 'X == Y'.

#### Documentação de código

```prolog
predicado(+number) % tem de estar instanciada, uma constante
predicado(-number) % não pode estar instanciada, uma variável
predicado(?number) % o argumento pode ser instanciado ou não
```

### Recursão

```prolog
% Recursão sem preocupação com eficiência
sumN(0, 0).
sumN(N, Sum) :-
    N > 0,
    N1 is N - 1,
    sumN(N1, Sum1),
    Sum is Sum1 + N.

% Recursão eficiente: tail recursion, em que é necessário um acumulador

sumN(N, Sum):-
    sumN(N, Sum, 0).
sumN(0, Sum, Sum).
sumN(N, Sum, Acc):-
    N > 0,
    N1 is N - 1,
    Acc1 = Acc + N.
    sumN(N1, Sum, Acc1).
```

## Input Output

### Input

```prolog
read(-X)        % lê do stdin. Temos de colocar ponto (.) no final
get_char(-C)    % lê apenas um caracter do stdin
get_code(-C)    % lê apenas um caracter do stdin, mas coloca-o como código ASCII
```

### Output

```prolog
write(+X)                   % coloca valores no stdout
put_char(+C)                % coloca apenas um caracter C no stdout
put_code(+C)                % coloca um caracter dado pelo código ASCII C no stdout
format(+Pattern, +ArgList)  % parecido com o printf em C
```

## Lists

```prolog
append(L1, L2, L)           % Faz concatenação de duas listas, colocando o resultado no terceiro argumento. O(L1).
member(X, L)                % Verifica se X está presente na lista L
length(?L, ?N)              % O comprimento da lista. Pode ser usada para gerar números de 0 até infinito, usando length(_, N).
sort(+L, ?Ordered)          % Este predicado primeiro remove os duplicados de uma lista

:- use_module(library(list))

nth0(?N, ?L, ?X)            % Coloca em X o valor de L na posição X
select()
reverse
```