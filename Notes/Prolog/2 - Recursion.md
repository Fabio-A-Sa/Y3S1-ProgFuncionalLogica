# Recursion

```prolog
% Recursão sem preocupação com eficiência
sumN(0, 0).
sumN(N, Sum) :-
    N > 0,
    N1 is N - 1,
    sumN(N1, Sum1),
    Sum is Sum1 + N.

% Recursão eficiente: tail recursion, em que é necessário um acumulador

sumN(N, Sum):-
    sumN(N, Sum, 0).
sumN(0, Sum, Sum).
sumN(N, Sum, Acc):-
    N > 0,
    N1 is N - 1,
    Acc1 = Acc + N.
    sumN(N1, Sum, Acc1).

reverse(Xs, Rev):- 
    reverse(Xs, [], Rev).
reverse([X|Xs], Acc, Rev):-
    reverse(Xs, [X|Acc], Rev).
reverse([], Rev, Rev).
```