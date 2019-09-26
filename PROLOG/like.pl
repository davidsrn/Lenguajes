likes(david, lidia).
likes(lidia, david).
likes(sam, lulu).
likes(lulu, sam).
likes(ian, lidia).

dating(X, Y):-
  likes(X, Y),
  likes(Y, X).

friendship(X, Y):-
  likes(X, Y);
  likes(Y, X).

  
