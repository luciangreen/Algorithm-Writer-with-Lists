:- use_module(library(lists)).

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
has_property(Word, actor_type(animate)) :-
    (ancestor(Word, Parent) ; Word = Parent),
    concept_property(Parent, 'CapableOf', _). % Anything capable of executing actions

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

% Propose a fix for a broken sentence by swapping parts out matching constraints
suggest_correction(svo(Subj, Verb, Obj), ReplacedPart, Suggestion) :-
    verb_constraint(Verb, SubjConstraint, ObjConstraint),
    (   \+ has_property(Subj, SubjConstraint) ->
        % Subject is wrong; find a noun that fits the verb's subject rule
        word_type(ValidSubj, noun),
        ValidSubj \= Subj,
        has_property(ValidSubj, SubjConstraint),
        ReplacedPart = subject(Subj),
        Suggestion = svo(ValidSubj, Verb, Obj)
    ;   \+ has_property(Obj, ObjConstraint) ->
        % Object is wrong; find a noun that fits the verb's object rule
        word_type(ValidObj, noun),
        ValidObj \= Obj,
        has_property(ValidObj, ObjConstraint),
        ReplacedPart = object(Obj),
        Suggestion = svo(Subj, Verb, ValidObj)
    ;   % If both nouns are fine but the verb is wrong, find a matching verb
        word_type(ValidVerb, verb),
        ValidVerb \= Verb,
        verb_constraint(ValidVerb, SubjConstraint, ObjConstraint),
        has_property(Subj, SubjConstraint),
        has_property(Obj, ObjConstraint),
        ReplacedPart = verb(Verb),
        Suggestion = svo(Subj, ValidVerb, Obj)
    ).

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
