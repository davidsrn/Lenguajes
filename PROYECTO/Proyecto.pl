:-use_module(library(clpfd)).
couple(david, lidia).
couple(eliel, mayra).
couple(ivo,nan).
family(david, malena).
family(lidia, mlidia).
family(nan, else).
family(eliel, nan).
friend(david, eliel).
friend(if, eliel).
friend(if, mlidia).
knows(david, ivo).
knows(else, if).
knows(ivo, eliel).

table(_):-!.

score(P1, P2, Score):-
  couple(P1, P2),
  % table(P1, P2, 100);
  Score is 100;
  couple(P2, P1),
  Score is 100;
  % table(P2, P1, 100);
  knows(P1, P2),
  Score is 25;
  % table(P1, P2, 1);
  knows(P2, P1),
  Score is 25;
  % table(P2, P1, 1);
  friend(P1, P2),
  Score is 50;
  % table(P1, P2, 5);
  friend(P2, P1),
  Score is 50;
  family(P2, P1),
  Score is 75;
  family(P1, P2),
  Score is 75;
  Score is 0.
  % table(P2, P1, 5).

swap_internals((X,Y), Y1-X):- Y1 #= -Y.

pair_sort(L,Sorted):-
      maplist(swap_internals, L, L2),
      keysort(L2, L3),
      maplist(swap_internals, Sorted, L3).

join_dicts(D1, D2, D3) :-
    D1 >:< D2,
    put_dict(D1, D2, D3).


% rem_tuple([], [], []).
rem_tuple([], New, New).


rem_tuple([H|T], New, Res):-
  (Val, _) = H,
  rem_tuple(T, [Val|New], Res).

main(Tables, Persons, Res):-
  main_h(Tables, Persons, [], Res).

% main_h(_, [], Res, _, Res).
% main_h(_, [], _, _, Final_Res).

% main_h(Tables, [], Final_Res):-
%   match(Tables, [], [], Res, _),
%   Final_Res = Res.

main_h(_, [], Temp, Temp).

main_h(Tables, Persons, Temp, Final_Res):-
  match(Tables, Persons, [], Res, Missing),
  rem_tuple(Missing, [], NewL),
  main_h(Tables, NewL, [Res|Temp], Final_Res).

%
% main_h(Tables, Persons, Res, Missing):-
%   match(Tables, Persons, [], Res, Missing),
%   length(Missing, I),
%   I > 0,
%   rem_tuple(Missing, [], NewL),
%   match(Tables, NewL, [], Res1, Missing1),
%   Res = [Res|Res1],
%   Missing = [Missing|Missing1];
%   match(Tables, Persons, [], Res, Missing).

rem_extras_h(Tables, [H|T], Temp, Res, Missing):-
  NewTemp = [H|Temp],
  length(NewTemp, I),
  Tables >= I,
  rem_extras_h(Tables, T, NewTemp, Res, Missing);
  Res = Temp,
  Missing = [H|T].

rem_extras(Tables, List, Res, Missing):-
  length(List, I),
  Tables -1 < I,
  rem_extras_h(Tables, List, [], Res, Missing);
  length(List, I),
  Tables >= I,
  Res = List.

% finish(_, [], Res, Res).
%
finish(H, Res3, [H|Res3]).
format_out(H, Res):-
  write(""),
  print(H),
  write(" will be seated with "),
  print(Res),
  write(" since their relationship score is the highest."),
  nl().

% match(_, [], Dict, Dict, _).
match(_, [_|[]], Dict, Dict, _).

match(Tables, [H|[P|T]], Dict, Res, Missing):-
  score(H, P, Score),
  % match(Tables, [H|T], join_dicts(Dict, {P, Score}), Res).
  match(Tables, [H|T], [(P, Score)|Dict], Res1, Missing),
  pair_sort(Res1, Res2),
  rem_extras(Tables, Res2, Res, Missing),
  format_out(H, Res).

  % finish((H, 1000), Res3, Res).
