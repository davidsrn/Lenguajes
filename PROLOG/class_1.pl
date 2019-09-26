dad(alex, john).
dad(billy, bob).
dad(bob, alex).
dad(bob, sue).
dad(john, pete).
dad(pete, jack).
mom(ana, billy).
mom(ana, erika).
mom(erika, sue).
mom(sue, sussy).

grandparent(X, Z):-
  dad(X, Y),
  dad(Y, Z);
  mom(X, Y),
  mom(Y, Z).

ancestor_of(An, Des):-
  dad(An, Des);
  dad(An, Mid),
  ancestor_of(Mid, Des).




dad(jaime, joffrei).
dad(jaime, myrcella).
dad(jaime,tommen).
dad(tywin, cercei).
dad(tywin, jaime).
dad(tywin, tyrion).
mom(cercei, joffrei).
mom(cercei, myrcella).
mom(cercei,tommen).
mom(joanna, cercei).
mom(joanna, jaime).
mom(joanna, tyrion).
