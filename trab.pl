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

% Limites da matriz
limiteI(X) :- X < 5, X >= 0.
limiteJ(X) :- X < 10, X >= 0.

meta((_, _, [], _, _)).

livre(I, J, Fogos) :- 
	not(pedra(I, J)),
	not(escada(I - 1, J)),
	not(escada(I, J)),
	not(bloqueio(I, J)),
	not(pertence((I, J), Fogos)).

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
	NovoCargasExtintor is 2,
	CargasExtintor == 0.


% Movimentacao horizontal - direita
s(
	(I, J, Fogos, CargasExtintor, Extintores),
	(I, NovoJ, Fogos, CargasExtintor, Extintores)
) :-
	NovoJ is J + 1,							% NovoJ é J + 1
	limiteJ(NovoJ), 						% Novo J está dentro da matriz
	not(bloqueio(I, NovoJ)),
	(	
		(
			not(pedra(I, NovoJ))			% Não existe pedra na próxima posição
			;								% Ou
			(pedra(I, NovoJ),				% Existe pedra na nova posição
			NJ = NovoJ + 1,
			livre(I, NJ, Fogos))			% Mas a posterior está livre Obs: posições inválidas contam como livres
		)
	).

% Movimentacao horizontal - esquerda
s(
	(I, J, Fogos, CargasExtintor, Extintores),
	(I, NovoJ, Fogos, CargasExtintor, Extintores)
) :- 
	NovoJ is J - 1,							% NovoJ é J - 1
	limiteJ(NovoJ), 						% Novo J está dentro da matriz
	not(bloqueio(I, NovoJ)), 				% Não existe bloqueio na próxima posição
	(	
		(
			not(pedra(I, NovoJ))			% Não existe pedra na próxima posição
			;								% Ou
			(pedra(I, NovoJ),				% Existe pedra na nova posição
			NJ = NovoJ - 1,
			livre(I, NJ, Fogos))			% Mas a posterior está livre Obs: posições inválidas contam como livres
		)
	).



% Movimentação vertical - baixo
s(
	(I, J, Fogos, CargasExtintor, Extintores),
	(NovoI, J, Fogos, CargasExtintor, Extintores)
) :- NovoI is I + 1,
	escada(I, J),							% Vai para baixo se tiver escada para usar
	limiteI(NovoI).

% Movimentação vertical - cima
s(
	(I, J, Fogos, CargasExtintor, Extintores),
	(NovoI, J, Fogos, CargasExtintor, Extintores)
) :- NovoI is I - 1,
	escada(NovoI, J),						% Vai para cima se tiver escada para usar
	limiteI(NovoI).



/*
% Ambiente 2
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
