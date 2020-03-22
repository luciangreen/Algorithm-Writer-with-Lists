random_dependencies(A) :-
	random(N1),N2 is round(2*N1),
	random_dependencies1(N2,A).
random_dependencies1(0,[]) :- !.
random_dependencies1(1,A) :-
	random_member(B,[and,or,reverse,string_to_list,
split_into_sentences,is_positive_language,agrees,member,delete,minus,get_item_n,length,intersection,
substring,sum,sort,maximum,map,findall,duplicates,mutually_exclusive,list_head,add_number_to_list]),
random_dependencies(C),
A=[B,[C]].

random_dependencies1(2,A) :-
	random_member(B,[and,or,reverse,string_to_list,
split_into_sentences,is_positive_language,agrees,member,delete,minus,get_item_n,length,intersection,
substring,sum,sort,maximum,map,findall,duplicates,mutually_exclusive,list_head,add_number_to_list]),
random_dependencies(C),random_dependencies(D),
A=[B,[C,D]].