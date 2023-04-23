%чтобы запустить программу просто введите start.


property(1,"не нужны деньги").
property(2,"нужно мало денег").
property(3,"нужно много денег").
property(4,"нужны продукты").
property(5,"нужны книги").
property(6,"нужна усидчивость").
property(7,"нужна физическая активность").
property(8,"нужен фотоаппарат").
property(9,"нужны рецепты").
property(10,"нужна модель для фото").
property(11,"нужен спортивный зал").
property(12,"нужно место для бега").
property(13,"нужна спортивная подготовка").
property(14,"нужна удочка").
property(15,"нужно ружье").
property(16,"нужна гитара").
property(17,"нужны волны").
property(18,"нужно уметь искать").
property(19,"нужны материалы").
property(20,"нужно обучаться").
property(21,"нужен пк").
property(22,"нужен плейлист").
property(23,"нужен сад").
property(24,"нужен хореограф").
property(25,"нужна мишень").
property(26,"нужны кегли").
property(27,"нужны краски и кисточка").


hobby(1,"Кулинария",[2,4,9]).
hobby(2,"Чтение",[1,5,6]).
hobby(3,"Фотография",[2,8,10]).
hobby(4,"Путешествие",[3,7]).
hobby(5,"Йога",[1,7,6]).
hobby(6,"Бег",[1,7,12,13]).
hobby(7,"Игровые виды спорта",[1,7,11,13]).
hobby(8,"Рыбалка",[2,7,14]).
hobby(9,"Охота",[3,7,15]).
hobby(10,"Коллекционирование",[3,18,19]).
hobby(11,"Игра на гитаре",[2,16,20]).
hobby(12,"Серфинг",[3,17]).
hobby(13,"Компьютер",[2,6,21]).
hobby(14,"Прослушивание музыки",[1,21,22]).
hobby(15,"Садоводство",[2,7,19,23]).
hobby(16,"Танцы",[1,7,20,24]).
hobby(17,"Стрельба",[3,15,25]).
hobby(18,"Боулинг",[2,7,26]).
hobby(19,"Рисование",[2,27]).
hobby(20,"Иностранные языки",[1,5,20]).


start :-
    writeln("Начало:"),
    writeln("1: хобби по вопросам"),
    writeln("2: характеристики хобби по названию"),
    ask_number(N),
    option(N),!.

option(1) :- build_all_variants(Y),
    find_solve(Y, Ans, Ques_ans),
    hobby(Ans, X,_),
    writeln("Вам подходит"),
    writeln(X),
    print_user_answers(Ques_ans), !.


option(2) :-
    writeln("Введите хобби"),
    read_string(user_input, "\n", "", _, Val),
    (   hobby(_, Val, X),
        write_property(X), !);
    (   writeln("такого хобби нет"), !).

ask_number(Num) :-
    writeln("Введите число"),
    read_string(user_input, "\n", "", _, Val),
    atom_number(Val, Numeric),
    Num is Numeric, !.

write_property([]) :- !.
write_property([H|T]) :- property(H, Q), writeln(Q), write_property(T), !.


print_user_answers(A) :-
    writeln("Ваши ответы:"),
    print_ans(A), !.

print_ans([]):- !.
print_ans([[A|B]|Tail]) :- property(A, Text),
    write(A),
    write(","),
    write(Text),
    write("   "),
    writeln(B),
    print_ans(Tail), !.

find_solve(List, Ques_ans, Ans) :-create_list_of_questions(List, Q_list), find_sol(List, Q_list, [], Ques_ans, Ans).

find_sol([X],_, Buf, Hobby, Ans_list) :- Hobby=X, Ans_list=Buf,!.
find_sol([],_, Buf, Hobby, Ans_list) :- Hobby = [], Ans_list=Buf,!.
find_sol(List, [Q_head|_], Ans_buf, Hobby, Ans_list) :- ask_question(Q_head, Q_ans), del(List, Q_head, New_hobbies, Q_ans),
    create_list_of_questions(New_hobbies, New_Questions), find_sol(New_hobbies, New_Questions,[[Q_head, Q_ans]|Ans_buf], Hobby, Ans_list),!.

del(Hobbies, Q_id, New_hobbies, 1) :- del_by_not_member(Hobbies, Q_id, [], New_hobbies),!.
del(Hobbies, Q_id, New_hobbies, _) :- del_by_member(Hobbies, Q_id, [], New_hobbies),!.

del_by_not_member([], _, Buf, New_hobbies) :- New_hobbies=Buf.
del_by_not_member([H|T], Q_id, Buf, New_hobbies) :- hobby(H, _ , Arr), member(Q_id, Arr),
    del_by_not_member(T, Q_id, [H|Buf], New_hobbies),!.
del_by_not_member([H|T], Q_id, Buf, New_hobbies) :- hobby(H, _, Arr), not(member(Q_id, Arr)),
    del_by_not_member(T, Q_id, Buf, New_hobbies), !.

del_by_member([], _, Buf, New_hobbies) :- New_hobbies=Buf.
del_by_member([H|T], Q_id, Buf, New_hobbies) :- hobby(H, _,  Arr), not(member(Q_id, Arr)),
del_by_member(T, Q_id, [H|Buf], New_hobbies),!.
del_by_member([H|T], Q_id, Buf, New_hobbies) :- hobby(H, _,  Arr), member(Q_id, Arr),
del_by_member(T, Q_id, Buf, New_hobbies),!.



ask_question(A, Q) :- property(A, X),
    writeln("Введите ответ: 0 - нет, 1 - да"),
    writeln(X),
    ask_number(N),
    Q = N, !.

create_list_of_questions(Possible_H, Ans) :- create_list_of_questions(Possible_H, [], Ans).
create_list_of_questions([], Buf, Ans) :- Ans = Buf, !.
create_list_of_questions([X|T], Buf ,Ans) :- hobby(X, _, Q) ,add_uniq(Q, Buf, A), create_list_of_questions(T, A, Ans).

add_uniq([], Buf, Ans) :-  Ans = Buf, !.
add_uniq([X|T], Buf, Ans) :- (not(member(X, Buf)) , add_uniq(T, [X|Buf], Ans), !) ; (add_uniq(T, Buf, Ans) , !).


build_all_variants(Arr) :- aggregate_all(count, hobby(_, _, _), Count), build_all_variants(Arr, [], Count).
build_all_variants(Arr, Buf, 0) :- Arr = Buf, !.
build_all_variants(Arr, Buf, Count) :- hobby(X, _, _), not(member(X, Buf)), T is Count - 1, build_all_variants(Arr, [X|Buf],T), !.

