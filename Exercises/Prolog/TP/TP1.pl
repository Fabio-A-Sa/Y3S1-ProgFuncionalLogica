% 2022/11/08

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

female(haley).                      % yes
male(gil).                          % no
parent(frank, phil).                % no
parent(x, claire).                  % dede ; jay ; no
parent(clair, X).                   % joe ; manny ; no
parent(jay, X), parent(X, Y).       % 5 resultados, pares (X, Y), Y = neto
parent(jay,_X), parent(_X, Y)       % 5 resultados, somente os Y
parent(X, lily), parent(Y, X).      % 4 resultados, pares (X, Y), Y = avós
parent(_X, lily), parent(Y, _X).    % 4 resultados, somente os Y
parent(alex, X).                    % no 
parent(jay, X), \+parent(gloria, X) % claire ; mitchel ; no