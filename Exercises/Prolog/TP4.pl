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