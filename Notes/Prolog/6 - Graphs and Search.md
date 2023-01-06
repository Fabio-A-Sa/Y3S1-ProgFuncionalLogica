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

Para contornar a existência de loops, é necessário existir um acumulador (uma lista), que reuna todos os nós já visitados até encontrar o destino final:

```prolog
path_dfs(Origem, Destino):-
    construct_path_dfs(Origem, Destino, [Origem], Path),
    write(Path).

construct_path_dfs(Origem, Destino, Acc, Path):-
    connected(Origem, Destino),
    append(Acc, [Destino], Path).
construct_path_dfs(Origem, Destino, Acc, Path):-
    connected(Origem, Meio),
    \+member(Meio, Acc),
    append(Acc, [Meio], Acc1),
    construct_path_dfs(Meio, Destino, Acc1, Path).
```

## Breath-First Search (BFS)

Para buscas em largura, de modo a percorrer os nós mais próximos primeiro, usa-se esta técnica:

```prolog
path_bfs(Origem, Destino):-
    construct_path_bfs([Origem], Destino, [], Path),
    write(Path).

construct_path_bfs([Destino|_], Destino, Visited, Path):-
    reverse([Destino|Visited], Path).
construct_path_bfs([Node|Nodes], Destino, Visited, Path):-
    findall(NextNode, (connected(Node, NextNode), \+member(NextNode, Visited), \+member(NextNode, [Node|Nodes])), DirectChildren),
    append(Nodes, DirectChildren, NewNodes),
    construct_path_bfs(NewNodes, Destino, [Node|Visited], Path).
```

### Ciclos nos grafos

Podem ser determinados tanto com DFS como com BFS. A técnica é sempre tentar encontrar um caminho que contenha o nó inicial:

```prolog
cicle([Origem|SubPath]):-
    connected(Origem, Node),
    find_cicle(Origem, Node, [], SubPath).

find_cicle(Origem, Origem, Acc, Path):-
    append(Acc, [Origem], Path), !.
find_cicle(Origem, Destino, Acc, Path):-
    append(Acc, [Destino], Acc1),
    connected(Destino, Medio),
    \+member(Medio, Acc),
    find_cicle(Origem, Medio, Acc1, Path).
```