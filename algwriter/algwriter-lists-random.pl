%% algwriter(A),write1(A).
%% write data,fns in exec format

:-include('../texttobrall2').
:-include('../texttobr2qb').
:-include('../la_strings').

multiply(A,B,C) :- 
C is A*B. 

subtract(A,B,C) :- 
C is A-B. 

head(A,B) :- A=[B|_].

tail(A,B) :- A=[_|B].

wrap(A,B) :- B=[A].

algwriter(Na) :- 
%%notrace,
	phrase_from_file_s(string(BrDict0), "../brdict1.txt"),
	%%SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
	splitfurther(BrDict0,BrDict01),
	%%trace,
	sort(BrDict01,BrDict02),
makerandomlist(BrDict02,5,[],R0),makerandomlist(R0,3,[],R1),makerandomlist(R0,3,[],R2),wrap(R1,Nb1),wrap(R2,Nb2),append(Nb1,Nb2,Nb3),trialy2A([3,4,5,6,7,8],NFns),randomfns(NFns,Nb3,Na),!.
makerandomlist(_,0,A,A).
makerandomlist(List,A,C1,C) :- 
not((=(A,0))),trialy2A(List,N1),%%random(R),multiply(R,L,R1),ceiling(R1,N1),
wrap(N1,N2),append(C1,N2,Nb3),subtract(A,1,D),makerandomlist(List,D,Nb3,C).
randomfns(1,B,Nb3):-randomlist(B,Na1),randomlist(B,Na2),randomfn(Na1,Na2,Nb),wrap(Nb,Nb2),append(B,Nb2,Nb3).%%write1(".").
randomfns(A,B,C) :- not((=(A,1))),randomlist(B,Na1),randomlist(B,Na2),randomfn(Na1,Na2,Nb),wrap(Nb,Nb2),append(B,Nb2,Nb3),%%tail(B,T),
	subtract(A,1,D),write(,),
	randomfns(D,Nb3,C).
randomlist(B,Na) :- %%List1=[1,2,3,4,5,6,7,9,10],
length(B,L),length(C,L),append(C,_,B),trialy2A(C,Na).%%,random(R),length(B,Bl),multiply(R,Bl,N),ceiling(N,N1),getitemn(N1,B,Na).
getitemn(0,_A,[]).
getitemn(1,B,C) :- head(B,C).
getitemn(A,B,C) :- not((=(A,1))),tail(B,T),subtract(A,1,D),getitemn(D,T,C).
randomfn(A1,A2,B) :- %%repeat,
trialy2A([1,3,4,5,7],N1),%%random(R),multiply(R,8,N),ceiling(N,N1),
fna(N1,A1,A2,B).
fna(1,A1,_A2,B) :- reverse(A1,[],B),write1([[n,reverse],[A1,[],B]]).
%%fna(2,A1,_A2,B) :- sort0(A1,B),write1(sort0(A1,B)).
fna(3,A1,A2,B) :- append1(A1,A2,B),write1([[n,append1],[A1,A2,B]]).
fna(4,A1,A2,B) :- minus1(A1,A2,B),write1([[n,minus1],[A1,A2,B]]).
fna(5,A1,A2,B) :- intersection1(A1,A2,[],B),write1([[n,intersection1],[A1,A2,[],B]]).
%%fna(6,A1,A2,A2) :- mutually_exclusive(A1,A2),write1([[n,mutually_exclusive],[A1,A2]]).
fna(7,A1,A2,B) :- duplicates(A1,A2,[],B),write1([[n,duplicates],[A1,A2,[],B]]).
%%fna(8,A1,A2,A1) :- substring(A1,A2),write1([[n,substring],[A1,A2]]).
reverse([],L,L).
reverse(L,M,N) :- head(L,H),tail(L,T),wrap(H,H1),append(H1,M,O),reverse(T,O,N).
sort0(L,N) :- sort1(L,[],N).
sort1([],L,L).
sort1(L,M1,N) :- not((=(L,[]))),head(L,H),tail(L,T),maximum(T,H,M2,[],R),wrap(M2,M3),append(M1,M3,M4),sort1(R,M4,N).
maximum([],L,L,R,R).
maximum(L,M1,N,R1,R2) :- not((=(L,[]))),head(L,H),tail(L,T),(>=(M1,H)->(=(M2,M1),wrap(H,H2),append(R1,H2,R3));(=(M2,H),wrap(M1,M12),append(R1,M12,R3))),maximum(T,M2,N,R3,R2).
map(_F,[],L,L).
map(F,L,M1,N) :- not((=(L,[]))),head(L,H),tail(L,T),functor(A,F,3),arg(1,A,M1),arg(2,A,H),arg(3,A,M2),A,map(F,T,M2,N).
findall(_F,[],L,L).
findall(F,L,M1,N) :- not((=(L,[]))),head(L,H),tail(L,T),functor(A,F,2),arg(1,A,H),arg(2,A,M2),(A->((wrap(M2,M3),append(M1,M3,M4)));(=(M1,M4))),findall(F,T,M4,N).
intersection1([],_A,L,L).
intersection1(L1,L2,L3a,L3) :- head(L1,I1),tail(L1,L4),intersection2(I1,L2,[],L5),append(L3a,L5,L6),intersection1(L4,L2,L6,L3).
intersection2(_A,[],L,L).
intersection2(I1,L1,L2,L3) :- head(L1,I1),tail(L1,L4),wrap(I1,I11),append(L2,I11,L5),intersection2(I1,L4,L5,L3).
intersection2(I1,L1,L2,L3) :- head(L1,I2),tail(L1,L4),not((=(I1,I2))),intersection2(I1,L4,L2,L3).
append1(B,C,A) :- append(B,C,A).
minus1(L,[],L).
minus1(L1,L2,L3) :- head(L2,I1),tail(L2,L5),delete2(L1,I1,[],L6),minus1(L6,L5,L3).
delete2([],_A,L,L).
delete2(L1,I1,L2,L3) :- head(L1,I1),tail(L1,L5),delete2(L5,I1,L2,L3).
delete2(L1,I1,L2,L3) :- head(L1,I2),tail(L1,L5),not((=(I1,I2))),wrap(I2,I21),append(L2,I21,L6),delete2(L5,I1,L6,L3).

