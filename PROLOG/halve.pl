halve(L, A, B):-
  hv(L,[], A, B).

hv(L, L, [], L).
hv(L, [_|L], [], L).
hv([H|T], Acc, [H|L], B):-
  hv(T, [_|Acc], L, B).

stack(H, S, [E|S]).
% push
stack(2, [3, 5], X).
% pop
stack(H, S, [2, 3, 5]).
