/*
 * This code defines a module with the name "mod2"
 * The module exports predicates foo/1 and bar/2 and leaves some_helper/2 private
 */

:- module(mod2, [foo/1, bar/2]).

% This predicate is private, and it won't overload something
some_helper(A, B) :- length(A, B),!,write("Lengths match!").

% bar/2 does some unreasonable things with lists
bar([H|T], _current_len) :-
    some_helper(T, _current_len),
    _new_len is _current_len - 1,
    writeln(H),
    bar(T, _new_len).

bar([], L) :- L =< 0.


% foo/1 always prints the same message regardless of parameters
foo(_) :- writeln('I am a foo from the mod2').
