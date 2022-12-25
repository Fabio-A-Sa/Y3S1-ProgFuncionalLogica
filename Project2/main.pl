:- use_module(library(lists)).
:- use_module(library(random)).
:- consult(configurations).
:- consult(board).

% validate_move(+Board,+CoordsOrigin,+CoordsDestination)
% Checks if the move is valid or not
validate_move(GameState, ColI-RowI,ColF-RowF) :-
    [Board,Player,FearList,_] = GameState,
    in_bounds(Board,ColI-RowI), in_bounds(Board,ColF-RowF), 
    (member(ColI-RowI, FearList); length(FearList,0)),
    position(Board, ColI-RowI,PieceI), position(Board, ColF-RowF, PieceF),
    \+(piece_info(PieceI, neutral)), piece_info(PieceF, neutral),
    piece_info(PieceType,Player,PieceI),              
    valid_direction(PieceType,ColI-RowI,ColF-RowF),  
    \+path_obstructed(Board,ColI-RowI,ColF-RowF),  
    (\+fears_close(Board, PieceI,ColF-RowF); member(ColI-RowI, FearList)).

% fears_close(+Board,+Piece,+Coords)
% Checks if the Piece fears a piece near Coords
fears_close(Board, Piece, Col-Row) :-
    check_fears(Board, Piece, Col-Row, FearList),
    \+length(FearList,0).

% afraid(+Piece1,+Piece2)
% Checks if Piece1 is afraid of Piece2
afraid(Piece1,Piece2):-
    piece_info(Type1,PlayerA,Piece1),
    piece_info(Type2,PlayerB,Piece2),
    PlayerA \= PlayerB, !,
    fears(Type1,Type2).

% check_fears(+Board,+Piece,+Coords,-FearList)
% Gets the list of positions (FearList) around the position Coords with another piece that Piece fears
check_fears(Board, Piece, Col-Row, FearList):-
    findall(FearPos, check_fears_aux(Board, Piece, Col-Row, FearPos), FearList).

% check_fears(+Board,+Piece,+Coords,-FearList)
% Auxiliary function of check_fears. Checks fears around an animal at position Col-Row
check_fears_aux(Board, Piece1, Col-Row, FearPos):-
    between(-1,1,I), between(-1,1,J),
    ColTarget is Col+I, RowTarget is Row+J,
    in_bounds(Board, ColTarget-RowTarget),
    position(Board, ColTarget-RowTarget, Piece2),
    afraid(Piece1, Piece2),
    FearPos = ColTarget-RowTarget.

% orthogonal_move(+PosOrigin,+PosDestination)
% Checks if the move is orthogonal
orthogonal_move(Col-_,Col-_).
orthogonal_move(_-Row,_-Row).

% diagonal_move(+PosOrigin,+PosDestination)
% Checks if the move is diagonal
diagonal_move(ColI-RowI,ColF-RowF) :-
    ColDif is ColF-ColI, RowDif is RowF-RowI,
    abs(ColDif,AbsDif), abs(RowDif,AbsDif).

% valid_direction(+PieceType,+PosOrigin,+PosDestination)
% Checks if the direction of the move is valid
valid_direction(mouse,ColI-RowI,ColF-RowF) :-
    orthogonal_move(ColI-RowI,ColF-RowF).
valid_direction(lion,ColI-RowI,ColF-RowF) :-
    diagonal_move(ColI-RowI,ColF-RowF).
valid_direction(elephant,ColI-RowI,ColF-RowF) :-
    orthogonal_move(ColI-RowI,ColF-RowF); diagonal_move(ColI-RowI,ColF-RowF).

% path_obstructed(+Board,+PosOrigin,+PosDestination)
% Checks if there is a piece between the two positions of the move
path_obstructed(Board, ColI-RowI,ColF-RowF) :-
    DeltaCol is ColF-ColI, DeltaRow is RowF-RowI,
    move_direction(DeltaCol-DeltaRow,HorDir,VerDir),
    \+path_obstructedAux(Board, ColI-RowI,ColF-RowF,HorDir-VerDir).

% path_obstructedAux(+Board,+PosOrigin,+PosDestination,+Direction)
% Auxiliary function of path_obstructed.
path_obstructedAux(_,Col-Row,Col-Row,_) :- !.
path_obstructedAux(Board,ColI-RowI,ColF-RowF,HorDir-VerDir) :-
    NewCol is ColI + HorDir, NewRow is RowI + VerDir,
    position(Board,NewCol-NewRow,Piece),
    piece_info(Piece, neutral), !,
    path_obstructedAux(Board,NewCol-NewRow,ColF-RowF,HorDir-VerDir).

% move_direction(+MoveVector,-HorDir,-VerDir) :-
% Given a move, gives the horizontal and vertical direction with both forming a unit vector
move_direction(0-DeltaRow,0,-1) :-          %Top Move
    DeltaRow < 0, !.
move_direction(0-DeltaRow,0,1):-            %Bottom Move
    DeltaRow > 0, !.
