%% combophil.pl x combophil2qadb.pl

% don;t change to mrtree because mr is working.  Without seeing and thinking about options, it is meaningless.

%% Finds combinations of lines of philosophy

%% *** Deprecated by Repository Lucian-Academy/combophil_alg_log.pl

:-include('../listprologinterpreter/la_strings.pl').

string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).

%% e.g. combophil(2). to write on a combination of philosophies

combophil2qadb :- %(NumberOfPhils) :-

% get box, right, box words from brdict1
phrase_from_file_s(string(BrDict0), "../Text-to-Breasonings/brdict1.txt"),
%phrase_from_file_s(string(BrDict0), "../../brdict1.txt"),
%string_codes(String02b,BrDict0),
%atom_to_term(String02b,String02a,[]),
splitfurther(BrDict0,BrDict01),
sort(BrDict01,String02a),
findall(A2,(member(A,String02a),A=[A2,"box"]),A1),
findall(B2,(member(B,String02a),B=[B2,"right"]),B1),


	phrase_from_file_s(string(Phil1), "../Text-to-Breasonings/file.txt"),
	SepandPad="\n\r.",
	split_string(Phil1,SepandPad,SepandPad,Phil2),
	delete(Phil2,"",Phil3),
	sort(Phil3,Phil4),
	length(Phil4,LengthPhil4),write("Number of philosophies in file.txt: "),
	writeln(LengthPhil4),
	%length(PhilsLengthList,NumberOfPhils),
	
	findall([C,Algorithm],(member(C,Phil4),
	qa_db_finder(A1,B1,Algorithm)),D),
	
	term_to_atom(D,K),
	(open_s("file-o.txt",write,Stream1),
	write(Stream1,K),
	close(Stream1)),!.
	/** 
	repeat,
	findall(Phils1,(member(_,PhilsLengthList),random_member(Phils1,Phil4)),Phils2),
	reverse(Phils2,Phils3),Phils3=[Phil6|Phils4],reverse(Phils4,Phils5),
	findall(_,(member(Phil5,Phils5),writeln1(Phil5),nl,writeln1("because"),nl),_),
	writeln1(Phil6),nl,
	write("1-Continue or 2-End: "),
	read_string(user_input, "\n", "\r", _End, Input),
	(Input="2"->abort;fail).
**/


splitfurther(BrDict01,N) :-
   phrase(file0(N),BrDict01).
   
   file0(N) --> "[", file(N), "]", !.
   file0([]) --> [].

   file([L|Ls]) --> entry(L),",",
   %%{writeln(L)}, %%***
   file(Ls), !.
   file([L]) --> entry(L), 
   %%{writeln(L)},
   !.

   entry([Word2,Word4]) -->
   "[", word(Word), {string_codes(Word2,Word),string(Word2)},
",",
           word(Word3), {string_codes(Word4,Word3),string(Word4)},
              "]".
                 
      word([X|Xs]) --> [X], {char_type(X,csymf)->true;(X=27->true;X=8217)}, word(Xs), !.
      %%word([X]) --> [X], {char_type(X,csymf);(X=27;X=8217)}, !.
      word([]) --> [].

qa_db_finder(A1,B1,Algorithm) :-
% name of algorithm
	random_member(Verb,B1),

	%writeln("What is the input variable?"),
	random_member(I1,A1),
	upper_first_letter(I1,I),
	%read_string(user_input, "\n", "\r", _End, I),
	
	%writeln("What variable is this last variable linked to?"),
	random_member(N1,A1),
	upper_first_letter(N1,N),
	%read_string(user_input, "\n", "\r", _End2, N),

	concat_list(["member(A1,",I,N,"),A1=[",I,",",N,"],"],Algorithm1),
	Vars1=[I,N],
	
	repeat1(A1,2,N,Algorithm1,Algorithm2,Vars1,Vars2),
	
	string_concat(Algorithm3,",",Algorithm2),
	
	%writeln("What is the final output variable?"),
	random_member(O1,A1),
	upper_first_letter(O1,O2),
	append(Vars2,[O2],O3),
	random_member(O,O3),
	%read_string(user_input, "\n", "\r", _End3, O),
	%%trace,
	
	find_header_args1(Vars2,"",HA1),
	%%string_concat(HA2,",",HA1),
	
	concat_list(["a(",HA1,I,",",O,"):-"],Algorithm4),
	concat_list([Algorithm4,Algorithm3,"."],Algorithm).

upper_first_letter(A,B) :-
	string_concat(C,F,A),
	string_length(C,1),
	to_upper(C,D),
	string_codes(E,[D]),
	string_concat(E,F,B),!.
	
repeat1(A1,M1,N,Algorithm1,Algorithm2,Vars1,Vars2) :-
	%writeln("Is this the final variable? (y/n)"),
	random_member(Q,["y","n"]),
	%read_string(user_input, "\n", "\r", _End, Q),

	(Q="y"->(Algorithm2=Algorithm1,Vars2=Vars1);
	%writeln("What variable is this last variable linked to?"),
	%(random(X_A),X_B is ceiling(2*X_A),
	%(X_B=1->
	random_member(V1,A1),
	upper_first_letter(V1,V2),
	append(Vars1,[V2],V3),
	random_member(V,V3),
	%read_string(user_input, "\n", "\r", _End2, V),
	
	concat_list(["member(A",M1,",",N,V,"),A",M1,"=[",N,",",V,"],"],Algorithm1a),
	append(Vars1,[V],Vars3),
	M2 is M1+1,
	string_concat(Algorithm1,Algorithm1a,Algorithm1b),
	repeat1(A1,M2,V,Algorithm1b,Algorithm2,Vars3,Vars2)

	).


find_header_args1([_],HA,HA) :- !.
find_header_args1(Vars,HA1,HA2) :-
	Vars=[_|F],
	Vars=[A,B|_],
	concat_list([A,B,","],D),
	string_concat(HA1,D,E),
	find_header_args1(F,E,HA2).

	
concat_list(A1,B):-
	A1=[A|List],
	concat_list(A,List,B),!.

concat_list(A,[],A):-!.
concat_list(A,List,B) :-
	List=[Item|Items],
	string_concat(A,Item,C),
	concat_list(C,Items,B).
