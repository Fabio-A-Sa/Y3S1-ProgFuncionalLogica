% 2022/11/15

% Exercício 1

% 1.a

%factorial(+N, ?F)
factorial(0, 0).
factorial(1, 1).
factorial(N, F):-
    N1 is N-1,
    factorial(N1, F1),
    F is F1*N.

% 1.b 

%somaRec(+N, ?Sum)
somaRec(0, 0).
somaRec(N, Sum):-
    N1 is N-1,
    somaRec(N1, Sum1),
    Sum is Sum1 + N.

% 1.c

%fibonacci(+N, ?F)
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(2, 2).
fibonacci(N, F):-
    N1 is N-1,
    N2 is N-2,
    fibonacci(N1, F1),
    fibonacci(N2, F2),
    F is F1 + F2.

% 1.d

%isPrime(+X)
isPrime(1).
isPrime(2).
isPrime(X):-
    X > 2,
    Next is X - 1,
    isPrimeAux(X, Next).

isPrimeAux(_, 1).
isPrimeAux(X, N):-
    X mod N =\= 0,
    Next is N - 1,
    isPrimeAux(X, Next).

% Exercício 4

% a yes
% b no 
% c yes 
% d H = pfl e T = [lbaw, redes, ltw]
% e H = lbaw T = [ltw]
% f H = leic T = []
% g no
% h H = leic e T = [[pfl, lwt, lbaw, redes]]
% i H = leic e T = [Two]
% j Inst = gram e LEIC = feup
% k One = 1, Two = 2 e Tail = [3, 4]
% l One = leic e Rest = [Two|Tail]

% Exercício 5

% 5.a

%list_size(+List, ?Size)
list_size([], 0).
list_size([_|T], Size):-
    list_size(T, SubSize),
    Size is 1 + SubSize.

% 5.b 

%list_sum(+List, ?Sum)
list_sum([], 0).
list_sum([H|T], Sum):-
    list_sum(T, SubSum),
    Sum is H + SubSum.

% 5.c

%list_prod(+List, ?Prod)
list_prod([], 1).
list_prod([H|T], Prod):-
    list_prod(T, SubProd),
    Prod is H * SubProd.

% 5.d

%inner_product(+List1, +List2, ?Result)
inner_product([], [], 0).
inner_product([H1|T1], [H2|T2], Result):-
    inner_product(T1, T2, SubResult),
    Result is (H1 * H2) + SubResult.

% 5.e

%count(+Elem, +List, ?N)
count(_, [], 0).
count(Element, [Element|T], Result):-
    count(Element, T, SubResult),
    Result is 1 + SubResult, !.
count(Element, [_|T], Result):-
    count(Element, T, Result).

% Exercício 6

% 6.1

%invert(+List,?List2)
invert([], []).
invert([H|T], Result):-
    invert(T, Sublist),
    append(Sublist, [H], Result).

% 6.2

%del_one(+Elem, +List1, ?List2)
del_one(_, [], []).
del_one(Element, [Element|T], T):- !.
del_one(Element, [H|T], List):-
    del_one(Element, T, Result),
    append([H], Result, List).

% 6.3 

%del_all(+Elem, +List1, ?List2)
del_all(_, [], []).
del_all(Element, [Element|Tail], Result):-
    del_all(Element, Tail, Result).
del_all(Element, [Head|Tail], Result):-
    del_all(Element, Tail, SubResult),
    append([Head], SubResult, Result).

% 6.4

%del_all_list(+ListElems, +List1, ?List2)
del_all_list(_, [], []):- !.
del_all_list([], List1, List1):- !.
del_all_list([H|T], List1, List2):-
    del_all(H, List1, SubResult),
    del_all_list(T, SubResult, List2), !.

% 6.5

%del_dups(+List1, ?List2)
del_dups([], []).
del_dups([H|T], List2):-
    del_all(H, T, SubResult),
    del_dups(SubResult, Another),
    append([H], Another, List2), !.

