# 7 - DataStructures, Meta-Programming and Operators

## 7.1 - DataStructures

Prolog não explicita tipos definidos, mas estes podem ser usando as definições de predicados e factos. Por exemplo as árvores binárias:

```prolog
node(Value, Left, Right).

binary_tree(null).
binary_tree( node(Value, Left, Right) ):-
    binary_tree(Left),
    binary_tree(Right).
```

A partir desta estrutura de dados é possível:

- Procurar um valor na árvore;
- Listar todos os elementos;
- Verificar se é uma árvore binária de pesquisa;
- Inserir um elemento em ordem na árvore;
- Determinar a altura de uma árvore;
- Verificar se é uma árvore balanceada;

## 7.2 - Difference List

Para aumentar a eficiência da manipulação de listas (por exemplo o append/3), é utilizado um apontador do final do primeiro argumento do predicado:

```prolog
append_dl(X\Y, Y\W, X\W).
append_dl( [a, b, c | Y ]\Y, [d, e, f | W]\W, A).

% Y=[d,e,f|W]
% A=[a,b,c,d,e,f|W]\W
```

## 7.3 - Metaprogramming Operators

Essencialmente operadores de *type checking*, assim é possível criar definições de predicados para todos os tipos instanciados e não instanciados:

```prolog
sum(A, B, S):- number(A), number(B), !, S is A + B.
sum(A, B, S):- number(A), number(S), !, B is S – A.
sum(A, B, S):- number(B), number(S), !, A is S – B.
```

O operador `=..` retorna um predicado com nome e argumentos ou o contrário:

```prolog
Predicate =.. [sum, A, B, C] % sum(A, B, B)
[sum, A, B, C] =.. Predicate % sum(A, B, B)
```

O predicado `functor/3` constroi ou retira dados de nome do functor e a aridade deste:

```prolog
functor(parent(homer, bart), Name, Arity).  % Name = homer , Arity = 2
functor(Term, parent, 2)                    % Term = parent(_A, _B)
```

O predicado `call/1` executa o argumento:

```prolog
B = parent(homer, bart), call(B). % yes
```

Exemplo da utilização de metaprogramming para implementar um predicado de ordem superior:

```prolog
map([], _).
map([Arg|Resto], Predicate):-
    G =.. [Predicate, Arg],
    G,
    map(Resto, Predicate).

map([1, 2, a, b], write). % 12ab
```

