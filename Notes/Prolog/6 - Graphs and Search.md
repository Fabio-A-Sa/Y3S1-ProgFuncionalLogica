# 6 - Graphs and Search

Os grafos podem ser representados por um conjunto de factos que funcionam como ligações diretas entre dois nós:

```prolog
connected(porto, lisbon).
connected(lisbon, madrid).
connected(lisbon, paris).
```

## Depth-First Search (DFS)

Para saber se existe uma ligação entre um nó e outro é simples e basta invocar o funcionamento de backtracking usando para isso uma pesquisa em profundidade:

```prolog
connects_dfs(S, F):- connected(S, F).
connects_dfs(S, F):-
    connected(S, N),
    connects_dfs(N, F).
```

Para contornar a existência de loops, é necessário existir um acumulador (uma lista), que reuna todos os 

## Breath-First Search (BFS)