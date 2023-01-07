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
    find_flights_bfs([Origin], Destination, [], Reversed),
    get_codes(Reversed, [], Flights).

find_flights_bfs([Destination|_], Destination, Visited, Flights):-
    reverse([Destination|Visited], Flights).
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

% 2.g

%find_flights_stops(+Origin, +Destination, +Stops, -ListFlights)
find_flights_stops(Origin, Destination, Stops, ListFlights):-
    find_flights_bfs([Origin], Destination, [], Reversed),
    findall(Edge, (member(Edge, Stops), \+member(Edge, Reversed)), List),
    length(List, 0),
    get_codes(Reversed, [], ListFlights).

% 2.h

%find_circular_trip (+MaxSize, +Origin, -Cycle)
find_circular_trip(MaxSize, Origin, Cycle):-
    flight(Origin, Destination, _, _, _, _),
    find_circular_path(Origin, Destination, [], Cycle),
    length(Cycle, Length),
    Length =< MaxSize.

find_circular_path(Origin, Origin, Acc, [Origin|Path]):-
    append(Acc, [Origin], Path), !.
find_circular_path(Origin, NextNode, Acc, Path):-
    append(Acc, [NextNode], Acc1),
    flight(NextNode, AnotherNode, _, _, _, _),
    \+member(AnotherNode, Acc),
    find_circular_path(Origin, AnotherNode, Acc1, Path).

% 2.i

%find_circular_trips(+MaxSize, +Origin, -Cycles)
find_circular_trips(MaxSize, Origin, Cycles):-
    findall(Cycle, find_circular_trip(MaxSize, Origin, Cycle), Cycles).

% 2.j

%strongly_connected(+ListOfNodes)
strongly_connected([]).
strongly_connected([_]).
strongly_connected([Node|Rest]):-
    bfs([Node], [], Visited),
    findall(UnvisitedNode, (member(UnvisitedNode, [Node|Rest]), \+member(UnvisitedNode, Visited)), UnvisitedNodes),
    length(UnvisitedNodes, 0).

bfs([], Visited, Visited).
bfs([CurrentNode|Rest], Visited, Result):-
    findall(Node, (flight(CurrentNode, Node, _, _, _, _), \+member(Node, Visited), \+member(Node, Rest)), NewNodes),
    append(Rest, NewNodes, List),
    bfs(List, [CurrentNode|Visited], Result).

% 2.k

%strongly_connected_components(-Components)
strongly_connected_components(Components):-
    setof(Node, is_node(Node), Nodes),
    get_components(Nodes, [], Components).

is_node(Node):- flight(Node, _, _, _, _, _).
is_node(Node):- flight(_, Node, _, _, _, _).

get_components([], Components, Components).
get_components([Node|Rest], Accumulator, Components):-
    bfs([Node], [], Component),
    append(Accumulator, Component, NextAccumulator),
    findall(UnvisitedNode, (member(UnvisitedNode, [Node|Rest]), \+member(UnvisitedNode, Component)), UnvisitedNodes),
    get_components(UnvisitedNodes, NextAccumulator, Components).   

% 2.l

%bridges(-ListOfBridges)
bridges(ListOfBridges):-
    get_all_circular_trips(CircularCodes),
    get_all_codes(AllCodes),
    setof(Bridge, (member(Bridge, AllCodes), \+member(Bridge, CircularCodes)), ListOfBridges).

get_all_circular_trips(Cycles):-
    setof(Code, (Origin, Cycle, Codes)^(is_node(Origin), 
                                        find_circular_trip(100000, Origin, Cycle), 
                                        get_codes(Cycle, [], Codes), 
                                        member(Code, Codes)), Cycles).

get_all_codes(Codes):-
    setof(Code, flight(_, _, _, Code, _, _), Codes).

% 2.m

%central_betweeness(-Nodes)
central_betweeness(Nodes):-
    % Encontra todos os caminhos possíveis com pelo menos 2 voos => há pelo menos uma cidade intermédia
    findall(ShortPath, (X, Y, Len)^(is_node(X), is_node(Y), 
                       find_flights_least_stops(X, Y, ShortPath), 
                       length(ShortPath, Len), Len > 1), Paths),
    get_betweens(Paths, [], NodeFrequency),
    sort(NodeFrequency, SingleNodes),
    make_pairs(SingleNodes, NodeFrequency, [], Pairs),
    get_max(Pairs, -1, Max),
    findall(Node, member(Max-Node, Pairs), Nodes).

