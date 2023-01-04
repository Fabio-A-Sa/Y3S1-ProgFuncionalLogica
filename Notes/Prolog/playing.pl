connected(porto, lisbon).
connected(lisbon, madrid).
connected(lisbon, paris).
connected(lisbon, porto).
connected(madrid, paris).
connected(madrid, lisbon).
connected(paris, madrid).
connected(paris, lisbon).

% Verifica se há conexão entre um ponto e outro. Não verifica ciclos.

is_connected(Origem, Destino):-
    connected(Origem, Destino).
is_connected(Origem, Destino):-
    connected(Origem, Meio),
    is_connected(Meio, Destino).

% Verifica se há conexão entre um ponto e outro, evitando ciclos e mostrando o caminho percorrido.

path(Origem, Destino):-
    construct_path(Origem, Destino, [Origem], Path),
    write(Path).

construct_path(Origem, Destino, Acc, Path):-
    connected(Origem, Destino),
    append(Acc, [Destino], Path).
construct_path(Origem, Destino, Acc, Path):-
    connected(Origem, Meio),
    \+member(Meio, Acc),
    append(Acc, [Meio], Acc1),
    construct_path(Meio, Destino, Acc1, Path).