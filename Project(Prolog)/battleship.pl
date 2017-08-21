/* Visualization of battleship matrix with hidden ships */

showMenu(Map) :-
  write('  ===== Batalha Naval ======\n\n'),
  printMatrixPlayer(Map, 0),
  write('1 - BattleShip\n2 - Cruiser\n3 - Minesweeper \nx - Erro\n\n').

printTrayPlayer(Map) :-
  write('  ===== Batalha Naval ======\n\n'),
  printMatrixPlayer(Map, 0).

printMatrixPlayer([], _).
printMatrixPlayer([H|T], Index) :-
    write('  '), printLinePlayer(H), nl,
    NewIndex is Index+1,
    printMatrixPlayer(T, NewIndex).

printLinePlayer([]).
printLinePlayer([H|T]) :-
  (H == 0, write('~');
  H == 1, write('~');
  H == 2, write('~');
  H == 3, write('~');
  H == '1', write('1');
  H == '2', write('2');
  H == '3', write('3');
  H == x, write('x')), write('  '),
  printLinePlayer(T).

shoot(Tabuleiro, NovoTabuleiro) :-
  write('\n Onde deseja atirar? \n'),
  insert_number('Linha', Linha),
  insert_number('Coluna', Coluna), nl,
  (Linha >= 0, Linha =< 8, Coluna >= 0, Coluna =< 8 ->
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),
    (
    (Simbolo == 0) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, x, NovoTabuleiro), write("Errou!!\n\n");
    (Simbolo == 1) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, '1', NovoTabuleiro), write("Acertou!!\n\n");
    (Simbolo == 2) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, '2', NovoTabuleiro), write("Acertou!!\n\n");
    (Simbolo == 3) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, '3', NovoTabuleiro), write("Acertou!!\n\n");
    (Simbolo == x) -> shoot(Tabuleiro, NovoTabuleiro)
    );
  write('Coordenadas Inválidas\n'), atirar(Tabuleiro, NovoTabuleiro)
  ).

changeValueOnBoard([H|T], 0, Coluna, NovoValor, [J|T]) :- substituir(H, Coluna, NovoValor, J).
 changeValueOnBoard([H|T], Linha, Coluna, NovoValor, [H|U]) :-
   Linha1 is Linha - 1, changeValueOnBoard(T, Linha1, Coluna, NovoValor, U).

encontraSimboloNaMatriz(Matriz, Linha, Coluna, Simbolo) :-
  nth0(Linha, Matriz, ListaDaPos),
  nth0(Coluna, ListaDaPos, Simbolo).

substituir([_|T], 0, X, [X|T]).
substituir([H|T], Index, NewElement, [H|U]) :-
  Index1 is Index - 1, substituir(T, Index1, NewElement, U).

/* Checks if some ship stay on the matrix*/

contem([X|_], X).
contem([_|T], X) :-
  contem(T, X).

hasShips([H|_]) :- contem(H, 1).
hasShips([_|T]) :- hasShips(T).

hasShips([H|_]) :- contem(H, 2).
hasShips([_|T]) :- hasShips(T).

hasShips([H|_]) :- contem(H, 3).
hasShips([_|T]) :- hasShips(T).
/* Insert ships on the tray */

insertBattleship(Tabuleiro, NovoTabuleiro):-
    random(0,6,Linha),random(0,6,Coluna),
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, _),Coluna2 is Coluna+1,Coluna3 is Coluna+2,Coluna4 is Coluna+3, Linha2 is Linha+1,Linha3 is Linha+2,Linha4 is Linha+3,
    changeValueOnBoard(Tabuleiro, Linha, Coluna, 1, Tabuleiro2),changeValueOnBoard(Tabuleiro2, Linha, Coluna2, 1, Tabuleiro3),changeValueOnBoard(Tabuleiro3, Linha, Coluna3, 1, Tabuleiro4),changeValueOnBoard(Tabuleiro4, Linha, Coluna4, 1, NovoTabuleiro).


insertCruiser(Tabuleiro, NovoTabuleiro):-
    random(0,8,Linha),random(0,8,Coluna),
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),Coluna2 is Coluna+1, Linha2 is Linha+1, encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna2, Simbolo2),encontraSimboloNaMatriz(Tabuleiro, Linha2, Coluna, Simbolo3),
 (
 (Simbolo == 0), (Simbolo2 == 0) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, 2, Tabuleiro2),changeValueOnBoard(Tabuleiro2, Linha, Coluna2, 2, NovoTabuleiro);
 ((Simbolo \= 0);(Simbolo2 \= 0))-> insertCruiser(Tabuleiro, NovoTabuleiro)
 ).

insertMinesweeper(Tabuleiro, NovoTabuleiro):-random(0,9,Linha),random(0,9,Coluna),
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),
 (
 (Simbolo == 0) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, 3, NovoTabuleiro);
 (Simbolo \= 0) -> insertMinesweeper(Tabuleiro, NovoTabuleiro)
 ).

buildMat([[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]).

insertShips(Tabuleiro, NovoTabuleiro):-
  insertBattleship(Tabuleiro, Tabuleiro2),
	insertCruiser(Tabuleiro2, Tabuleiro3),
	insertCruiser(Tabuleiro3, Tabuleiro4),
	insertMinesweeper(Tabuleiro4, Tabuleiro5),
	insertMinesweeper(Tabuleiro5, Tabuleiro6),
	insertMinesweeper(Tabuleiro6, Tabuleiro7),
	insertMinesweeper(Tabuleiro7, NovoTabuleiro).

play(Tabuleiro, Misseis) :-
  Misseis > 0,
  shoot(Tabuleiro, NovoTabuleiro), NovosMisseis is Misseis-1,
  printTrayPlayer(NovoTabuleiro),
  (
  not( hasShips(NovoTabuleiro) ) -> write('\nYou Win!!\n');
  (NovosMisseis > 1 ->  play(NovoTabuleiro, NovosMisseis);
  NovosMisseis =:= 1 -> play(NovoTabuleiro, NovosMisseis);
  NovosMisseis =:= 0 -> showRealMap(NovoTabuleiro), write('\nYou Lose!\n\n'))
  ).


showRealMap(Tabuleiro) :-
    write('\n\n  ======= Real Map ========\n\n'),
    printLines(Tabuleiro, 0).

printLines([], _).
  printLines([H|T], Index) :-
    write('  '), imprimeLinha(H), nl,
    NewIndex is Index+1,
    printLines(T, NewIndex).

imprimeLinha([]).
  imprimeLinha([H|T]) :-
    write(H), write('  '),
    imprimeLinha(T).

insert_number(Prompt, Numero) :-
  write(Prompt),
  write(': '),
  read(Numero).

:- initialization(main).
main :-
  write('Digite a quantidade de tiros que deseja ter: '),
  read(N),
  buildMat(InitialMap),
  insertShips(InitialMap, Map), showMenu(Map),
  play(Map, N).
