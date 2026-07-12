% =============================================================================
% STRING EXTENSION FOR MULTIPLE SENTENCES
% =============================================================================

% Main Entry Point: Pass a raw text string here
evaluate_text(TextString) :-
    % 1. Split the text into individual sentences based on periods (.)
    split_string(TextString, ".", " \t\n", RawSentences),
    % 2. Process each sentence loop
    process_sentence_strings(RawSentences).

% Base case: stop when there are no more sentences left to process
process_sentence_strings([]).
process_sentence_strings([Str|Rest]) :-
    % Skip trailing empty strings caused by the final period
    (   Str == ""
    ->  process_sentence_strings(Rest)
    ;   format('~n--- Evaluating Sentence: "~w." ---~n', [Str]),
        % 2. Convert sentence string to lowercase words list
        string_lower(Str, LowerStr),
        split_string(LowerStr, " ", " \t\n", WordStrings),
        maplist(atom_string, WordList, WordStrings),
        
        % 3. Call your core DCG / Semantic Validation engine
        % (Wraps call in catch to prevent one bad sentence from crashing the whole loop)
        catch(evaluate_sentence(WordList), Error, format('Engine Error: ~w~n', [Error])),
        
        % Continue to next sentence in string
        process_sentence_strings(Rest)
    ).