get_betweens([], Accumulator, Accumulator).
get_betweens([Path|OthersPaths], Accumulator, Nodes):-
    [_|Rest] = Path,
    get_middle(Rest, Accumulator, NextAccumulator),
    get_betweens(OthersPaths, NextAccumulator, Nodes).

get_middle([], Accumulator, Accumulator).
get_middle([FlightCode|Rest], Accumulator, Nodes):-
    flight(Origin, _, _, FlightCode, _, _),
    append(Accumulator, [Origin], NewAccumulator),
    get_middle(Rest, NewAccumulator, Nodes).

make_pairs([], _, Pairs, Pairs).
make_pairs([Node|Rest], Frequency, Accumulator, Pairs):-
    get_frequency(Node, Frequency, 0, Number),
    append(Accumulator, [Number-Node], NewAccumulator),
    make_pairs(Rest, Frequency, NewAccumulator, Pairs).

get_frequency(_, [], Number, Number).
get_frequency(Node, [Node|Rest], Acc, Number):-
    Acc1 is Acc + 1, !,
    get_frequency(Node, Rest, Acc1, Number).
get_frequency(Node, [_|Rest], Acc, Number):-
    get_frequency(Node, Rest, Acc, Number).

get_max([], Max, Max).
get_max([Number-_|Rest], Acc, Max):-
    Number >= Acc, !,
    get_max(Rest, Number, Max).
get_max([_|Rest], Acc, Max):- get_max(Rest, Acc, Max).

% 2.n

