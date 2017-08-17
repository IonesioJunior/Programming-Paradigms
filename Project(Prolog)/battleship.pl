insertMinesweeper(Tabuleiro, NovoTabuleiro):-random(0,9,Linha),random(0,9,Coluna),
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),
 (
 (Simbolo == ~) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, n, NovoTabuleiro);
 (Simbolo == n) -> insertMinesweeper(Tabuleiro, NovoTabuleiro)
 ).

gerarTabuleiro([[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~]]).

inserirNavios(Tabuleiro, NovoTabuleiro):-
        inserirBattleShip(Tabuleiro, Tabuleiro2),
	inserirCruiser(Tabuleiro2, Tabuleiro3),
	inserirCruiser(Tabuleiro3, Tabuleiro4),
	insertMinesweeper(Tabuleiro4, Tabuleiro5),
	insertMinesweeper(Tabuleiro5, Tabuleiro6),
	insertMinesweeper(Tabuleiro6, Tabuleiro7),
	insertMinesweeper(Tabuleiro7, NovoTabuleiro).



