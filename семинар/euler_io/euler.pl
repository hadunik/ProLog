/*
 *
 * Lesson 7. Draw graph problem.
 *
 */


% Define graph
vertex(a, 1, 2).
vertex(b, 1, 3).
vertex(c, 2, 3).
vertex(d, 2, 4).
vertex(e, 3, 5).
vertex(f, 2, 5).
vertex(g, 3, 4).
vertex(h, 4, 5).

edge(E, A, B) :- vertex(E, A, B);vertex(E, B, A).

% Count number of edges in the graph.
% Number of edges is equal to the length of the path we seek
count_edges(L) :- findall(E, vertex(E, _, _), Es), length(Es, L).

% When the current path has length equal to the number of edges then
% stop and return result
path(_, Path, Max, Path) :- length(Path, Max), !.
path(N, Path, Max, Res) :- edge(E, N, M), \+memberchk(E, Path), path(M, [E|Path], Max, Res).

draw(Start) :- count_edges(Len), path(Start, [], Len, Res), print_(Res).

main([Start|_]) :- atom_number(Start, S),
    count_edges(Len),
    findall(Sol, (path(S, [], Len, Res), reverse(Res,Sol)), Ss),
    prints(Ss, 1).

print_([]).
print_([H]) :- write(H),!.
print_([H|T]) :-  format('~w --> ', [H]), print_(T).

prints([], _).
prints([Solution|Rest], N) :- format('~d: ', [N]), 
	N1 is N + 1, 
	print_(Solution), nl, 
	prints(Rest, N1).


:- initialization(main, main).
