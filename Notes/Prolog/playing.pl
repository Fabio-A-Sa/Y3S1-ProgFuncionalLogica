:-use_module(library(lists)).

connected(a, b).
connected(b, c).
connected(f, e).
connected(c, f).
connected(c, a).
connected(e, g).
connected(k, l).
connected(m, o).
connected(r, a).
connected(s, e).
connected(t, y).
connected(q, a).
connected(p, o).
connected(f, y).
connected(t, w).
connected(t, f).
connected(f, d).
connected(d, g).
connected(d, e).
connected(e, g).
connected(e, j).
connected(j, k).
connected(l, p).
connected(q, e).
connected(q, r).
connected(e, d).
connected(f, s).
connected(d, z).
connected(z, d).
connected(s, z).
connected(a, s).

% Verifica se há conexão entre um ponto e outro. Não verifica ciclos.

is_connected(Origem, Destino):-
    connected(Origem, Destino).
is_connected(Origem, Destino):-
    connected(Origem, Meio),
    is_connected(Meio, Destino).

% Verifica se há conexão entre um ponto e outro, evitando ciclos e mostrando o caminho percorrido.

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

% Encontra um ciclo existente no grafo

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

is_node(X):- connected(_, X).
is_node(X):- connected(X, _).

% Encontra todos os ciclos existente no grafo

all_cicles(Paths):-
    setof(Path, cicle(Path), Paths).

% Percorre o grafo de Origem até Destino fazendo pesquisa em largura

path_bfs(Origem, Destino):-
    construct_path_bfs([Origem], Destino, [], Path),
    write(Path).

construct_path_bfs([Destino|_], Destino, Visited, Path):-
    reverse([Destino|Visited], Path).
construct_path_bfs([Node|Nodes], Destino, Visited, Path):-
    findall(NextNode, (connected(Node, NextNode), \+member(NextNode, Visited), \+member(NextNode, [Node|Nodes])), DirectChildren),
    append(Nodes, DirectChildren, NewNodes),
    construct_path_bfs(NewNodes, Destino, [Node|Visited], Path).