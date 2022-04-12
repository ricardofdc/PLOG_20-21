:- use_module(library(lists)).

% isMember(+Elem, +List).
isMember(Elem, [Elem|_]).
isMember(Elem, [_|Tail]):-
    isMember(Elem, Tail).

% nth0_membro(+Number, +List, -Result) ==> nth0().
nth0_membro(0,[M|_],M).
nth0_membro(N,[_|T],M) :-
    N > 0,
    N1 is N-1,
    nth0_membro(N1,T,M).

% nth1_membro(+Number, +List, -Result) ==> nth1().
nth1_membro(1,[M|_],M).
nth1_membro(N,[_|T],M) :-
    N > 1,
    N1 is N-1,
    nth1_membro(N1,T,M).

% inverter(+Lista, -InvLista) ==> inverter uma lista
inverter(Lista,InvLista):
    -rev(Lista,[],InvLista).
rev([H|T],S,R):
    -rev(T,[H|S],R).
rev([],R,R).

% removeDups(+Lista, -ListaSemDups) ==> remover valores duplicados
removeDups([],[]).
removeDups([H|[H|T]],[H|OtherElems]) :-
     removeDups(T,OtherElems).
removeDups([H|T],[H|OtherElems]) :-
    removeDups(T,OtherElems).



% ------------------------------------------------------------------------------
% Base de Factos

% participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

% performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).


% ------------------------------------------------------------------------------
% Implemente o predicado madeItThrough(+Participant), que sucede se Participant
% é um participante que já atuou e em cuja atuação pelo menos um elemento do
% júri não carregou no botão.

% check_button_pressed(+Lista)
check_button_pressed([]):- fail.
check_button_pressed([Head|Tail]):-
  (Head == 120 ; check_button_pressed(Tail)).

% madeItThrough2(+Participant)
madeItThrough2(Participant):-
  performance(Participant, Lista),
  check_button_pressed(Lista).

% outra solução:

% madeItThrough(+Participant)
madeItThrough(Participant) :-
    performance(Participant, Times),
    member(120, Times).

% ------------------------------------------------------------------------------
% Implemente o predicado juriTimes(+Participants, +JuriMember, -Times, -Total),
% que devolve em Times o tempo de atuação de cada participante na lista
% Participants (pela mesma ordem) até que o júri número JuriMember (de 1 a E)
% carregou no botão, e em Total a soma desses tempos.


% juriTimes(+Participants, +JuriMember, -Times, -Total)
juriTimes([], _ , [], 0).
juriTimes([Head_Participants|Tail_Participants], JuriMember, [Head_Times|Tail_Times], Total):-
  juriTimes(Tail_Participants, JuriMember, Tail_Times, Total_Recursive),
  performance(Head_Participants, Avaliations),
  nth1_membro(JuriMember, Avaliations, Head_Times),
  Total is Total_Recursive + Head_Times.

% outra solução

% juriTimes(+Participants, +JuriMember, -Times, -Total)
juriTimes2([Head|[]], JuriMember, Times, Total):-
    performance(Head, ParticipantTimes),
    nth1_membro(JuriMember, ParticipantTimes, JuriTime),
    append([], [JuriTime], Times),
    Total is JuriTime.

juriTimes2([Head|Tail], JuriMember, Times, Total):-
    juriTimes2(Tail, JuriMember, Times1, Total1),
    performance(Head, ParticipantTimes),
    nth1_membro(JuriMember, ParticipantTimes, JuriTime),
    append([JuriTime], Times1, Times),
    Total is Total1 + JuriTime.

% ------------------------------------------------------------------------------
% Implemente o predicado patientJuri(+JuriMember) que sucede se o júri
% JuriMember já se absteve de carregar no botão pelo menos por duas vezes.

% patientJuri(+JuriMember)
patientJuri(JuriMember):-
    performance(P1, Times1),
    nth1_membro(JuriMember, Times1, 120),
    performance(P2, Times2),
    P1 =\= P2,
    nth1_membro(JuriMember, Times2, 120).


% ------------------------------------------------------------------------------
% Implemente o predicado bestParticipant(+P1, +P2, -P) que unifica P com o
% melhor dos dois participantes P1 e P2. O melhor participante é aquele que
% tem uma maior soma de tempos na sua atuação (independentemente de estar ou
%  não em condições de passar à próxima fase). Se ambos tiverem o mesmo tempo
%  total, o predicado deve falhar.

