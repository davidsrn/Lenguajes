person(ben).
person(mary).

trait(ben,kind).
trait(ben,nice).
trait(ben, persuasive).
trait(ben,short).
trait(mary,crazy).
trait(mary,short).

same(X,Y):-
    trait(X,Z),
    trait(Y,Z).

?-same(ben,mary).