move_direction(DeltaCol-0,-1, 0) :-         %Left Move
    DeltaCol < 0, !.
move_direction(DeltaCol-0,1, 0) :-          %Right Move
    DeltaCol > 0, !.
move_direction(DeltaCol-DeltaRow,-1,-1) :-  %Top-Left move
    (DeltaCol < 0, DeltaRow < 0), !.
move_direction(DeltaCol-DeltaRow,1,-1) :-   %Top-Right move
    (DeltaCol > 0, DeltaRow < 0), !.
move_direction(DeltaCol-DeltaRow,-1,1) :-   %Bottom-Left move
    (DeltaCol < 0, DeltaRow > 0), !.
move_direction(DeltaCol-DeltaRow,1,1) :-    %Bottom-Right move
    (DeltaCol > 0, DeltaRow > 0), !.

% count_waters(+Board, +Player, -Number)
% Gets the number of water the Player currently controls
count_waters(Board, Player, Number):-
    findall(1, (water(Coordinate), piece_info(_, Player, Piece), position(Board, Coordinate, Piece)), Waters),
    length(Waters,Number).

% winnerMoves(Moves, WinnerMoves)
% Given the total number of moves in a game, gets the number of moves the winner made
winner_moves(Moves, WinnerMoves):-
    Moves mod 2 =:= 1,
    WinnerMoves is (Moves // 2) + 1, !.
winner_moves(Moves, WinnerMoves):-
     WinnerMoves is Moves // 2.

% show_winner(+GameState, +Winner)
% Prints the winner of the game and number of moves they made
show_winner([_,_,_,TotalMoves], Winner):-
    name_of(Winner, Name),
    winner_moves(TotalMoves, WinnerMoves),
    format('Winner is ~a with ~d moves!\n', [Name, WinnerMoves]).

% game_cycle(+GameState)
% Loop that keeps the game running
game_cycle(GameState):-
    game_over(GameState, Winner), !,
    display_game(GameState),
    show_winner(GameState, Winner).
game_cycle(GameState):-
    display_game(GameState),
    print_turn(GameState),
    choose_move(GameState, Move),
    move(GameState, Move, NewGameState), !,
    game_cycle(NewGameState).

% forced_moves(+Board, +NewPlayer, -ForcedMoves)
% Gets the positions with a piece that the next player will be forced move
forced_moves(Board, NewPlayer, ForcedMoves) :-
    findall(Col-Row, (in_bounds(Board, Col-Row), piece_info(_,NewPlayer,Piece),position(Board,Col-Row,Piece)), AllPositions),
    forced_moves_aux(Board,AllPositions,[],ForcedMoves).

% forced_moves_aux(+Board,+AllPositions,+Acc,-ForcedMoves)
% Auxiliary function of forced_moves
forced_moves_aux(_,[],Acc,Acc).
forced_moves_aux(Board,[H|T],Acc,ForcedMoves):-
    position(Board,H,Piece),
    findall(H, check_fears_aux(Board, Piece, H, _), FearList),
    append(Acc,FearList, Acc1),
    forced_moves_aux(Board, T, Acc1, ForcedMoves).

% check_forced_moves(+PosOrigin,+ForcedMoves)
% Checks if the starting position has a piece thats is forced to move (if there are any forced moves)
check_forced_moves(ColI-RowI,ForcedMoves):-
    (member(ColI-RowI,ForcedMoves); length(ForcedMoves,0)), !.
check_forced_moves(_,_):-
    write('You have to move a piece that is afraid!\n'), fail.

% print_turn(+GameState)
% Prints a message declaring whose turn it is
print_turn([_, Player, _, _]):-
    name_of(Player, Name),
    format('Player ~a, is your turn!\n', [Name]), !.

% display_game(+GameState)
% Prints the board
display_game([Board,_,_,_]) :-
    clear_console,
    length(Board, Size),
    display_header(1, Size),
    display_bar(Size),
    display_rows(Board, 1, Size).

% move(+GameState, +Move, -NewGameState)
% Moves a piece
move(GameState, ColI-RowI-ColF-RowF, NewGameState):-                       
    [Board,Player,_,TotalMoves] = GameState,
    position(Board,ColI-RowI,Piece),
    put_piece(Board, ColI-RowI, empty, NewBoard1),
    put_piece(NewBoard1, ColF-RowF, Piece, NewBoard),
    other_player(Player, NewPlayer),
    forced_moves(NewBoard, NewPlayer, NewForcedMoves),
    NewTotalMoves is TotalMoves + 1,
    NewGameState = [NewBoard,NewPlayer,NewForcedMoves,NewTotalMoves].

% valid_moves(+GameState, +Player, -ListOfMoves)
% Gets all the valid moves of the given player
valid_moves(GameState, _, ListOfMoves):-
    findall(ColI-RowI-ColF-RowF, validate_move(GameState,ColI-RowI,ColF-RowF),ListOfMoves),
    \+length(ListOfMoves, 0), !.
valid_moves(GameState, Player, ListOfMoves):-
    [Board,Player,_,TotalMoves] = GameState,
    findall(ColI-RowI-ColF-RowF, validate_move([Board,Player,[],TotalMoves],ColI-RowI,ColF-RowF),ListOfMoves).

% game_over(+GameState, +Winner)
% Checks if the game is over
game_over([Board,OtherPlayer,_, _], Winner):-
    n_waters_to_win(NWatersToWin),
    other_player(OtherPlayer, Winner),
    count_waters(Board, Winner, NWatersToWin).

% value(+GameState,+Player,-Value)
% Gets the value of the current board for minimax algorithm
value([Board,OtherPlayer,ForcedMoves,_], Player, Value):-
    count_waters(Board, Player, Waters),
    count_waters(Board, OtherPlayer, EnemyWaters),
    WaterDiff is Waters-EnemyWaters,
    value_forced_moves(WaterDiff, ForcedMoves, 0, ForcedMovesVal),
    check_directions(Board,Player,WatersReachable),
    Value is 100*WaterDiff + ForcedMovesVal + WatersReachable.

% value_forced_moves(+WaterDiff,+ForcedMoves,+Acc,-Number)
% Gets the value of the forced moves, taking into account the difference in captured waters between the 2 players
value_forced_moves(_, [], Acc, Acc).
value_forced_moves(WaterDiff,[H|T], Acc, Number) :-
    water(H),
    Acc1 is Acc + 95 - WaterDiff*30,
    value_forced_moves(WaterDiff, T, Acc1, Number), !.
value_forced_moves(WaterDiff, [_|T], Acc, Number):-
    Acc1 is Acc + 1,
    value_forced_moves(WaterDiff, T, Acc1, Number), !.

% check_directions(+Board,+Player,-Result)
% Unifies Result with the amount of Player animals that are in line with an unoccupied water
check_directions(Board,Player,Result):-
    findall(1,( piece_info(Type1,Player,Piece1), 
                in_bounds(Board,ColI-RowI),
                position(Board,ColI-RowI,Piece1),
                water(ColF-RowF),
                position(Board,ColF-RowF,water), % Water position is not filled by another piece
                valid_direction(Type1,ColI-RowI,ColF-RowF), 
                \+path_obstructed(Board,ColI-RowI,ColF-RowF)),
            List),
    length(List, Result).

% choose_move(+GameState,+Player,+Level,-Move)
% Choose move a human player
choose_move([Board,Player,ForcedMoves,TotalMoves], ColI-RowI-ColF-RowF):-
    \+difficulty(Player, _),                    
    repeat,
    get_move(Board, ColI-RowI-ColF-RowF),                 
    check_forced_moves(ColI-RowI,ForcedMoves),
    validate_move([Board,Player,ForcedMoves,TotalMoves], ColI-RowI, ColF-RowF), !.  
choose_move([Board,Player,ForcedMoves,TotalMoves], Move):-
    difficulty(Player, Level),                  
    choose_move([Board,Player,ForcedMoves,TotalMoves], Player, Level, Move), !.   

% choose_move(+GameState,+Player,+Level,-Move)
% Bot random player. Makes a list of possible moves and select a random one
choose_move(GameState, Player, 1, ColI-RowI-ColF-RowF):- 
    valid_moves(GameState, Player, ListOfMoves),
    random_member(ColI-RowI-ColF-RowF, ListOfMoves).

% choose_move(+GameState,+Player,+Level,-Move)
% Bot greedy player. Makes a list of possible moves and select the one with the most points according minimax algorithm
choose_move(GameState, Player, 2, ColI-RowI-ColF-RowF):-
	valid_moves(GameState, Player, ListOfMoves),
    other_player(Player, NewPlayer),
	findall(Value-Coordinate, ( member(Coordinate, ListOfMoves), 
                                move(GameState, Coordinate, NewGameState), 
                                value(NewGameState,Player, Value1),
                                minimax(NewGameState, NewPlayer, min, 1, Value2),
                                Value is Value1 + Value2), Pairs),
    sort(Pairs, SortedPairs),
    last(SortedPairs, Max-_),
    findall(Coordinates, member(Max-Coordinates, SortedPairs), MaxCoordinates),
    random_member(ColI-RowI-ColF-RowF, MaxCoordinates).

% minimax(+GameState, +Player, +Type, +Level, -Value)
% Minimax algorithm with depth 2
minimax(_, _, _, 2, 0):- !.
minimax(GameState, Player, Type, Level, Value):-
	other_player(Player, NewPlayer),
	swap_minimax(Type, NewType),
    NextLevel is Level + 1,
	valid_moves(GameState, Player, ListOfMoves),
	setof(Val, (  member(Coordinate, ListOfMoves), 
                  move(GameState, Coordinate, NewGameState), 
                  value(NewGameState,Player,Value1),
                  minimax(NewGameState, NewPlayer, NewType, NextLevel, Value2), 
                  Val is Value1 + Value2), Values),
    eval(Type, Values, Value).

% play/0
% Starts the game and clears data when it ends 
play :-
    configurations(GameState), !,
    game_cycle(GameState),
    clear_data.