% sum_all(+Lista, -Resultado)
sum_all([], 0).
sum_all([Head|Tail], Result):-
  sum_all(Tail, Result2),
  Result is Result2+Head.

% unify_P(+P1, +P2, +Value_P1, +Value_P2, -P)
unify_P(_P1, P2, Value_P1, Value_P2, P):-
Value_P2 > Value_P1,
P is P2.

unify_P(P1, _P2, Value_P1, Value_P2, P):-
Value_P1 > Value_P2,
P is P1.

% bestParticipant(+P1, +P2, -P)
bestParticipant(P1, P2, P):-
    performance(P1, P1Times),
    performance(P2, P2Times),
    sum_all(P1Times, P1Sum),
    sum_all(P2Times, P2Sum),
    % (P1Sum > P2Sum -> P is P1 ; true),
    % (P2Sum > P1Sum -> P is P2 ; false).
    P1Sum \== P2Sum,
    unify_P(P1, P2, P1Sum, P2Sum, P).


% ------------------------------------------------------------------------------
% Implemente o predicado allPerfs, que imprime na consola os números dos
% participantes que já atuaram, juntamente com o nome da sua atuação e
% lista de tempos.

% allPerfs/0
allPerfs:-
  performance(Participant, Times),          %% on fail traceback comes here!
  once(participant(Participant, _Age, Song)),
  write(Participant), write(':'), write(Song), write(':'), write(Times), nl,
  fail.
allPerfs.

% ------------------------------------------------------------------------------
% Implemente o predicado nSuccessfulParticipants(-T) que determina quantos
% participantes não tiveram qualquer clique no botão durante a sua atuação.

% no_click_of_button(+List).
no_click_of_button([]).
no_click_of_button([120|T]):-
    no_click_of_button(T).

% nSuccessfulParticipants(-T).
nSuccessfulParticipants(T):-
    findall(Participant,
            (performance(Participant, Times), no_click_of_button(Times)),
            List),
    length(List, T).


% ------------------------------------------------------------------------------
% Implemente o predicado juriFans(juriFansList), que obtém uma lista contendo,
%  para cada participante, a lista dos elementos do júri que não carregaram
%  no botão ao longo da sua atuação.

get_favourite_juris([],[],_).
get_favourite_juris([120|Tail], [HeadJuri|TailJuri], Index):-
    HeadJuri is Index,
    NewIndex is Index + 1,
    get_favourite_juris(Tail, TailJuri, NewIndex).
get_favourite_juris([_|Tail], JuriList, Index):-
    NewIndex is Index + 1,
    get_favourite_juris(Tail, JuriList, NewIndex).

goal(Participant, JuriList):-
    performance(Participant, Times),
    once(get_favourite_juris(Times, JuriList, 1)).

% juriFans(-L).
juriFans(L):-
    findall(Participant-JuriList, goal(Participant, JuriList), L).



% ------------------------------------------------------------------------------
% O seguinte predicado permite obter participantes, suas atuações e tempos
% totais, que estejam em condições de passar à próxima fase: para um
% participante poder passar, tem de haver pelo menos um elemento do júri que
% não tenha carregado no botão durante a sua atuação.

eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).

% Fazendo uso deste predicado, implemente o predicado
% nextPhase(+N, -Participants), que obtém a lista com os tempos totais,
% números e atuações dos N melhores participantes, que passarão portanto
% à próxima fase. Se não houver pelo menos N participantes a passar, o
% predicado deve falhar.

% nextPhase(+N, -Participants).
nextPhase(N, Participants):-
    setof(SumTime-Id-Perf, eligibleOutcome(Id, Perf, SumTime), Participants),
    length(Participants, ListSize),
    ListSize >= N.

% ------------------------------------------------------------------------------
% Explique o que faz o predicado predX/3 apresentado abaixo.
% Indique ainda se o cut utilizado é verde ou vermelho, justificando
% a sua resposta.
predX(Q,[R|Rs],[P|Ps]) :-
    participant(R,I,P), I=<Q, !,
    predX(Q,Rs,Ps).
