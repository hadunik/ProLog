/*
 * Excercises 4.1 Peano Arithmetic
 *
 */

% Basis
num(0).
num(s(N)) :- num(N).

% Converting common numbers to Peano notation and vice versa
convert(0, _, _, 0) :- !.
convert(Common, Common, Peano, Peano) :- !.
convert(Common, Counter, Buff, Peano) :- CntNext is Counter + 1, convert(Common, CntNext, s(Buff), Peano).
convert(Common, Peano) :- convert(Common, 0, 0, Peano).

% Summation
sum(0, N, N).
sum(s(M), N, s(S)) :- sum(M, N, S).
sum_(A, B, Sum) :- var(Sum), convert(A, Pa), convert(B, Pb), sum(Pa, Pb, Ps), convert(Sum, Ps), !.
sum_(A, B, Sum) :- var(A), convert(B, Pb), convert(Sum, Ps), sum(Pa, Pb, Ps), convert(A, Pa), !.
sum_(A, B, Sum) :- var(B), convert(A, Pa), convert(Sum, Ps), sum(Pa, Pb, Ps), convert(B, Pb), !.

% Multiplication
% A simple and dumb solution lies just below, but we
% want a tail recursive solution, which is a bit lower.
% mult(0, _, 0) :- !.
% mult(s(M), N, P) :- mult(M, N, P1), sum(P1, N, P).

mult(0, _, _, _, 0) :- !.	% multiplication to zero returns zero
mult(L, L, _, Prod, Prod) :- !.	% when counter is equal to the left multiplier then stop and say that the result is equal to the accumulator
mult(L, Cnt, R, Acc, Prod) :- sum(Acc, R, AccNext), mult(L, s(Cnt), R, AccNext, Prod).
mult(Left, Right, Prod) :- mult(Left, 0, Right, 0, Prod).
mult_(A, B, P) :- convert(A, Pa), convert(B, Pb), mult(Pa, Pb, Pp), convert(P, Pp).

% Exponentiation
% No-tail solution:
% exp(s(_), 0, s(0)).
% exp(0, s(_), 0).
% exp(X, s(N), E) :- exp(X, N, E1), mult(E1, X, E).
exp(0, _, s(_), _, s(0)) :- !. % any number (which is greater than zero) to the power of 0 is one
exp(s(_), _, 0, _, 0) :- !. % zero to the power of anything but zero is zero
exp(N, N, _, Exp, Exp) :- !. % when counter is equal to the exponent then stop and return the result
exp(N, Cnt, X, Acc, Exp) :- mult(Acc, X, AccNext), exp(N, s(Cnt), X, AccNext, Exp).
exp(X, N, Exp) :- exp(N, 0, X, s(0), Exp).


% Lesser than
lt(0, s(_)).
lt(s(N), s(M)) :- lt(N, M).

% Greater than
gt(N, M) :- lt(M, N).

% Equal to
eq(0, 0).
eq(s(N), s(M)) :- eq(N, M).

% Max and min
max(N, N, N) :- !.
max(N, M, M) :- lt(N, M), !.
max(N, _, N).

min(N, N, N) :- !.
min(N, M, N) :- lt(N, M), !.
min(_, N, N).

% Modulo
% mod(A, B, Q, K) <=> A = B * Q + K
mod(A, B, 0, A) :- lt(A, B), !.
mod(A, B, s(Q), K) :- sum(B, A1, A), mod(A1, B, Q, K).


gcd(0, X, X) :-!.
gcd(X, 0, X) :-!.
gcd(X, X, X) :-!.
gcd(M, N, X) :- gt(N,M), mod(N,M,_,K), gcd(M, K, X).
gcd(M, N, X) :- lt(N,M), mod(M,N,_,K), gcd(K, N, X).


