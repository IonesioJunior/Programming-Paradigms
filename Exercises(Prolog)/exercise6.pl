insert(X, L, [X|L]).

readElements(0, []).
readElements(T, N) :- read_line_to_codes(user_input, X2),
             string_to_atom(X2,X1),
             atom_number(X1,X),
             insert(X, LF, N),
             G is T - 1,
             readElements(G, LF).

sum([], []).
sum([H|T], [H2|T2]) :- S is H + H2, write(S),nl, soma(T, T2).

:- initialization main.

main:-
  read_line_to_codes(user_input, T2),
  string_to_atom(T2,T1),
  atom_number(T1,T),
  readElements(T, L1),
  readElements(T, L2),
  sum(L1, L2).
