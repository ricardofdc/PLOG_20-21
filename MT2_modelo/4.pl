:- use_module(library(clpfd)).

build(Budget,NPacks,ObjectCosts,ObjectPacks,Objects,UsedPacks):-
    Objects = [O1, O2, O3],
    domain(UsedPacks, 0, NPacks),
