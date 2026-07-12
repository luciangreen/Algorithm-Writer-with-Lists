% ['/Users/lg3/Prolog/conceptnet_fast.qlf'].
% [semantic_parser].
% [grammar_logic_to_alg].
% sentences(2,S),evaluate_text(S).

:- use_module(library(readutil)).

% Declare dynamic predicates that map to our syntax/semantic engine
:- dynamic is_a/2.
:- dynamic concept_property/3.

% =============================================================================
% 1. STREAM INGESTION ENGINE (Memory-Safe)
% =============================================================================

load_conceptnet(FilePath) :-
    retractall(is_a(_, _)),
    retractall(concept_property(_, _, _)),
    open(FilePath, read, Stream),
    writeln('Streaming ConceptNet... Processing English assertions only...'),
    read_lines_loop(Stream, 0),
    close(Stream),
    writeln('Success: Ingestion complete!').

% Loop through file line by line to keep RAM usage near 0 MB
read_lines_loop(Stream, Count) :-
    read_line_to_string(Stream, Line),
    (   Line == end_of_file
    ->  true
    ;   process_line(Line),
        NewCount is Count + 1,
        % Print a progress update every 100,000 lines
        (0 is NewCount mod 100000 -> format('Processed ~w lines...~n', [NewCount]); true),
        read_lines_loop(Stream, NewCount)
    ).

% =============================================================================
% 2. THE FORMAT PARSER (URI Transformer)
% =============================================================================

process_line(Line) :-
    % ConceptNet columns are tab-separated (\t)
    split_string(Line, "\t", "", [_URI, Relation, Source, Target, _JSON]),
    
    % Filter out non-English nodes to drastically shrink memory footprint
    (   (sub_string(Source, 0, 6, _, "/c/en/"), sub_string(Target, 0, 6, _, "/c/en/"))
    ->  clean_uri(Source, CleanSource),
        clean_uri(Target, CleanTarget),
        assert_conceptnet_fact(Relation, CleanSource, CleanTarget)
    ;   true
    ).

% Strips ConceptNet URIs down to plain English words 
% Example: "/c/en/cow/n" -> 'cow'
clean_uri(URI, WordAtom) :-
    split_string(URI, "/", "", Components),
    % Components list structure: ["", "c", "en", "word", ...]
    nth0(3, Components, WordString),
    atom_string(WordAtom, WordString).

% =============================================================================
% 3. SEMANTIC ENGINE ADAPTER
% =============================================================================
% Translates standard ConceptNet properties into predicates our parser expects

assert_conceptnet_fact("/r/IsA", Source, Target) :-
    \+ is_a(Source, Target), % Avoid duplication
    assertz(is_a(Source, Target)), !.

assert_conceptnet_fact(Relation, Source, Target) :-
    % Translates relation URI paths like "/r/CapableOf" into standard properties
    split_string(Relation, "/", "", ["", "r", RelName]),
    atom_string(RelAtom, RelName),
    \+ concept_property(Source, RelAtom, Target),
    assertz(concept_property(Source, RelAtom, Target)), !.
assert_conceptnet_fact(_, _, _). % Ignore other entries
