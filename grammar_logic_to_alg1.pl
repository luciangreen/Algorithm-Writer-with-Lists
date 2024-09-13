/**

grammar_logic_to_alg.pl


e.g. I liked God with you
[liked,God],[God,you] with extra data
- connect liked to you with member, return words on path

POS

goes backwards x forwards
- I v n by v n x ignore

n,v
- single type

adjective
- ignored x (ignore names in alg)
- like v,n

joining words - ignore, just pairs v, n
- on
- joins v to n
- separates vns

negative terms
- switch to positive or ignore

disappearing words
- my
- no list of these, because they are ignored

vv is v1, v2 x v1
nn is n1

*

later: can randomly generate details like given sentence

**/

:-include('../Text-to-Breasonings/truncate.pl').
%:- include('../Philosophy/14 10 23.pl').

:- dynamic brdict/1.
:-dynamic words_for_sent/1.



mt_t2b2:-
%Thread=
	%[
	phrase_from_file_s(string(Essay_0), %"lacom5million.txt"
	"../../private/lacom0.5million.txt"
	),

	%Br is 5,
	%Br is 5000000,
	W is 0,
	
	%grammar_logic_to_alg1(Essay_0,Br,GL_out1),
	grammar_logic_to_alg113(Essay_0,GL_out1),

	term_to_atom(GL_out1,GL_out2),
	string_atom(GL_out,GL_out2),

	texttobr2(u,u,GL_out,Br,false,false,false,false,false,false,W),
	texttobr(u,u,GL_out,Br).%],

mt_t2b3:-mt_t2b2.
	
mt_t2b4:-mt_t2b2.	

mt_t2b5:-mt_t2b2.	

mt_t2b6:-mt_t2b2.	

mt_t2b7:-mt_t2b2.	

mt_t2b8:-mt_t2b2.	

mt_t2b9:-mt_t2b2.	
	%trace,Thread.
	

mt_t2b :-	

Goals=[mt_t2b2,mt_t2b3,mt_t2b4,mt_t2b5,mt_t2b6,mt_t2b7,mt_t2b8,mt_t2b9
],

length(Goals,L),

%time(mt_t2b2).
time(concurrent(L,Goals,[])).
	
grammar_logic_to_alg1(String1,N,Result) :-

	%term_to_atom(String,Essay_01),
	%string_atom(Essay_02,Essay_01),

	%working_directory(_, '../'),
	
	%(open_s("../Text-to-Breasonings/file.txt",write,Stream1),
	%write(Stream1,String),
	%close(Stream1)),!,

	truncate1(string,String1,N,String),

	%working_directory(_, 'algwriter/'),
	grammar_logic_to_alg114(String,Result).
	
grammar_logic_to_alg1 :-
	grammar_logic_to_alg11(S%[Sentence1,List_a,List_a1,List_b1,List_bb,List_bb1,Cs1,Cs2]
	),
	%writeln1([*,Sentence1,a_alg(List_a)]),
	%writeln(List_a1),
	%writeln1([*,Sentence1,b_alg(List_a)]),
	%writeln(List_b1),
	%writeln1([*,Sentence1,bb_alg(List_bb)]),
	%writeln(List_bb1),

	%writeln1(Cs1),
	%writeln1(Cs2)
	writeln(S),!.

grammar_logic_to_alg112(Result) :-
	grammar_logic_to_alg11(Result1),term_to_atom(Result1,Result),!.

grammar_logic_to_alg114(Text,Result) :-
	grammar_logic_to_alg113(Text,Result1),term_to_atom(Result1,Result),!.


grammar_logic_to_alg11(S%[Sentence1,List_a,List_a1,List_b1,List_bb,List_bb1,Cs1,Cs2]
) :-
	phrase_from_file_s(string(Text1), "../Text-to-Breasonings/file.txt"),

grammar_logic_to_alg113(Text1,S%[Sentence1,List_a,List_a1,List_b1,List_bb,List_bb1,Cs1,Cs2]
),!.


grammar_logic_to_alg113(Text1,S%[Sentence1,List_a,List_a1,List_b1,List_bb,List_bb1,Cs1,Cs2]
) :-

	phrase_from_file_s(string(BrDict0), "../Text-to-Breasonings/brdict1.txt"),
	splitfurther(BrDict0,BrDict01),
	sort(BrDict01,BrDict012),
	retractall(brdict(_)),
	assertz(brdict(BrDict012)),

	SepandPad=".\n",
	split_string(Text1,SepandPad,SepandPad,Text2a),
	delete(Text2a,"",Text2),
	
	findall(B2,(member(B1,Text2),grammar_logic_to_alg(B1,B2)),C),

	term_to_atom(C,List_a2),
	string_atom(S,List_a2),
	!.

