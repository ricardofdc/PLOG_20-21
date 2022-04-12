piloto(lamb).
piloto(besenyei).
piloto(chambliss).
piloto(macLean).
piloto(mangold).
piloto(jones).
piloto(bonhomme).

piloto_equipa(lamb, breitling).
piloto_equipa(besenyei, redBull).
piloto_equipa(chambliss, redBull).
piloto_equipa(macLean, mediterraneanRacingTeam).
piloto_equipa(mangold, cobra).
piloto_equipa(jones, matador).
piloto_equipa(bonhomme, matador).

aviao(lamb, mx2).
aviao(besenyei, edge540).
aviao(chambliss, edge540).
aviao(macLean, edge540).
aviao(mangold, edge540).
aviao(jones, edge540).
aviao(bonhomme, edge540).

circuito(instanbul).
circuito(budapest).
circuito(porto).

venceu(jones, porto).
venceu(mangold, budapest).
venceu(mangold, instanbul).

gates(instanbul, 9).
gates(budapest, 6).
gates(porto, 5).

ganhou(Equipa,Corrida) :- piloto_equipa(Piloto,Equipa), venceu(Piloto,Corrida).

% PERGUNTAS

% a)
:- venceu(X, porto), write(piloto_venceu_corrida_porto: X), nl.

% b)
:- ganhou(X, porto), write(equipa_ganhou_corrida_porto: X), nl.

% c)
:- findall(
      Piloto,
      (
        venceu(Piloto, Circuito1),
        venceu(Piloto, Circuito2),
        Circuito1 \= Circuito2
      ),
      Pilotos
    ),
    write(polotos_venceram_mais_do_que_um_circuito: Pilotos), nl.

% d)
:- findall(
      Circuito,
      (
        gates(Circuito, Gates),
        Gates > 8
      ),
      Circuitos
    ),
    write(circuitos_com_mais_de_8_gates: Circuitos), nl.

% e)
:- findall(
      Piloto,
      (
        aviao(Piloto, Aviao),
        Aviao \= edge540
      ),
      Pilotos
    ), write(pilotos_que_nao_pilotam_edge540: Pilotos), nl.
