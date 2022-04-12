Invocação de termos
call(X)        invoca a variável X como se fosse um objectivo.

Controlo
repeat      sucede sempre, repetindo após backtracking.
fail        representa uma cláusula sempre falsa.

Tipos de termos
integer(X)          X é um inteiro.
atom(X)             X é um átomo.
atomic(X)           X é um inteiro ou um átomo.
var(X)              X é uma variável.
nonvar(X)           X não é uma variável.
functor(X, F, N)    X é um termo composto de functor F e aridade N.
arg(N, X, Arg)      Arg é o N-ésimo argumento de X.

X == Y          X e Y são o mesmo termo (incluindo variável).

Entrada/saída
read(X)         Lê X do canal de entrada (até um ponto final). Falha em retrocesso.
write(X)        Escreve X no canal de saída.
name(X, Y)      Converte o elemento atómico X numa string (lista de inteiros).
put(N)          Coloca o caractér de código ASCII N no canal de saída.
get(N)          N é o código ASCII do carácter não branco seguinte do canal de saída.
get0(N)         N é o código ASCII do carácter seguinte do canal de saída.

see(F)          Abre um canal de entrada para o ficheiro F e coloca-o como actual.
seeing(F)       F é o nome do ficheiro no canal de entrada.
seen            fecha o canal de entrada actual.
tell(F)         Abre um canal de saída para o ficheiro F e coloca-o como actual.
telling(F)      F é o nome do ficheiro no canal de saída.
told            fecha o canal de saída actual.

O canal de entrada pré-definido está ligado ao terminal e tem nome “user”.

Acesso ao programa
listing             Lista o programa actual.
listing(Pred)       Lista o predicado Pred.
assert(Clause)      Adiciona a cláusula Clause no fim do predicado respectivo.
retract(Clause)     elimina a primeira cláusula que unifica com Clause.

Definição de operadores
Op(Prec, Type, Op)    define um operador com símbolo Op, de tipo Type e com precedência Prec. Prec é a precedência de 0 (mais prioridade) até 1200 (menos prioridade). Type é um átomo de entre: xfx, xfy, yfx, yfy (infixo); fx, fy (pré-fixo); xf, yf (pós-fixo).

Predicados de conjuntos
bagof(Term, Goal, Set)    List é o conjunto (com repetidos) de todas as instâncias de Term que satisfazem o objectivo Obj. Se Obj tiver variáveis não presentes em Term, pode produzir mais do que uma solução por backtracking, correspondente a diferentes instanciações destas. Retorna false se nenhum valor para a variável for encontrado.
setof(Term, Goal, Bag)    igual a bagof, mas sem repetidos e ordenado.
findall(Term, Goal, Bag)  igual a bagof, mas tomando todas as variáveis de Goal como quantificadas existencialmente. Isto significa que findall produz exactamente uma solução (possivelmente uma lista vazia), e nenhuma variável em Goal é instanciada.


Predicados auxiliares

Listas

% member(?Elem, ?List)
member(X, [X|_]).
member(X, [_|B]):- 
    member(X, B).

% append(?List1, ?List2, ?NewList)
append([], L, L).
append([A|B], L, [A|C]):- 
    append(B, L, C).

% length(?List, ?Length)
length(List, Length):- 
    length(List, Length, 0).
length([], Acum, Acum):- !.
length([_|Rest], Length, Acum):- 
    A2 is Acum+1, 
    length(Rest, Length, A2).

% nth1(?N, +List, ?Elem)
nth1(1, [Elem|_], Elem).
nth1(N, [_|Rest], Elem):- 
    nth1(N2, Rest, Elem), 
    N is N2+1.

% sort(+List, ?Sorted)
sort(List, Sorted):- 
    sort(List, Sorted, []).
sort([], Acum, Acum):- !.
sort([Elem|Rest],Sorted,Acum):-    
    sort_insert(Elem,Acum,A2),
    sort(Rest,Sorted,A2).
sort_insert(X,[],[X]):- !.
sort_insert(X,[Y|Rest],[X,Y|Rest]):- X=<Y, !.
sort_insert(X,[Y|Rest],[Y|NewRest]):- sort_insert(X,Rest,NewRest).

