% name_of(+Player, -Name)
% Find the Players name
:- dynamic name_of/2.

% difficulty(+Bot,-Difficulty)
% Find the Bot difficulty
:- dynamic difficulty/2.

% water(+Coordinate)
% Find waters coordinate
:- dynamic water/1.

% board(+Size,+Matrix)
% Board structure
board(10, [
        [empty,     empty,      empty,     empty,     lion1,     lion1,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     elephant1, mouse1,    mouse1,    elephant1, empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     elephant2, mouse2,    mouse2,    elephant2, empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     lion2,     lion2,     empty,     empty,     empty,     empty]
]).

board(13, [
        [empty,     empty,      empty,     empty,     empty,     lion1,     lion1,     lion1,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     elephant1, mouse1,    mouse1,    mouse1,    elephant1, empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     elephant1, empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     empty,     elephant2, empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     elephant2, mouse2,    mouse2,    mouse2,    elephant2, empty,     empty,     empty,     empty],
        [empty,     empty,      empty,     empty,     empty,     lion2,     lion2,     lion2,     empty,     empty,     empty,     empty,     empty]
]).

board(16, [
        [empty,     empty,     empty,      empty,     empty,     empty,     lion1,     lion1,     lion1,     lion1,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     elephant1, mouse1,    mouse1,    mouse1,    mouse1,    elephant1, empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     empty,     empty,     elephant1, elephant1, empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     empty,     empty,     elephant2, elephant2, empty,     empty,     empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     elephant2, mouse2,    mouse2,    mouse2,    mouse2,    elephant2, empty,     empty,     empty,     empty,     empty],
        [empty,     empty,     empty,      empty,     empty,     empty,     lion2,     lion2,     lion2,     lion2,     empty,     empty,     empty,     empty,     empty,     empty]
]).

% piece_info(?Type,?Player,+Piece)
% It allows to generalize the type of piece and to know the player that uses it
piece_info(lion, player1, lion1).
piece_info(lion, player2, lion2).
piece_info(elephant, player1, elephant1).
piece_info(elephant, player2, elephant2).
piece_info(mouse, player1, mouse1).
piece_info(mouse, player2, mouse2).
piece_info(water, neutral).
piece_info(empty, neutral).

% fears(+Animal1,+Animal2)
% Checks if Animal1 is afraid of Animal2
fears(lion,elephant).
fears(mouse,lion).
fears(elephant,mouse).

% other_player(+CurrentPlayer,-NextPlayer)
% Change player turn
other_player(player1, player2).
other_player(player2, player1).

% symbol(+Piece,-Symbol)
% Translates the piece to a visible symbol on the board
symbol(lion1, 'L') :- !.
symbol(lion2, 'l') :- !.
symbol(elephant1, 'E') :- !.
symbol(elephant2, 'e') :- !.
symbol(mouse1, 'M') :- !.
symbol(mouse2, 'm') :- !.
symbol(water, '#') :- !.
symbol(empty,' ') :- !.