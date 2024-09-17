:- (load_files(['../listprologinterpreter/listprolog.pl'],[if(changed),if(not_loaded)])).
:-include('../Text-to-Breasonings/truncate.pl').
:-dynamic brdict/1.
:-dynamic words_for_sent/1.

grammar_logic_to_alg1(String1,N,Result) :-
	container(grammar_logic_to_alg1_contents(String1,N,Result)),!.
grammar_logic_to_alg1 :-
	container(grammar_logic_to_alg1_contents),!.
	
grammar_logic_to_alg1_contents(String1,N,Result) :-

	truncate1(string,String1,N,String),

	grammar_logic_to_alg114(String,Result).
	
grammar_logic_to_alg1_contents :-
	grammar_logic_to_alg11(S),
	writeln(S),!.

grammar_logic_to_alg114(Text,Result) :-
	grammar_logic_to_alg113(Text,Result1),term_to_atom(Result1,Result),!.


grammar_logic_to_alg11(S) :-
	phrase_from_file_s(string(Text1), "../Text-to-Breasonings/file.txt"),

grammar_logic_to_alg113(Text1,S),!.

grammar_logic_to_alg113(Text1,S) :-

	phrase_from_file_s(string(BrDict0), "../Text-to-Breasonings/brdict1.txt"),
	splitfurther(BrDict0,BrDict01),
	sort(BrDict01,BrDict012),
	%retractall(brdict(_)),
	%assertz(brdict(BrDict012)),

	split_string_on_non_alpha(Text1,Text2a),

	length(Text2a,L),
	L1 is L*79,
	numbers(L1,1,[],Ns),
	
	maplist(random_word(BrDict012),Ns,C),
	append(Text2a,C,C1),
	
	term_to_atom(C1,A),
	atom_string(A,S),!.
	
random_word(BrDict012,_,S) :-
	random_member([S,_],BrDict012),!.
	