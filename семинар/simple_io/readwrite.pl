/*
 * This example shows how to read from and write to a file
 */

% open a file, read from it and close it again
readNumbers :-
    open('numbers.txt', read, In),
    readNumbers(In),
    close(In).

% if we are at the end of the imput stream
% then stop and succeed with cut
readNumbers(Stream) :- at_end_of_stream(Stream),!.

% otherwise read next term and make a recursive call
readNumbers(Stream) :-
    read(Stream, N),
    (integer(N) -> format('~d ', [N]); write('NaN ')),
    readNumbers(Stream).

% open a file (or create if it does not exist yet),
% write two strings to it and close it again
writeFile :- open('out.txt', write, Out),
    write(Out, 'Some string.\n'),
    write(Out, 'skin(Smith,Black).'),
    close(Out).

% open file containing not term, but arbitrary strings
readStrings :-
    open('strings.txt', read, In),
    readStrings(In),
    close(In).


readStrings(Stream) :- at_end_of_stream(Stream), !.
readStrings(Stream) :-
    read_string(Stream, "\n", "\r\t ", _, String),
    split_string(String, " ", "", L),
    writeln(L),
    readStrings(Stream).


main :- writeln('Reading from numbers.txt'),
    readNumbers, nl,
    writeln('Reading from string.txt'),
    readStrings,
    writeln('Writing to out.txt'),
    writeFile.

:- initialization(main, main).