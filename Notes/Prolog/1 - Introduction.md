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

- Negação: \\+
- Disjunção: ;
- Conjunção: ,

#### Documentation

```prolog
square(+number, -square) % calcula o quadrado de um valor dado e instanciado
parent(?parent, ?child) % o argumento pode ser instanciado ou não
```

