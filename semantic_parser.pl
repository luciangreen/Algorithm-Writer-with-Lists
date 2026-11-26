:- use_module(library(lists)).

% ConceptNet facts, if a loader has read any (see csv_loader.pl, pure_loader.pl).
:- dynamic concept_property/3.

% =============================================================================
% 1. KNOWLEDGE BASE & TAXONOMY (The Facts)
% =============================================================================

% Lexical category and entity definitions
word_type(the, determiner).
word_type(a, determiner).

word_type(cow, noun).
word_type(table, noun).
word_type(grass, noun).
word_type(water, noun).

word_type(eats, verb).
word_type(holds, verb).
word_type(drinks, verb).

% Taxonomical Hierarchy (IsA links)
is_a(cow, mammal).
is_a(mammal, animal).
is_a(animal, organism).
is_a(organism, living_thing).

is_a(table, furniture).
is_a(furniture, inanimate_object).

is_a(grass, vegetation).
is_a(vegetation, organic_matter).

is_a(water, liquid).

% Recursive Ancestor Rule for Inheritance
ancestor(X, Y) :- is_a(X, Y).
ancestor(X, Y) :- is_a(X, Z), ancestor(Z, Y).

% Base Semantic Properties
property(living_thing, [actor_type(animate)]).
property(inanimate_object, [actor_type(inanimate)]).
property(organic_matter, [food_type(vegetation)]).
property(liquid, [food_type(liquid)]).

% Inherited Property Lookup
% An unconstrained slot (a variable) accepts anything.
has_property(_, Constraint) :-
    var(Constraint), !.
% A word has a property if it, or anything it is a kind of, lists it.
has_property(Word, Property) :-
    (Word = Parent ; ancestor(Word, Parent)),
    property(Parent, Properties),
    memberchk(Property, Properties), !.
% Anything ConceptNet says is capable of an action counts as animate.
has_property(Word, actor_type(animate)) :-
    (Word = Parent ; ancestor(Word, Parent)),
    concept_property(Parent, 'CapableOf', _), !.

% Verb Semantic Constraints (What verbs demand from Subjects and Objects)
% Verb, Subject Requirement, Object Requirement
verb_constraint(eats, actor_type(animate), food_type(vegetation)).
verb_constraint(drinks, actor_type(animate), food_type(liquid)).
verb_constraint(holds, actor_type(inanimate), _AnyObject).

% =============================================================================
% 2. DCG SYNTAX PARSER
% =============================================================================
% Parses a list of words into a structural Subject-Verb-Object (SVO) tree.

sentence(svo(Subj, Verb, Obj)) --> noun_phrase(Subj), verb_phrase(Verb), noun_phrase(Obj).

noun_phrase(Noun) --> [Det], [Noun], { word_type(Det, determiner), word_type(Noun, noun) }.
noun_phrase(Noun) --> [Noun], { word_type(Noun, noun) }.

verb_phrase(Verb) --> [Verb], { word_type(Verb, verb) }.

% =============================================================================
% 3. SEMANTIC VALIDATION & REASONING CORE
% =============================================================================

% Validate if the parsed SVO structure matches the world facts database
validate_semantics(svo(Subj, Verb, Obj)) :-
    verb_constraint(Verb, SubjConstraint, ObjConstraint),
    has_property(Subj, SubjConstraint),
    has_property(Obj, ObjConstraint).

% =============================================================================
% 4. CORRECTION & SUGGESTION ENGINE
% =============================================================================

% Propose a fix for a broken sentence: the fewest changed words (subject,
% object or verb first, then two of them) that give a sentence which itself
% passes validate_semantics/1, so a suggestion is never also wrong.
suggest_correction(svo(Subj, Verb, Obj), ReplacedPart, Suggestion) :-
    (   candidate_fix(svo(Subj, Verb, Obj), 1, ReplacedPart, Suggestion)
    ;   candidate_fix(svo(Subj, Verb, Obj), 2, ReplacedPart, Suggestion)
    ),
    Suggestion = svo(SS, _, SO), SS \== SO,
    validate_semantics(Suggestion),
    !.

candidate_fix(svo(S, V, O), 1, subject(S), svo(S2, V, O)) :-
    word_type(S2, noun), S2 \== S.
candidate_fix(svo(S, V, O), 1, object(O), svo(S, V, O2)) :-
    word_type(O2, noun), O2 \== O.
candidate_fix(svo(S, V, O), 1, verb(V), svo(S, V2, O)) :-
    word_type(V2, verb), V2 \== V.
candidate_fix(svo(S, V, O), 2, [subject(S), object(O)], svo(S2, V, O2)) :-
    word_type(S2, noun), S2 \== S,
    word_type(O2, noun), O2 \== O.
candidate_fix(svo(S, V, O), 2, [subject(S), verb(V)], svo(S2, V2, O)) :-
    word_type(S2, noun), S2 \== S,
    word_type(V2, verb), V2 \== V.
candidate_fix(svo(S, V, O), 2, [verb(V), object(O)], svo(S, V2, O2)) :-
    word_type(V2, verb), V2 \== V,
    word_type(O2, noun), O2 \== O.

% =============================================================================
% 5. MAIN ENTRY POINT (User Interface)
% =============================================================================

% Evaluates an input sentence list and prints the logical outcome
evaluate_sentence(WordList) :-
    % Step 1: Syntactic parsing via DCG
    (   phrase(sentence(SVO), WordList)
    ->  format('Syntax Validated: ~w~n', [SVO]),
        % Step 2: Semantic fact check
        (   validate_semantics(SVO)
        ->  writeln('Result: Sentence makes logical sense!')
        ;   writeln('Result: Semantic Error! Sentence violates physical facts.'),
            % Step 3: Rule-based correction synthesis
            (   suggest_correction(SVO, ReplacedPart, FixedSVO)
            ->  format('Correction Suggestion: Replace ~w -> Managed Form: ~w~n', [ReplacedPart, FixedSVO])
            ;   writeln('Correction Suggestion: No valid replacements found in current database.')
            )
        )
    ;   writeln('Syntax Error: Sentence structure not recognized (Use SVO pattern).')
    ).
