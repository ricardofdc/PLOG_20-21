:- use_module(library(lists)).
:- use_module(library(clpfd)).

p1(L1,L2) :-
    gen(L1,L2),
    test(L2).

gen([],[]).
gen(L1,[X|L2]) :-
    select(X,L1,L3),
    gen(L3,L2).


%%%%%%%%%%%%%%%%%%%%%%%%%	PERGUNTA 3		%%%%%%%%%%%%%%%%%%%%%%%%%


test([]).
test([_]).
test([_,_]).
test([X1,X2,X3|Xs]) :-
    (X1 #< X2, X2 #< X3; X1 #> X2, X2 #> X3),
    test(Xs).
	

p2(L1,L2) :-
    length(L1,N),
    length(L2,N),
    
    pos(L1,L2,Is),
    all_distinct(Is),
    
    test(L2),
    labeling([],Is).

pos([],_,[]).
pos([X|Xs],L2,[ I | Is ]) :-
    element(I,L2,X),
    pos(Xs,L2,Is).
	

%%%%%%%%%%%%%%%%%%%%%%%%%	PERGUNTA 4		%%%%%%%%%%%%%%%%%%%%%%%%%
	
	
constroi(NEmb, Orcamento, EmbPorObjeto, CustoPorObjeto, EmbUsadas, Objetos) :- 
									
	length(Objetos, 4),
	length(EmbPorObjeto, TotalDeObjetos),
	domain(Objetos, 1, TotalDeObjetos),
	all_distinct(Objetos),
	
	domain([EmbUsadas], 0, NEmb),
	
	determinaEmbUsadas(Objetos, EmbPorObjeto, EmbUsadas),
	restringeCusto(Objetos, CustoPorObjeto, ActualOrcamento),
	ActualOrcamento #=< Orcamento,
	
	append([EmbUsadas], Objetos, Vars),
	labeling([maximize(EmbUsadas)], Vars).


determinaEmbUsadas([], _, 0).
determinaEmbUsadas([Objeto | RObjetos], EmbPorObjeto, ActualEmbUsadas) :- 
	element(Objeto, EmbPorObjeto, Emb),
	ActualEmbUsadas #= (Emb + ActualEmbUsadas2),
	determinaEmbUsadas(RObjetos, EmbPorObjeto, ActualEmbUsadas2).
							

restringeCusto([], _, 0).				
restringeCusto([Objeto | RObjetos], CustoPorObjeto, ActualOrcamento) :- 
	element(Objeto, CustoPorObjeto, Custo),
	ActualOrcamento #= Custo + ActualOrcamento2,
	restringeCusto(RObjetos, CustoPorObjeto, ActualOrcamento2).




%%%%%%%%%%%%%%%%%%%%%%%%%	PERGUNTA 5		%%%%%%%%%%%%%%%%%%%%%%%%%


cut(Shelves, Boards, SelectedBoards) :-
	length(Shelves, NumberShelves),
	length(SelectedBoards, NumberShelves),
	
	length(Boards, NumberBoards),
	domain(SelectedBoards, 1, NumberBoards),
	
	createTasks(Shelves, SelectedBoards, Tasks),
	createMachines(Boards, Machines, 1),
	
	cumulatives(Tasks, Machines, [bound(upper)]),
	
	labeling([], SelectedBoards).


createTasks([], [], []).
createTasks([Shelve | RestShelves], [SelectedBoard | RestSelectedBoards], [task(1, 1, 2, Shelve, SelectedBoard) | RestTasks]) :-
	createTasks(RestShelves, RestSelectedBoards, RestTasks).	
		
createMachines([], [], _).			
createMachines([BoardCap | RestBoards], [machine(Id, BoardCap) | RestMachines], Id) :- 
	NewId is Id + 1,
	createMachines(RestBoards, RestMachines, NewId).
