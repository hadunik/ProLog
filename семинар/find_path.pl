/*
 * Solve some pathfinding task defined in module.
 * Task is not defined yet, so it is just a sample of import syntax.
 */

:- use_module(task, [check_in/2, next/2, start_stop/3, out/1]).

solve(Current, Buff, Stop, Buff) :- Current = Stop,!.
solve(Current, Buff, Stop, Solution) :-
	next(Current, Next),
	\+memberchk(Next, Buff),
	append(Buff, [Next], NextBuff),
	solve(Next, NextBuff, Stop, Solution).


% Solve jars problem
main(RawParams) :-
	writeln('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),
	writeln('             Solve Task             '),
	writeln('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),
	nl,
	task:check_in(RawParams, Params) -> (
		start_stop(Params, Start, Stop),
		findall(Solution, solve(Start, [Start], Stop, Solution), Solutions),
		out(Solutions)
	) ;
	writeln('Invalid input').

:- initialization(main, main).
