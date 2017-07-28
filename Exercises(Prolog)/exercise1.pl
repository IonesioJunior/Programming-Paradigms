estacionamento(moto,5).
estacionamento(carro,10).
estacionamento(largo,30).

:- initialization main.

main :-
	read_line_to_codes(user_input, A2),
	string_to_atom(A2,A1),
	estacionamento(A1, Y),
	write(Y).

