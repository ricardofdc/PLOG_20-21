:- use_module(library(lists)).
?- lista([a,[b],c,[d]]) = lista([_|[X|X]]). % false
?- lista([[a],[b],C])=lista([C,B,[a]]).     % C=[a], B=[b].
?- lista([c,c,c])=lista([X|[X|_]]).         % X=c.
?- lista([a,[b,c]])=lista([A,B,C]).         % false (A=a, B=[b,c], C nao existe)
?- [joao,gosta,peixe]=[X,Y,Z].              % X=joao, Y=gosta, Z=peixe.
?- [gato]= lista([X|Y]).                    % false
?- [vale,dos,sinos])=[sinos,X,Y].           % false
?- [branco,Q]=[P,cavalo].                   % Q=cavalo, P=branco.
?- [1,2,3,4,5,6,7]=[X,Y,Z|D].               % x=1, Y=2, Z=3, D=[4,5,6,7].
