% [[[n,member],[[list],[_3386]]],[[n,member],[[list],[list]]],[[n,intersection],[[list],[list]]],[[n,member],[[list],[_5928]]],[[n,atom_string],[[atom],[string]]],[[n,string_length],[[string],[number]]]]

mr_alg(Commands3) :-
 commands(Commands),
 algorithm_length(Algorithm_length),
 random_member(Command1,Commands),
 Command1=[_Name1,[_Input1,Output1]],
 mr_alg(Algorithm_length,Commands,Output1,[],Commands2),
 append([Command1],Commands2,Commands3).
 
mr_alg(0,_,_,Commands,Commands) :- !.
mr_alg(Algorithm_length1,Commands,Output1,Commands1,Commands2) :-
 findall(Command2,(member(Command2,Commands),
 Command2=[_Name2,[Output1,_Output2]]),Commands3),
 random_member(Command4,Commands3),
 Command4=[_Name3,[_Input3,Output3]],
 append(Commands1,[Command4],Commands5),
 Algorithm_length2 is Algorithm_length1 - 1,
 mr_alg(Algorithm_length2,Commands,Output3,Commands5,Commands2).
 
algorithm_length(5).

%& check if any of these have 3 args - x
commands([
[[n,+],[[number,number],[number]]],
[[n,-],[[number,number],[number]]],
[[n,*],[[number,number],[number]]],
[[n,/],[[number,number],[number]]],
[[n,/],[[number,number],[]]],
[[n,>],[[number,number],[]]],
[[n,>=],[[number,number],[]]],
[[n,<],[[number,number],[]]],
[[n,=<],[[number,number],[]]],
[[n,=],[[number,number],[]]],
[[n,=\=],[[number,number],[]]],
[[n,head],[[list],[_]]],
[[n,tail],[[list],[_]]],
[[n,member],[[list],[_]]], % swapped for this exercise
[[n,delete],[[list,_],[list]]],
[[n,append123],[[list,list],[list]]], % append([1],[2],A).
[[n,append132],[[list,list],[list]]], % append([1],A,[1,2]).
[[n,append231],[[list,list],[list]]], % append(A,[2],[1,2]).
 % append(A,B,[1,2]). x
[[n,stringconcat123],[[string,string],[string]]], % string("1","2",A).
[[n,stringconcat132],[[string,string],[string]]], % string("1",A,"12").
[[n,stringconcat231],[[string,string],[string]]], % string(A,"2","12").
[[n,stringtonumber],[[string],[number]]],
[[n,random],[[number]]],
[[n,length],[[list],[number]]],
[[n,ceiling],[[number],[number]]],
[[n,sqrt],[[number],[number]]],
[[n,round],[[number],[number]]],
[[n,string_length],[[string],[number]]],
[[n,sort],[[list],[_]]],
[[n,intersection],[[list],[list]]],
[[n,atom_string],[[atom],[string]]]
]).