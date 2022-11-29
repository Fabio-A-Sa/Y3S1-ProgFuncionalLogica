% 2022/11/29

% same_day(+Class1, +Class2).

same_day(UC1, UC2):-
    findall(D, (class(UC1,_,D,_,_),class(UC2,_,D,_,_)),[_|_]).

same_day2(UC1, UC2):-
    bagof(D, (CTF1, CT2, T1, T2, D1, D2)^(class(UC1,CT1,D,T1,D1),class(UC2,CT2,D,T2,D2)),[_|_]),
    UC1 @< UC2.

schedule:-
    setof(D-T-UC-CT-Dur,class(UC, CT, D, T, Dur), L),
    print_classes(L).

print_classes([]).
print_classes([D-T-UC-CT-Dur|Tail]):-
    translate(D, NiceDay),
    format('~a (~a) - ~a ~2f (~2f)', nl, [UC, CT, NiceDay, T, Dur]),
    print_classes(Tail).

translate('1 Seg', monday).
translate('2 Ter', tuesday).
translate('3 Qua', wednesday).
translate('4 Qui', thursday).
translate('5 Sex', friday).

% print_n(+S, +N).

print_n(_, 0).
print_n(S, N):-
    N > 0,
    N1 is N - 1,
    write(S),
    print_n(S, N1).

read_number(X):-
    read_number_aux(0, false, X).

read_number_aux(Acc, _, X):-
    get_code(C),
    C >= 48,
    C =< 57,
    !, 
    Acc1 is 10*Acc + (C-48),
    read_number_aux(Acc1, true, X).

read_number_aux(X, true, X). 

clear_buffer:-
    repeat,
    get_char(C),
    C = '\n'.

read_until_between(Min, Max, Value):-
    repeat,
    read_number(Value),
    Value >= Min,
    Value =< Max,
    !.

% read_number(X), clear_buffer. % útil para o trabalho prático