%add_times(+Time, +Duration, -FinalTime, -NextDay)
add_times(Time, Duration, FinalTime, NextDay):-
    Minutes is (Time // 100)*60 + (Time mod 100) + Duration,
    NewMinutes is Minutes mod 60,
    NewHours1 is Minutes // 60,
    NextDay is NewHours1 // 24,
    NewHours is NewHours1 mod 24,
    FinalTime is NewHours * 100 + NewMinutes.

% 2.o

%time_diff(+Time1, +Time2, -Duration)
time_diff(Time1, Time2, Duration):-
    Time2 > Time1, !,
    Duration is ((Time2 // 100)*60 + (Time2 mod 100)) - ((Time1 // 100)*60 + (Time1 mod 100)).
time_diff(Time1, Time2, Duration):-
    Duration is (1440 - ((Time1 // 100)*60 + (Time1 mod 100))) + ((Time2 // 100)*60 + (Time2 mod 100)).

% 2.p

%waiting_time(+Flight1, +Flight2, -WaitingTime)
waiting_time(Flight1, Flight2, WaitingTime):-
    flight(_, Destino, _, Flight1, Time1, Duration1),
    flight(Destino, _, _, Flight2, HorarioPartida, _),
    add_times(Time1, Duration1, HorarioChegada, _),
    time_diff(HorarioChegada, HorarioPartida, WaitingTime).

% 2.q

%filter_flights(+Origin, +Destination, +MaxWait, +MaxStops, -Fs)
filter_flights(Origin, Destination, MaxWait, MaxStops, Fs):-
    findall(Flight, (find_flights(Origin, Destination, Flight),    
                     length(Flight, Len), 
                     Len < MaxStops,
                     verify_flight(Flight, MaxWait)), Fs).

verify_flight([_], _).
verify_flight([Voo1,Voo2|Resto], MaxWait):-
    waiting_time(Voo1, Voo2, Waiting),
    Waiting =< MaxWait, !,
    verify_flight([Voo2|Resto], MaxWait).
verify_flight(_,_):- !, fail.

% 2.r

%get_ordered_flights(+Origin, +Destination, -Flights)
get_ordered_flights(Origin, Destination, Flights):-
    findall(Time-Flight, (find_flights(Origin, Destination, Flight), get_total_time(Flight, 0, Time)), Pairs),
    keysort(Pairs, SortedPairs),
    findall(SortedFlight, member(_-SortedFlight, SortedPairs), Flights).

get_total_time([], Time, Time).
get_total_time([Code], Acc, Time):-
    flight(_, _, _, Code, _, Duration),
    Time is Acc + Duration.
get_total_time([Voo1, Voo2 | Resto], Acc, Time):-
    flight(_, _, _, Voo1, _, Duration),
    waiting_time(Voo1, Voo2, WaitingTime),
    NewAcc is Acc + Duration + WaitingTime,
    get_total_time([Voo2|Resto], NewAcc, Time). 

% Exercise without otimization

separate(L, Pred, SortedList):-
    separate_aux(L, Pred, Ys, Ns),
    append(Ys, Ns, SortedList).

separate_aux([], _, [], []).
separate_aux([H|T], Pred, [H, Ys], Ns):-
    Goal =.. [Pred, H],
    call(Goal), !, 
    separate_aux(T, Pred, Ys, Ns).
separate_aux([H|T], Pred, Ys, [H,Ns]):-
    separate_aux(T, Pred, Ys, Ns).

even(X):- 0 =:= X mod 2.

% Exercíse with otimization

separate2(L, Pred, SortedList):-
    separate2_aux(L, Pred, SortedList-Ns, Ns-[]),

separate2_aux([], _, Ys-Ys, Ns-Ns).
separate2_aux([H|T], Pred, [H|Ys]-TailYs, Ns-TailNs):-
    Goal =.. [Pred, H],
    call(Goal), !, 
    separate2_aux(T, Pred, Ys-TailYs, Ns-TailNs).
separate2_aux([H|T], Pred, Ys-TailYs, [H,Ns]-TailNs):-
    separate2_aux(T, Pred, Ys-TailYs, Ns-TailNs).

% Insert implementation

% insert(+Number, +Goal, +List, -FinalList).
insert(Number, 0, Tail, [Number|Tail]).
insert(Number, Index, [H|T], [H|FinalList]):-
    Index1 is Index - 1,
    insert(Number, Index1, T, FinalList).

% Playing with graphs

connected(a, b).
connected(b, c).
connected(f, e).
connected(c, f).
connected(c, a).
connected(e, g).
connected(k, l).
connected(m, o).
connected(r, a).
connected(s, e).
connected(t, y).
connected(q, a).
connected(p, o).
connected(f, y).
connected(t, w).
connected(t, f).
connected(f, d).
connected(d, g).
connected(d, e).
connected(e, g).
connected(e, j).
connected(j, k).
connected(l, p).
connected(q, e).
connected(q, r).
connected(e, d).
connected(f, s).
connected(d, z).
connected(z, d).
connected(s, z).
connected(a, s).

% Verifica se há conexão entre um ponto e outro. Não verifica ciclos.

is_connected(Origem, Destino):-
    connected(Origem, Destino).
is_connected(Origem, Destino):-
    connected(Origem, Meio),
    is_connected(Meio, Destino).

% Verifica se há conexão entre um ponto e outro, evitando ciclos e mostrando o caminho percorrido.

path_dfs(Origem, Destino):-
    construct_path_dfs(Origem, Destino, [Origem], Path),
    write(Path).

construct_path_dfs(Origem, Destino, Acc, Path):-
    connected(Origem, Destino),
    append(Acc, [Destino], Path).
construct_path_dfs(Origem, Destino, Acc, Path):-
    connected(Origem, Meio),
    \+member(Meio, Acc),
    append(Acc, [Meio], Acc1),
    construct_path_dfs(Meio, Destino, Acc1, Path).

% Encontra um ciclo existente no grafo

cicle([Origem|SubPath]):-
    connected(Origem, Node),
    find_cicle(Origem, Node, [], SubPath).

find_cicle(Origem, Origem, Acc, Path):-
    append(Acc, [Origem], Path), !.
find_cicle(Origem, Destino, Acc, Path):-
    append(Acc, [Destino], Acc1),
    connected(Destino, Medio),
    \+member(Medio, Acc),
    find_cicle(Origem, Medio, Acc1, Path).

is_node(X):- connected(_, X).
is_node(X):- connected(X, _).

% Encontra todos os ciclos existente no grafo

all_cicles(Paths):-
    setof(Path, cicle(Path), Paths).

% Percorre o grafo de Origem até Destino fazendo pesquisa em largura

path_bfs(Origem, Destino):-
    construct_path_bfs([Origem], Destino, [], Path),
    write(Path).

construct_path_bfs([Destino|_], Destino, Visited, Path):-
    reverse([Destino|Visited], Path).
construct_path_bfs([Node|Nodes], Destino, Visited, Path):-
    findall(NextNode, (connected(Node, NextNode), \+member(NextNode, Visited), \+member(NextNode, [Node|Nodes])), DirectChildren),
    append(Nodes, DirectChildren, NewNodes),
    construct_path_bfs(NewNodes, Destino, [Node|Visited], Path).