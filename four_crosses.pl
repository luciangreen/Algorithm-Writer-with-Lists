four_crosses :-
	prompt("What are the two items to cross?",_Two_items),
	cross,cross,cross,
	prompt("What is their cross?",_Cross11).

cross :-
	prompt("What is their cross?",_Cross11),
	prompt("What is at the same level as this?",_Cross12).

prompt(Prompt,String) :-
	writeln(Prompt),
	read_string(user_input, "\n", "\r", _End, String).