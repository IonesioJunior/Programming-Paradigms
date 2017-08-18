/* Visualization of battleship matrix with hidden ships */

printTrayPlayer(Tabuleiro) :-
  write('--------- BattleShip --------'),nl,
  write('   0  1  2  3  4  5  6  7  8'),nl,
  printMatrixPlayer(Tabuleiro, 0),
  write('Legenda:'),nl,
  write('~ = Água | ^ = Atirou na água | x = Acertou o navio'), nl, nl.

printMatrixPlayer([], _).
printMatrixPlayer([H|T], Index) :-
    write(Index), write('  '), printLinePlayer(H), nl,
    NewIndex is Index+1,
    printMatrixPlayer(T, NewIndex).

printLinePlayer([]).
printLinePlayer([H|T]) :-
  (H == '~', write('~');
  H == n, write('~');
  H == ^, write('^');
  H == x, write('x')), write('  '),
  printLinePlayer(T).

atirar(Tabuleiro, NovoTabuleiro) :-
  selecione,
  insert_number('Linha', Linha),
  insert_number('Coluna', Coluna), nl,
  (Linha >= 0, Linha =< 8, Coluna >= 0, Coluna =< 8 ->
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),
    (
    (Simbolo == ~) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, ^, NovoTabuleiro), errou, nl;
    (Simbolo == n) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, x, NovoTabuleiro), acertou, nl;
    (Simbolo == ^) -> invalido, atirar(Tabuleiro, NovoTabuleiro);
    (Simbolo == x) -> invalido, atirar(Tabuleiro, NovoTabuleiro)
    );
  selecaoInvalida, atirar(Tabuleiro, NovoTabuleiro)
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

hasShips([H|_]) :- contem(H, n).
hasShips([_|T]) :- hasShips(T).

/* Insert ships on the tray */

insertBattleship(Tabuleiro, NovoTabuleiro):-
    random(0,6,Linha),random(0,6,Coluna),random(0,2,Orientacao),
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, _),Coluna2 is Coluna+1,Coluna3 is Coluna+2,Coluna4 is Coluna+3, Linha2 is Linha+1,Linha3 is Linha+2,Linha4 is Linha+3,
 (
 (Orientacao == 0) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, n, Tabuleiro2),changeValueOnBoard(Tabuleiro2, Linha, Coluna2, n, Tabuleiro3),changeValueOnBoard(Tabuleiro3, Linha, Coluna3, n, Tabuleiro4),changeValueOnBoard(Tabuleiro4, Linha, Coluna4, n, NovoTabuleiro);
 (Orientacao == 1) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, n, Tabuleiro2),changeValueOnBoard(Tabuleiro2, Linha2, Coluna, n, Tabuleiro3),changeValueOnBoard(Tabuleiro3, Linha3, Coluna, n, Tabuleiro4),changeValueOnBoard(Tabuleiro4, Linha4, Coluna, n, NovoTabuleiro)

 ).

insertCruiser(Tabuleiro, NovoTabuleiro):-
    random(0,8,Linha),random(0,8,Coluna),random(0,2,Orientacao),
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),Coluna2 is Coluna+1, Linha2 is Linha+1, encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna2, Simbolo2),encontraSimboloNaMatriz(Tabuleiro, Linha2, Coluna, Simbolo3),
 (
 (Simbolo == ~), (Simbolo2 == ~), (Orientacao == 0) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, n, Tabuleiro2),changeValueOnBoard(Tabuleiro2, Linha, Coluna2, n, NovoTabuleiro);
 (Simbolo == ~), (Simbolo3 == ~), (Orientacao == 1) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, n, Tabuleiro2),changeValueOnBoard(Tabuleiro2, Linha2, Coluna, n, NovoTabuleiro);
 (Orientacao == 0),((Simbolo == n);(Simbolo2 == n))-> insertCruiser(Tabuleiro, NovoTabuleiro);
 (Orientacao == 1),((Simbolo == n);(Simbolo3 == n))-> insertCruiser(Tabuleiro, NovoTabuleiro)

 ).

insertMinesweeper(Tabuleiro, NovoTabuleiro):-random(0,9,Linha),random(0,9,Coluna),
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),
 (
 (Simbolo == ~) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, n, NovoTabuleiro);
 (Simbolo == n) -> insertMinesweeper(Tabuleiro, NovoTabuleiro)
 ).

generateTray([[~,~,~,~,~,~,~,~,~],
              [~,~,~,~,~,~,~,~,~],
              [~,~,~,~,~,~,~,~,~],
              [~,~,~,~,~,~,~,~,~],
              [~,~,~,~,~,~,~,~,~],
              [~,~,~,~,~,~,~,~,~],
              [~,~,~,~,~,~,~,~,~],
              [~,~,~,~,~,~,~,~,~],
              [~,~,~,~,~,~,~,~,~]]).

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
  printTrayPlayer(Tabuleiro),
  atirar(Tabuleiro, NovoTabuleiro), NovosMisseis is Misseis-1,
  (
  not( hasShips(NovoTabuleiro) ) -> imprimeTabuleiroReal(NovoTabuleiro), vitoria;
  (NovosMisseis > 1 -> misseis(NovosMisseis), play(NovoTabuleiro, NovosMisseis);
  NovosMisseis =:= 1 -> ultimoMissel, play(NovoTabuleiro, NovosMisseis);
  NovosMisseis =:= 0 -> misseisEsgotados, gameOver)
  ).

/*imprimeTabuleiroReal(NovoTabuleiro), */

imprimeTabuleiroReal(Tabuleiro) :-
  write('---------  Battleship Real  --------'),nl,nl,
  write('   0   1   2   3   4   5   6   7   8'),nl,nl,
  printLines(Tabuleiro, 0),
  write('Legenda:'),nl,
  write('~ = Água | n = NAVIO | ^ = Atirou na água | x = Acertou o navio'), nl, nl.

printLines([], _).
printLines([H|T], Index) :-
  write(Index), write('  '), imprimeLinha(H), nl,nl,
  NewIndex is Index+1,
  printLines(T, NewIndex).

imprimeLinha([]).
imprimeLinha([H|T]) :-
  write(H), write('   '),
  imprimeLinha(T).

acertou :-
  write('Acertou!'), nl.

errou :-
  write('Errou!'), nl.

invalido :-
  write('Você já atirou aqui!.'), nl.

selecione :-
  write('Selecione as coordenadas de onde deseja atirar.'), nl.

selecaoInvalida :-
  write('Coordenadas inválidas. Coloque uma diferente.'), nl.

misseis(Qtd) :-
  write('Você ainda tem '), write(Qtd), write(' mísseis.'), nl, nl.

ultimoMissel :-
  write('Resta apenas um míssel!'), nl, nl.

misseisEsgotados :-
  write('Seus mísseis acabaram!'),nl.

gameOver :-
  nl,
  write('You Lose!'),nl,nl.

vitoria :-
  nl,
  write('You Win!').

insert_number(Prompt, Numero) :-
  write(Prompt),
  write(': '),
  read(Numero).

:- initialization(main).
main :-
  write("Digite a quantidade de tiros que deseja ter: "),
  read(N),
  generateTray(TabuleiroRamdomicoAux),
  insertShips(TabuleiroRamdomicoAux, TabuleiroRamdomico),
  play(TabuleiroRamdomico, N).