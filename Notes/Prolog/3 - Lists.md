# Lists

```prolog
append(L1, L2, L)               % Faz concatenação de duas listas, colocando o resultado no terceiro argumento. O(L1).
member(X, L)                    % Verifica se X está presente na lista L (flexível)
memberchk(X,                    % Verifica se X está presente na lista L (fixo)
length(?L, ?N)                  % O comprimento da lista. Pode ser usada para gerar números de 0 até infinito, usando length(_, N).
sort(+L, ?Ordered)              % Este predicado primeiro remove os duplicados de uma lista
keysort(+L, ?Ordered)           % Ordena uma lista de pares do tipo A-B através das chaves

:- use_module(library(list))

nth0(?N, ?L, ?X)                % Coloca em X o valor de L na posição X
select(?X, ?XList, ?Y, ?YList) 
append(+ListOfLists, -List)
```