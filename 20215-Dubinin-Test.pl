%says(A, S)
%S = (A = khight)
%S = (A = knave)




says(knight, S) :- S.
says(knave, S) :- false(S).

