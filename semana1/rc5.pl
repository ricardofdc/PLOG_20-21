homem(joão).
mulher(maria).
mulher(ana).
animal(cão).
animal(gato).
animal(tigre).
jogo(xadrez).
jogo(damas).
desporto(ténis).
desporto(natação).

mora_em(joão, casa).
mora_em(maria, apartamento).
mora_em(ana, apartamento).

gosta_de(joâo, cão).
gosta_de(joão, ténis).
gosta_de(maria, xadrez).
gosta_de(maria, tigre).
gosta_de(maria, natação).
gosta_de(maria, ténis).
gosta_de(ana, damas).
gosta_de(ana, gato).
gosta_de(ana, natação).

% PERGUNTAS

% a)
:- findall(
    Pessoa,
    (
        mora_em(Pessoa, apartamento),
        gosta_de(Pessoa, Animal),
        animal(Animal)
    ),
    Pessoas
), write("a) Moram num apartamento e gostam de animais: "), write(Pessoas), nl, nl.

% b)
:-write(
'b)
mora_em(joão, casa),
mora_em(maria, casa),
gosta_de(joão, Desporto),
desporto(Desporto),
gosta_de(maria, Desporto2),
desporto(Desporto2). '), nl.
:- write('O João e a Maria moram numa casa e gostam de desportos? R:Não.'), nl, nl.

% c)
:- findall(
    Pessoa,
    (
        gosta_de(Pessoa, Jogo),
        gosta_de(Pessoa, Desporto),
        jogo(Jogo),
        desporto(Desporto)
    ),
    Pessoas
),
sort(Pessoas, Pessoas_sort),
write('c) Gostam de jogos e de desportos: '), write(Pessoas_sort), nl, nl.

% d)
:- write(
'd)
mulher(Mulher),
gosta_de(Mulher, ténis),
gosta_de(Mulher, tigre). '), nl.
:- write('Alguma mulher gosta de ténis e de tigres? R:Sim.'), nl, nl.
