:-include('../listprologinterpreter/la_strings.pl').


midnight_algorithm_input_list :-
writeln("Algorithm name?"),
	read_string(user_input, "\n", "\r", _End2, Alg_name),
writeln("List item 1?"),
	read_string(user_input, "\n", "\r", _End21, List_item1),
writeln("List item 2?"),
	read_string(user_input, "\n", "\r", _End22, List_item2),
writeln("List item 3?"),
	read_string(user_input, "\n", "\r", _End23, List_item3),
writeln("List item 4?"),
	read_string(user_input, "\n", "\r", _End24, List_item4),
	Algorithm=
	
	[[[n,Alg_name],[[[List_item1,List_item2],[List_item2,List_item3],[List_item3,List_item4]]]],
        [[[n,Alg_name],[[[t,list],[[t,list2]]]]],
        [[t,list2],[[t,string],[t,string]]],
        [[n,reverse],[[[t,list],[[t,list2]]],[[t,list],[[t,list2]]],[[t,list],[[t,list2]]]]],
        [[n,function2],[[[t,list],[[t,list2]]],[t,string],[t,string]]],
        [[n,length],[[[t,list],[[t,list2]]],[t,number],[t,number]]]],
        
        [[[n,Alg_name],[input]],
        [[n,reverse],[input,input,output]],
        [[n,function2],[input,input,input]],
        [[n,length],[input,input,output]]],

[[[n,Alg_name],[[v,a]],":-",
[[[n,length],[[v,a],0,[v,b]]],
[[n,=],[[v,b],1]]]],

[[n,Alg_name],[[v,a]],":-",
[[[n,head],[[v,a],[v,d]]],
[[n,equals1],[[v,d],[[v,e],[v,f]]]],
[[n,reverse],[[v,a],[],[v,a1]]],
[[n,head],[[v,a1],[v,d1]]],
[[n,equals1],[[v,d1],[[v,e1],[v,f1]]]],
[[n,function2],[[v,a],[v,f],[v,f1]]]]],

[[n,reverse],[[],[v,l],[v,l]]],

[[n,reverse],[[v,l],[v,m],[v,n]],":-",
[[[n,head],[[v,l],[v,h]]],
[[n,tail],[[v,l],[v,t]]],
[[n,wrap],[[v,h],[v,h1]]],
[[n,append],[[v,h1],[v,m],[v,o]]],
[[n,reverse],[[v,t],[v,o],[v,n]]]]],

[[n,function2],[[v,a],[v,b],[v,f]],":-",
[[[n,member],[[v,d],[v,a]]],
[[n,equals1],[[v,d],[[v,b],[v,f]]]]]],

[[n,function2],[[v,a],[v,b],[v,c]],":-",
[[[n,member],[[v,d],[v,a]]],
[[n,equals1],[[v,d],[[v,b],[v,f]]]],
[[n,function2],[[v,d],[v,f],[v,c]]]]],

[[n,length],[[],[v,l],[v,l]]],

[[n,length],[[v,l],[v,m1],[v,n]],":-",
[[[n,not],[[[n,=],[[v,l],[]]]]],
[[n,tail],[[v,l],[v,t]]],
[[n,+],[[v,m1],1,[v,m2]]],
[[n,length],[[v,t],[v,m2],[v,n]]]]]],
[[]]],

writeln1([algorithm,Algorithm]).
