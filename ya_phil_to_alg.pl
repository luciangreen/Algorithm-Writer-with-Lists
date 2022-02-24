:-include('../Lucian-Academy/folders.pl').
:-include('mr_alg.pl').
:-include('../listprologinterpreter/la_strings.pl').
:-include('../listprologinterpreter/la_strings_string.pl').
:-include('../listprologinterpreter/la_files.pl').

% start with 1g memory

ya_phil_to_alg :-

folders(Courses1),
%random_member(Course,Courses1),
		%get_texts(Dept,Texts) :-

findall(Texts1,(member(Dept,Courses1),	concat_list(["../Lucian-Academy/",Dept,"/"],Dept1),
	directory_files(Dept1,F),
	delete_invisibles_etc(F,G),
	findall(String02b,(member(Filex1,G),
	string_concat(Dept1,Filex1,Filex),
		phrase_from_file_s(string(String00a), Filex),
		string_codes(String02b,String00a)),Texts1)
		),Texts2),

flatten(Texts2,Texts3),

term_to_atom(Texts3,Texts4),

split_string(Texts4,"\n\r","\n\r",Texts5),

findall([Text6,Alg],(member(Text6,Texts5),
mr_alg(Alg)),Algs1),

flatten(Algs1,Algs2),

term_to_atom(Algs2,Algs3),

%string_atom(Algs,Algs),

	(open_s("yet_more_phil_algs.txt",write,Stream3),
	write(Stream3,Algs3),
	close(Stream3)),!.



		