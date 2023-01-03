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
