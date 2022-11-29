# Cut and IO

## Cut

```prolog
% Exemplo de red cut (se removido acaba por não fazer o que é suposto)
not(X):-
    X, !, fail.
not(_Y).

max(A, B, B):- B >= A, !.
max(A, B, A).
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

## Projeto

```note
Algoritmo minimax -> gerar todas as possibilidades (cada nível intercalado por jogador e adversário) e escolher aquela que maximiza pontos. A árvore pode ter vários níveis -> quantos mais níveis, mais o computador explora e mais dificil se torna derrotá-lo.
Para o computador versão fácil -> gerar todas as possibilidades e escolher uma random
Para o computador versão difícil -> gerar todas as possibilidades e escolha a de maior pontos para a jogada do computador e/ou a de menores pontos para a jogada seguinte do jogador humano
```

## Findall, Bagof, Setof

### Findall

Se não encontrar qualquer elemento, acaba por retornar uma lista vazia.

```prolog
% findall(Um elemento possível, teste ao elemento, lista de return com os elementos todos)
findall(Child, parent(homer, Child), Children).
Children = [lisa, bart, maggie] % Não mostra os repetidos
```

### Bagof

Semelhante ao Findall mas se não existir qualquer solução, em vez de mostrar a lista vazia acaba por dar fail.

### Setof

Semelhante ao Setof, mas retira os elementos repetidos e ordena os resultados obtidos