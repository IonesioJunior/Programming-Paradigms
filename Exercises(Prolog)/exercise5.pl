count(W, [], 0).
count(W, [W|L], X) :- contar(W, L, G), X is 1 + G.
count(W, [D|L], X) :- contar(W, L, X).

:- initialization main.

main:-
  read_line_to_codes(user_input, A1),
  string_to_atom(A1, A),
  read_line_to_codes(user_input, L2),
  string_chars(L2, L),
  count(A, L, X),
  write(X).
