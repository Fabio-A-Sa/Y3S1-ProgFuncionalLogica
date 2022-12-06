% 2022/12/06

Avaliar as peças dos tabuleiros gerados por todas as combinações possíveis. Respeitar os nomes que estão no enunciado.

```prolog
% Para o bot random 
findall(X0-Y0-X-Y, can_move(Board, X0-Y0-X-Y), L)
L = module(random), com o random_member
```

```prolog
% Para o bot inteligente
setof(Val-X0-Y0-X-Y, (move(Board0, X0-Y0,X-Y, Board), evaluate(Board, Val)), L)
```

