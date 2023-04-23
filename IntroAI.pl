isDivisible(Number, Divisor):-
  Number mod Divisor =:= 0, !.
isDivisible(Number, Divisor):-
  Divisor * Divisor =< Number,
  NextDivisor is Divisor + 1,
  isDivisible(Number, NextDivisor).

isPrime(2):-!.
isPrime(Number):-
  Number > 0,
  not(isDivisible(Number, 2)).

pal(List) :- reverse(List,RevList),pal1(List,RevList).
pal1([H1|T1],[H1|T2]) :- pal1(T1,T2).
pal1([],[]) :- !.



