/*
 * Examples for the assignment 2.
 */


% First declare a simple database
item(3, "Par12", "Par13").
item(3, "Par22", "Par23").
item(8, "Par32", "Par33").


% Search
search_ :-
    write("Please, enter the value: "), % asking to enter a value
    % read the value
    % here we use read_string/5 predicate
    % it takes an 'end-of-input' sumbol as the second argument
    % here it is a new-line symbol /

    read_string(user_input, "\n", "", _, Val), atom_number(Val, Numeric), search_by_the_first_param_(Numeric), nl.

% What to do if nothing is found
search_by_the_first_param_(P) :- \+ item(P, _, _), !, writeln("Nothing found!").
% Print results
search_by_the_first_param_(P) :-
    item(P, P2, P3),
    writeln("====================================="),
    write("P1 = "), writeln(P),
    write("P2 = "), writeln(P2),
    write("P3 = "), writeln(P3),
    writeln("=====================================").
