% David Ramirez A01206423
% Lab 2
% 23/09/2019

is_empty(List):- not(member(_,List)).

% Si encuentras un numero positivo simplemente vete a
% regresar true

any_positive(1, 1):-!.

any_positive([Head, Tail], Res):-
  Head > 0,
  any_positive(1, 1);
  Head < 0,
  any_positive(Tail, Res).

%substitute(N1, N2, List, Res):-
%  substituteH(N1, N2, List, Res).

%substitute(_, _, [], Res).

% Si encuentra el caracter a sustituir lo pasa a construir
% si no pasa el carcater existente

substitute(_, _, [], []).

substitute(N1, N2, [Head|Tail], [N2|Res]):-
  Head = N1,
  substitute(N1, N2, Tail, Res).

substitute(N1, N2, [Head|Tail], [Head|Res]):-
  substitute(N1, N2, Tail, Res).

% Intentos fallidos

% eliminate_duplicates([Head | Tail], Res):-
%   [THead | _] = Tail,
%   Head = THead,
%   [RHead | _] = Res,
%   RHead = Head,
%   eliminate_duplicates(Tail, Res).
%
% eliminate_duplicates([Head | Tail], [Head|Res]):-
%   [THead | _] = Tail,
%   Head = THead,
%   eliminate_duplicates(Tail, Res).
%
%   eliminate_duplicates([Head | Tail], [Head|Res]):-
%     eliminate_duplicates(Tail, Res).

% eliminate_duplicates([], []).
% eliminate_duplicates([Head], [Head]).
%
% eliminate_duplicates([Head, Head | Tail], Res):-
%   eliminate_duplicates([Head | Tail], Res).
%
% eliminate_duplicates([Head, Else | Tail],  [Head|ResT]):-
%   Head \= Else,
%   eliminate_duplicates([Else | Tail], ResT).



% eliminate_duplicates([H | T], Res):-
%   search(H, T, Res),
%   is_empty(T);
%   search(H, T, Res1),
%   eliminate_duplicates(Res1, Res).
%
%
% search(_, [], []).
% search(H, [H|T], [H|Res]):-
%   [RH|_] = Res,
%   H = RH,
%   search(H, T, Res).
%
% search(H, [H|T], Res):-
%   search(H, T, [H|Res]).
%
%
% search(H, [Y|T], [Y|Res]):-
%   % H \= Y,
%   search(H, T, Res).
%   % search(Y, T, Res1)

% eliminate_duplicates([], []).
%
% eliminate_duplicates([H|T], [H|Res]):-
%   not(member(H, Res)),
%   eliminate_duplicates(T, Res).
%
% eliminate_duplicates([_|T], Res):-
%   eliminate_duplicates(T, Res).

% Funciona pero regresa el resultado al revés así que hay que invertirlo

eliminate_duplicates_head_invert(List, Res):-
  search(List, [], Res).

search([H|T], Acc, Res):-
    not(member(H, Acc)),
    search(T, [H|Acc], Res).

search([_|T], Acc, Res):-
  search(T, Acc, Res).

search([], Acc, Res):-
  invert(Acc, Res).

% FRIKIN YO TENÍA ESTO PERO FRIKIN EL NOT MEMBER VA DESPUES DE
% HACER RECURSIÓN Y ODIO ODIO ODIO QUE ME HAYA TOMADO TANTO TIEMPO
% HACER QUE FUNCIONARA CON SOLO MOVER UNA LINEA ABAJO DE OTRA.
% Ya entendí porque

eliminate_duplicates([],[]).

eliminate_duplicates([H|T],[H|Res]):-
  eliminate_duplicates(T , Res),
  not(member(H, Res)).

eliminate_duplicates([_|T], Res):-
  eliminate_duplicates(T, Res).

% eliminate_duplicates(List, Res):-
%   search(List, Res).
%
% search([H|T], [H|Res]):-
%     not(member(H, Res)),
%     search(T, Res).
%
% search([_|T], Res):-
%   search(T, Res).
%
% search([], []).

% Si el elemento de la lista de la izqueirda es parte de la de la derecha se
% agrega al resultado, si no se ignora y si está vacía es el caso base,

intersect([], _, []).

intersect([H|T], List, [H|Res]):-
  member(H, List),
  intersect(T, List, Res).

intersect([_|T], List, Res):-
  intersect(T, List, Res).

% Haces head recursion y ya

invert(List, Res):-
  invh(List, [], Res).

invh([], Acc, Acc).

invh([H|T], Acc, Res):-
    invh(T, [H|Acc], Res).


% Si es menor lo pasas al resultado, si no se ignora

less_than(_, [], []).

less_than(X, [H|T], [H|Res]):-
  X > H,
  less_than(X, T, Res).

less_than(X, [_|T], Res):-
  less_than(X, T, Res).

%Igual que el less than

more_than(_, [], []).

more_than(X, [H|T], [H|Res]):-
  X < H,
  more_than(X, T, Res).

more_than(X, [_|T], Res):-
  more_than(X, T, Res).

% last(X,[X]).
% last(X,[_|Z]):-
%   last(X,Z).

% Vas moviendo la cola al final y restando uno al contador cada que lo haces

rotate(Res, 0, Res).

rotate([H|T], N, Res):-
  N >= 0,
  NewN is N-1,
  append(T, [H], NewRes),
  rotate(NewRes, NewN, Res).

% Si es negativo haces una resta para usar la operación par positivos

rotate(List, N, Res):-
  N =< 0,
  length(List, Len),
  Trick is Len - N - 1,
  rotate(List, Trick, Res).
