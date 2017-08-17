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

/* Execução da lógica sequencial do jogo */

play(Tabuleiro, Misseis) :-
  Misseis > 0,
  imprimeTabuleiroJogador(Tabuleiro),
  atirar(Tabuleiro, NovoTabuleiro), NovosMisseis is Misseis-1,
  (
  not( existemNavios(NovoTabuleiro) ) -> imprimeTabuleiroReal(NovoTabuleiro), vitoria;
 (NovosMisseis > 1 -> misseis(NovosMisseis), jogar(NovoTabuleiro, NovosMisseis);
  NovosMisseis =:= 1 -> ultimoMissel, jogar(NovoTabuleiro, NovosMisseis);
  NovosMisseis =:= 0 -> misseisEsgotados, imprimeTabuleiroReal(NovoTabuleiro), gameOver)
  ).

/* Execução do programa */
:- initialization(main).
main :-
   write("Digite a quantidade de tiros que deseja ter: "),
   read(N),
   gerarTabuleiro(TabuleiroRamdomicoAux),
   inserirNavios(TabuleiroRamdomicoAux, TabuleiroRamdomico),
   play(TabuleiroRamdomico, N).




