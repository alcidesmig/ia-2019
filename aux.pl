% Auxiliar

inverte_lista([], X, X).
inverte_lista([X|Xs], Y, R) :-
	inverte_lista(Xs, Y, [X|R]).
remove_elem(Elem, [Elem|Resto], Resto).
remove_elem(Elem, [Cabeca|Resto], [Cabeca|NovoResto]) :- 
	remove_elem(Elem, Resto, NovoResto).
pertence(Elem, [Elem|_ ]).
pertence(Elem, [_| Cauda]) :- 
	pertence(Elem, Cauda).
concatena([ ], L, L).
concatena([Cab|Cauda], L2, [Cab|Resultado]) :- 
	concatena(Cauda, L2, Resultado).
solucao_bl(Inicial, Solucao) :- 
	bl([[Inicial]], Solucao).
bl([[Estado|Caminho]|_], [Estado|Caminho]) :- 
	meta(Estado).
bl([Caminho|Outros], Solucao) :- 
	estende(Caminho, NovoCaminho), 
	concatena(Outros, NovoCaminho, CaminhoAnterior), 
	bl(CaminhoAnterior, Solucao). 
estende([Estado|Caminho], NovoCaminho):- 
	bagof([Sucessor, Estado|Caminho], (s(Estado,Sucessor), not(pertence(Sucessor, [Estado|Caminho]))), NovoCaminho), !.
estende(_, []). 
solucao_bp(Inicial, Solucao) :- 
	bp([], Inicial, Solucao). 
bp(Caminho, Estado, [Estado|Caminho]) :- 
	meta(Estado).
bp(Caminho, Estado, Solucao) :- 
	s(Estado, Sucessor), 
	not(pertence(Sucessor, Caminho)), 
	bp([Estado|Caminho], Sucessor, Solucao).