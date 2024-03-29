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

father(X):- father(X, Y).   % X is a father
                            % if X is the father of some Y
```

### Operadores

- Negação: '\\+'
- Disjunção: ';'
- Conjunção: ','
- Igual: '='. Não faz computações, ou seja, X = 1+1 resultará em X = 1+1.
- Is: 'is'. Funciona com 'Variável is <Expressão Matemática>', atribui valor ao cálculo;
- '=:=', X = 40, 1 =:= X mod 2, serve para comparar expressões matemáticas 
- '==', serve para comparar valores do mesmo tipo. Não funciona como '2-1 == 1' ou 'X == 1' ou 'X == Y'.

- //, divisão inteira, operadores positivos e negativos dão o mesmo resultado;
- div, divisão fracionária e arredondada para baixo;
- rem, integer remainder, pode ser positiva ou negativa;
- mod, integer remainder, resultado positivo;

#### Documentação de código

```prolog
predicado(+number) % tem de estar instanciada, uma constante
predicado(-number) % não pode estar instanciada, uma variável
predicado(?number) % o argumento pode ser instanciado ou não
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