/* Visualization of battleship matrix with hidden ships */

showMenu(Map) :-
  write('  ===== Battle Ship ======\n\n'),
  printMatrixPlayer(Map, 0),
  write('1 - BattleShip\n - Cruiser\n - Minesweeper\n - Erro\n').

printTrayPlayer(Map) :-
  write('  ===== Battle Ship ======\n\n'),
  printMatrixPlayer(Map, 0).

printMatrixPlayer([], _).
printMatrixPlayer([H|T], Index) :-
    write('  '), printLinePlayer(H), nl,
    NewIndex is Index+1,
    printMatrixPlayer(T, NewIndex).

printLinePlayer([]).
printLinePlayer([H|T]) :-  (H == 0,
				write('~');
  			    H == 1,
			    	write('~');
  			    H == 2,
			    	write('~');
  			    H == 3,
			    	write('~');
  			    H == '1',
			    	write('1');
  			    H == '2',
			    	write('2');
  			    H == '3',
			    	write('3');
  			    H == x,
			    	write('x')),
					write('  '),
  			printLinePlayer(T).



shoot(Matrix, newMatrix) :-  write('\n Onde deseja atirar? \n'),
  				insert_number('X Coord : ', X), insert_number('Y Coord : ', Y), nl,
  						(X >= 0, X =< 8, Y >= 0, Y =< 8 ->  findSymbol(Matrix, X, Y, Symbol),(
    (Symbol == 0) -> changeValueOnBoard(Matrix, X, Y, x, newMatrix), write("Errou!!\n\n");(Symbol == 1) -> changeValueOnBoard(Matrix, X, Y, '1', newMatrix), write("Acertou!!\n\n");
    (Symbol == 2) -> changeValueOnBoard(Matrix, X, Y, '2', newMatrix), write("Acertou!!\n\n");(Symbol == 3) -> changeValueOnBoard(Matrix, X, Y, '3', newMatrix), write("Acertou!!\n\n");
    (Symbol == x) -> shoot(Matrix, newMatrix));
  				write('Wrong Coord\n'), shoot(Matrix, newMatrix)).



changeValueOnBoard([H|T], 0, Y, value, [J|T]) :- replace(H, Y, value, J).
changeValueOnBoard([H|T], X, Y, value, [H|U]) :- X1 is X - 1, changeValueOnBoard(T, X1, Y, value, U).

findSymbol(Matrix, X, Y, Symbol) :-nth0(X, Matrix, Pos),nth0(Y, Pos, Symbol).

replace([_|T], 0, X, [X|T]).
replace([H|T], Index, NewElement, [H|U]) :- Index1 is Index - 1, replace(T, Index1, NewElement, U).

/* Checks if some ship stay on the matrix*/

containsElement([X|_], X).
containsElement([_|T], X) :- containsElement(T, X).

hasShips([H|_]) :- containsElement(H, 1).
hasShips([_|T]) :- hasShips(T).

hasShips([H|_]) :- containsElement(H, 2).
hasShips([_|T]) :- hasShips(T).

hasShips([H|_]) :- containsElement(H, 3).
hasShips([_|T]) :- hasShips(T).

/* Insert ships on the tray */

insertBattleship(Matrix, newMatrix):- random(0,6,X),random(0,6,Y),
    				      findSymbol(Matrix, X, Y, _), 
				      			Y2 is Y+1,
							Y3 is Y+2,
							Y4 is Y+3, 
							X2 is X+1,
							X3 is X+2,
							X4 is X+3,
    				      			changeValueOnBoard(Matrix, X, Y, 1, Matrix2),
				      			changeValueOnBoard(Matrix2, X, Y2, 1, Matrix3),
							changeValueOnBoard(Matrix3, X, Y3, 1, Matrix4),
							changeValueOnBoard(Matrix4, X, Y4, 1, Matrix).


insertCruiser(Matrix, newMatrix):- random(0,8,X),random(0,8,Y),
    				   findSymbol(Matrix, X, Y, Symbol),
				   			Y2 is Y+1, 
							X2 is X+1,
				   findSymbol(Matrix, X, Y2, Symbol2),
				   findSymbol(Matrix, X2, Y, Symbol3),((Symbol == 0), (Symbol2 == 0) -> changeValueOnBoard(Matrix, X, Y, 2, Matrix2),
				   changeValueOnBoard(Matrix2, X, Y2, 2, newMatrix);
 							((Symbol \= 0);(Symbol2 \= 0))-> insertCruiser(Tabuleiro, NovoTabuleiro)).

insertMinesweeper(Matrix, newMatrix):- random(0,9,X),random(0,9,Y),
    				       findSymbol(Matrix, X, Y, Symbol),((Symbol == 0) -> changeValueOnBoard(Tabuleiro, Linha, Coluna, 3, NovoTabuleiro);
 				       (Symbol \= 0) -> insertMinesweeper(Matrix, newMatrix)).

buildMat([[0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0]]).

insertShips(Matrix, newMatrix):-  insertBattleship(Matrix, Matrix2),
				  insertCruiser(Matrix2, Matrix3),
				  insertCruiser(Matrix3, Matrix4),
				  insertMinesweeper(Matrix4, Matrix5),
				  insertMinesweeper(Matrix5, Matrix6),
				  insertMinesweeper(Matrix6, Matrix7),
				  insertMinesweeper(Matrix7, newMatrix).

play(Matrix, shots) :- shots > 0,
  		       shoot(Matrix, newMatrix), newShots is shots-1,
  		       printTrayPlayer(newMatrix),( not( hasShips( newMatrix ) ) -> write('\nYou Win!!\n');
  		       (newShots > 1 ->  play(newMatrix, newShots);
  		       newShots =:= 1 -> play(newMatrix, newShots);
  		       newShots =:= 0 -> showRealMap(newMatrix), write('\nYou Lose!\n\n'))).


showRealMap(Tabuleiro) :-
    write('\n\n  ======= Real Map ========\n\n'),
    printLines(Tabuleiro, 0).

printLines([], _).
printLines([H|T], Index) :- write('  '), printLine(H), nl,
    						NewIndex is Index+1,
    						printLines(T, NewIndex).

printLine([]).
printLine([H|T]) :- write(H), write('  '), printLine(T).

insert_number(Prompt, Number) :- write(Prompt),
  				 write(': '),
  				 read(Number).

:- initialization(main).
main :-
  write('Digite a quantidade de tiros que deseja ter: '),
  read(N),
  buildMat(InitialMap),
  insertShips(InitialMap, Map), showMenu(Map),
  play(Map, N).
