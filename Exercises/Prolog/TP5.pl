% 2022/12/06

% Exercício 1

%map(+Pred, +List1, ?List2)
map(Predicate, List, Result):-
    map_aux(Predicate, List, [], Result).

map_aux(_, [], Result, Result).
map_aux(Predicate, [Element|Rest], Accumulator, Result):-
    Operation =.. [Predicate, Element, R],
    Operation, 
    append(Accumulator, [R], Accumulator1),
    map_aux(Predicate, Rest, Accumulator1, Result).

double(X, Y):- Y is X * 2.

