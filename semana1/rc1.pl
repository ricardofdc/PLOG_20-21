parent(aldoBurrows, lisaRix).
parent(aldoBurrows, lincolnBurrows).
parent(aldoBurrows, michaelScofield).
parent(aldoBurrows, saraTancredi).
parent(christinaRoseScofield, lisaRix).
parent(christinaRoseScofield, lincolnBurrows).
parent(christinaRoseScofield, michaelScofield).
parent(christinaRoseScofield, saraTancredi).
parent(lincolnBurrows, ljBurrows).
parent(lisaRix, ljBurrows).
parent(michaelScofield, ellaScofield).
parent(saraTancredi, ellaScofield).

male(aldoBurrows).
male(lincolnBurrows).
male(michaelScofield).
male(ljBurrows).
female(christinaRoseScofield).
female(lisaRix).
female(saraTancredi).
female(ellaScofield).

% pais de Michael
:- findall(X, parent(X, michaelScofield), L), write(pais_de_Michael: L), nl.

% filhos de Aldo
:- findall(X, (parent(aldoBurrows, X), male(X)), L), write(filhos_de_Aldo: L), nl.
