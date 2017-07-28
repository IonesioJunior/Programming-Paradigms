aviao(A, B) :- read_line_to_codes(user_input, X2),
               string_to_atom(X2,X1),
               atom_number(X1,X),
               calculo(A, B, X).

calculo(A, B, X) :- (B =:= A; X =:= A), write("OK").
calculo(A, B, X) :- (abs(A - B) > abs(A - X)), write("ADEQUADO"),nl, aviao(A, X).
calculo(A, B, X) :- write("PERIGO"),nl, aviao(A, X).

:- initialization main.

main:-
  read_line_to_codes(user_input, A2),
  string_to_atom(A2,A1),
  atom_number(A1,A),
  read_line_to_codes(user_input, B2),
  string_to_atom(B2,B1),
  atom_number(B1,B),
  aviao(A, B).
