% 2022/12/06






















































% Exercício 5 da ficha 5

% 5.a

:-op(600, xfx, from).
:-op(500, fx, fligh).
:-op(550, xfx, to).
:-op(500, xfx, at).
:-op(400, xfx, :).

% 5.b

:-op(400, fx, if).
:-op(500, xfx, then).
:-op(400, xfx, else).

if X then Y else _ :-
    call(X), !, call(Y).

if X then _ else Z :-
    \+call(X), call(Z).

% Exercício extra

% separate (+List, +Pred, -SortedList).
% SortedList - [Ys, ......, Ns].

separate(L, Pred, SortedList):-
    separate_aux(L, Pred, Ys, Ns),
    append(Ys, Ns, SortedList).

separate_aux([], _, [], []).
separate_aux([H|T], Pred, [H, Ys], Ns):-
    Goal =.. [Pred, H],
    call(Goal), !, 
    separate_aux(T, Pred, Ys, Ns).
separate_aux([H|T], Pred, Ys, [H,Ns]):-
    separate_aux(T, Pred, Ys, Ns).

even(X):- 0 =:= X mod 2.

% Exercício extra com otimização

separate2(L, Pred, SortedList):-
    separate2_aux(L, Pred, SortedList-Ns, Ns-[]),

separate2_aux([], _, Ys-Ys, Ns-Ns).
separate2_aux([H|T], Pred, [H|Ys]-TailYs, Ns-TailNs):-
    Goal =.. [Pred, H],
    call(Goal), !, 
    separate2_aux(T, Pred, Ys-TailYs, Ns-TailNs).
separate2_aux([H|T], Pred, Ys-TailYs, [H,Ns]-TailNs):-
    separate2_aux(T, Pred, Ys-TailYs, Ns-TailNs).

even(X):- 0 =:= X mod 2.

% Insert 

% insert(+Number, +Goal, +List, -FinalList).

insert(Number, 0, Tail, [Number|Tail]).

insert(Number, Index, [H|T], [H|FinalList]):-
    Index1 is Index - 1,
    insert(Number, Index1, T, FinalList).