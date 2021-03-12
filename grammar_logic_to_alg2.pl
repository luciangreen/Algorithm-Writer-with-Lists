/**

?- grammar_logic_to_alg.                                                        ["Simplify algorithm","pia","pear"]
["What is the word for","person"]
1	harry
2	june
3	person
4	pia

"Please choose from menu items 1-4, or enter a new word:"
|: subject
["Simplify algorithm","harry","banana"]
["Simplify algorithm","apple","june"]
[["subject","pia","pear","pear"],["subject","harry","banana","banana"],["subject","june","apple","apple"]]
true.

?- grammar_logic_to_alg.                                                        ["Simplify algorithm","pia","pear"]
[["subject","pia","pear","pear"]]
true.

**/

:-include('../listprologinterpreter/la_strings.pl').
:-include('../listprologinterpreter/la_strings_string.pl').
:-include('../listprologinterpreter/la_maths.pl').

grammar_logic_to_alg2(First_n_words) :-

	% get file
	phrase_from_file_s(string(String1),"../Text-to-Breasonings/file.txt"),
	
	% split into lines and sentences
	%SepandPad2="\n\r",
		SepandPad1="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
	string_codes(String1b,String1),
	downcase_atom(String1b,String1c),
	string_codes(String1c,String1a),
	split_string(String1a,SepandPad1,SepandPad1,String21),
	length(String21,L),
	(L<First_n_words->First_n_words1=L;First_n_words1=First_n_words),
	length(String2,First_n_words1),
	append(String2,_,String21),
	

%	phrase_from_file_s(string(BrDict0), "../../Text-to-Breasonings/brdict1.txt"),
	phrase_from_file_s(string(BrDict0), "../Text-to-Breasonings/brdict1.txt"),
	splitfurther(BrDict0,Term),

%trace,	
	phrase_from_file_s(string(BrDict3), "brdict3.txt"),
		string_codes(String02ba,BrDict3),
		atom_to_term(String02ba,Term1,[]),
	
	phrase_from_file_s(string(BrDict4), "first-words.txt"),
		string_codes(String02b,BrDict4),
		atom_to_term(String02b,String02a,[]),
	
	% Finds additions to brdict3.txt (box,values)
	process_file(String2,Term,Term1,String02a,%[],
	Additions_to_brdict3,[],Pseudo_algorithms,%[],
	First_words),
	
	%***append(Term1,Additions_to_brdict3,Additions_to_brdict3_2),
	
	term_to_atom(Additions_to_brdict3,String02a_b),
	string_atom(String02a_c,String02a_b),

	(open_s("brdict3.txt",write,Stream1),
	write(Stream1,String02a_c),
	close(Stream1)),!,

	%***append(String02a,First_words,First_words_2),
	
	term_to_atom(First_words,First_words_2_b),
	string_atom(First_words_2_c,First_words_2_b),

	(open_s("first-words.txt",write,Stream2),
	write(Stream2,First_words_2_c),
	close(Stream2)),!,
	
	writeln1(Pseudo_algorithms),!,
	
	random_member(Summary_algorithm,Pseudo_algorithms),
	writeln1("Summary algorithm:"),
	writeln1(Summary_algorithm).

	process_file(String2,Term,Term1,String02a,%Additions_to_brdict31,
	Additions_to_brdict3,Pseudo_algorithms1,Pseudo_algorithms,%First_words1,
	First_words) :-
	%trace,
	String2=[Word1,Word2|Words],
	writeln1(["Simplify algorithm",Word1,Word2]),
	found(Word1,Term,Term1,Item1,%Term1,
	Additions_to_brdict31_4),
	found(Word2,Term,Additions_to_brdict31_4,Item2,%Additions_to_brdict31_4,
	Additions_to_brdict31_5),	
	stronger_word([Item1,Word1],[Item2,Word2],String02a,_Word3,String02a,First_words3,Item_a),
	append(Pseudo_algorithms1,[Item_a],Pseudo_algorithms2),
		process_file(Words,Term,Additions_to_brdict31_5,First_words3,%Additions_to_brdict31_5,
		Additions_to_brdict3,Pseudo_algorithms2,Pseudo_algorithms,%First_words3,
		First_words).

	process_file(_String2,_Term,Term1,String02a,%Additions_to_brdict3,
	Term1,Pseudo_algorithms,Pseudo_algorithms,%First_words,
	String02a) :- !.



