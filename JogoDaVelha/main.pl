% Função para mostrar o tabuleiro
mostrarTab([]) :-
  nl.

mostrarTab([L|T]) :-
  print(L),
  nl,
  mostrarTab(T).

jogada(Y, X, T, _, J) :-
  (J = x -> NovoJ = o; NovoJ = x),
  nth1(Y, T, Linha),
  (nth1(X, Linha, NovoJ); nth1(X, Linha, J)),
  nl,
  print("JOGADA INVALIDA"),
  nl,
  jogar(T, J).

% Função para realizar a jogada
jogada(Y, X, T, Tatualizado, J) :-
  nth1(Y, T, Linha),
  nth1(X, Linha, _, RestoLinha),
  nth1(X, NovaLinha, J, RestoLinha),
  nth1(Y, Tatualizado, NovaLinha, RestoTabuleiro),
  nth1(Y, T, _, RestoTabuleiro).

% Função para iniciar o jogo
iniciarJogo() :-
  jogar([[-,-,-],[-,-,-],[-,-,-]], x).

% MENSAGEM VENCEU
mensagemVenceu(J, TAB) :-
  mostrarTab(TAB),
  print("JOGADOR "),
  print(J),
  print(" GANHOU!!!!!!!!!!! "),
  (J = x -> V = 1; V = -1),
  print(V).

vertical(_, [], _).
  
vertical(X, [H|T], J) :-
  nth1(X, H, J),
  vertical(X, T, J).

diagonal([H|_], J) :-
  nth1(2, H, J).
  
% VERIFICAR GANHADOR
verificarGanhou([H|T], J) :-
  member([J,J,J], [H|T]),
  mensagemVenceu(J, [H|T]);
  nth1(X, H, J),
  vertical(X, T, J),
  mensagemVenceu(J, [H|T]);
  last(T, UltL),
  (last(UltL, J), nth1(1, H, J); last(H, J), nth1(1, UltL, J)), 
  diagonal(T, J),
  mensagemVenceu(J, [H|T]).


verificarEmpate([]).

verificarEmpate([H|T]) :-
  \+ member(-, H),
  verificarEmpate(T).  

mensagemEmpate() :-
  print("Vocês são igualmente ruins"),
  print(0).
  

% Função principal do jogo
jogar(TAB, J) :-
  (J = x -> AntigoJ = o; AntigoJ = x),
  verificarGanhou(TAB, AntigoJ);
  verificarEmpate(TAB),
  mensagemEmpate();
  mostrarTab(TAB),
  vez(TAB, J).

% Função para controlar a vez do jogador
vez(TAB, J) :-
  print("JOGADOR "),
  print(J),
  print(": Digite a coordenada x da sua jogada."),
  nl,
  read(CoordX),
  nl,
  print("JOGADOR "),
  print(J),
  print(": Digite a coordenada y da sua jogada."),
  nl,
  read(CoordY),
  nl,
  jogada(CoordY ,CoordX, TAB, Tatualizado, J),
  (J = x -> NovoJ = o; NovoJ = x),
  jogar(Tatualizado, NovoJ).