exibirLetra(0, [H|T], H).
exibirLetra(I, [H|T], C) :- Z is I - 1, 
			   exibirLetra(Z, T, C).

:- initialization main.

main:-
	read_line_to_codes(user_input, A1),
	string_to_atom(A1,A2),
	atom_number(A2,A),
	read_line_to_codes(user_input, B1),
	string_to_atom(B1,B2),
	atom_number(B2,B),
	read_line_to_codes(user_input, C1),
	string_to_atom(C1,C2),
	atom_number(C2,C),
	read_line_to_codes(user_input, D1),
	string_to_atom(D1,D2),
	atom_number(D2,D),
	read_line_to_codes(user_input, E1),
	string_to_atom(E1,E2),
	string_chars(E2, L1),
	read_line_to_codes(user_input, F1),
	string_to_atom(F1,F2),
	string_chars(F2, L2),
	read_line_to_codes(user_input, G1),
	string_to_atom(G1,G2),
	string_chars(G2, L3),
	read_line_to_codes(user_input, H1),
	string_to_atom(H1,H2),
	string_chars(H2, L4),
	exibirLetra(A, L1, Z1),
	exibirLetra(B, L2, Z2),
	exibirLetra(C, L3, Z3),
	exibirLetra(D, L4, Z4),
	write(Z1),
	write(Z2),
	write(Z3),
	write(Z4), nl.
