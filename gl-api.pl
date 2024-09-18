:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_error)).
:- use_module(library(http/html_write)).

% we need this module from the HTTP client library for http_read_data
:- use_module(library(http/http_client)).
:- http_handler('/', web_form, []).

% GitHub
:-include('grammar_logic_to_alg.pl').

server(Port) :-
        http_server(http_dispatch, [port(Port)]).

	/*
	browse http://127.0.0.1:8000/
	This demonstrates handling POST requests
	   */

	   web_form(_Request) :-
	   	reply_html_page(
			    title('Grammar Logic'),
			    	    [
				    	     form([action='/landing', method='POST'], [
				    	     /**
					     		p([], [
									  label([for=debug],'Debug (on/off):'),
									  		  input([name=debug, type=textarea])
											  		      ]),
											  		      **/
													      		p([], [
																	  label([for=query],'Grammar Logic Input:'),
																	  		  input([name=query, type=textarea])
																			  		      ]),
													  
																					      		p([], input([name=submit, type=submit, value='Submit'], []))
																								      ])]).

																								      :- http_handler('/landing', landing_pad, []).

																								      landing_pad(Request) :-

%	working_directory(_, 'GitHub/Algorithm-Writer-with-Lists/'),
																								              member(method(post), Request), !,
																									              http_read_data(Request, Data, []),
																										              format('Content-type: text/html~n~n', []),
																											      	format('<p>', []),
																												        %%portray_clause(Data),
																												        
																												        %%term_to_atom(Term,Data),
																												        
Data=[%%debug='off',%%Debug1,
query=Query1,submit=_],


	grammar_logic_to_alg1(Query1,4000,Result),
																														%%format('</p><p>========~n', []),
																															%%portray_clause
																															portray_clause(Result),
																																																															%%writeln1(Data),

format('</p>').