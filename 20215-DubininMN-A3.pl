%����� ��������� ��������� ������ ������� start.


property(1,"�� ����� ������").
property(2,"����� ���� �����").
property(3,"����� ����� �����").
property(4,"����� ��������").
property(5,"����� �����").
property(6,"����� �����������").
property(7,"����� ���������� ����������").
property(8,"����� �����������").
property(9,"����� �������").
property(10,"����� ������ ��� ����").
property(11,"����� ���������� ���").
property(12,"����� ����� ��� ����").
property(13,"����� ���������� ����������").
property(14,"����� ������").
property(15,"����� �����").
property(16,"����� ������").
property(17,"����� �����").
property(18,"����� ����� ������").
property(19,"����� ���������").
property(20,"����� ���������").
property(21,"����� ��").
property(22,"����� ��������").
property(23,"����� ���").
property(24,"����� ���������").
property(25,"����� ������").
property(26,"����� �����").
property(27,"����� ������ � ��������").


hobby(1,"���������",[2,4,9]).
hobby(2,"������",[1,5,6]).
hobby(3,"����������",[2,8,10]).
hobby(4,"�����������",[3,7]).
hobby(5,"����",[1,7,6]).
hobby(6,"���",[1,7,12,13]).
hobby(7,"������� ���� ������",[1,7,11,13]).
hobby(8,"�������",[2,7,14]).
hobby(9,"�����",[3,7,15]).
hobby(10,"������������������",[3,18,19]).
hobby(11,"���� �� ������",[2,16,20]).
hobby(12,"�������",[3,17]).
hobby(13,"���������",[2,6,21]).
hobby(14,"������������� ������",[1,21,22]).
hobby(15,"�����������",[2,7,19,23]).
hobby(16,"�����",[1,7,20,24]).
hobby(17,"��������",[3,15,25]).
hobby(18,"�������",[2,7,26]).
hobby(19,"���������",[2,27]).
hobby(20,"����������� �����",[1,5,20]).


start :-
    writeln("������:"),
    writeln("1: ����� �� ��������"),
    writeln("2: �������������� ����� �� ��������"),
    ask_number(N),
    option(N),!.

option(1) :- build_all_variants(Y),
    find_solve(Y, Ans, Ques_ans),
    hobby(Ans, X,_),
    writeln("��� ��������"),
    writeln(X),
    print_user_answers(Ques_ans), !.


option(2) :-
    writeln("������� �����"),
    read_string(user_input, "\n", "", _, Val),
    (   hobby(_, Val, X),
        write_property(X), !);
    (   writeln("������ ����� ���"), !).

ask_number(Num) :-
    writeln("������� �����"),
    read_string(user_input, "\n", "", _, Val),
    atom_number(Val, Numeric),
    Num is Numeric, !.

write_property([]) :- !.
write_property([H|T]) :- property(H, Q), writeln(Q), write_property(T), !.


print_user_answers(A) :-
    writeln("���� ������:"),
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
    writeln("������� �����: 0 - ���, 1 - ��"),
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

