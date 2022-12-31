:- use_module(library(between)).

% clear_buffer/0
% Clears input buffer
clear_buffer:-
    repeat,
    get_char(C),
    C = '\n'.

% clear_console/0
% Clears console
clear_console:- 
    write('\33\[2J').

% init_random_state/0
% Initialize the random module
init_random_state :-
    now(X),
    setrand(X).

% clear_data/0
% removes all waters, names and difficul from the fact base for the next game
clear_data :-
    retractall(water(_)),
    retractall(n_waters_to_win(_)),
    retractall(difficulty(_, _)),
    retractall(name_of(_, _)).

% get_line(-Result,+Acc)
% Unifies Result with an input line up to endline '\n'
get_line(Result, Acc):-
    get_char(Char),
    Char \= '\n',
    append(Acc, [Char], Acc1),
    get_line(Result, Acc1).
get_line(Result, Acc):-
    atom_chars(Result, Acc).

% abs(+Number,-AbsNumber)
% Unifies AbsNumber with the absolute value of Number
abs(X,X) :- X >= 0, !.
abs(X,Y) :- Y is -X.

% get_name(+Player)
% Asks player name. Dynamically adds the name_of/2 fact to the base fact
get_name(Player):-
    format('Hello ~a, what is your name? ', [Player]),
    get_line(Name, []),
    asserta(name_of(Player, Name)).

% read_number(-Number)
% Unifies Number with input number from console
read_number(X):-
    read_number_aux(X,0).
read_number_aux(X,Acc):- 
    get_code(C),
    between(48, 57, C), !,
    Acc1 is 10*Acc + (C - 48),
    read_number_aux(X,Acc1).
read_number_aux(X,X).

% get_option(+Min,+Max,+Context,-Value)
% Unifies Value with the value given by user input between Min and Max when asked about Context
get_option(Min,Max,Context,Value):-
    format('~a between ~d and ~d: ', [Context, Min, Max]),
    repeat,
    read_number(Value),
    between(Min, Max, Value), !.

% get_move(+Board,-Coordinate)
% Unifies Coordinate with a valid coordinate given by input within the Board
get_move(Board, Col1-Row1-Col2-Row2):-
    length(Board, Size),
    get_option(1, Size, 'Origin column', Col1),
    get_option(1, Size, 'Origin row', Row1),
    get_option(1, Size, 'Destination column', Col2),
    get_option(1, Size, 'Destination row', Row2).

% replace(+Index,+Element,+List,-Result)
% Unifies Result with the list resulting from replace the element at Index of List by Element
replace(Index, Element, List, Result) :-
  nth0(Index, List, _, R),
  nth0(Index, Result, Element, R).

% swap_minimax(+MiniMaxMode, -NewMode)
% Swaps minimax algorithm mode
swap_minimax(min, max).
swap_minimax(max, min).

% eval(+MiniMaxMode, +Values, -Result)
% Unifies Result with the value according to the MiniMax mode
eval(min, [Value|_], Result):- Result is -Value.
eval(max, Values, Value):- last(Values, Value).