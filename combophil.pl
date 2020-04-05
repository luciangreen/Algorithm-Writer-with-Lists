%% combophil.pl

%% Finds combinations of lines of philosophy

:-include('../listprologinterpreter/la_strings').

string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).

%% e.g. combophil(2). to write on a combination of philosophies

combophil(NumberOfPhils) :-
	phrase_from_file_s(string(Phil1), "../listprologinterpreter/file.txt"),
	SepandPad="\n\r",
	split_string(Phil1,SepandPad,SepandPad,Phil2),
	delete(Phil2,"",Phil3),
	sort(Phil3,Phil4),
	length(Phil4,LengthPhil4),write("Number of philosophies in luciansphilosophy.txt: "),
	writeln(LengthPhil4),
	length(PhilsLengthList,NumberOfPhils),
	repeat,
	findall(Phils1,(member(_,PhilsLengthList),random_member(Phils1,Phil4)),Phils2),
	reverse(Phils2,Phils3),Phils3=[Phil6|Phils4],reverse(Phils4,Phils5),
	findall(_,(member(Phil5,Phils5),writeln1(Phil5),nl,writeln1("because"),nl),_),
	writeln1(Phil6),nl,
	write("1-Continue or 2-End: "),
	read_string(user_input, "\n", "\r", _End, Input),
	(Input="2"->abort;fail).

