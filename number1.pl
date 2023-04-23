num(0).
num(s(N)) :- num(N).

sum(0,N,N).
sum(s(M), N, s(S)) :- sum(M,N,S).

mult(0,_,0).
mult(s(0),N,N).
mult(s(M),N,P) :- mult(M,N,P1), sum(P1,N,P).

mult(0,_,_,_,0) :- !.
mult(L,L,_,P,P) :- !.
mult(L,Cnt,R,Acc,P) :- sum(Acc,R,AccNext), mult(L, s(Cnt),R,AccNext,P).
mult1(L,R,P) :- mult(L,0,R,0,P).



%size(List,Len)
size([],L,L) :-!.
size([_|T],L,C) :- C1 is C+1,size(T,L,C1).

size(List,Len) :- size(List,Len,0).


%add(L1,L2,L1+L2)
add([],L,L).
add([H|T], L, [H|R]) :- add(T,L,R).
