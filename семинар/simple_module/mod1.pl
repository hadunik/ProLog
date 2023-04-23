/*
 * This code defines a module with the name "mod1"
 * The module exports predicate foo/1 and leaves some_helper/2 private
 */

:- module(mod1, [foo/1]).

% Now this predicate is private and won't be overloaded outside of the module
some_helper(A, B) :- format("~w ~w, ", [A, B]).

% This predicate is public and it will be accessible from the outside
% Getting a user's name it simply greets him or her, and does nothing else
foo(A) :- some_helper("Hello", "there"), writeln(A).