% 6.6

%list_perm (+L1, +L2)
list_perm(List1, List2):-
    length(List1, Len),
    length(List2, Len),
    del_all_list(List1, List2, []),
    del_all_list(List2, List1, []).

% 6.7

%replicate(+Amount, +Elem, ?List) 
replicate(0, _, []):- !.
replicate(1, Element, [Element]):- !.
replicate(N, Element, [Element|List]):-
    NextN is N - 1,
    replicate(NextN, Element, List).

% 6.8

%intersperse(+Elem, +List1, ?List2)
intersperse(_, [], []):- !.
intersperse(_, [H], [H]):- !.
intersperse(Element, [H|T], Result):-
    intersperse(Element, T, SubResult),
    append([H, Element], SubResult, Result).

% 6.9

%insert_elem(+Index, +List1, +Elem, ?List2)
insert_elem(0, List, Element, [Element|List]).
insert_elem(N, [H|T], Element, Result):-
    length([H|T], X), X > N,
    NextN is N - 1,
    insert_elem(NextN, T, Element, SubResult),
    append([H], SubResult, Result).

% 6.10

%delete_elem(+Index, +List1, +Elem, ?List2)
delete_elem(0, [Element|T], Element, T).
delete_elem(N, [H|T], Element, Result):-
    length([H|T], X), X > N,
    NextN is N - 1,
    delete_elem(NextN, T, Element, SubResult),
    append([H], SubResult, Result).

% 6.11

%replace(+List1, +Index, ?Old, +New, ?List2)
replace([Old|Tail], 0, Old, New, [New|Tail]).
replace([H|T], Index, Old, New, List2):-
    NextIndex is Index - 1,
    replace(T, NextIndex, Old, New, SubResult),
    append([H], SubResult, List2).

% Exercício 7

% 7.1

%list_append(?L1, ?L2, ?L3)
list_append([], L2, L2).
list_append([H|T], L2, [H|R]):-
    list_append(T, L2, R).

% 7.2

%list_member(?Elem, ?List)
list_member(_, []):- fail.
list_member(Element, List):-
    append(_, [Element|_], List).

% 7.3

%list_last(+List, ?Last)
list_last(List, Last):-
    append(_, [Last], List).

% 7.4

%list_nth(?N, ?List, ?Elem)
list_nth(N, List, Elem):-
    append(Before, [Elem|_], List),
    length(Before, N).

% 7.5

%list_append(+ListOfLists, ?List)
list_append([], []).
list_append([H], H).
list_append([H|T], Result):-
    list_append(T, SubResult),
    append(H, SubResult, Result).

% 7.6

%list_del(+List, +Elem, ?Res)
list_del(List, Elem, Res):-
    append(Before, [Elem|After], List),
    append(Before, After, Res).

% 7.7

%list_before(?First, ?Second, ?List)
list_before(First, Second, List):-
    append(_, [First|After], List),
    append(_, [Second|_], After).

% 7.8

%list_replace_one(+X, +Y, +List1, ?List2)
list_replace_one(X, Y, List1, List2):-
    append(Before, [X|After], List1),
    append(Before, [Y|After], List2).

% 7.9
%list_repeated(+X, +List)

list_repeated(X, List):-
    append(_, [X|After], List),
    append(_, [X|_], After).

% 7.10

%list_slice(+List1, +Index, +Size, ?List2)
list_slice(List1, Index, Size, List2):-
    append(Before, After, List1),
    length(Before, Index),
    append(List2, _, After),
    length(List2, Size).

% 7.11

%list_shift_rotate(+List1, +N, ?List2)
list_shift_rotate(List1, N, List2):-
    append(Before, After, List1),
    length(Before, N),
    append(After, Before, List2).

% Exercício 8

% 8.1

%list_to(+N, ?List)
list_to(0, []).
list_to(N, List):-
    NextN is N - 1,
    list_to(NextN, SubList),
    append(SubList, [N], List).

