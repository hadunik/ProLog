item("Avatar","USA","fantastic",2009).
item("Brother 2","Russia","militant",2000).
item("Shutter Island","USA","thriller",2009).
item("Pirates of the Caribbean: The Curse of the Black Pearl","USA","fantastic",2003).
item("Harry Potter and the Sorcerer's Stone","Great Britain","fantastic",2001).
item("The Dark Knight","USA","fantastic",2008).
item("The Prestige","USA","fantastic",2006).
item("The Lord of the Rings: The Fellowship of the Ring","New Zealand","fantastic",2001).
item("WALL-E","USA","cartoon",2008).
item("The Lord of the Rings: The Return of the King","New Zealand","fantastic",2003).
item("Sherlock Holmes","USA","fantastic",2009).
item("Gladiator","Great Britain","militant",2000).
item("Ratatouille","USA","cartoon",2007).
item("Catch Me If You Can","Canada","crime",2002).
item("A Beautiful Mind","USA","drama",2001).
item("Iron Man","USA","fantastic",2008).
item("The Butterfly Effect","Canada","fantastic",2003).
item("Shrek","USA","cartoon",2001).
item("Hachi: A Dog's Tale","USA","drama",2008).
item("Snatch","Great Britain","crime",2000).
item("Intouchables","France","drama",2011).
item("The Gentlemen","Great Britain","crime",2019).
item("Green Book","USA","biography",2018).
item("Now You See Me","USA","thriller",2013).
item("Gisaengchung","South Korea","thriller",2019).
item("El hoyo","Spain","fantastic",2019).



search :- write("Do you want to search something (yes/no)?"),nl,
    read_string(user_input, "\n", "", _, Val),parsing_1answer(Val).

parsing_1answer(Val):-Val=="no",!,writeln("Bye! Have a nice day!").
parsing_1answer(Val):-(Val=="yes", mainsearch ,firstsearch),!.
parsing_1answer(_):-search.


mainsearch :- writeln("Please select search parameter:"),
    writeln("1 - The name of the movie"),
    writeln("2 - Country"),
    writeln("3 - The genre of the film"),
    writeln("4 - Year of production"),
    read_string(user_input, "\n", "", _, Value),
    atom_number(Value, Numeric),
    parsing_2answer(Numeric).

parsing_2answer(1) :-!,
    writeln("You have chosen to search by name of the movie."),
    write("Please enter the full title of the movie:"),
    read_string(user_input, "\n", "", _, Val),
    parsing_name(Val),
    nl.
parsing_2answer(2) :-!,
    writeln("You have selected the movie country search."),
    write("Please enter the country of the movie:"),
    read_string(user_input, "\n", "", _, Val),
    parsing_counrty(Val),
    nl.
parsing_2answer(3) :- !,
    writeln("You have selected a movie genre search"),
    write("Please enter the genre of the movie:"),
    read_string(user_input, "\n", "", _, Val),
    parsing_genre(Val),
    nl.
parsing_2answer(4) :- !,
    writeln("You have chosen to search by movie year."),
    write("Please enter the lower bound:"),
    read_string(user_input, "\n", "", _, Vall),
    write("Please enter the upper bound:"),
    read_string(user_input, "\n", "", _, Valr),
    parsing_years_help(Vall,Valr),
    nl.

parsing_2answer(_):-mainsearch.



parsing_name(Val) :-
    item(Val, P2, P3, P4),
    writeln("====================================="),
    write("Name - "), writeln(Val),
    write("Country - "), writeln(P2),
    write("Genre - "), writeln(P3),
    write("Year - "), writeln(P4),
    writeln("====================================="),
    fail.

parsing_counrty(Val) :-
    item(P1, Val, P3, P4),
    writeln("====================================="),
    write("Name - "), writeln(P1),
    write("Country - "), writeln(Val),
    write("Genre - "), writeln(P3),
    write("Year - "), writeln(P4),
    writeln("====================================="),
    fail.

parsing_genre(Val) :-
    item(P1, P2, Val, P4),
    writeln("====================================="),
    write("Name - "), writeln(P1),
    write("Country - "), writeln(P2),
    write("Genre - "), writeln(Val),
    write("Year - "), writeln(P4),
    writeln("====================================="),
    fail.

parsing_years_help(L,R):-
    atom_number(L,NumericL),
    atom_number(R,NumericR),
    parsing_years(NumericL,NumericR).
parsing_years_help(L,R):-
    \+atom_number(L,_),
    atom_number(R,NumericR),
    parsing_years(1999,NumericR).
parsing_years_help(L,R):-
    atom_number(L,NumericL),
    \+atom_number(R,_),
    parsing_years(NumericL,2022).
parsing_years_help(L,R):-
    \+atom_number(L,_),
    \+atom_number(R,_),
    parsing_years(1999,2022).


parsing_years(L,R) :-
    between(L,R,Val),
    item(P1, P2, P3, Val),
    writeln("====================================="),
    write("Name - "), writeln(P1),
    write("Country - "), writeln(P2),
    write("Genre - "), writeln(P3),
    write("Year - "), writeln(Val),
    writeln("====================================="),
    fail.

