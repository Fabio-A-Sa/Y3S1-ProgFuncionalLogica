% 2022/11/22

% Exercício 1

s(1).
s(2):- !.
s(3).

% a) X = 1, X = 2
% b) X = 1, Y = 1 ; X = 1, Y = 2 ; X = 2, Y = 1 ; X = 2, Y = 1
% c) X = 1, Y = 1 ; X = 1, Y = 2

% Exercício 2

data(one).
data(two).
data(three).
cut_test_a(X):- data(X).
cut_test_a('five').
cut_test_b(X):- data(X), !.
cut_test_b('five').
cut_test_c(X, Y):- data(X), !, data(Y).
cut_test_c('five', 'five').

% a) one, two, three, five
% b) one
% c) one-one, one-two, one-three

% Exercício 3

% Em immature/1 o cut usado é vermelho, pois influencia nos resultados obtidos pelo predicado
% Em adult/1 o cut usado é verde pois trava o backtracking do prolog por motivos de eficiência de pesquisa

% Exercício 4

% 4.a

%print_n(+S, +N)
print_n(_, 0).
print_n(Symbol, N):-
    write(Symbol),
    Next is N - 1,
    print_n(Symbol, Next).

% 4.b

%print_text(+Text, +Symbol, +Padding)
print_text(Text, Symbol, Padding):-
    write(Symbol),
    print_n(' ', Padding),
    text(Text),
    print_n(' ', Padding),
    write(Symbol), nl.

text([]).
text([H|T]):-
    put_code(H),
    text(T).

% 4.c

print_banner(Text, Symbol, Padding):-
    length(Text, Len),
    TotalLength is Len + 2*Padding + 2,
    Spaces is TotalLength - 2,
    print_n(Symbol, TotalLength), nl, print_n(Symbol, 1),
    print_n(' ', Spaces), print_n(Symbol, 1), nl,
    print_n(Symbol, 1), print_n(' ', Padding), text(Text), print_n(' ', Padding), print_n(Symbol, 1), nl,
    print_n(Symbol, 1), print_n(' ', Spaces), print_n(Symbol, 1), nl,print_n(Symbol, TotalLength), nl.

% 4.d

%read_number(-X)
read_number(X):-
    read_number_aux(0, X).

read_number_aux(Acc, X):-
    get_code(C),
    C >= 48,
    C =< 57, !,
    NextAcc is Acc * 10 + (C - 48),
    read_number_aux(NextAcc, X).
read_number_aux(Acc, Acc).

% 4.e

%read_until_between(+Min, +Max, -Value)
read_until_between(Min, Max, Value):-
    repeat,
    read_number(Value),
    Min =< Value,
    Max >= Value.

% 4.f

%read_string(-X)
read_string(X):-
    read_string_aux([], X).

read_string_aux(List, Result):-
    get_code(C),
    C \= 10, !,
    append(List, [C], AnotherList),
    read_string_aux(AnotherList, Result).
read_string_aux(String, String).

% 4.g

banner:-
    write('Some text: '),
    read_string(Text),
    write('Symbol: '),
    get_char(C), 
    write('Paddind between 1 and 10: '),
    read_until_between(1, 10, Padding), nl,
    print_banner(Text, C, Padding).

% 4.h

%print_multi_banner(+ListOfTexts, +Symbol, +Padding)
print_multi_banner(ListOfTexts, Symbol, Padding):-
    getMax(ListOfTexts, -1, Max),
    TotalLength is Max + 2*Padding + 2,
    MinLength is TotalLength - 2,
    print_n(Symbol, TotalLength), nl, print_n(Symbol, 1), print_n(' ', MinLength), print_n(Symbol, 1), nl,
    print_texts(ListOfTexts, Max, Padding, Symbol),
    print_n(Symbol, 1), print_n(' ', MinLength), print_n(Symbol, 1), nl, print_n(Symbol, TotalLength), nl.

getMax([], Result, Result).
getMax([H|T], Acc, Result):-
    length(H, Attemp),
    Attemp >= Acc, !,
    getMax(T, Attemp, Result).
getMax([_|T], Acc, Result):-
    getMax(T, Acc, Result).

print_texts([], _, _, _):- !.
print_texts([Text|Tail], Max, Padding, Symbol):-
    length(Text, TextLength),
    Spaces is (Max - TextLength)//2 + Padding,
    print_n(Symbol, 1), print_n(' ', Spaces), 
    text(Text),
    print_n(' ', Spaces), print_n(Symbol, 1), nl, !, 
    print_texts(Tail, Max, Padding, Symbol).

