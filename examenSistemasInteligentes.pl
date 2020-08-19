metate:-
    write('?'), read_word_list(Input), metate(Input), !.

metate([adios]) :-
    write('Gracias por tu visita.'), nl.
metate(Input) :-
    pattern(Stimulus, Response),
    match(Stimulus, Dictionary, Input),
    match(Response, Dictionary, Output),
    reply(Output),
    !, metate.

match([N|Pattern], Dictionary, Target) :-
    integer(N), lookup(N, Dictionary, LeftTarget),
    append(LeftTarget, RightTarget, Target),
    match(Pattern, Dictionary, RightTarget).
match([Word | Pattern], Dictionary, [Word | Target]) :-
    atom(Word), match(Pattern, Dictionary, Target).
match([], _Dictionary, []).

pattern([X,2],[bienvenido,a,metate,para,continuar,puedes,escribir]):-saludo(X).
pattern([X],[qué,le,gustaría,X,?]):-intent_ordenar(X).

pattern([tengo,ganas,de,X],[con,mucho,gusto,¿,qué,desea,tomar,?]):-plato(X,Y).
pattern([tengo,ganas,de,1],[por,el,momento,no,tenemos,1,quiere,otra,cosa,'?']).
pattern([quiero,X, por,favor],[con,mucho,gusto,¿,qué,desea,tomar,?]):-plato(X,Y).
pattern([quiero,1,por,favor],[por,el,momento,no,tenemos,1,quiere,otra,cosa,'?']).

pattern([cuanto,cuesta,el,X],[su,costo,es,de,Y,pesos]):-plato(X,Y).
pattern([cuanto,cuesta,la,X],[su,costo,es,de,Y,pesos]):-plato(X,Y).
pattern([cuanto,cuesta,1],[por,el,momento,se,no,tenemos,1,¿,gusta,pedir,algo,diferente,?]).

pattern([un,X,de,tomar],[por,su,puesto]):-bebida(X,Y).
pattern([una,X,de,tomar],[por,su,puesto]):-bebida(X,Y).
pattern([un,1,de,tomar],[por,el,momento,no,tenemos,1,¿,desea,otra,bebida,?]).
pattern([una,1,de,tomar],[por,el,momento,no,tenemos,1,¿,desea,otra,bebida,?]).

pattern([cuanto,cuesta,el,X],[su,costo,es,de,Y,pesos]):-bebida(X,Y).
pattern([cuanto,cuesta,la,X],[su,costo,es,de,Y,pesos]):-bebida(X,Y).

pattern([1],[no,entendí,puedes,ordenar,tu,comida,preguntar,sobre,precios,o,salir]).

saludo(buenas).
saludo(saludos).
saludo(hola).
saludo(días).
saludo(iniciar).
saludo(empezar).



intent_ordenar(tomar_orden).
intent_ordenar(ordenar).
intent_ordenar(pedir).
intent_ordenar(pedir_comida).
intent_ordenar(tomar_ordenes).

plato(mole,doscientos).
plato(tasajo,cien).
plato(tlayuda,cien).
plato(amarillito,doscientos).
plato(estofado,cien).
plato(memela,cincuenta).
plato(coloradito,cien).
plato(caldo_de_piedra,cien).
plato(tamal_oaxaqueño,cincuenta).
plato(texmole,cien).
plato(chapulines,cincuenta).
plato(chile_de_agua,cien).
plato(pan_de_cazón,cien).
plato(chileajo,cien).
plato(sopa_de_guías,cincuenta).
plato(chileatole,cien).
plato(revolcadas,cincuenta).
plato(tortilla_de_trigo,cien).

bebida(chocolate,ochenta).
bebida(mezcal,doscientos).
bebida(aguardiente,cien).
bebida(cerveza,ciencuenta).
bebida(tejate,cincuenta).
bebida(chocomio,cuarenta).
bebida(metate,cien).
bebida(pozol,cien).
bebida(rey,treinta).




reply([Head | Tail]) :-
    write(Head), write(' '), reply(Tail).
reply([]) :- nl.

lookup(Key, [(Key, Value) | _Dict], Value).
lookup(Key, [(Key1, _Val1) | Dictionary], Value) :-
    Key \= Key1, lookup(Key, Dictionary, Value).

read_word_list(Ws) :-
    read_line_to_codes(user_input, Cs),
    atom_codes(A, Cs),
    tokenize_atom(A, Ws).
