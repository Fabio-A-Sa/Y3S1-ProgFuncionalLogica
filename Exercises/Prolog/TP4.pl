% 2022/11/29

:-use_module(library(lists)).

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

%get_all_nodes(-ListOfAirports)
get_all_nodes(ListOfAirports):-
    setof(Airport, source_or_dest(Airport), ListOfAirports).

source_or_dest(Airport):- flight(Airport, _, _, _, _, _).
source_or_dest(Airport):- flight(_, Airport, _, _, _, _).

% 2.b

%most_diversified(-Company)
most_diversified(Company):-
    findall(Quantity-Comp, List^(flight(_, _, Comp, _, _, _), get_destinations(Comp, List), length(List, Quantity)), ListOfCompanies),
    sort(ListOfCompanies, L),
    last(L, _-Company).

get_destinations(Company, Destinations):-
    findall(Destination, Company^flight(_, Destination, Company, _, _, _) ,Destinations).

% 2.c

%find_flights(+Origin, +Destination, -Flights)
find_flights(Origin, Destination, Flights):-
    find_flights_dfs(Origin, Destination, [], Flights).

find_flights_dfs(Destination, Destination, Flights, Flights).
find_flights_dfs(Origin, Destination, Acc, Flights):-
    flight(Origin, Node, _, Code, _, _),
    \+member(Code, Acc),
    append(Acc, [Code], Acc1),
    find_flights_dfs(Node, Destination, Acc1, Flights).

% 2.d

%find_flights_breadth(+Origin, +Destination, -Flights)
find_flights_breadth(Origin, Destination, Flights):-
    find_flights_bfs([Origin], Destination, [], Flights).

find_flights_bfs([Destination|_], Destination, Visited, Flights):-
    reverse([Destination|Visited], Reversed),
    get_codes(Reversed, [], Flights).
find_flights_bfs([CurrentNode|OldNodes], Destination, Visited, Flights):-
    findall(Child, (flight(CurrentNode, Child, _, _, _, _), \+member(Child, OldNodes), \+member(Child, Visited)), NewNodes),
    append(OldNodes, NewNodes, Nodes),
    find_flights_bfs(Nodes, Destination, [CurrentNode|Visited], Flights).

get_codes([], Result, Result).
get_codes([_], Result, Result).
get_codes([Origin,Destination|Something],Acc, Result):-
    flight(Origin, Destination, _, Code, _, _),
    append(Acc, [Code], Acc1),
    get_codes([Destination|Something], Acc1, Result).

% 2.e

%find_all_flights (+Origin, +Destination, -ListOfFlights)
find_all_flights(Origin, Destination, ListOfFlights):-
    findall(Path, find_flights(Origin, Destination, Path), ListOfFlights).

% 2.f

%find_flights_least_stops(+Origin, +Destination, -ListOfFlights)
find_flights_least_stops(Origin, Destination, ListOfFlights):-
    find_all_flights(Origin, Destination, [One|Rest]),
    get_min([One|Rest], One, ListOfFlights).

get_min([], Minimal, Minimal).
get_min([Possible|Rest], Minimal, ListOfFlights):-
    length(Possible, A),
    length(Minimal, Min),
    A =< Min, !, 
    get_min(Rest, Possible, ListOfFlights).
get_min([_|Rest], Minimal, ListOfFlights):-
    get_min(Rest, Minimal, ListOfFlights).

