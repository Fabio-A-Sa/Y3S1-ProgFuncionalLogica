# Cut and IO

## Cut

```prolog
% Exemplo de red cut (se removido acaba por não fazer o que é suposto)
not(X):-
    X, !, fail.
not(_Y).
```

## IO

