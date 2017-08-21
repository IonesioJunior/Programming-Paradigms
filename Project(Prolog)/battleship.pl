/* Visualization of battleship matrix with hidden ships */

buildMat([[0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0],
	  [0,0,0,0,0,0,0,0,0]]).

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

shoot(Matrix, NewMatrix) :-  write('\n Onde deseja atirar? \n'),
  				insert_number('X Coord : ', X), insert_number('Y Coord : ', Y), nl,
  						(X >= 0, X =< 8, Y >= 0, Y =< 8 ->  findSymbol(Matrix, X, Y, Symbol),(
    (Symbol == 0) -> changeValueOnBoard(Matrix, X, Y, x, NewMatrix), write("Miss!!\n");(Symbol == 1) -> changeValueOnBoard(Matrix, X, Y, '1', NewMatrix), write("Acertou!!\n\n");
    (Symbol == 2) -> changeValueOnBoard(Matrix, X, Y, '2', NewMatrix), write("Hit!!\n");(Symbol == 3) -> changeValueOnBoard(Matrix, X, Y, '3', NewMatrix), write("Acertou!!\n\n");
    (Symbol == x) -> shoot(Matrix, NewMatrix));
  				write('Wrong Coord\n'), shoot(Matrix, NewMatrix)).


play(Matrix, Shots) :- Shots > 0,
  		       shoot(Matrix, NewMatrix), NewShots is Shots-1,
  		       printTrayPlayer(NewMatrix),( not( hasShips( NewMatrix ) ) -> write('\nYou Win!!\n');
  		       (NewShots > 1 ->  play(NewMatrix, NewShots);
  		       NewShots =:= 1 -> play(NewMatrix, NewShots);
  		       NewShots =:= 0 -> showRealMap(NewMatrix), write('\nYou Lose!\n\n'))).
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






changeValueOnBoard([H|T], 0, Y, Value, [J|T]) :- replace(H, Y, Value, J).
changeValueOnBoard([H|T], X, Y, Value, [H|U]) :- X1 is X - 1, changeValueOnBoard(T, X1, Y, Value, U).

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

insertBattleship(Matrix, NewMatrix):- random(0,6,X),random(0,6,Y),
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


insertCruiser(Matrix, NewMatrix):- random(0,8,X),random(0,8,Y),
    				   findSymbol(Matrix, X, Y, Symbol),
				   			Y2 is Y+1, 
							X2 is X+1,
				   findSymbol(Matrix, X, Y2, Symbol2),
				   findSymbol(Matrix, X2, Y, Symbol3),((Symbol == 0), (Symbol2 == 0) -> changeValueOnBoard(Matrix, X, Y, 2, Matrix2),
				   changeValueOnBoard(Matrix2, X, Y2, 2, NewMatrix);
 							((Symbol \= 0);(Symbol2 \= 0))-> insertCruiser(Matrix, NewMatrix)).

insertMinesweeper(Matrix, NewMatrix):- random(0,9,X),random(0,9,Y),
    				       findSymbol(Matrix, X, Y, Symbol),((Symbol == 0) -> changeValueOnBoard(Matrix, X, Y, 3, NewMatrix);
 				       (Symbol \= 0) -> insertMinesweeper(Matrix, NewMatrix)).



insertShips(Matrix, NewMatrix):-  insertBattleship(Matrix, Matrix2),
				  insertCruiser(Matrix2, Matrix3),
				  insertCruiser(Matrix3, Matrix4),
				  insertMinesweeper(Matrix4, Matrix5),
				  insertMinesweeper(Matrix5, Matrix6),
				  insertMinesweeper(Matrix6, Matrix7),
				  insertMinesweeper(Matrix7, NewMatrix).




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