% 4.i

%oh_christmas_tree(+N)
oh_christmas_tree(N):- tree(0, N).

tree(Max, Max):-
    Padding is (Max*2 + 1) // 2,
    print_n(' ', Padding), print_n('*', 1), !.
tree(N, Max):-
    Stars is N*2 + 1,
    MaxStars is Max*2 + 1,
    Padding is (MaxStars - Stars) // 2,
    print_n(' ', Padding), print_n('*', Stars), nl,
    NextTree is N + 1,
    tree(NextTree, Max).

% Exercise 5

male(frank).
male(jay).
male(javier).
male(merle).
male(phil).
male(mitchell).
male(joe).
male(pameron).
male(bo).
male(dylan).
male(luke).
male(rexford).
male(calhoun).
male(george).

female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(manny).
female(cameron).
female(haley).
female(alex).
female(lily).
female(poppy).

parent(grace,phil).
parent(frank,phil).
parent(dede,claire).
parent(jay,claire).
parent(dede,mitchell).
parent(jay,mitchell).
parent(jay,joe).
parent(gloria,joe).
parent(gloria,manny).
parent(javier,manny).
parent(barb,cameron).
parent(merle,cameron).
parent(barb,pameron).
parent(merle,pameron).
parent(phil, haley).
parent(claire, haley).
parent(phil, alex).
parent(claire, alex).
parent(phil, luke).
parent(claire, luke).
parent(mitchell, lily).
parent(mitchell, rexford).
parent(cameron, lily).
parent(cameron, rexford).
parent(pameron, calhoun).
parent(bo, calhoun).
parent(dylan, george).
parent(dylan, poppy).
parent(haley, george).
parent(haley, poppy).

% 5.a

%children(+Person, -Children)
children(Person, Children):-
    findall(Child, parent(Child, Person), Children).

% 5.b

%children_of(+ListOfPeople, -ListOfPairs)
children_of(ListOfPeople, ListOfPairs):-
    findall(Parent-Child, (member(Parent, ListOfPeople),parent(Child, Parent)), ListOfPairs).

% 5.c

%family(-F)
family(Family):-
    setof(Person,(male(Person) ; female(Person)), Family).

% 5.d

%couple(?C)
couple(C):-
    setof(Mother-Father, (parent(_X, Mother), female(Mother), parent(_X, Father), male(Father)), AllCouples),
    member(C, AllCouples).

% 5.e

%couples(-List)
couples(List):-
    findall(Couple, couple(Couple) ,List).

% 5.f

%spouse_children(+Person, -SC) 
spouse_children(Person, SC):-   
    setof(Spouse-Children, (parent(_X, Person), parent(_X, Spouse), Person \= Spouse, children(Spouse, Children)), SC).

% 5.g

%immediate_family(+Person, -PC)
immediate_family(Person, PC):-
    findall(Parents-Children, (parents(Person, Parents), spouse_children(Person,Children)), PC).

parents(Person, All):-
    setof(Parent, parent(Parent, Person), All).

% 5.h

parents_of_two(Parents):-
    setof(Person, (_X, _Y)^(parent(_X, Person), parent(_Y, Person), _X \= _Y), Parents).

% Exercício 6

leciona(adalberto, algoritmos).
leciona(bernardete, basesdedados).
leciona(capitolino, compiladores).
leciona(diogenes, estatistica).
leciona(ermelinda, redes).

frequenta(alberto, algoritmos).
frequenta(bruna, algoritmos).
frequenta(cristina, algoritmos).
frequenta(diogo, algoritmos).
frequenta(eduarda, algoritmos).
frequenta(antonio, basesdedados).
frequenta(bruno, basesdedados).
frequenta(cristina, basesdedados).
frequenta(duarte, basesdedados).
frequenta(eduardo, basesdedados).
frequenta(alberto, compiladores).
frequenta(bernardo, compiladores).
frequenta(clara, compiladores).
frequenta(diana, compiladores).
frequenta(eurico, compiladores).
frequenta(antonio, estatistica).
frequenta(bruna, estatistica).
frequenta(claudio, estatistica).
frequenta(duarte, estatistica).
frequenta(eva, estatistica).
frequenta(alvaro, redes).
frequenta(beatriz, redes).
frequenta(claudio, redes).
frequenta(diana, redes).
frequenta(eduardo, redes).
frequenta(xico, redes).

% 6.a

