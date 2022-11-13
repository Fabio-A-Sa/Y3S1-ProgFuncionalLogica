% 2022/11/08

% Exercise 1

% 1.a 

male(frank).
male(jay).
male(javier).
male(merle).
male(phil).
male(mitchell).
male(joe).
male(pameron).
male(bo).
male(dylan).
male(luke).
male(rexford).
male(calhoun).
male(george).

female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(manny).
female(cameron).
female(haley).
female(alex).
female(lily).
female(poppy).

parent(grace,phil).
parent(frank,phil).
parent(dede,claire).
parent(jay,claire).
parent(dede,mitchell).
parent(jay,mitchell).
parent(jay,joe).
parent(gloria,joe).
parent(gloria,manny).
parent(javier,manny).
parent(barb,cameron).
parent(merle,cameron).
parent(barb,pameron).
parent(merle,pameron).
parent(phil, haley).
parent(claire, haley).
parent(phil, alex).
parent(claire, alex).
parent(phil, luke).
parent(claire, luke).
parent(mitchell, lily).
parent(mitchell, rexford).
parent(cameron, lily).
parent(cameron, rexford).
parent(pameron, calhoun).
parent(bo, calhoun).
parent(dylan, george).
parent(dylan, poppy).
parent(haley, george).
parent(haley, poppy).

% 1.b 

% female(haley).                      % yes
% male(gil).                          % no
% parent(frank, phil).                % no
% parent(X, claire).                  % dede ; jay ; no
% parent(clair, X).                   % joe ; manny ; no
% parent(jay, X), parent(X, Y).       % 5 resultados, pares (X, Y), Y = neto
% parent(jay,_X), parent(_X, Y)       % 5 resultados, somente os Y
% parent(X, lily), parent(Y, X).      % 4 resultados, pares (X, Y), Y = avós
% parent(_X, lily), parent(Y, _X).    % 4 resultados, somente os Y
% parent(alex, X).                    % no 
% parent(jay, X), \+parent(gloria, X) % claire ; mitchel ; no

% 1.c 

father(X, Y):-
    parent(X, Y), 
    male(X).

mother(X, Y):-
    parent(X, Y),
    female(X).

grandparent(X, Y):-
    parent(X, Z),
    parent(Z, Y).

grandfather(X, Y):-
    grandparent(X, Y),
    male(X).

grandmother(X, Y):-
    grandparent(X, Y),
    female(X).

siblings(X, Y):-
    father(A, X),
    father(A, Y),
    mother(B, X),
    mother(B, Y),
    X \= Y.

siblings2(X, Y):-
    parent(A, X),
    parent(A, Y),
    parent(B, X),
    parent(B, Y),
    A @< B,         % Para retirar os exemplos repetidos
    X \= Y.

halfsiblings(X, Y):-
    parent(Z, X),
    parent(W, Y),
    \+siblings(X,Y),
    Z == W.

cousins(X, Y):-
    parent(Z, X),
    parent(W, Y),
    siblings(Z, W).

uncle(X, Y):-
    parent(Z, Y),
    siblings(X, Z).

% 1.d

% cousins(haley, lily).
% father(X, luke).
% uncle(X, lily).
% grandmother(X, _Y).
% siblings(X, Y) ; halfsiblings(X, Y).

% 1.5 

% married(Person1, Person2, Year)
% divorce(Person1, Person2, Year)
% is_married(Person1, Person2, CurrentYear)

married(jay, gloria, 2008).
married(jay, dede, 1968).
divorce(jay, dede, 2003).

% Rule 1: We assume that Person1 and Person2 never got divorced

is_married(X, Y, CurrentYear):-
    married(X, Y, Year1),
    CurrentYear >= Year1,
    \+divorce(X, Y, _).

% Rule 2: We assume that Person1 and Person2 got divorced sometime later

is_married(X, Y, CurrentYear):-
    married(X, Y, Year1),
    CurrentYear >= Year1,
    \+divorce(X, Y, Year2),
    CurrentYear < Year2.

% Exercise 2

% 2.a  

leciona(adalberto, algoritmos).
leciona(bernardete, basesdedados).
leciona(capitolino, compiladores).
leciona(diogenes, estatistica).
leciona(ermelinda, redes).

frequenta(alberto, algoritmos).
frequenta(bruna, algoritmos).
frequenta(cristina, algoritmos).
frequenta(diogo, algoritmos).
frequenta(eduarda, algoritmos).
frequenta(antonio, basesdedados).
frequenta(bruno, basesdedados).
frequenta(cristina, basesdedados).
frequenta(duarte, basesdedados).
frequenta(eduardo, basesdedados).
frequenta(alberto, compiladores).
frequenta(bernardo, compiladores).
frequenta(clara, compiladores).
frequenta(diana, compiladores).
frequenta(eurico, compiladores).
frequenta(antonio, estatistica).
frequenta(bruna, estatistica).
frequenta(claudio, estatistica).
frequenta(duarte, estatistica).
frequenta(eva, estatistica).
frequenta(alvaro, redes).
frequenta(beatriz, redes).
frequenta(claudio, redes).
frequenta(diana, redes).
frequenta(eduardo, redes).

% 2.b 

% leciona(diogenes, X).
% leciona(felismina, _X).
% frequenta(claudio, X).
% frequenta(dalmindo, _X).
% leciona(bernardete, X), frequenta(eduarda, X).
% frequenta(alberto, X), frequenta(alvaro, Y), X == Y.

% 2.c 

aluno(X, Y):-
    leciona(Y, Z),
    frequenta(X, Z).

professor(X, Y):-
    aluno(Y, X).

colega(X, Y):-
    leciona(X, _Z),
    leciona(Y, _W).

colega(X, Y):-
    frequenta(X, Z),
    frequenta(Y, W),
    Z == W,
    X \= Y.

% aluno(bernardo, francisco).
% aluno(X, bernardete).
% professor(X, antonio).
% aluno(Z, bernardete), aluno(Z, diogenes).
% colega(X, Y), X @< Y.
% frequenta(X, _Y), frequenta(X, _Z), _Y @< _Z.