predX(Q,[R|Rs],Ps) :-
    participant(R,I,_), I>Q,
    predX(Q,Rs,Ps).
predX(_,[],[]).

/*
predX(Q,[Head_Id_Participante|Tail_Id_Participantes],[Head_Song|Tail_Song]) :-
    participant(Head_Id_Participante,Idade,Head_Song), Idade=<Q, !,
    predX(Q,Tail_Id_Participantes,Tail_Song).
predX(Q,[Head_Id_Participante|Tail_Id_Participantes],Ps) :-
    participant(Head_Id_Participante,Idade,_), Idade>Q,
    predX(Q,Tail_Id_Participantes,Ps).
predX(_,[],[]).
*/
    % Mudei nomes para ir percebendo o que fazia
    % Predicado é capaz de devolver, para um array de ids de participantes,
    % uma lista das musicas dos quais os seus interpretadores têm idade menor ou
    % igual a Q. O cut usado é verde, visto que a sua omissão não implica perda de
    % soluçoes, o cut neste caso permite-nos, caso o predX falhe, não
    % voltar em backtrack até situações em que já encontrou uma solução,
    % por exemplo:

    % | ?- predX(18, [1234, 4865, 8937], X).
    % X = ['PÃ© coxinho'] ?
    %
    % | ?- predX(19, [1234, 4865, 8937], X).
    % X = ['PÃ© coxinho','Pontes de pen-drives'] ?

    % | ?- predX(22, [1234, 4865, 8937], X).
    % X = ['PÃ© coxinho','Pontes de esparguete','Pontes de pen-drives'] ?

% ------------------------------------------------------------------------------
% Dado um número N, pretende-se determinar uma sequência de 2*N números que
% contenha, para todo o k ∈ [1,N], uma sub-sequência Sk = k,…,k começada e
% terminada com o número k e com k outros números de permeio. Por exemplo,
% a sequência [2, 3, 1, 2, 1, 3] cumpre os requisitos: os 1s têm 1 número
% no meio, os 2s têm 2 números no meio, e os 3s têm 3 números no meio.
% A sequência [2, 3, 4, 2, 1, 3, 1, 4] também cumpre. No entanto, alguns
% valores de N não têm solução possível.

% Explique o que faz o seguinte predicado:

 impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

    % O predicado permite verificar se no fim e no inicio da lista estao o numero X,
    % separados por X numeros, mais, permite gerar listas com estas caracteristicas
    % ou instanciar elementos de uma lista com elementos nao instanciados (usado no
    % proximo exercicio)

    % | ?- impoe(2,X).
    % X = [2,_A,_B,2|_C] ?

    % | ?- impoe(3,X).
    % X = [3,_A,_B,_C,3|_D] ?

    % | ?- impoe(4,X).
    % X = [4,_A,_B,_C,_D,4|_E] ?

    % | ?- impoe(5,X).
    % X = [5,_A,_B,_C,_D,_E,5|_F] ?

% ------------------------------------------------------------------------------
% Tirando partido do predicado anterior, implemente o predicado
% langford(+N,-L), em que N é um inteiro dado e L será uma sequência
% de 2*N números conforme indicado atrás. (Nota: Langford foi o matemático
% escocês que propôs este problema.)

%------------------ raciocinio, gerar lista 2*N
% | ?- length(X, 8), impoe(4,X).
% X = [4,_A,_B,_C,_D,4,_E,_F] ? ;
% X = [_A,4,_B,_C,_D,_E,4,_F] ? ;
% X = [_A,_B,4,_C,_D,_E,_F,4] ? ;

%  Aproveitar backtrack do prolog para pesquisar tudo pela solução que queremos
%------------------

impoe_restricoes(0, Lista, Lista).
impoe_restricoes(Numero, Lista, Lista_Final):-
  impoe(Numero,Lista), % aqui vai instanciar o que nao tiver instanciado...
  NewN is Numero -1,
  impoe_restricoes(NewN, Lista, Lista_Final).

% langford(+N,-L)
langford(N,L):-
  Size_List is 2*N,
  length(Lista_Nao_Instanciada, Size_List),
  impoe_restricoes(N, Lista_Nao_Instanciada, L).
% ------------------------------------------------------------------------------
