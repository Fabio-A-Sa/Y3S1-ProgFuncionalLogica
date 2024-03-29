% Exercises 07/01/2023

% Pasta FEUP > Teste1 

% Teste 1 de 2017

:- dynamic(played/4).
:- use_module(library(lists)).
:- use_module(library(between)).

%player(Name, Username, Age)
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Johnny', 'A Player', 16).

%game(Name, Categories, MinAge)
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

%played(Player, Game, HoursPlayed, PercentUnlocked)
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).

% 1

%achievedALot(+Player)
achievedALot(Player):-
    played(Player, _, _, Percentage),
    Percentage >= 80.

% 2

%isAgeAppropriate(+Name, +Game)

isAgeAppropriate(Name, Game):-
    game(Game, _, MinAge),
    player(Name, _, Age),
    Age >= MinAge.

% 3

%timePlayingGames(+Player, +Games, -ListOfTimes, -SumTimes)
timePlayingGames(Player, Games, ListOfTimes, SumTimes):-
    fill_times(Player, Games, [], ListOfTimes),
    sum_times(ListOfTimes, 0, SumTimes).

fill_times(_, [], List, List).
fill_times(Player, [Game|Rest], Acc, List):-
    played(Player, Game, Time, _), !,
    append(Acc, [Time], NewAcc),
    fill_times(Player, Rest, NewAcc, List).
fill_times(Player, [Game|Rest], Acc, List):-
    \+played(Player, Game, _ , _),
    append(Acc, [0], NewAcc),
    fill_times(Player, Rest, NewAcc, List).

sum_times([], Sum, Sum).
sum_times([Element|Rest], Acc, Sum):-
    NewAcc is Element + Acc,
    sum_times(Rest, NewAcc, Sum).

% 4

%listGamesOfCategory(+Category)
listGamesOfCategory(Category):-
    game(Name, Categories, MinAge),
    member(Category, Categories),
    format('~a (~d)\n', [Name, MinAge]),
    fail.
listGamesOfCategory(_).

% 5

%updatePlayer(+Player, +Game, +Hours, +Percentage)
updatePlayer(Player, Game, Hours, Percentage):-
    retract(played(Player, Game, Hours1, Percentage1)),
    Hours2 is Hours1 + Hours,
    Percentage2 is Percentage1 + Percentage,
    asserta(played(Player, Game, Hours2, Percentage2)).

% 6

%fewHours(+Player, -Games)
fewHours(Player, Games):-
    get_games(Player, [], Games).

get_games(Player, Acc, Games):-
    played(Player, Game, Hours, _),
    Hours < 10,
    \+member(Game, Acc), !,
    append(Acc, [Game], NewAcc),
    get_games(Player, NewAcc, Games).
get_games(_, Games, Games).

% 7

%ageRange(+MinAge, +MaxAge, -Players)
ageRange(MinAge, MaxAge, Players):-
    findall(Name, Age^(player(Name, _, Age), Age >= MinAge, Age =< MaxAge), Players).

% 8

%averageAge(+Game, -AverageAge)
averageAge(Game, AverageAge):-
    findall(Age, (player(_, Username, Age), played(Username, Game, _, _)), Ages),
    sum_all(Ages, 0, Sum),
    length(Ages, Len),
    AverageAge is Sum / Len.

sum_all([], Sum, Sum).
sum_all([Element|Rest], Acc, Sum):-
    NewAcc is Acc + Element,
    sum_all(Rest, NewAcc, Sum).

% 9

%mostEffectivePlayers(+Game, -Players)
mostEffectivePlayers(Game, Players):-
    setof(Player-Percentage, (Player, Game, Hours, Perc)^(played(Player, Game, Hours, Perc), Percentage is Perc / Hours), All),
    All = [_-Max|_],
    findall(Player, member(Player-Max, All), Players).

% 10