grammar_logic_to_alg(Sentence1,B) :- %% Not by multi-sentence algorithms, just by sentence
	atom_string(Sentence0,Sentence1),
	downcase_atom(Sentence0,Sentence01),
	atom_string(Sentence01,Sentence02),
	
	SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
	
	/*Connectors=
		["the","a","i","on","with","of","an","for","to",
		"was","were","and","in","my","from","out","by"],
	*/
	split_string(Sentence02,SepandPad,SepandPad,Sentence2),
	%subtract(Sentence2,Connectors,Sentence3),
	%%length(Sentence3,Length),
	
	%% () add generated data
	%%write_commands(Length,[],Commands), %% sentence alg
	
	findall(B1,(member(S,Sentence2),

	Num=79,
	retractall(words_for_sent(_)),
	assertz(words_for_sent([])),
	%Nums2 is ceiling(Num),
	length(List2,Num),
	findall(W1,(member(_,List2),
	words_for_sent(WS),
	find_until_passes((
	generate_sentence([A12],Sentence),
	[_,_,W1,_W2|_]=Sentence,
	not(member(W1,WS))
	)),
	append(WS,[W1],WS1),
	retractall(words_for_sent(_)),
	assertz(words_for_sent(WS1))
	),W4),
	append([S],W4,B1)
	),B2),
	flatten(B2,B),
	
	!.
	  %% detail algs
	
generate_sentence(Item,Sentence) :-
	random_member(Grammar1,[[n,v,n],[n,v,a,n],[v,n],[v,a,n]]),
	brdict(BrDict012),
	find_pos(Item,POS,BrDict012),
	substitute1(Item,POS,Grammar1,[],Grammar2),
	substitute2(Grammar2,BrDict012,[],Sentence).

find_pos("right",v,_) :- !.
find_pos("plus",a,_) :- !.
find_pos(Item,POS2,BrDict012) :-
	member([Item,POS1],BrDict012),
	POS1="right",
	POS2=v,!.
find_pos(Item,POS2,BrDict012) :-
	member([Item,POS1],BrDict012),
	POS1="plus",
	POS2=a,!.
find_pos(_Item,POS2,_BrDict012) :-
	POS2=n.

substitute1(_Item,_POS,[],Grammar,Grammar) :- !.
substitute1(Item,POS,Grammar1,Grammar2,Grammar3) :-
	Grammar1=[Grammar4|Grammar5],
	Grammar4=POS,
	append_list([Grammar2,Item],Grammar6),
	append(Grammar6,Grammar5,Grammar3),!.
substitute1(Item,POS,Grammar1,Grammar2,Grammar3) :-
	Grammar1=[Grammar4|Grammar5],
	not(Grammar4=POS),
	append_list([Grammar2,Grammar4],Grammar6),
	substitute1(Item,POS,Grammar5,Grammar6,Grammar3),!.

substitute2([],_BrDict012,Sentence,Sentence) :- !.
substitute2(Grammar1,BrDict012,Sentence1,Sentence2) :-
	Grammar1=[Grammar2|Grammar3],
	Grammar2=n,
	findall(A,(member([A,"box"],BrDict012)),B),
	random_member(Word,B),
	append(Sentence1,[Word],Sentence3),
	substitute2(Grammar3,BrDict012,Sentence3,Sentence2).
substitute2(Grammar1,BrDict012,Sentence1,Sentence2) :-
	Grammar1=[Grammar2|Grammar3],
	Grammar2=v,
	findall(A,(member([A,"right"],BrDict012)),B),
	random_member(Word,B),
	append(Sentence1,[Word],Sentence3),
	substitute2(Grammar3,BrDict012,Sentence3,Sentence2).
substitute2(Grammar1,BrDict012,Sentence1,Sentence2) :-
	Grammar1=[Grammar2|Grammar3],
	Grammar2=a,
	findall(A,(member([A,"plus"],BrDict012)),B),
	random_member(Word,B),
	append(Sentence1,[Word],Sentence3),
	substitute2(Grammar3,BrDict012,Sentence3,Sentence2).
substitute2(Grammar1,BrDict012,Sentence1,Sentence2) :-
	Grammar1=[Grammar2|Grammar3],
	append(Sentence1,[Grammar2],Sentence3),
	substitute2(Grammar3,BrDict012,Sentence3,Sentence2).

make_lists(Sentence1,Sentence,Sentence) :-
	Sentence1=[_Sentence2],
	!.	
make_lists(Sentence1,Sentence2,Sentence3) :-
	Sentence1=[Sentence4|Sentence5],
	Sentence5=[Sentence6|_Sentence7],
	append(Sentence2,[[Sentence4,Sentence6]],Sentence8),
	make_lists(Sentence5,Sentence8,Sentence3).

