:-use_module(library(clpfd)).
:-use_module(library(lists)).

magic(Vars):-
    Vars=[A1,A2,A3,A4,A5,A6,A7,A8,A9],
    domain(Vars,1,9),
    %Soma is (9+1)*3//2,   % Aumenta a Eficiência
    all_distinct(Vars),
    A1+A2+A3 #= Soma,
    A4+A5+A6 #= Soma,
    A7+A8+A9 #= Soma,
    A1+A4+A7 #= Soma,
    A2+A5+A8 #= Soma,
    A3+A6+A9 #= Soma,
    A1+A5+A9 #= Soma,
    A3+A5+A7 #= Soma,
    % A1 #< A2, A1 #< A3, A1 #< A4, A2 #< A4,  % Eliminar simetrias
    labeling([],Vars).



create_mat(0, _, _, []).
create_mat(N0, N, Nmax, [Head|Matrix]) :-
	N0 > 0,
	N1 is N0 - 1,
	length(Head, N),
    domain(Head, 1, Nmax),
	create_mat(N1, N, Nmax, Matrix).

sum_row([],_).
sum_row([Row|Matrix], SumDim):-
    sum(Row, #=, SumDim),
    sum_row(Matrix, SumDim).

diagonal([], _, _, []).
diagonal([Row|Matrix], Index, P, [X|Diagonal]):-
    nth1(Index, Row, X),
    Index1 is Index + P,
    diagonal(Matrix, Index1, P, Diagonal).

magic_n(N, Vars):-
    Nmax is N*N,
    SumDim is N*(N*N+1)//2,
    create_mat(N, N, Nmax, Mat),
    %flatten(Mat, Vars),
    %domain(Vars, 1, Nmax),
    write(1),
    sum_row(Vars, SumDim),
    write(2),
    transpose(Vars, TransVars),
write(3),
    sum_row(TransVars, SumDim),
write(4),
    diagonal(Vars, 1, 1, D1),
write(5),
    sum(D1, #=, SumDim),
    diagonal(Vars, N, -1, D2),
    sum(D2, #=, SumDim),
    all_distinct(Vars),
    labeling([], Vars).
