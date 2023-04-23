kind(cat, butsie).
kind(cat, cornie).
kind(cat, mac).
kind(dog, flash).
kind(dog, rover).
kind(dog, spot).

color(brown, butsie).
color(black, cornie).
color(red, mac).
color(spotted, flash).
color(red, dog).
color(white, spot).

owns(tom, Pet) :- kind(_, Pet), (color(brown, Pet); color(black, Pet)).

owns(kate, Pet) :- kind(dog, Pet), not(color(white, Pet)), not(owns(tom, Pet)).

owns(alan, mac) :- not(owns(kate,butsie)), not(pedigree(spot)).

pedigree(Pet) :- kind(_, Pet), (owns(kate, Pet) ; owns(tom, Pet)).

homeless(Pet) :- kind(_, Pet), not(owns(_, Pet)).
