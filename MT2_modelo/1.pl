:- use_module(library(lists)).

p1(L1,L2) :-
    gen(L1,L2),
    test(L2).

gen([],[]).
gen(L1,[X|L2]) :-
    select(X,L1,L3),
    gen(L3,L2).

test([_,_]).
test([X1,X2,X3|Xs]) :-
    (X1 < X2, X2 > X3; X1 > X2, X2 < X3),
    test([X2,X3|Xs]).

    /*

    R:  O predicado gen verifica se L1 e L2 contêm os mesmos elementos, não necessariamente pela 
    mesma ordem. O predicado test verifica se os elementos de L2 obedecem à seguinte regra: se
    um elemento da lista tem um valor superior ao elemento anterior, então o elemento seguinte
    tem de ter um, valor inferior, e vice-versa. As listas têm de conter mais do que 1 elemento.
        Relativamente à eficiência deste programa, não é ótima uma vez que é necessário percorrer
    a lista L2 duas vezes, uma dentro de gen, e uma segunda vez dentro de test.

    */