mutually_exclusive([],_L):-!.
mutually_exclusive(L,M):-head(L,H),tail(L,T),membera3(M,H),mutually_exclusive(T,M),!.
membera3([],_L):-!.
membera3(L,M):-head(L,H),tail(L,T),not((=(M,H))),membera3(T,M),!.

duplicates([],_L,S,S).
duplicates(L,M,S1,S2):-head(L,H),tail(L,T),member(H,M),(deletea2(M,H,M1)->(true);(=(M,M1))),wrap(H,H1),append(S1,H1,S3),duplicates(T,M1,S3,S2),!.
duplicates(L,M,S1,S2):-head(L,H),tail(L,T),not((membera4(M,H))),duplicates(T,M,S1,S2).
deletea2([],_L,_M1):-fail.
deletea2(L,M,T):-head(L,H),tail(L,T),=(M,H).
deletea2(L,M,M1):-head(L,H),tail(L,T),not((=(M,H))),deletea2(T,M,M1).
membera4([],_L):-fail.
membera4(L,H):-head(L,H).
membera4(L,M):-head(L,H),tail(L,T),not(M=H),membera4(T,M).

substring([],[]).
substring([],B):-not((=(B,[]))),fail.
substring(A,B):-tail(A,At),(listhead(A,B)->(true);(substring(At,B))).
listhead(_L,[]).
listhead(A,B):-head(A,Ah),tail(A,At),head(B,Ah),tail(B,Bt),listhead(At,Bt).


%%%%%%%%%%%%

%%findbest(R,R) :-!.
findbest2(R,Item):-
	sort(R,RA),
	reverse(RA,RB),
	RB=[[_,Item]|_Rest].


%%trialy2A([],R) :-
%%	R=[[_,'A']].
%%trialy2A(List,R) :-
%%	random_member(A,List),
%%	R=[[_,A]].

trialy2A([],R) :-
	R=[].
trialy2A(List,R) :-
	random_member(R,List).
	%%R=[[_,A]].

%%trialy2A(List,R) :-
%%	notrace,trialy2B(List,R).%%,trace.
trialy2B(List,R) :-
	length(List,Length),
	((Length=<9->
		findr4(R4),
		number_string(R4,R4A),
		formr5([R4A],9,Length,R5),
		findr(R5,List,R));
	(Length=<99->
		findr4(R41),
		findr4(R42),
		formr5([R41,R42],99,Length,R5),
		findr(R5,List,R));
	(Length=<999->
		findr4(R41),
		findr4(R42),
		findr4(R43),
		formr5([R41,R42,R43],999,Length,R5),
		findr(R5,List,R));
	(Length=<9999->
		findr4(R41),
		findr4(R42),
		findr4(R43),
		findr4(R44),
		formr5([R41,R42,R43,R44],9999,Length,R5),
		findr(R5,List,R));
	(Length=<99999->
		findr4(R41),
		findr4(R42),
		findr4(R43),
		findr4(R44),
		findr4(R45),
		formr5([R41,R42,R43,R44,R45],99999,Length,R5),
		findr(R5,List,R));
	fail),
	%%write1([r,R]),trace.
	true.

findr4(R4) :-
		List1=[0,1,2,3,4,5,6,7,8,9],
		Trials is 30,
		trialy22(List1,Trials,[],R1),
		findbest2(R1,R4).
		%%number_string(R3,R2),
formr5(RList,Upper,Length,R5) :-
		%%findall(D,(member(C,RList),floor(C,D)),RList2),
		concat_list2A(RList,R5A),
		number_string(R5B,R5A),
		R51 is floor((R5B/Upper)*Length),
		(R5B=Upper->R5 is R51-1;R5=R51).
