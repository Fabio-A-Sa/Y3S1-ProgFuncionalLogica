% 2022/11/22

% Ficha 2

invert([], []).
invert([X|Xs], Rev):-
    invert(Xs, Rev1),
    append(Rev1, [X], Rev).

invert2(L, Rev):-
    invert2_aux(L, [], Rev).

invert2_aux([], Acc, Acc).
invert2_aux([X|Xs], Acc, Rev):-
    invert2_aux(Xs,[X, Acc], Rev).

list_member(Element, List).
    append(_, [Element, _], List).

list_nth(Index, List, Element):-
    append(Prefix, [Element,_], List),
    length(Prefix, N).

% Ficha 3