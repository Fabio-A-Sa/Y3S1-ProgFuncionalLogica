# 5 - Database modification and Memoization

## Database modification

Essencialmente para aumento da eficiência e *debug*:

```prolog
:- dynamic [predicados/N] -> para que os predicados assinalados tenham acesso à memória dinâmica

asserta/1 -> coloca o resultado na base de dados interna, no início
assertz/1 -> coloca o resultado na base de dados interna, no fim

retract/1 -> remove o resultado da base de dados interna
retractall/1 -> remove todos os resultados da base de dados interna
retractall(parent(homer, _)) -> remove todos os predicados que contêm o "homer" como pai

listing/0 -> lista todas as clauses do programa
listing/1 -> lista todas as clauses do predicado dado no argumento (parent/2, por exemplo)

abolish/1 -> remove todas as clauses do programa que tenham aquele predicado (parent/2, por exemplo)
```

## Memoization

### Método recursivo

```prolog
fib(0, 0).
fib(1, 1).
fib(N, F):-
    N > 1,
    N2 is N - 2,
    N1 is N - 1,
    fib(N2, F2), fib(N1, F1),
    F is F1 + F2.
```

### Método com memorização dos predicados calculados

```prolog
fib(0, 0).
fib(1, 1).
fib(N, F):-
    N > 1,
    N2 is N - 2,
    N1 is N - 1,
    fib(N2, F2), fib(N1, F1),
    F is F1 + F2,
    asserta((fib(N, F):- !)).
```

## Fail Driven Loops

São úteis para enumerar todos os predicados da base de factos:

```prolog
%person(-X)
person(X):-
    male(X) ; female(X).

%imprime_pessoas/0
imprime_pessoas:-
    person(X),
    write(X), nl,
    fail.
imprime_pessoas.
```