%whatDoesItDo(?X)
% Verifica se o player de username X joga sempre jogos apropriados à sua idade, ou seja, em que a idade mínima
% é sempre inferior à idade do jogador.
% Existe um green cut para auxiliar na eficiência: como sabemos que os usernames são únicos, não necessita de computar mais
% pesquisas, pelo que o backtracking é cortado
whatDoesItDo(Username):-
    player(_, Username, Age), !,
    \+( played(Username, Game, _, _), game(Game, _, MinAge), Age > MinAge ).

% 11
% Sugiro uma lista de listas de elementos [[8, 8, 7, 7], [2, 4, 4], [3, 3], [1]]

matrix([[8, 8, 7, 7], [2, 4, 4], [3, 3], [1]]).

% 12

%areClose(+Distance, +Matrix, -Pairs)
areClose(Distance, Matrix, Pairs):-
    length(Matrix, Len),
    Max is Len + 1,
    findall(Row/Col, (between(1, Max, Row), between(1, Max, Col), Row < Col, get_distance(Row/Col, Matrix, D), D =< Distance), Pairs).

get_distance(Col/Col, _,  0):- !.
get_distance(Row/Col, Matrix, D):-
    Col > Row, !,
    Index is Col - Row,
    nth1(Row, Matrix, Line),
    nth1(Index, Line, D),
    write(Row/Col/D), nl.
get_distance(Row/Col, Matrix, D):-
    get_distance(Col/Row, Matrix, D), !.

% 13
% Sugiro uma representação de uma lista que contenha [ID, Left, Right], com Left/Right representados da mesma forma e nos nós apenas o nome do país

dendo([1, [2, [5, [7, [8, australia, [9, [10, stahelena, anguila], georgiadosul]], reinounido], [6, servia, franca]], [3, [4,niger, india], irlanda]], brasil]).

% 14

%distance(+Pais1, +Pais2, +Dendo, -Distancia)
distance(Pais1, Pais2, Dendo, Distancia):-
    find(Pais1, Dendo, 0, Distancia1),
    find(Pais2, Dendo, 0, Distancia2),
    min(Distancia1, Distancia2, Min),
    max(Distancia1, Distancia2, Max),
    Distancia is Max - Min.

find(Atom, Atom, Distance, Distance):- !.
find(Atom, [_, Left, Right], Acc, Distance):-
    NewAcc is Acc + 1,
    find(Atom, Left, NewAcc, Distance1),
    find(Atom, Right, NewAcc, Distance2),
    max(Distance1, Distance2, Distance), !.
find(_, _, _, -1000).

max(A, B, A):- A > B, !.
max(_, B, B).
min(A, B, A):- A < B, !.
min(_, B, B).

% Teste 1 de 2018

%airport(Name, ICAO, Country)
airport('Aeroporto Francisco Sá Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aéroport de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci', 'LIRF', 'Italy').

