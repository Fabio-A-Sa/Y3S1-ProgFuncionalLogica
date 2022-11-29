# 5 - Database modification

Essencialmente para aumento da eficiência e *debug*:

```prolog
:- dynamic [predicados/N] -> para que os predicados assinalados tenham acesso à memória dinâmica

asserta/1 -> coloca o resultado na base de dados interna, no início
assertz/1 -> coloca o resultado na base de dados interna, no fim

retract/1 -> remove o resultado da base de dados interna
retractall/1 -> remove todos os resultados da base de dados interna
retractall(parent(homer, _)) -> remove todos os predicados que contêm o "homer" como pai

listing/0 -> lista todas as clauses do programa
listing/1 -> lista todas as clauses do predicado dado no argumento
```