% bd3 - person, subject and
found(Word1,Term,Additions_to_brdict1,Item1,%Additions_to_brdict1,
Additions_to_brdict2) :-
	
	%(Word1="june"->trace;true),
	
	(member([Word1,Word21],Term)->true;(writeln(["Error:",Word1,"not in brdict1.txt."]),abort)),
	(Word21=""->Word2=Word1;Word2=Word21),
	(member([Word2,Item1],Additions_to_brdict1)->Additions_to_brdict1=Additions_to_brdict2;
	(%trace,
	
	
	findall(Word3,(member([Word3,Word2],Term)),Word22),
	append([Word2],Word22,Word23),
	%trace,
	sort(Word23,Word241),
	delete(Word241,"",Word24),
	
	length(Word24,Menu_items_length),
	(Menu_items_length=1->([Item1]=Word24,
	append(Additions_to_brdict1,[[Word2,Item1]],Additions_to_brdict2));
	(writeln1(["What is the word for",Word1]),
	numbers(Menu_items_length,1,[],N),
	findall([N1,"\t",Menu_item,"\n"],(member(N1,N),
	get_item_n(Word24,N1,Menu_item)),Menu1),
	maplist(append,[Menu1],[Menu3]),
	concat_list(Menu3,Menu2),
	writeln(Menu2),

	repeat,%trace,
	concat_list(["Please choose from menu items 1-",Menu_items_length,", or enter a new word:"],Prompt),
	writeln1(Prompt),
	read_string(user_input,"\n","\r",_,Input),
	((%trace,
	number_string(Input_num,Input),
	Input_num>=1,Input_num=<Menu_items_length,
	%trace,
	get_item_n(Menu1,Input_num,[_,_,Item1,_]),
	%trace,
	append(Additions_to_brdict1,[[Word2,Item1]],Additions_to_brdict2))->true;
		(string(Input)->(Input=Item1,append(Additions_to_brdict1,[[Word2,Item1]],Additions_to_brdict2))
)))))).
	
stronger_word([Word1,Word1a],[Word2,Word2a],String02a,Word3,First_words1,First_words,Item) :-
	(member(Word1,String02a)->(First_words1=First_words,Item=[Word1,Word1a,Word2,Word2a]);
	(member(Word2,String02a)->(First_words1=First_words,Item=[Word2,Word2a,Word1,Word1a]);
	(%trace,
	writeln(["Which of 1-",Word1,"or 2-",Word2,"is stronger?"]),
	read_string(user_input,"\n","\r",_,Input),
	(Input="1"->(Word3=Word1,Item=[Word1,Word1a,Word2,Word2a]);
	(Word3=Word2,Item=[Word2,Word2a,Word1,Word1a])),
	append(First_words1,[Word3],First_words)))).
	
	% Append punctuation point to end if necessary.
	% find last character in file
	%	string_concat(_,".",String1),

/**
split_string_onnonletter(String00,Chars,List1) :-
	string_codes(String00,String1),
	split_string_onnonletter(String1,[],Chars,List0),
	string_codes(List0,List2),
	split_string(List2,"@","@",List1),!.
split_string_onnonletter([],Input,_Chars,Input) :- !.
split_string_onnonletter(Input1,Input2,Chars,Input3) :-
	Input1=[Input4|Input5],
	%not(char_type(Input4,alpha)),
	string_codes(Chars,Codes),
	member(Code,Codes),
	Input4=Code,
	append(Input2,[Code],Input7),
	append(Input7,`@`,Input6),
	split_string_onnonletter(Input5,Input6,Chars,Input3), !.
split_string_onnonletter(Input1,Input2,Chars,Input3) :-
	Input1=[Input4|Input5],
	%char_type(Input4,alpha),
	append(Input2,[Input4],Input6),
	split_string_onnonletter(Input5,Input6,Chars,Input3), !.
**/

splitfurther(BrDict01,N) :-
	   phrase(file0(N),BrDict01).
	
file0(N) --> "[", file(N), "]", !.
file0([]) --> [].

%%file([]) --> [].
file([L|Ls]) --> entry(L),",",
%%{writeln(L)}, %%***
file(Ls), !. %% file(Ls),{M=[Ls]})), !. %%, {writeln(["l",L])},",", file(Ls), {writeln(["ls",Ls])},!. %%, {append(L,Ls,M)}, !.	
file([L]) --> entry(L), 
%%{writeln(L)},
!. %%(entry(L),{M=L});{M=[],(writeln("Warning - Entry in incorrect format.")
%%,abort
%%)}, !.

entry([Word2,Word4]) -->
		"[", word(Word), {string_codes(Word2,Word),string(Word2)},
		",",
           word(Word3), {string_codes(Word4,Word3),string(Word4)},
           "]".
           
word([X|Xs]) --> [X], {char_type(X,csymf)->true;(X=27->true;X=8217)}, word(Xs), !.
%%word([X]) --> [X], {char_type(X,csymf);(X=27;X=8217)}, !.
word([]) --> [].
           