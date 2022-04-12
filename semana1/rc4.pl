comida(peru).
comida(frango).
comida(salmão).
comida(solha).
bebida(cerveja).
bebida(vinho_verde).
bebida(vinho_maduro).

mulher(ana).
mulher(bárbara).
homem(antónio).
homem(bruno).
casado(antónio, ana).
casado(bruno, bárbara).

gosta(ana, frango).
gosta(ana, vinho_verde).
gosta(bárbara, peru).
gosta(bárbara, vinho_maduro).
gosta(antónio, salmão).
gosta(antónio, cerveja).
gosta(bruno, solha).
gosta(bruno, cerveja).

combina(peru, vinho_verde).
combina(frango, cerveja).
combina(salmão, vinho_maduro).
combina(solha, vinho_verde).

% PERGUNTAS

/* a)
x :- casado(bruno, ana),
gosta(bruno, vinho_verde),
gosta(ana, vinho_verde).
:- x. */

% b)
:- combina(salmão, Bebida), write('Bebida que combina com salmão: '), write(Bebida), nl.

% c)
:- findall(
    Comida,
    combina(Comida, vinho_verde),
    Comidas
), write('Comidas que combinam com vinho verde: '), write(Comidas), nl.
