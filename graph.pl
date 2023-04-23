e(a,1,2).
e(b,1,3).
e(c,2,3).
e(d,2,4).
e(e,3,5).
e(f,2,5).
e(g,3,4).
e(h,4,5).

edge(M,X,Y) :- e(M,X,Y);e(M,X,Y).

find_path(_,Buff,MaxLen,Sol) :- length(Buff,Len),MaxLen =:= Len, !, Sol = Buff.
find_path(Curr,Buff,MaxLen,Sol) :-  edge(Mark,Curr,Next), \+memberchk(Mark,Buff), find_path(Next,[Curr|Buff],MaxLen,Sol).

find_all_path(V) :- findall(M,e(M,_,_),Ms),length(Ms,Len),find_path(V,[],Len,S),write(S).

