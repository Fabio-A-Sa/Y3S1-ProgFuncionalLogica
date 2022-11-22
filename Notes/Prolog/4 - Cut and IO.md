# Cut and IO

## Cut

```prolog
% Exemplo de red cut (se removido acaba por não fazer o que é suposto)
not(X):-
    X, !, fail.
not(_Y).
```

## IO

```prolog
getPiece(+Board, +Line, +Column, -Piece).
setPiece(+BoardIN, +Line, +Column, +Piece, -BoardOUT).
move(+BoardIN, +LineIN, +ColumnIN, +LineOUT, +ColumnOUT, -BoardOUT).

repeat.
repeat :-
    repeat.
    
main :-
    % initialization, names, quem é primeiro, criar um board...
    repeat,
    getStatus(CurrentPlayer, CurrentBoard), % Implementação interna com cut
    play(CurrentPlayer, CurrentBoard, NextPlayer, NextBoard),  % Implementação interna com cut
    store(NextPlayer, NextBoard),  % Implementação interna com cut
    finish(NextBoard)  % Implementação interna com cut
    showWinnner.
```