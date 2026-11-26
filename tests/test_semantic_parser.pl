% Load the checker relative to this file, so the tests run from any folder.
:- prolog_load_context(directory, Dir),
   (   member(Rel, ['/../semantic_parser.pl', '/semantic_parser.pl']),
       atomic_list_concat([Dir, Rel], P),
       exists_file(P)
   ->  consult(P)
   ;   throw(error(existence_error(file, 'semantic_parser.pl'), _))
   ).

:- begin_tests(semantic_parser).

test(cow_eats_grass_makes_sense) :-
    validate_semantics(svo(cow, eats, grass)).

test(cow_drinks_water_makes_sense) :-
    validate_semantics(svo(cow, drinks, water)).

test(table_eats_grass_is_wrong) :-
    \+ validate_semantics(svo(table, eats, grass)).

test(cow_eats_water_is_wrong) :-
    \+ validate_semantics(svo(cow, eats, water)).

test(properties_are_inherited) :-
    has_property(cow, actor_type(animate)),
    has_property(grass, food_type(vegetation)),
    has_property(table, actor_type(inanimate)).

test(any_object_accepted_when_unconstrained) :-
    has_property(water, _).

test(suggestion_for_wrong_subject) :-
    suggest_correction(svo(table, eats, grass), subject(table), svo(cow, eats, grass)).

test(suggestion_for_wrong_object) :-
    suggest_correction(svo(cow, eats, water), object(water), svo(cow, eats, grass)).

test(every_suggestion_is_itself_valid) :-
    forall(( member(S, [cow, table, grass, water]), member(V, [eats, drinks, holds]),
             member(O, [cow, table, grass, water]),
             \+ validate_semantics(svo(S, V, O)),
             suggest_correction(svo(S, V, O), _, Fix) ),
           validate_semantics(Fix)).

test(suggestion_never_repeats_a_noun) :-
    forall(( member(S, [cow, table, grass, water]), member(V, [eats, drinks, holds]),
             member(O, [cow, table, grass, water]),
             suggest_correction(svo(S, V, O), _, svo(S2, _, O2)) ),
           S2 \== O2).

test(sentence_parses) :-
    phrase(sentence(svo(cow, eats, grass)), [the, cow, eats, the, grass]).

:- end_tests(semantic_parser).
