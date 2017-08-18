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
atirar(Tabuleiro, NovoTabuleiro) :-
  selecione,
  inserir_numero('Linha', Linha),
  inserir_numero('Coluna', Coluna), nl,
  (Linha >= 0, Linha =< 8, Coluna >= 0, Coluna =< 8 ->
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),
    (
    (Simbolo == ~) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, @, NovoTabuleiro), errou, nl;
    (Simbolo == n) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, x, NovoTabuleiro), acertou, nl;
    (Simbolo == @) -> invalido, atirar(Tabuleiro, NovoTabuleiro);
    (Simbolo == x) -> invalido, atirar(Tabuleiro, NovoTabuleiro)
    );
  selecaoInvalida, atirar(Tabuleiro, NovoTabuleiro)
  ).

 alteraValorNoTabuleiro([H|T], 0, Coluna, NovoValor, [J|T]) :- substituir(H, Coluna, NovoValor, J).
 alteraValorNoTabuleiro([H|T], Linha, Coluna, NovoValor, [H|U]) :-
   Linha1 is Linha - 1, alteraValorNoTabuleiro(T, Linha1, Coluna, NovoValor, U).

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