%teachers(-T)
teachers(T):-
    setof(Teacher, UC^leciona(Teacher, UC) , T).

% 6.b
% A implementação apresentada já elimina os duplicados
% Porque recorri ao setof

% 6.c

%students_of(+T, -S)
students_of(T, S):-
    setof(Student, UC^(leciona(T, UC), frequenta(Student, UC)), S).

% 6.d

%teachers_of(+S, -T)
teachers_of(S, T):-
    setof(Teacher, UC^(leciona(Teacher, UC), frequenta(S, UC)), T).

% 6.e

%common_courses(+S1, +S2, -C)
common_courses(S1, S2, C):-
    findall(UC, (S1, S2)^(frequenta(S1, UC), frequenta(S2, UC)), C).

% 6.f

% more_than_one_course(-L)
more_than_one_course(L):-
    setof(Student, (UC1, UC2)^(frequenta(Student, UC1), frequenta(Student, UC2), UC1 \= UC2) , L).

% 6.g

%strangers(-L)
strangers(L):-
    findall(S1-S2, (frequenta(S1, _), frequenta(S2, _), common_courses(S1, S2, UCs), length(UCs, 0)), L).

% 6.h

%good_groups(-L)
good_groups(L) :-
    setof(S1-S2, (UC1, UC2, UCs, Len)^(frequenta(S1, UC1), frequenta(S2, UC2), common_courses(S1, S2, UCs), S1 @< S2, length(UCs, Len), Len > 1), L).

% Exercício 7

%class(Course, ClassType, DayOfWeek, Time, Duration)
class(pfl, t, '1 Seg', 11, 1).
class(pfl, t, '4 Qui', 10, 1).
class(pfl, tp, '2 Ter', 10.5, 2).
class(lbaw, t, '1 Seg', 8, 2).
class(lbaw, tp, '3 Qua', 10.5, 2).
class(ltw, t, '1 Seg', 10, 1).
class(ltw, t, '4 Qui', 11, 1).
class(ltw, tp, '5 Sex', 8.5, 2).
class(fsi, t, '1 Seg', 12, 1).
class(fsi, t, '4 Qui', 12, 1).
class(fsi, tp, '3 Qua', 8.5, 2).
class(rc, t, '4 Qui', 8, 2).
class(rc, tp, '5 Sex', 10.5, 2).

% 7.a

%same_day(+UC1, +UC2)
same_day(UC1, UC2):-
    class(UC1, _, _Day, _, _),
    class(UC2, _, _Day, _, _).

% 7.b

%daily_courses(+Day, -Courses)
daily_courses(Day, Courses):-
    findall(UC, Day^class(UC, _, Day, _, _), Courses).

% 7.c

%short_classes(-L)
short_classes(L):-
    findall(UC-Dia/Hora, (class(UC, _, Dia, Hora, Duration), Duration < 2), L).

% 7.d

%course_classes(+Course, -Classes)
course_classes(Course, Classes):-
    findall(Dia/Hora-Tipo, class(Course, Tipo, Dia, Hora, _) , Classes).

% 7.e

%courses(-L)
courses(L):-
    setof(UC, (A, B, C, D)^class(UC, A, B, C, D), L).

% 7.f

%schedule/0
schedule:-
    setof(Key1-Key2-(Course-Tipo-Key1-Key2-Duration), class(Course, Tipo, Key1, Key2, Duration), Values),
    print_courses(Values).

print_courses([]).
print_courses([Key1-Key2-(Course-Tipo-Key1-Key2-Duration)|Tail]):-
    format('~a ~a ~a ~1f ~d', [Course, Tipo, Key1, Key2, Duration]), nl,
    print_courses(Tail).

% 7.g

%traduz(+UglyDay,-Day)
traduz('1 Seg', seg).
traduz('2 Ter', ter).
traduz('3 Qua', qua).
traduz('4 Qui', qui).
traduz('5 Sex', sex).

% 7.h

%find_class/0
find_class:-
    repeat,
    write('Day: '),
    read(Day1),
    traduz(Day, Day1),
    write('Hour: '),
    read(Hour),
    class(UC, _, Day, Begin, Duration),
    Final is Begin + Duration,
    Hour >= Begin,
    Hour =< Final,
    format('~a ~1f ~d', [UC, Begin, Duration]). 

% 7.i

%person(-X)
person(X):-
    male(X) ; female(X).

%imprime_pessoas/0
imprime_pessoas:-
    person(X),
    write(X), nl,
    fail.
imprime_pessoas.