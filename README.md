# Algorithm Writer with Lists

Generates random algorithms in List Prolog, which can be converted to a simple form similar to Prolog.

* algwriter-lists-mr.pl - generates algorithms with combinations of other algorithms with vague mind reading
* algwriter-lists-random.pl - generates algorithms with combinations of other algorithms at random
* grammar_logic_to_alg.pl - takes text, randomly generates details and appropriate algorithms for A (agreement), B (disagreement) and solution to B based on approximate parts of speech and the Text to Breasonings dictionary.

Please contact Lucian Green at <a href="mailto:luciangreen@lucianacademy.com">luciangreen@lucianacademy.com</a> with questions, comments and feedback about Algorithm Writer with Lists.

# Getting Started

Please read the following instructions on how to install the project on your computer for generating algorithms.

# Prerequisites

Install List Prolog Interpreter Repository (https://github.com/luciangreen/listprologinterpreter) first.

# Installing and Running Algorithm Writer with Lists with Mind Reader

* Download this repository.
* In SWI-Prolog, in the `"algwriter"` folder in the code folder, enter:
```
['algwriter-lists-mr.pl'].
```
* Enter `algwriter(Algorithm),writeln1(Algorithm).`

### Caution:

follow instructions in <a href="https://github.com/luciangreen/listprologinterpreter/blob/master/Instructions_for_Using_texttobr(2).pl.txt">Instructions for Using texttobr(2)</a> when using texttobr, texttobr2 or mind reader to avoid medical problems.

* If necessary, repeat the "arem" mantra all the time while the computation is running to ensure the best results.

# Installing and Running Algorithm Writer with Lists at Random

* Download this repository.
* In SWI-Prolog, in the `"algwriter"` folder in the code folder, enter:
```
['algwriter-lists-random.pl'].
```
* Enter `algwriter(Algorithm),writeln1(Algorithm).`

# Installing and Running Grammar and Logic to Algorithm

* Download this repository.
* In SWI-Prolog, in the `"algwriter"` folder in the code folder, enter:
```
['grammar_logic_to_alg.pl'].
```
* Enter sentences and lines to randomly process to give details and algorithms to into `"file.txt"` in the code, NOT the algwriter folder.  The output or the `gla.txt` file, depending on whether you run using (1) or (2) in the following will contain the sentences and algorithms with instructions about how to run them.

* Enter `grammar_logic_to_alg1.` (1) or paste the contents of `grammar_logic_to_alg_sh.txt` into the Terminal window on Mac (2).

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the <a href="LICENSE">LICENSE.md</a> file for details

