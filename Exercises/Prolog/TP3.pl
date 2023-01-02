% 2022/11/22

% Exercício 1

s(1).
s(2):- !.
s(3).

% a) X = 1, X = 2
% b) X = 1, Y = 1 ; X = 1, Y = 2 ; X = 2, Y = 1 ; X = 2, Y = 1
% c) X = 1, Y = 1 ; X = 1, Y = 2

% Exercício 2

data(one).
data(two).
data(three).
cut_test_a(X):- data(X).
cut_test_a('five').
cut_test_b(X):- data(X), !.
cut_test_b('five').
cut_test_c(X, Y):- data(X), !, data(Y).
cut_test_c('five', 'five').

% a) one, two, three, five
% b) one
% c) one-one, one-two, one-three

% Exercício 3

% Em immature/1 o cut usado é vermelho, pois influencia nos resultados obtidos pelo predicado
% Em adult/1 o cut usado é verde pois trava o backtracking do prolog por motivos de eficiência de pesquisa

% Exercício 4

% 4.a

%print_n(+S, +N)
print_n(_, 0).
print_n(Symbol, N):-
    write(Symbol),
    Next is N - 1,
    print_n(Symbol, Next).

% 4.b

%print_text(+Text, +Symbol, +Padding)
print_text(Text, Symbol, Padding):-
    write(Symbol),
    print_n(' ', Padding),
    text(Text),
    print_n(' ', Padding),
    write(Symbol), nl.

text([]).
text([H|T]):-
    put_code(H),
    text(T).

% 4.c

print_banner(Text, Symbol, Padding):-
    length(Text, Len),
    TotalLength is Len + 2*Padding + 2,
    Spaces is TotalLength - 2,
    print_n(Symbol, TotalLength), nl, print_n(Symbol, 1),
    print_n(' ', Spaces), print_n(Symbol, 1), nl,
    print_n(Symbol, 1), print_n(' ', Padding), text(Text), print_n(' ', Padding), print_n(Symbol, 1), nl,
    print_n(Symbol, 1), print_n(' ', Spaces), print_n(Symbol, 1), nl,print_n(Symbol, TotalLength), nl.