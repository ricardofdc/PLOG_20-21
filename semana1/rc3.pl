nome('Os Maias').
tipo('Os Maias', livro).
tipo('Os Maias', romance).
tipo('Os Maias', ficção).
autor('Os Maias', 'Eça de Queiroz').
nacionalidade('Eça de Queiroz', português).
linguagem('Os Maias', inglês).

% PERGUNTAS

% a)
:- autor('Os Maias', Autor), write('Autor de\'OsMaias\': '), write(Autor), nl.

% b)
:- findall(
    Autor,
    (nacionalidade(Autor, português),
    autor(Livro, Autor),
    tipo(Livro, romance)),
    Autores),
write('Autores portugueses que escreveram romances: '), write(Autores), nl.

% c)
:- findall(
    Autor,
    (
        autor(Livro, Autor),
        tipo(Livro, ficção),
        tipo(Livro2, Tipo),
        Livro \= Livro2,
        Tipo \= ficção
    ),
    Autores
) ,
write('Autores de livros de ficção que escreveram livros de outro tipo: '), write(Autores), nl.
