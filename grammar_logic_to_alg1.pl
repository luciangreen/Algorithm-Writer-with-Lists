%:-include('../listprologinterpreter/listprolog.pl').
:-include('../Text-to-Breasonings/truncate.pl').
:-dynamic brdict/1.
:-dynamic words_for_sent/1.

grammar_logic_to_alg1(String1,N,Result) :-
	container1(grammar_logic_to_alg1_contents(String1,N,Result)),!.
grammar_logic_to_alg1 :-
	container1(grammar_logic_to_alg1_contents),!.
	
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


sentences(N,S) :-

	phrase_from_file_s(string(BrDict0), "../Text-to-Breasonings/brdict1.txt"),
	splitfurther(BrDict0,BrDict01),
	sort(BrDict01,BrDict012),
	generate_paragraph(N, S,BrDict012).

% Generate a paragraph containing N sentences
generate_paragraph(0, "",_) :- !.
generate_paragraph(N, Paragraph,BrDict012) :-
    N > 0,
    generate_single_sentence(SentenceWords,BrDict012),
    format_sentence(SentenceWords, FormattedString),
    N1 is N - 1,
    generate_paragraph(N1, RestOfParagraph,BrDict012),
    atomics_to_string([FormattedString, " ", RestOfParagraph], Paragraph).

% Generate a single sentence with at least 3 words
generate_single_sentence(Words,BrDict012) :-
    random_between(3, 8, Length), % Random sentence length between 3 and 8 words
    length(Words, Length),
    maplist(random_word(BrDict012,_), Words).

% Capitalize the first word and append a full stop
format_sentence([FirstWord|Rest], Sentence) :-
    atom_string(FirstWord, FirstStr),
    % Isolate the first letter and capitalize it
    once(sub_string(FirstStr, 0, 1, _, FirstChar)),
    string_upper(FirstChar, CapChar),
    % Get the rest of the first word
    findall(RestOfWord,sub_string(FirstStr, 1, _, _, RestOfWord),RestOfWord1),
    reverse(RestOfWord1,[RestOfWord2|_]),
    string_concat(CapChar, RestOfWord2, CapFirstWord),
    
    % Reconstruct the sentence and append full stop
    append([CapFirstWord], Rest, AllWords),
    atomics_to_string(AllWords, " ", CoreSentence),
    atomics_to_string([CoreSentence, "."], Sentence).
	
	
	