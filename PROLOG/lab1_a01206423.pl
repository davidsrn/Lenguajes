% David Ramirez A01206423
% Resulta que sin nombre pierdes 13 puntos parciales
% JAJAJA : ^ ) end me

hobby(elena,tennis).
hobby(hans,videogame).
hobby(juan,kaggle).
hobby(laura,hack).
hobby(luis,hack).
hobby(midori,videogame).
hobby(simon,kaggle).
hobby(simon,sail).

compatible(X, Y):-
  hobby(X, Hobby),
  hobby(Y, Hobby).

road(ancona, castrum).
road(ancona, roma).
road(ariminum, ancona).
road(ariminum, roma).
road(brundisium, capua).
road(capua, roma).
road(castrum, roma).
road(catina, rhegium).
road(genua, pisae).
road(genua, roma).
road(lilibeum, messana).
road(messana, capua).
road(pisae, roma).
road(placentia, ariminum).
road(rhegium ,messana).
road(syracusae, catina).

% We calculate if we can get to the destiny by going trough every road
can_get_to(Origin, Destiny):-
  road(Origin, City),
  road(City, Destiny);
  road(Origin, City),
  can_get_to(City, Destiny).

% We get a 1 for each step we take
size(X, Y, Z):-
  road(X, Y),
  Z is 1;
  road(X, A),
  size(A, Y, B),
  Z is B+1.

% Brute force calc of the numebers
min(A, B, C, Z):-
  A = B, B = C, Z is A;
  A > B, B > C, Z is C;
  A < B, B < C, Z is A;
  A < B, B > C, A < C, Z is A;
  A > B, B < C, Z is B;
  A < B, B > C, A > C, Z is C.

%gdc formula just implemented in prolog, nothing spicy
  gcd(A,B,Z):-
    A=B,
    Z=A.

  gcd(A,B,Z):-
    A<B,
    B1 is B-A,
    gcd(A,B1,Z).

  gcd(A,B,Z):-
    A>B,
    gcd(A,B,Z).
