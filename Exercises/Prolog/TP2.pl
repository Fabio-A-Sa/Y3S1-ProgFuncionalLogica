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