%company(ICAO, Name, Year, Coutry)
company('TAP', 'TAP Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Société Air France S.A', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

%flight(Designation, Origin, Destination, DepartureTIme, Duration, Company)
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('FR5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'ARF').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'ARF').

% 1

%short(+Flight)
short(Flight):-
    flight(Flight, _, _, _, Time, _),
    Time =< 90.

% 2

%shorter(+Flight1, +Flight2, -ShorterFlight)
shorter(Flight1, Flight2, Flight2):-
    flight(Flight1,_, _, _, Time1, _),
    flight(Flight2,_, _, _, Time2, _),
    Time1 \= Time2,
    Time1 > Time2, !.
shorter(Flight1, Flight2, Flight1):-
    flight(Flight1,_, _, _, Time1, _),
    flight(Flight2,_, _, _, Time2, _),
    Time1 \= Time2,
    Time1 < Time2.

% 3

%arrivalTime(+Flight, -ArrivalTime)
arrivalTime(Flight, ArrivalTime):-
    flight(Flight,_, _, Inicio, Time, _),
    TotalTime is (Inicio // 100) * 60 + (Inicio mod 100) + Time,
    Minutes is TotalTime mod 60,
    Hours is (TotalTime // 60) mod 24,
    ArrivalTime is Hours*100 + Minutes.

% 4 

%countries(+Company, -ListOfCoutries)
countries(Company, ListOfCoutries):-
    get_countries(Company, [], ListOfCoutries).

get_countries(Company, Acc, ListOfCoutries):-
    get_airport_code(Company, Code),
    airport(_, Code, Pais),
    \+member(Pais, Acc), !,
    append(Acc, [Pais], NewAcc),
    get_countries(Company, NewAcc, ListOfCoutries).
get_countries(_, ListOfCoutries, ListOfCoutries).

get_airport_code(Company, Code):- flight(_, Code, _, _, _, Company).
get_airport_code(Company, Code):- flight(_, _, Code, _, _, Company).

% 5

%pairableFlights/0
pairableFlight:-
    airport(_, Airport, _),
    flight(Code1, _, Airport, _, _, _),
    flight(Code2, Airport, _, TimePartida, _, _),
    arrivalTime(Code1, TimeChegada),
    get_minutes(TimeChegada, T1),
    get_minutes(TimePartida, T2),
    Gap is T2 - T1,
    Gap =< 90, Gap >= 30,
    format('~a - ~a \\ ~a \n', [Airport, Code1, Code2]),
    fail.
pairableFlight.

get_minutes(Inicio, Result):-
    Result is (Inicio // 100) * 60 + (Inicio mod 100).

% 6

%tripDays(+Trip, +Time, -FlightTimes, -Days)
tripDays([Begin|Resto], Time, FlightTimes, Days):-
    airport(_, AirportCode, Begin),
    get_times(Resto, AirportCode, Time, [], FlightTimes),
    get_days(FlightTimes, 1, Days).

get_times([], _, _, Times, Times).
get_times([Pais|Resto], AirportCode, Time, Acc, Times):-
    airport(_, Airport, Pais),
    flight(_, AirportCode, Airport, Inicio, Duracao, _),
    Inicio >= Time, !,
    append(Acc, [Inicio], NewAcc),
    NewDuracao is Duracao + 30,
    sum_minutes(NewDuracao, Duracao, NewSlot),
    get_times(Resto, Airport, NewSlot, NewAcc, Times).
get_times([Pais|Resto], AirportCode, Time, Acc, Times):-
    Time \= 0,
    get_times([Pais|Resto], AirportCode, 0, Acc, Times), !.
get_times(_, _, 0, _, _):-
    !, fail.

sum_minutes(Time, Duration, Result):-
    TotalTime is (Time // 100) * 60 + (Time mod 100) + Duration,
    Minutes is TotalTime mod 60,
    Hours is (TotalTime // 60) mod 24,
    Result is Hours*100 + Minutes.

get_days([], Days, Days):- !.
get_days([_], Days, Days):- !.
get_days([Time1, Time2 | Resto], Acc, Days):-
    Time1 < Time2, !,
    get_days([Time2|Resto], Acc, Days).
get_days([_, Time2 | Resto], Acc, Days):-
    NextAcc is Acc + 1,
    get_days([Time2|Resto], NextAcc, Days).

% 7

%avg(+Airport, -AvgAirport)
avg(Airport, Avg):-
    findall(Duration, flight(_, Airport, _, _, Duration, _), All),
    sum(All, 0, Result),
    length(All, R),
    Avg is Result / R.

sum([], A, A).
sum([Element|S], Acc, A):-
    NewAcc is Acc + Element,
    sum(S, NewAcc, A).

% 8

%mostInternational(-List)
mostInternational(List):-
    findall(Total-Company, (Company, List)^(company(Company, _, _, _), get_countries(Company, [], List), length(List, Total)), All),
    All = [Max-_|_],
    findall(C, member(Max-C, All), List).

% 9 e 10

make_pairs(N, P, [X-Y|Zs]):-
    sort(N, L),
    select(X, L, L2),
    select(Y, L2, L3),
    G =.. [P, X, Y], G,
    !,
    make_pairs(L3, P, Zs).
make_pairs(N, P, [X-Y|Zs]):-
    sort(N, L),
    select(X, L, L2),
    select(Y, L2, L3), !,
    make_pairs(L3, P, Zs).
make_pairs([], _, []).

dif_max_2(X, Y):- X < Y, X >= Y - 2.

% 11

%make_max_pairs(+L, +P, -S)
make_max_pairs(L, P, S):-
    aux_pairs(L, P, [], S).

aux_pairs([], _, List, List).
aux_pairs([Element|Rest], P, Acc, Lists):-
    aux_aux_pairs(Element, Rest, P, [], Another),
    append(Acc, Another, New),
    aux_pairs(Rest, P, New, Lists).

aux_aux_pairs(_, [], _, Lists, Lists).
aux_aux_pairs(Element, [X|Rest], P, Acc, Lists):-
    Pred =.. [P, Element, X], Pred, !,
    append(Acc, [Element-X], New),
    aux_aux_pairs(Element, Rest, P, New, Lists).
aux_aux_pairs(Element, [X|Rest], P, Acc, Lists):-
    Pred =.. [P, X, Element], Pred, !,
    append(Acc, [X-Element], New),
    aux_aux_pairs(Element, Rest, P, New, Lists).
aux_aux_pairs(Element, [_|Rest], P, Acc, Lists):-
    aux_aux_pairs(Element, Rest, P, Acc, Lists).

% 12

%whitoff(+N,-W)
whitoff(N, W):-
    get_all(N, 1, 0, [], [_|W], min), !.

get_all(Max, L, _, W, W, _):- L > Max, !.
get_all(Max, L, Delta, W, W, _):- R is L + Delta, R > Max, !.
get_all(Max, L, Delta, Acc, W, min):- !,
    L1 is L + Delta,
    append(Acc, [(L-L1),(L1-L)], NewAcc),
    NextDelta is Delta + 1,
    NextL is L + 1,
    get_all(Max, NextL, NextDelta, NewAcc, W, max).
get_all(Max, L, Delta, Acc, W, max):- !,
    L1 is L + Delta,
    append(Acc, [(L-L1),(L1-L)], NewAcc),
    NextDelta is Delta + 1,
    NextL is L1 + 1,
    get_all(Max, NextL, NextDelta, NewAcc, W, min).

% Teste 1 de 2020

%jogo(Partida, Equipa1, Equipa2, Resultado)
jogo(1, sporting, porto, 1-2).
jogo(1, maritimo, benfica, 2-0).
jogo(2, sporting, benfica, 0-2).
jogo(2, porto, maritimo, 1-0).
jogo(3, maritimo, sporting, 1-1).
jogo(3, benfica, porto, 0-2).

%treinadores(Equipa, [[Época-Treinador]])
treinadores(porto, [[1-3]-sergio_conceicao]).
treinadores(sporting, [[1-2]-silas, [3-3]-ruben_amorim]).
treinadores(benfica, [[1-3]-bruno_lage]).
treinadores(maritimo, [[1-3]-jose_gomes]).

% 1

%n_treinadores(?Equipa, ?Número)
n_treinadores(Equipa, Numero):-
    treinadores(Equipa, List),
    length(List, Numero).

% 2

%n_jogadas_treinador(?Treinador, ?NumeroJogadas)
n_jogadas_treinador(Treinador, 1):-
    treinadores(_, List),
    member([N-N]-Treinador, List), !.
n_jogadas_treinador(Treinador, NumeroJogadas):-
    treinadores(_, List),
    member([Min-Max]-Treinador, List),
    NumeroJogadas is Max - Min + 1.

% 3

%ganhou(?Jornada, ?EquipaVencedora, ?EquipaDerrotada)
ganhou(Jornada, EquipaVencedora, EquipaDerrotada):-
    jogo(Jornada, EquipaVencedora, EquipaDerrotada, V-D), V > D.
ganhou(Jornada, EquipaVencedora, EquipaDerrotada):-
    jogo(Jornada, EquipaDerrotada, EquipaVencedora, D-V), V > D.

% 4 Alínea C

:-op(180, fx, o).

% 5 Alínea E

:-op(200, xfx, venceu).

% 6

o Equipa1 venceu o Equipa2 :-
    jogo(_, Equipa1, Equipa2, V-D), V > D, !.

% 7

predX(N, N, _).
predX(N, A, B):-
    !, 
    A \= B,
    A1 is A + sign(B - A),
    predX(N, A1, B).

% Imprime todos os números de A até B se N não estiver instanciado. Se N estiver instanciado apenas verifica se está dentro do intervalo A e B
% O Cut é verde uma vez que não altera os resultados da pesquisa, apenas evita backtracking desnecessário e assim aumenta a eficiência desta (poda do algoritmo)

% 8

%treinador_bom(?Treinador)
treinador_bom(Treinador):-
    treinadores(Equipa, List),
    member([Min-Max]-Treinador, List),
    verify_win(Min, Max, Equipa).

verify_win(N, Max, _):- N > Max, !.
verify_win(N, Max, Equipa):-
    ganhou(N, Equipa, _), !,
    NextN is N + 1,
    verify_win(NextN, Max, Equipa).
verify_win(_, _, _):- !, fail.

% 9

imprime_totobola(1,'1').
imprime_totobola(0,'X').
imprime_totobola(-1,'2').

imprime_texto(1, 'vitoria da casa').
imprime_texto(0, 'empate').
imprime_texto(-1, 'derrota da casa').

%imprime_jogos(+F)
imprime_jogos(F):-
    jogo(Jornada, Equipa1, Equipa2, E1-E2),
    get_final(E1,E2,Sinal),
    Goal =.. [F, Sinal, Result], Goal,
    format('Jornada ~d: ~a x ~a - ~a\n', [Jornada, Equipa1, Equipa2, Result]),
    fail.
imprime_jogos(_).

get_final(V, D, 1):- V > D, !.
get_final(V, V, 0):- !.
get_final(D, V, -1):- V > D, !.

% 10 Alínea E - Pelo functor e o primeiro argumento

% 11 Alínea E - O univ é o único que não é extralógico

% 12

%listar_treinadores(?L)
listar_treinadores(L):-
    findall(Treinador, (treinadores(_, List), member([_-_]-Treinador, List)), L1),
    sort(L1, L).

% 13

%duracao_treinadores(?L)
duracao_treinadores(L):-
    setof(N-T, (listar_treinadores(List), member(T, List), get_years(T, N)), L1),
    reverse(L1, L).

get_years(Treinador, Diff):-
    treinadores(_, List),
    member([A-B]-Treinador, List),
    diff(A,B,Diff).

diff(X, X, 1):- !.
diff(X, Y, D):-
    Y > X, !, 
    D is Y - X + 1.
diff(X, Y, D):- !, diff(Y, X, D).

% 14

pascal(1, [1]) :- !.
pascal(N, L) :-
    N1 is N - 1,
    pascal(N1, L1),
    append([0], L1, L2),
    append(L2, [0], Aux),
    aux_pascal([], L, Aux), !.

aux_pascal(L, L, [_ | []]).
aux_pascal(Acc, L, [Elem1, Elem2 | Rest]) :-
    NewElem is Elem1 + Elem2,
    append(Acc, [NewElem], NewAcc),
    aux_pascal(NewAcc, L, [Elem2 | Rest]).

% Teste 1 Modelo

%participant(ID, Age, Performence)
participant(1234,17,'Pé coxinho').
participant(3423,21,'Programar com os pés').
participant(3788,20,'Sing a Bit').
participant(4865,22,'Pontes de esparguete').
participant(8937,19,'Pontes de pen-drives').
participant(2564,20,'Moodle hack').

%performence(ID, Times)
performence(1234, [120, 120, 120, 120]).
performence(3423, [32, 120, 45, 120]).
performence(3788, [110, 2, 6, 43]).
performence(4865, [120, 120, 110, 120]).
performence(8937, [97, 101, 105, 110]).

% 1

%madeItTrough(+Participant)
madeItTrough(Participant):-
    performence(Participant, Times),
    member(120, Times).

% 2 

%juriTimes(+Participants, +JuriMember, -Times, -Total)
juriTimes(Participants, JuriMember, Times, Total):-
    get_times(Participants, JuriMember, [], Times),
    sum(Times, 0, Total).

sum([], Sum, Sum).
sum([N|R], Acc, Sum):-
    NewAcc is Acc + N,
    sum(R, NewAcc, Sum).

get_times([], _, Times, Times).
get_times([Participant|Resto], Index, Acc, Times):-
    performence(Participant, AllTimes),
    my_index(AllTimes, Index, Time),
    append(Acc, [Time], NewAcc),
    get_times(Resto, Index, NewAcc, Times).

my_index([Element|_], 1, Element).
my_index([_|R], Index, Element):-
    Search is Index - 1,
    my_index(R, Search, Element).

% 3

%patientJuri(+JuriMember)
patientJuri(JuriMember):-
    performence(P1, List1),
    performence(P2, List2),
    P1 \= P2,
    my_index(List1, JuriMember, 120),
    my_index(List2, JuriMember, 120).

% 4

%bestParticipant(+P1, +P2, -P)
bestParticipant(P1, P2, P1):-
    performence(P1, List1), sum(List1, 0, Sum1),
    performence(P2, List2), sum(List2, 0, Sum2),
    Sum1 > Sum2, !.
bestParticipant(P1, P2, P2):-
    performence(P1, List1), sum(List1, 0, Sum1),
    performence(P2, List2), sum(List2, 0, Sum2),
    Sum2 > Sum1, !.
bestParticipant(_, _, _):- !, fail.

% 5

%allPerfs/0
allPerfs:-
    performence(ID, Times),
    participant(ID, _, Description),
    format('~d:~a:', [ID, Description]), write(Times), nl,
    fail.
allPerfs.

% 6 

%nSuccess(-T)
nSuccess(T):-
    findall(Participant, (performence(Participant, Times), win(Times)), List),
    length(List, T).

win([]):- !.
win([120|Rest]):- !, win(Rest).
win(_):- !, fail.

% 7

%juriFans(-List)
juriFans(List):-
    findall(Participant-Juri, (performence(Participant, Times), get_juri(Times, 1, [], Juri)), List).

get_juri([], _, List, List):- !.
get_juri([120|Resto], Index, Acc, List):- !,
    append(Acc, [Index], NewAcc),
    NewIndex is Index + 1,
    get_juri(Resto, NewIndex, NewAcc, List).
get_juri([_|Resto], Index, Acc, List):-
    NewIndex is Index + 1,
    get_juri(Resto, NewIndex, Acc, List).

% 8

eligible(Id, Performence, TT):-
    performence(Id, Times),
    madeItTrough(Id),
    participant(Id, _, Performence),
    sumlist(Times, TT).

%nextPhase(+N, -Participants)
nextPhase(N, Participants):-
    findall(Time-Id-Performence, (participant(Id, _, Performence), eligible(Id, Performence, Time)), All),
    sort(All, S), reverse(S, List),
    append(Participants, _, List), length(Participants, N).

% 9

%pred(Idade, Participantes, Performences)
predX(Q, [R|Rs], [P|Ps]):-
    participant(R, I, P), I =< Q, !,
    predX(Q, Rs, Ps).
predX(Q, [R|Rs], Ps):-
    participant(R, I, _), I > Q,
    predX(Q, Rs, Ps).
predX(_, [], []).

% Verifica se todos os participantes das performences têm idade inferior ou igual a Q.
% O Cut presente é vermelho e ajuda a parar o backtracking na zona onde o predicado-chave (I =< Q) fica satisfeito.

% 10

impoe(X, L):-
    length(Mid, X),
    append(L1, [X|_], L), append(_, [X|Mid], L1).

% Para um número X, o predicado impõe que X esteja entre X elementos

% 11

%langford(+N, -L)
langford(N, L):-
    N2 is N * 2,
    length(L, N2),
    impoe(1, N, L).

impoe(N, N, L):-
    impoe(N, L).
impoe(X, N, L):-
    impoe(X, L),
    XX is X + 1,
    impoe(XX, N, L).

% 12

%substring(+String, ?Substring)
substring(String, String).
substring(String, Substring):-
    append(_, Substring, String).
substring(String, Substring):-
    append(Substring, _, String).
substring(String, Substring):-
    length(String, X),
    length(Substring, A), X >= A,
    append(_, Substring, After),
    append(After, _, String).

% 13

%permutations(+Elements, -ElementsPermutation)
permutations([Element], [Element]):- !.
permutations(List, Permutations):-
    findall(Perm, (
                    member(Element, List), 
                    my_delete(Element, List, NewList), 
                    permutations(NewList, SubPermutations), 
                    member(SubResult, SubPermutations),
                    append([Element], SubResult, Perm)
            ), 
            Permutations).

my_delete(_, [], []):- !.
my_delete(Element, [Element|Resto], Resto):- !.
my_delete(Element, [AnotherElement|Resto], Result):-
    AnotherElement \= Element,
    my_delete(Element, Resto, SubResult),
    append([AnotherElement], SubResult, Result).

% Teste de Modelo - Mesmo teste de 21/22

:- dynamic round/4.

% round(RoundNumber, DanceStyle, Minutes, [Dancer1-Dancer2 | DancerPairs])
% round/4 indica, para cada ronda, o estilo de dança, a sua duração, e os pares de dançarinos participantes.
round(1, waltz, 8, [eugene-fernanda]).
round(2, quickstep, 4, [asdrubal-bruna,cathy-dennis,eugene-fernanda]).
round(3, foxtrot, 6, [bruna-dennis,eugene-fernanda]).
round(4, samba, 4, [cathy-asdrubal,bruna-dennis,eugene-fernanda]).
round(5, rhumba, 5, [bruna-asdrubal,eugene-fernanda]).

% tempo(DanceStyle, Speed).
% tempo/2 indica a velocidade de cada estilo de dança.
tempo(waltz, slow).
tempo(quickstep, fast).
tempo(foxtrot, slow).
tempo(samba, fast).
tempo(rhumba, slow).

% Exercício 1

%style_round_number(?DanceStyle, ?RoundNumber)
style_round_number(DanceStyle, RoundNumber):-
    round(RoundNumber, DanceStyle, _, _).

% Exercício 2

%n_dancers(?RoundNumber, -NDancers)
n_dancers(RoundNumber, NDancers):-
    round(RoundNumber, _, _, List),
    length(List, N),
    NDancers is N * 2.

% Exercício 3

%danced_in_round(?RoundNumber, ?Dancer) 
danced_in_round(RoundNumber, Dancer):-
    round(RoundNumber, _, _, Dancers),
    exists_in(Dancers, Dancer).

exists_in(List, Element):- member(_-Element, List).
exists_in(List, Element):- member(Element-_, List).

% Exercício 4

%n_rounds(-NRounds)
n_rounds(NRounds):-
    n_rounds_aux([], List),
    length(List, NRounds).

n_rounds_aux(Acc, Result):-
    round(N, _, _, _),
    \+member(N, Acc), !,
    append(Acc, [N], NewAcc),
    n_rounds_aux(NewAcc, Result).
n_rounds_aux(Result, Result).

% Exercício 5

% add_dancer_pair(+RoundNumber, +Dancer1, +Dancer2) 
 add_dancer_pair(RoundNumber, Dancer1, Dancer2):-
    round(RoundNumber, X, Y, Dancers),
    \+danced_in_round(RoundNumber, Dancer1),
    \+danced_in_round(RoundNumber, Dancer2),
    retract(round(RoundNumber, X, Y, Dancers)),
    append(Dancers, [Dancer1-Dancer2], NewDancers),
    asserta(round(RoundNumber, X, Y, NewDancers)).

% Exercício 6

%total_dance_time(+Dancer, -Time)
total_dance_time(Dancer, Time):-
    total_dance_aux(Dancer, 0, Time, [], _).

total_dance_aux(Dancer, Acc, Time, AccRounds, Rounds):-
    round(Index, _, Tempo, _),
    danced_in_round(Index, Dancer),
    \+member(Index, AccRounds), !,
    append(AccRounds, [Index], NewAccRounds),
    Acc2 is Acc + Tempo,
    total_dance_aux(Dancer, Acc2, Time, NewAccRounds, Rounds).
total_dance_aux(_, Time, Time, Rounds, Rounds).

% Exercício 7

%print_program/0
print_program:-
    round(_, Style, Time, Dancers),
    length(Dancers, Pairs),
    format('~a (~d) - ~d\n', [Style, Time, Pairs]),
    fail.
print_program.

% Exercício 8

%dancer_n_dances(?Dancer, ?NDances)
dancer_n_dances(Dancer, NDances):-
    round(_, _, _, Something),
    exists_in(Something, Dancer),
    findall(Round-Dancer, (round(Round, _, _, Dancers), exists_in(Dancers, Dancer)), List),
    length(List, NDances).

% Exercício 9

%most_tireless_dancer(-Dancer)
most_tireless_dancer(Result):-
    get_all_dancers(Dancers),
    setof(Time-Dancer, (member(Dancer, Dancers), total_dance_time(Dancer, Time)), Values),
    append(_, [Max-_], Values),
    findall(Dancer, member(Max-Dancer, Values), Result).

get_all_dancers(Result):-
    findall(Dancer, (round(_, _, _, Dancers), exists_in(Dancers, Dancer)), List),
    sort(List, Result).

% Exercício 10

% Sendo +Arg1 uma lista com predicados, predX/2 indica o número de predicados dessa lista que levam exatamente 2 argumentos.

% Exercício 11

% O cut presente é vermelho, uma vez que influencia nos resultados obtidos. Por exemplo, sem ele o mecanismo de backtracking característico do prolog ainda iria encontrar o predicado "predX([_|Xs],N)". 
% Assim, da maneira que está, apenas quando o predicado X não comportar 2 argumentos é que irá para "predX([_|Xs],N)", avançando na pesquisa e avaliando o próximo predicado da lista.

% Exercício 12

% Alínea D -> a unificação produz um número mínimo de substituições para que as condições sejam provadas

% Exercício 13

% Alínea E -> O uso de listas de diferença permite reimplementar certos predicados de complexidade temporal quadrática em tempo linear.

% Exercício 14

:- op(580, xfy, and).

% Exercício 15

:- op(600, xfx, dances).

edge(a,b).
edge(a,c).
edge(a,d).
edge(b,e).
edge(b,f).
edge(c,b).
edge(c,d).
edge(c,e).
edge(d,a).
edge(d,e).
edge(d,f).
edge(e,f).

% Exercício 16

%shortest_safe_path(+Origin, +Destination, +ProhibitedNodes, -Path) 
shortest_safe_path(Origin, Destination, ProhibitedNodes, Path):-
    \+member(Origin, ProhibitedNodes),
    \+member(Destination, ProhibitedNodes),
    get_all_paths(Origin, Destination, ProhibitedNodes, Paths),
    Paths = [Min-_|_],
    findall(P, member(Min-P, Paths), AllMenores),
    member(Path, AllMenores).

get_all_paths(Origin, Destination, ProhibitedNodes, Paths):-
    setof(Length-Path, (get_one_path(Origin, Destination, ProhibitedNodes, [Origin], Path), length(Path, Length)), Paths).

get_one_path(Origin, Destination, _, Acc, Path):-
    edge(Origin, Destination), !,
    append(Acc, [Destination], Path).
get_one_path(Origin, Destination, ProhibitedNodes, Acc, Path):-
    edge(Origin, NextNode),
    \+member(NextNode, ProhibitedNodes),
    \+member(NextNode, Acc),
    append(Acc, [NextNode], NewAcc),
    get_one_path(NextNode, Destination, ProhibitedNodes, NewAcc, Path).

% Exercício 17

%all_shortest_safe_paths(+Origin, +Destination, +ProhibitedNodes, -ListOfPaths)
all_shortest_safe_paths(Origin, Destination, ProhibitedNodes, ListOfPaths):-
    findall(Path, (shortest_safe_path(Origin, Destination, ProhibitedNodes, Path), \+length(Path, 0)), ListOfPaths),
    \+length(ListOfPaths, 0).