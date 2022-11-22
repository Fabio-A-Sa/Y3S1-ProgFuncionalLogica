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

course_classes(UC, Course):-
    findall(Dia/Hora-Tipo, class(UC, Tipo, Dia, Hora, _), L).

short_classes(L):-
    findall(UC-Dia/Hora, (class(UC, _, Dia, Hora, Dur), Dur < 2), L).

same_day(UC1, UC2):-
    findall(D, (class(UC1, _, D, _, _), class(UC2, _, D, _, _)), [_|_]).