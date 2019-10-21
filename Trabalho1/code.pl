% Ambiente João
% solucao_bl((2, 0, [(1, 0), (0, 9), (1, 8), (2, 9), (3, 8), (4, 1)], 0, [(0, 0), (3, 0), (4, 7)]), X).

escada(0, 1).
escada(0, 6).
escada(1, 5).
escada(2, 4).
escada(3, 5).
escada(3, 9).

bloqueio(4, 0).
bloqueio(0, 5).
bloqueio(4, 6).

pedra(2, 2).
pedra(4, 3).
pedra(2, 7).


% Limites da matriz
limiteI(X) :- X < 5, X >= 0.						% Estipula o limite de linhas
limiteJ(X) :- X < 10, X >= 0.						% Estipula o limite de colunas

meta((_, _, [], _, _)).

livre(I, J, Fogos) :-								% Verifica se existe algum objeto na posição
	not(pedra(I, J)),
	not(escada(I - 1, J)),
	not(escada(I, J)),
	not(bloqueio(I, J)),
	not(pertence((I, J), Fogos)).

andarPedra(I, J, Fogos) :- 							% Verifica se pode andar (em relação a pedra)
	not(pedra(I, J))  								% Não existe pedra na próxima posição
	;												% ou
	(
		pedra(I, J),								% Existe pedra na nova posição
		NJ = I + 1,
		livre(I, NJ, Fogos)							% Mas a posterior está livre. Obs: posições inválidas contam como livres
	).

% Apaga fogo
s(
	(I, J, Fogos, CargasExtintor, Extintores),
	(I, J, NovoFogos, NovoCargasExtintor, Extintores)
) :- 
	pertence((I, J), Fogos), 							% Existe fogo na posição atual
	remove_elem((I, J), Fogos, NovoFogos),				% Remove o fogo da lista
	NovoCargasExtintor is CargasExtintor - 1,			% Usa carga do extintor
	CargasExtintor > 0.									% se tiver para ser usada

% Pega extintor
s(
	(I, J, Fogos, CargasExtintor, Extintores),
	(I, J, Fogos, NovoCargasExtintor, NovoExtintores)
) :-
	pertence((I, J), Extintores),						% Existe extintor na posição atual
	remove_elem((I, J), Extintores, NovoExtintores),	% Remove o extintor da lista
	NovoCargasExtintor is 2,							% Número de cargas do extintor vai para 2
	CargasExtintor == 0.								% Só pega extintor se estiver sem cargas


% Movimentacao horizontal - direita
s(
	(I, J, Fogos, CargasExtintor, Extintores),
	(I, NovoJ, Fogos, CargasExtintor, Extintores)
) :-
	NovoJ is J + 1,							% NovoJ é J + 1
	limiteJ(NovoJ), 						% Novo J está dentro da matriz
	not(bloqueio(I, NovoJ)),				% Verifica se não tem bloqueio
	andarPedra(I, NovoJ, Fogos).			% Verifica se pode andar em relação a possível pedra

% Movimentacao horizontal - esquerda
s(
	(I, J, Fogos, CargasExtintor, Extintores),
	(I, NovoJ, Fogos, CargasExtintor, Extintores)
) :- 
	NovoJ is J - 1,							% NovoJ é J - 1
	limiteJ(NovoJ), 						% Novo J está dentro da matriz
	not(bloqueio(I, NovoJ)), 				% Não existe bloqueio na próxima posição
	not(bloqueio(I, NovoJ)),				% Verifica se não tem bloqueio
	andarPedra(I, NovoJ, Fogos).			% Verifica se pode andar em relação a possível pedra


% Movimentação vertical - baixo
s(
	(I, J, Fogos, CargasExtintor, Extintores),
	(NovoI, J, Fogos, CargasExtintor, Extintores)
) :- NovoI is I + 1,
	escada(I, J),							% Vai para baixo se tiver escada para usar
	limiteI(NovoI).							% Verifica limite do mapa

% Movimentação vertical - cima
s(
	(I, J, Fogos, CargasExtintor, Extintores),
	(NovoI, J, Fogos, CargasExtintor, Extintores)
) :- NovoI is I - 1,
	escada(NovoI, J),						% Vai para cima se tiver escada para usar
	limiteI(NovoI).							% Verifica limite do mapa


/*
% Ambiente 1
% solucao_bl((4, 0, [(0, 9), (4, 8)], 0, [(2, 1)]), X).

escada(0, 2).
escada(0, 4).
escada(0, 8).
escada(1, 0).
escada(1, 9).
escada(2, 8).
escada(3, 4).

bloqueio(0, 6).
bloqueio(2, 2).

pedra(0, 5).
pedra(1, 3).
pedra(1, 6).
pedra(3, 3).
pedra(3, 6).

*/

/*
% Ambiente 2
% solucao_bl((4, 0, [(0, 1), (0, 9), (4, 8), (4, 9)], 0, [(2, 1), (2, 3)]), X).

escada(2, 0).
escada(0, 2).
escada(0, 4).
escada(0, 8).
escada(1, 9).
escada(3, 4).
escada(3, 7).

bloqueio(2, 3).
bloqueio(0, 6).

pedra(1, 3).
pedra(0, 5).
pedra(1, 6).
pedra(3, 5).
pedra(3, 6).
pedra(4, 2).
*/

/*
% Ambiente 3
% solucao_bl((4, 0, [(0, 1), (0, 7), (0, 9), (4, 9)], 0, [(1, 0), (2, 5)]), X).

escada(2, 0).
escada(0, 2).
escada(1, 3).
escada(3, 4).
escada(2, 7).
escada(3, 8).
escada(1, 9).

bloqueio(2, 4).
bloqueio(4, 5).

pedra(4, 2).
pedra(3, 2).
pedra(0, 5).
pedra(1, 5).
pedra(3, 5).
pedra(3, 6).

*/

/*
% Ambiente 4
% solucao_bl((4, 0, [(2, 1), (4, 4), (0, 7)], 0, [(2, 5), (4, 6)]), X).

escada(0, 2).
escada(0, 8).
escada(1, 3).
escada(1, 9).
escada(2, 0).
escada(2, 6).
escada(3, 3).
escada(3, 8).

bloqueio(2, 4).
bloqueio(4, 5).

pedra(0, 1).
pedra(0, 5).
pedra(1, 5).
pedra(3, 2).
pedra(3, 9).
pedra(4, 0).
*/

/*
% Ambiente João
% solucao_bl((2, 0, [(1, 0), (0, 9), (1, 8), (2, 9), (3, 8), (4, 1)], 0, [(0, 0), (3, 0), (4, 7)]), X).

escada(0, 1).
escada(0, 6).
escada(1, 5).
escada(2, 4).
escada(3, 5).
escada(3, 9).

bloqueio(4, 0).
bloqueio(0, 5).
bloqueio(4, 6).

pedra(2, 2).
pedra(4, 3).
pedra(2, 7).
*/

