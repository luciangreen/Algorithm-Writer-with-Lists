:- use_module(library(readutil)).

% Declare your core taxonomy elements as dynamic
:- dynamic is_a/2.
:- dynamic concept_property/3.

% 1. Read the raw ConceptNet file line by line and assert facts directly to RAM
compile_conceptnet_to_qlf(CsvPath, QlfOutputPath) :-
    retractall(is_a(_, _)),
    retractall(concept_property(_, _, _)),
    
    open(CsvPath, read, Stream),
    writeln('Streaming ConceptNet lines to virtual memory...'),
    stream_loop(Stream, 0),
    close(Stream),
    
    % 2. Save the asserted memory image out directly into a pre-compiled QLF file
    writeln('\nCompiling memory snapshot straight to QLF file...'),
    qcompile_fact_base(QlfOutputPath),
    writeln('Success! QLF compilation complete.').

stream_loop(Stream, Count) :-
    read_line_to_string(Stream, Line),
    (   Line == end_of_file
    ->  true
    ;   process_line(Line),
        NewCount is Count + 1,
        (0 is NewCount mod 100000 -> format('\rProcessed ~w lines...', [NewCount]), flush_output ; true),
        stream_loop(Stream, NewCount)
    ).

process_line(Line) :-
    split_string(Line, "\t", "", [_URI, Relation, Source, Target, _JSON]),
    (   (sub_string(Source, 0, 6, _, "/c/en/"), sub_string(Target, 0, 6, _, "/c/en/"))
    ->  clean_uri(Source, CleanSource),
        clean_uri(Target, CleanTarget),
        assert_fact(Relation, CleanSource, CleanTarget)
    ;   true
    ).

clean_uri(URI, WordAtom) :-
    split_string(URI, "/", "", Components),
    nth0(3, Components, WordString),
    atom_string(WordAtom, WordString).

assert_fact("/r/IsA", Src, Tgt) :- \+ is_a(Src, Tgt), assertz(is_a(Src, Tgt)), !.
assert_fact(Relation, Src, Tgt) :-
    split_string(Relation, "/", "", ["", "r", RelName]),
    atom_string(RelAtom, RelName),
    \+ concept_property(Src, RelAtom, Tgt),
    assertz(concept_property(Src, RelAtom, Tgt)), !.
assert_fact(_, _, _).

% Writes current memory facts down to a compiled object file
qcompile_fact_base(OutputFile) :-
    open(OutputFile, write, OutStream),
    % Write the standard dynamic definitions safely to file
    format(OutStream, ':- dynamic is_a/2.~n', []),
    format(OutStream, ':- dynamic concept_property/3.~n', []),
    forall(is_a(A, B), format(OutStream, 'is_a(~q, ~q).~n', [A, B])),
    forall(concept_property(X, Y, Z), format(OutStream, 'concept_property(~q, ~q, ~q).~n', [X, Y, Z])),
    close(OutStream),
    % Run SWI-Prolog's quick compilation compiler
    qcompile(OutputFile).
