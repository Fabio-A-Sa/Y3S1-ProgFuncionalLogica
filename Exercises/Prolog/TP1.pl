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

% Exercise 3

% 3.a

piloto(lamb).
piloto(besenyei).
piloto(chambliss).
piloto(maclean).
piloto(mangold).
piloto(jones).
piloto(bonhomme).

equipa(lamb, breitling).
equipa(besenyei, redbull).
equipa(chambliss, redbull).
equipa(maclean, mediterraneanracingteam).
equipa(mangold, cobra).
equipa(jones, matador).
equipa(bonhomme, matador).

aviao(lamb, mx2).
aviao(besenyei, edge540).
aviao(chambliss, edge540).
aviao(maclean, edge540).
aviao(mangold, edge540).
aviao(jones, edge540).
aviao(bonhomme, edge540).

circuito(istanbul).
circuito(budapest).
circuito(porto).

venceu(jones, porto).
venceu(mangold, budapest).
venceu(mangold, istanbul).

gates(istanbul, 9).
gates(budapest, 6).
gates(porto, 5).

ganhou(X, Y):- % a equipa X venceu uma corrida no percurso Y
    equipa(Z, X),
    venceu(Z, Y).

% 3.b 

% venceu(X, porto).
% ganhou(X, porto).
% gates(X, _Z), _Z > 8.
% aviao(X, _Y), _Y \= edge540.
% venceu(X, _Y), venceu(X, _Z), _Y @< _Z.
% aviao(_Y, X), venceu(_Y, porto).

% Exercise 4

legenda(1, 'Integer Overflow').
legenda(2, 'Divisao por Zero').
legenda(3, 'ID Desconhecido').

% legenda(1, Answer).

% Exercise 5

cargo(tecnico, eleuterio).
cargo(tecnico, juvenaldo).
cargo(analista, leonilde).
cargo(analista, marciliano).
cargo(engenheiro, osvaldo).
cargo(engenheiro, porfirio).
cargo(engenheiro, reginaldo).
cargo(supervisor, sisnando).
cargo(supervisor_chefe, gertrudes).
cargo(secretaria_exec, felismina).
cargo(diretor, asdrubal).
chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, diretor).
chefiado_por(secretaria_exec, diretor).

% 5.a 

% O cargo de "sisnando" que chefia uma pessoa com cargo analista
% Quem chefia o técnico e quem chefia quem chefia o técnico
% O nome e cargo de quem é chefiado por um supervisor
% O cargo de quem é chefiado pelo diretor cujo nome não é "felismina"

% 5.b 

% X = supervisor
% X = engenheiro, Y = supervisor
% J = analista, P = leonilde
% P = supervisor_chefe

% 5.c 

chefe(X, Y):-
    chefiado_por(Y, X).
% R: X = diretor, Y = supervisor_chefe&secretaria_exec

chefiadasmesmocargo(X, Y):-
    chefiado_por(X, _Y),
    chefiado_por(Y, _Z),
    _Y @< _Z.
% R: tecnico&engenheiro, tecnico&analista, ...

cargonaoresponsavel(X):-        
    \+chefiado_por(_Z, X).
% R: Não existem cargos não responsáveis por outros elementos

naochefiada(X):-
    \+(chefiado_por(X, _Y)).
% R: diretor

% Exercise 6 

u(1).
d(2).
d(4).
q(4).
q(16).

pairs(X, Y):- 
    d(X), 
    q(Y).

pairs(X, X):- 
    u(X).

% Os pares válidos pela expressão são (2, 4), (2, 16), (4, 4), (4, 16) e (1, 1), por esta ordem.

% Exercise 7 