% replace(+Elem, +NewElem, +List, -NewList)
replace(_,_,[],[]) :- !.
replace(Elem,NewElem,[Elem|List],[NewElem|New]):-
    !,                                         
    replace(Elem,NewElem,List,New).
replace(Elem,NewElem,[X|List],[X|New]) :- 
    replace(Elem,NewElem,List,New).


Output

% indent(+N, +Simb)
indent(0, _):- !.
indent(N, Symb):- 
    write(Symb), 
    N2 is N-1, 
    indent(N2, Symb).


PLR

:- use_module(library(clpfd)).

% number_digits(+Digits, -Number)
number_digits(Digits, Number) :-    
    length(Digits, NumDigits),
    digit_coefs(NumDigits, Coefs),
    scalar_product(Coefs, Digits, #=, Number).


digit_coefs(0, []):- !.
digit_coefs(N, [X|Rest]):-       
    N2 is N-1, 
    X is truncate(10**N2), 
    digit_coefs(N2, Rest).

% domain_list(?Vars, +Dom)
domain_list(Vars, Dom) :- 
    list_to_fdset(Dom, FdSet), 
    list_in_set(Vars, FdSet).
list_in_set([], _) :- !.
list_in_set([X|List], Set) :- 
    X in_set Set, 
    list_in_set(List, Set).

% m_line(+IndLin, +NumCol, +Matrix, -Line)
m_line(IndLin, NumCol, Matrix, Line) :-
    m_line(IndLin, NumCol, Matrix, Line, 1).

m_line(_, NumCol, _, [], IndCol) :- IndCol > NumCol, !.
m_line(IndLin, NumCol, Matrix, [Elem|Resto], IndCol) :-
    m_element(IndLin, IndCol, NumCol, Matrix, Elem),
    I2 is IndCol+1,
    m_line(IndLin, NumCol, Matrix, Resto, I2).

% m_column(+IndCol, +NumLin, +NumCol, +Matrix, -Column)
m_column(IndCol, NumLin, NumCol, Matrix, Column) :-
    m_column(IndCol, NumLin, NumCol, Matrix, Column, 1).

m_column(_, NumLin, _, _, [], IndLin) :- IndLin > NumLin, !.
m_column(IndCol, NumLin, NumCol, Matrix, [Elem|Resto], IndLin) :-
    m_element(IndLin, IndCol, NumCol, Matrix, Elem),
    I2 is IndLin+1,
    m_column(IndCol, NumLin, NumCol, Matrix, Resto, I2).

% m_element(+IndLin, +IndCol, +NumCol, +Matrix, -Elem)
m_element(IndLin, IndCol, NumCol, Matrix, Elem) :-
    Ind #= (IndLin-1)*NumCol + IndCol,
    element(Ind, Matrix, Elem).



Operadores Relacionais.
 - X = Y      ------------ X e Y são iguais;
 - X \= Y    -----------   X e Y são diferentes;
 - X < Y      ------------ X é menor que Y;
 -  X > Y     ------------ X é maior que Y;
 -  X =< Y   ------------ X é menor ou igual a Y;
 -  X >= Y  ------------- X é maior ou igual a Y.
 -  X =:= Y ------------- X e Y são iguais (p/ números);
 -  X =\= Y ------------- X e Y são diferentes (p/ números). Operadores aritméticos
 - X+Y ------------------ soma de X e Y;
 - X &ndash; Y ------  diferença de X e Y;
 - X * Y ----------------- multiplicação de X por Y;
 - X / Y ---------------  divisão de X por Y;
 - X mod Y ----------- resto da divisão de X por Y.
- \+(alguma coisa)-  ou not depende da ferramenta a utilizar, negação
- @>=, @=< -------- comparação (sem certeza) uma variável a uma constante (exemplo :
            (Letra @>= a , Letra @=< z)







Programação com restrições

scalar_product(+Cs, +Vs, +Rel, ?Expr)
Cs is a list of integers, Vs is a list of variables and integers. True if the scalar product of Cs and Vs is in relation Rel to Expr, where Rel is #=, #\=, #<, #>, #=< or #>=.

all_different(+Vars)
Vars are pairwise distinct.

all_distinct(+Ls)
Like all_different/1, with stronger propagation.

sum(+Vars, +Rel, ?Expr)
The sum of elements of the list Vars is in relation Rel to Expr, where Rel is #=, #\=, #<, #>, #=< or #>=.
