% David Ramirez A01206423

% go(Start, Goal) :-
% 	empty_stack(Empty_been_list),
% 	stack(Start, Empty_been_list, Been_list),
% 	path(Start, Goal, Been_list).
%
% 	% path implements a depth first search in PROLOG
%
% 	% Current state = goal, print out been list
% path(Goal, Goal, Been_list) :-
% 	reverse_print_stack(Been_list).
%
% path(State, Goal, Been_list) :-
% 	mov(State, Next),
% 	% not(unsafe(Next)),
% 	not(member_stack(Next, Been_list)),
% 	path(Next, Been_list, New_been_list),
% 	path(Next, Goal, New_been_list), !.
%
% reverse_print_stack(S) :-
% 	empty_stack(S).
% reverse_print_stack(S) :-
% 	stack(E, Rest, S),
% 	reverse_print_stack(Rest),
% 	write(E), nl.

% El proximo algoritmo es una mezcla del ejemplo de benji con otro encontrado
% en stackoverflow y fusionado por mi
%Lista de nodos con los cuales estan conectados
conn(1, 2).
conn(1, 3).
conn(1, 4).
conn(2, 4).
conn(2, 5).
conn(2, 6).
conn(4, 5).
conn(4, 6).
conn(4, 7).
conn(5, 6).
conn(6, 7).
%Nodo final para no mandar cual es el nodo al que quieres llegar
end(7).

% Funcion inicial para empezar a llamar la funciona ayudante
start(StartN, Res) :-
  dive([], StartN, Res).
	% reverse_print_stack(Res).


% Caso base, ecnonctro el final del nodo, en caso de que si regresa el stack
% de nodos viajados para legar a el
dive(Stack, Node, [Node|Stack]) :-
  end(Node).

% En caso de no ser el final viajar por todos y marcar los nodos viajados en
% el stack si no se ha pasado por el
dive(Stack, Node, Res) :-
  conn(Node, NewNode),
  not(member(NewNode, Stack)),
  dive([Node|Stack], NewNode, Res).

% Para poner en orden el camino tomado (omado del ejemplo dado por Benji)
% AL final no implementado por falta de tiempo
% reverse_print_stack(S) :-
% 	empty_stack(S).
%
% reverse_print_stack(S) :-
% 	stack(E, Rest, S),
% 	reverse_print_stack(Rest),
% 	write(E), nl.

% Caso base para el sort, SI recibe una lista vacía el resultado es vacío
quick_sort([],[]).

% Separamos el primer elemento de los demas y empezamos a dividir
% el arreglo para poder sortearlo.
% Al final solo unimos los resultados de la division
quick_sort([H|T],Res):-
  divide(T,H,Left,Right),
  quick_sort(Left,Lefts),
  quick_sort(Right,Rights),
  append(Lefts,[H|Rights],Res).

% Caso base para el dividir e igualar los valores vacios a un arreglo vacio
% para lograr hacer la recursion
% El segundo valor no nos importa, nos importa que la primera lista recibida
% este vacia
divide([],_,[],[]).

% Si nuestro head es menor a lo que tenemos lo unimos a la izqierda
% y llamamos la recursion con los nuevos resultados
divide([H|T],X,[H|Lefts],Res):-
  H =< X, divide(T,X,Lefts,Res).

% Si nuestro head es mayor lo unimos a la derecha
divide([H|T],X,Lefts,[H|Rights]) :-
  H > X, divide(T,X,Lefts,Rights).
