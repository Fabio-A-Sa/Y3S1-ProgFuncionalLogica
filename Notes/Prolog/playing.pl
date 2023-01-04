connected(a, b).
connected(b, c).
connected(f, e).
connected(c, f).
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