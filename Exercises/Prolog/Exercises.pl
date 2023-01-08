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

