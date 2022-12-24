% 2022/11/15

mya([], L, L).
mya([H|T], L2, [H|T3]):- 
    mya(T, L2, T3).