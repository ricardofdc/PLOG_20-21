% a)
factorial(0,1).
factorial(N, Valor) :-
    N>0,
    N1 is N-1,
    factorial(N1, Valor1),
    Valor is N*Valor1.

% b)
fibonacci(0,1).
fibonacci(1,1).
fibonacci(N, Valor) :-
    N>1,
    N1 is N-1,
    fibonacci(N1, F1),
    N2 is N-2,
    fibonacci(N2, F2),
    Valor is F1+F2.