findr(R4,List,R) :-
		%%floor(R4,R4A),		
		length(A,R4),
		append(A,[R|_],List).

	%%random_member(A,List),
	%%R=[[_,A]].
	
	/**
	length(List,L),
	Trials is L*3,
	trialy22(List,Trials,[],R).**/

trialy22([],_,R,R) :- !.
trialy22(List,Trials,RA,RB) :-
	List=[Item|Items],
	trialy21(Item,Trials,R1),
	append(RA,[R1],RC),
	trialy22(Items,Trials,RC,RB),!.

trialy21(Label,Trials,RA) :-
	trialy3(Trials,[],R),
	aggregate_all(count, member(true,R), Count),
	RA=[Count,Label].

trialy3(0,R,R) :-!.
trialy3(Trials1,RA,RB) :-
	trialy1(R1),
	append(RA,[R1],RC),
	Trials2 is Trials1-1,
	trialy3(Trials2,RC,RB),!.
	
%% try other nouns
trialy1(R1) :-
	%%control11(A1),
	%%repeat,
	trial0(A22), %% Control
	sum(A22,0,S22),
	mean(S22,A1),
	%%repeat,
	trial0(A21), %% Test 1
	sum(A21,0,S02),
	mean(S02,A2),
	(A1>A2->R1=true;R1=fail).

trial0(S3) :- N is 10, trial1(N,[],S),trial01(S,S3).
trial01(S1,S3) :-
	sort(S1,S),
	%%midpoint(S,MP),
	halves(S,H1,H2),
	midpoint(H1,Q1),
	midpoint(H2,Q3),
	IQR is Q3-Q1,
	sum(S,0,S02),
	mean(S02,Mean),
	furthestfrommean(S,Mean,V),
	D1 is 1.5*IQR,
	D2 is V-Mean,
	(D2>D1->(delete(S,V,S2),trial01(S2,S3));S=S3).
	
%%trial1(0,[],_A) :- fail,!.
trial1(0,A,A) :- !.
trial1(N,A,B) :- mindreadtest(S), append(A,[S],A2),
	N1 is N-1,trial1(N1,A2,B).
	
%%midpoint([],0) :- !.

midpoint(S,MP) :-
%%	not(S=[]),
	length(S,L),
	A is mod(L,2),
	(A is 0->
		(M1 is L/2, M2 is M1+1,N1 is M1-1,N2 is M2-1,length(N11,N1),length(N21,N2),append(N11,[N12|_Rest1],S),append(N21,[N22|_Rest2],S),MP is (N12+N22)/2)
	;
		(L2 is L+1, M1 is L2/2, N1 is M1-1,length(N11,N1),append(N11,[MP|_Rest],S))).

halves(S,H1,H2) :-
	length(S,L),
	A is mod(L,2),
	(A is 0->
		(M1 is L/2,length(H1,M1),append(H1,H2,S))
	;
		(L2 is L-1,M1 is L2/2,length(H1,M1),append(H1,[_|H2],S))).

sum([],S,S):-!.
sum(S0,S1,S2) :-
	S0=[S3|S4],
	S5 is S1+S3,
	sum(S4,S5,S2).
	
mean(Sum,Mean) :-
	Mean is Sum/2.

furthestfrommean(S,Mean,V) :-
	absdiffmean(S,Mean,[],D),
	sort(D,D1),
	reverse(D1,[[_,V]|_Rest]).

absdiffmean([],_M,D,D) :- !.
absdiffmean(S,M,D1,D2) :-
	S=[S1|S2],
	S3 is abs(S1-M),
	append(D1,[[S3,S1]],D3),
	absdiffmean(S2,M,D3,D2).

mindreadtest(Sec) :-
	%% 250 br for characters to be br out with 10 br each from person to me - do when initial 250 br test done and doing 10 br test
	%%comment(fiftyastest),
	%%random(X),X1 is 10*X, X2 is floor(X1), (X2=<2 -> (
	%%texttobr,write1(['true test']), %%); %% use breasonings breasoned out by computer for not by me, for job medicine for "me", at last time point
	%%true), %% leave last time point blank
	%%**texttobr2(640);true),%% make an A to detect reaction to gracious giving or blame of in following
	get_time(TimeStamp1),
	%%phrase_from_file(string(_String), 'file.txt'),
	texttobr2(2), %% 100 As for answer (must be br before this on same day)
	%% is gracious giving or blame
	get_time(TimeStamp2),
	%%comment(turnoffas),
   Sec is TimeStamp2 - TimeStamp1.
   
concat_list2A(A1,B):-
	A1=[A|List],
	concat_list2A(A,List,B),!.

concat_list2A(A,[],A):-!.
concat_list2A(A,List,B) :-
	List=[Item|Items],
	string_concat(A,Item,C),
	concat_list2A(C,Items,B).
