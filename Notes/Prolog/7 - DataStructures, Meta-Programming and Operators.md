# 7 - DataStructures, Meta-Programming and Operators

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