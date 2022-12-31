:- use_module(library(lists)).
:- consult(data).
:- consult(utils).

% put_piece(+Board,+Coordinate,+Piece,-NewBoard).
% Unifies NewBoard with a matrix representing the placement of Piece on Board in Col-Row coordinates
put_piece(Board, Col-Row, empty, NewBoard) :-
    water(Col-Row), !,
    put_piece(Board, Col-Row, water, NewBoard).
put_piece(Board, Col-Row, Piece, NewBoard) :-
    RowIndex is Row - 1, ColIndex is Col - 1,
    nth0(RowIndex,Board,Line),
    replace(ColIndex, Piece, Line, NewLine),
    replace(RowIndex, NewLine, Board, NewBoard).

% position(+Board,+Coordinate,-Piece)
% Unites Piece with the piece on the board at those coordinates
position(Board, Col-Row, Piece) :- 
    \+water(Col-Row),
    nth1(Row, Board, Line),
    nth1(Col, Line, Piece), !.
position(Board, Col-Row, Piece) :- 
    water(Col-Row),
    nth1(Row, Board, Line),
    nth1(Col, Line, Piece),
    Piece \= empty, Piece \= water, !.
position(_, Col-Row, water) :- water(Col-Row), !.

% in_bounds(+Board,+Coordinate)
% Checks if calculated coordinate is inside Board
in_bounds(Board, Col-Row) :-
    length(Board, Size),
    between(1, Size, Col),
    between(1, Size, Row).

% display_bar(+Size)
% Displays the pattern '|---|---|-...' with fixed length
display_bar(0):-
    write('|\n'), !.
display_bar(N):-
    write('|---'),
    N1 is N - 1,
    display_bar(N1).

% display_header(+Size)
% Displays the pattern '1  2  3  4...' with fixed length
display_header(Max, Max):-
    format('~d\n  ', [Max]), !.
display_header(1, Max):-
    write('\n    1   '),
    display_header(2, Max), !.
display_header(N, Max):-
    N > 9,
    format('~d  ', [N]),
    Next is N + 1,
    display_header(Next, Max).
display_header(N, Max):-
    format('~d   ', [N]),
    Next is N + 1,
    display_header(Next, Max).

% get_symbol(+Board,+Line,+Col,-Symbol)
% Unites Symbol with the part symbol in the Col-Line coordinate of Board
get_symbol(Board, Line, Col, Symbol):-
    position(Board,Col-Line,Piece),
    symbol(Piece, Symbol).

% display_pieces(+Board,+Line,+Col,+Size)
% Displays the Board piece in Line-Col coordinates
display_pieces(_, _, Col, Size):- 
    Col > Size, write('\n  '), !.
display_pieces(Board, Line, Col, Size):-
    get_symbol(Board, Line, Col, Symbol),
    format(' ~a |', [Symbol]),
    NextCol is Col + 1,
    display_pieces(Board, Line, NextCol, Size).

% display_rows(+Board,+Line,+Size)
% Displays one line of the board
display_rows(_, Line, Size):- 
    Line > Size, nl, !.
display_rows(Board, Line, Size):-
    Line > 9,
    format('~d|', [Line]),
    display_pieces(Board, Line, 1, Size),
    display_bar(Size),
    NextLine is Line + 1,
    display_rows(Board, NextLine, Size), !.
display_rows(Board, Line, Size):-
    format('~d |', [Line]),
    display_pieces(Board, Line, 1, Size),
    display_bar(Size),
    NextLine is Line + 1,
    display_rows(Board, NextLine, Size).

% fill_water(+Board)
% Considering the size of Board, it updates the fact base with water/1.
fill_water(10):-
    asserta((water(4-4))),
    asserta((water(4-7))),
    asserta((water(7-4))),
    asserta((water(7-7))), 
    asserta((n_waters_to_win(3))), !.
fill_water(13):-
    asserta((water(5-5))),
    asserta((water(5-9))),
    asserta((water(9-5))),
    asserta((water(9-9))),
    asserta((water(7-7))), 
    asserta((n_waters_to_win(4))), !.
    
fill_water(16):-
    asserta((water(5-5))),
    asserta((water(5-12))),
    asserta((water(12-5))),
    asserta((water(12-12))),
    asserta((water(7-7))),
    asserta((water(10-10))),
    asserta((n_waters_to_win(5))), !.

% init_state(+Size,-Board)
% Unifies Board with a Size matrix that represents the game: animals and empty pieces
init_state(Size, Board):-
    board(Size, Board),
    fill_water(Size).