% 2022/11/29

% Exercicio 1

% 1.a

%add_person/0
add_person:-
    write('male or female? '),
    read(male), !,
    write('name? '),
    read(Name),
    asserta(male(Name)).
add_person:-
    write('name? '),
    read(Name),
    asserta(female(Name)). 

% 1.b

%add_parents(+Person)
add_parents(Person):-
    add_parents_aux(Person, 2).

add_parents_aux(_, 0):- !.
add_parents_aux(Person, N):-
    format('Parent of ~a: \n', [Person]),
    read(Parent),
    asserta(parent(Person, Parent)),
    Next is N - 1,
    add_parents_aux(Person, Next).

% 1.c

%remove_person/0
remove_person:-
    write('Person to remove: '),
    read(Person),
    retractall(parent(_, Person)),
    retractall(parent(Person, _)),
    retractall(female(Person)),
    retractall(male(Person)).

% Exercício 2

%flight(origin, destination, company, code, hour, duration)
flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145).
flight(london, madrid, iberia, ib3163, 1030, 140).
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).

% 2.a

