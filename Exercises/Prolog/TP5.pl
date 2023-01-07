% 2022/12/06

% Exercício 1

% 1.a

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

% 1.b

%fold(+Pred, +StartValue, +List, ?FinalValue)
fold(_, Value, [], Value).
fold(Pred, StartValue, [Element|Rest], FinalValue):-
    Predicate =.. [Pred, StartValue, Element, Result],
    Predicate,
    fold(Pred, Result, Rest, FinalValue).

sum(A, B, R):- R is A + B.

% 1.c

%separate(+List, +Pred, -Yes, -No)
separate(List, Pred, Yes, No):-
    separate_aux(List, Pred, Yes, [], No, []).

separate_aux([], _, Yes, Yes, No, No).
separate_aux([Element|Rest], Pred, Yes, AccYes, No, AccNo):-
    Condition =.. [Pred, Element],
    Condition, !,
    append(AccYes, [Element], NewAccYes),
    separate_aux(Rest, Pred, Yes, NewAccYes, No, AccNo).
separate_aux([Element|Rest], Pred, Yes, AccYes, No, AccNo):-
    append(AccNo, [Element], NewAccNo),
    separate_aux(Rest, Pred, Yes, AccYes, No, NewAccNo).

even(X):- 0 =:= X mod 2.

% 1.d

%ask_execute/0
ask_execute:-
    read(Operation),
    call(Operation).

% Exercício 2

% 2.a.1

%my_arg(+Index, +Functor, -Arg)
my_arg(Index, Functor, Arg):-
    Functor =.. List,
    length(List, Len),
    Len >= Index,
    get_index(Index, List, Arg).

get_index(0, [Arg|_], Arg).
get_index(Index, [_|Rest], Arg):-
    NextIndex is Index - 1,
    get_index(NextIndex, Rest, Arg).

% 2.a.2

%my_functor(+Predicate, -Name, -Arity)
my_functor(Predicate, Name, Arity):-
    Predicate =.. [Name|Args],
    length(Args, Arity).

% 2.b

%my_univ(+Predicate, -List)
my_univ(Predicate, List):-
    my_functor(Predicate, Name, Arity),
    fill_args(Predicate, 1,  Arity, [Name], List).

fill_args(_, Index, Arity, List, List):-
    Index > Arity, !.
fill_args(Predicate, Index, Arity, Acc, List):-
    my_arg(Index, Predicate, Arg),
    append(Acc, [Arg], Acc1),
    NextIndex is Index + 1,
    fill_args(Predicate, NextIndex, Arity, Acc1, List).

% 2.c

:-op(400, xfx, my_univ).

% Exercício 3 no papel

% Exercício 4 - pode ser verificado usando o predicado write_canonical(+Expression)

:-op(550, xfx, de).
:-op(500, fx, aula).
:-op(550, xfy, pelas).
:-op(550, xfx, e).
:-op(600, xfx, as).

% 4.a
% as(de(aula(t),pfl),pelas(segundas,11))

% 4.b
% as(de(aula(tp),pfl),pelas(tercas,e(10,30)))

% 4.c
% as(e(aula(11),aula(12)),pelas(4,pelas(cinco,pelas(6,sete))))

% Exercício 5

% 5.a

% Uma possível árvore seria a seguinte:
% to(from(flight(tp1949), porto), at(lisbon, :(16, 15)))

:-op(500,xfx,to).
:-op(400,xfx,from).
:-op(300,fx,flight).
:-op(400,xfx,at).
:-op(300,xfx,:).

% 5.b

% Uma possível árvore seria a seguinte:
% then(if(X), else(Y, Z))

:-op(500, xfx, then).
:-op(400, fy, if).
:-op(400, xfx, else).

if X then Y else _:-
    X,
    Y.
if _ then _ else Z:-
    Z.