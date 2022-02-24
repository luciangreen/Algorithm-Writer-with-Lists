<a href="https://github.com/luciangreen/Essay-Helper">Essay Helper</a> | <a href="https://github.com/luciangreen/Text-to-Breasonings">Text-to-Breasonings (Helps Earn High Distinctions)</a> | Grammar Logic (Helps Mind Map Details)

# Algorithm Writer with Lists

Generates random algorithms in List Prolog, which can be converted to a simple form similar to Prolog.

* algwriter-lists-mr.pl - generates algorithms with combinations of other algorithms with vague mind reading
* algwriter-lists-random.pl - generates algorithms with combinations of other algorithms at random
* grammar_logic_to_alg.pl - takes text, randomly generates details and appropriate algorithms for A (agreement), B (disagreement) and solution to B based on approximate parts of speech and the Text to Breasonings dictionary.
* grammar_logic_to_alg_random.pl - like the previous algorithm but randomly selects up to 10 sentences from the file to process.
* random_dependencies.pl - generates random (meaningless) algorithm specifications.
* combophil.pl - finds combinations of lines to write philosophies about.
* combophil_grammar_logic_to_alg.pl - finds all combinations in lines to write philosophies and does what grammar_logic_to_alg.pl (above) does.
* four_crosses.pl - finds 4 crosses to transition to PhD refinement.
* combophil2qadb.pl - generates algorithms from dictionary.
* mr_alg.pl and ya_phil_to_alg.pl - Yet Another Philosophy to Algorithm and Mind Read Algorithm (randomly produces 5 line algorithms with type checking, possibly about Lucian Academy philosophies).

Please contact Lucian Green at <a href="mailto:luciangreen@lucianacademy.com">luciangreen@lucianacademy.com</a> with questions, comments and feedback about Algorithm Writer with Lists.

# Getting Started

Please read the following instructions on how to install the project on your computer for generating algorithms.

# Prerequisites

* Please download and install SWI-Prolog for your machine at `https://www.swi-prolog.org/build/`.

# 1. Install manually

Download <a href="http://github.com/luciangreen/Algorithm-Writer-with-Lists/">this repository</a>, the <a href="https://github.com/luciangreen/listprologinterpreter">List Prolog Interpreter Repository</a> and the <a href="https://github.com/luciangreen/Text-to-Breasonings">Text to Breasonings Repository</a>.

# 2. Or Install from List Prolog Package Manager (LPPM)

* Download the <a href="https://github.com/luciangreen/List-Prolog-Package-Manager">LPPM Repository</a>:

```
git clone https://github.com/luciangreen/List-Prolog-Package-Manager.git
cd List-Prolog-Package-Manager
swipl
['lppm'].
lppm_install("luciangreen","Algorithm-Writer-with-Lists").
halt
```

# Caution:

follow instructions in <a href="https://github.com/luciangreen/listprologinterpreter/blob/master/Instructions_for_Using_texttobr(2).pl.txt">Instructions for Using texttobr(2)</a> when using texttobr, texttobr2 or mind reader to avoid medical problems.

# Running Algorithm Writer with Lists with Mind Reader

* In Shell:
`cd Algorithm-Writer-with-Lists`
`swipl`
`['algwriter-lists-mr.pl'].`

* Enter `algwriter(Algorithm),writeln1(Algorithm).`

# Installing and Running Algorithm Writer with Lists at Random

* Download this repository.
* In SWI-Prolog, in the `"Algorithm-Writer-with-Lists"` folder, enter:
```
['algwriter-lists-random.pl'].
```
* Enter `algwriter(Algorithm),writeln1(Algorithm).`

# Installing and Running Grammar and Logic to Algorithm

* Download this repository.
* In SWI-Prolog, in the `"Algorithm-Writer-with-Lists"` folder, enter:
```
['grammar_logic_to_alg.pl'].
```
* Enter sentences and lines to randomly process to give details and algorithms to into `"file.txt"` in the `"Text-to-Breasonings"` folder.  The output or the `gla.txt` file, depending on whether you run using (1) or (2) in the following will contain the sentences and algorithms with instructions about how to run them.

* Enter `grammar_logic_to_alg1.` (1) or paste the contents of `grammar_logic_to_alg_sh.txt` into the Terminal window on Mac (2).

# Installing and Running Grammar and Logic to Algorithm at Random

* Download this repository.
* In SWI-Prolog, in the `"Algorithm-Writer-with-Lists"` folder, enter:
```
['grammar_logic_to_alg_random.pl'].
```
* As stated above, rather than processing the whole file, this algorithm processes up to 10 random sentences.
* Enter many sentences and lines to randomly process to give details and algorithms to into `"file.txt"` in the `"Algorithm-Writer-with-Lists"` folder.  The output or the `gla.txt` file, depending on whether you run using (1) or (2) in the following will contain the sentences and algorithms with instructions about how to run them.

* Enter `grammar_logic_to_alg1.` (1) or paste the contents of `grammar_logic_to_alg_sh.txt` into the Terminal window on Mac (2).

# Installing and Running Random Dependencies

* Download this repository.
* In SWI-Prolog, in the `"Algorithm-Writer-with-Lists"` folder, enter:
```
['random_dependencies.pl'].
```
* As stated above, the value of this algorithm's input is found by mentally inserting not and transformations.

* Enter `random_dependencies(A),writeln1(A).`

```
[substring,[[duplicates,[[]]],[findall,[[add_number_to_list,[[split_into_sentences,[[sort,[[list_head,[[reverse,[[findall,[[string_to_list,[[or,[[and,[[delete,[[map,[[]]]]],[]]]]]]]]]]]]],[map,[[length,[[maximum,[[length,[[reverse,[[split_into_sentences,[[member,[[map,[[]]]]]]],[]]]]]]],[delete,[[get_item_n,[[],[and,[[]]]]],[reverse,[[]]]]]]],[]]]]]]]]]]]]]
```

# Installing and Running Combinations of Lines of Philosophy

* Download this repository.
* In SWI-Prolog, in the `"Algorithm-Writer-with-Lists"` folder, enter:
```
['combophil.pl'].
```
* Finds combinations of lines to write philosophies about with e.g. a combination of 2 lines:

* Enter `combophil(2).`

# Installing and Running Combinations of Lines of Philosophy with Grammar and Logic to Algorithm

* Download this repository.
* In SWI-Prolog, in the `"Algorithm-Writer-with-Lists"` folder, enter:
```
['combophil_grammar_logic_to_alg.pl'].
```
* Enter sentences and lines to intermix (warning: takes all combinations of verbs and non verbs in file) and randomly process to give details and algorithms to into `"file.txt"` in the `"Text-to-Breasonings"` folder.  The output in the following will contain the sentences and algorithms with instructions about how to run them.

* Enter `combophil_grammar_logic_to_alg1.`

# Installing and Running Four Crosses
* Download this repository.
* In SWI-Prolog, in the `"Algorithm-Writer-with-Lists"` folder, enter:
```
['four_crosses.pl'].
```
* Enter four levels of crosses of ideas to make a PhD-level connection.

* Enter `four_crosses.`

# grammar_logic_to_alg2.pl
* Converts files from e.g. grammar_logic_to_alg.pl to simplified algorithms with more specific command names.  Breason out file.txt using <a href="https://github.com/luciangreen/Text-to-Breasonings">Text-to-Breasonings</a>, run grammar_logic_to_alg.pl, run
grammar_logic_to_alg2.pl, then run <a href="https://github.com/luciangreen/Text-to-Breasonings">Text-to-Breasonings Reading Algorithm</a> on the grammar_logic_to_alg2.pl output.
* Download this repository.
* In SWI-Prolog, in the `"Algorithm-Writer-with-Lists"` folder, enter:
```
['grammar_logic_to_alg2.pl'].
```
* Enter the number of words in file.txt to replace with computational language (it learns as it goes).

* Enter `grammar_logic_to_alg2(200).`

# combophil2qadb.pl
* Generates algorithms in qadb format from word dictionary.
* Download this repository.
* In SWI-Prolog, in the `"Algorithm-Writer-with-Lists"` folder, enter:
```
['combophil2qadb.pl'].
```
* Enter `.` or `\n` delimited algorithm ideas in `Text-to-Breasonings/file.txt` and enter:
`combophil2qadb.`
* Produces algorithms in `file-o.txt`.

# Installing and Running Yet Another Philosophy to Algorithm and Mind Read Algorithm

* Download this repository.
* In SWI-Prolog, in the `"Algorithm-Writer-with-Lists"` folder, enter:
```
['ya_phil_to_alg.pl.pl'].

```
* As stated above, Yet Another Philosophy to Algorithm randomly produces 5 line algorithms with type checking about all sentences in `Lucian-Academy/`.


* Enter `ya_phil_to_alg.`

* Produces the file `yet_more_phil_algs.txt`, containing, for example:
```
...n,length,list,number,n,round,number,number,n,sqrt,number,number,n,sqrt,number,number,n,round,number,number,n,sqrt,number,number...
```

* To produce one five-line algorithm, enter `mr_alg(Commands).`, producing:

* `Commands = [[[n,member],[[list],[_3386]]],[[n,member],[[list],[list]]],[[n,intersection],[[list],[list]]],[[n,member],[[list],[_5928]]],[[n,atom_string],[[atom],[string]]],[[n,string_length],[[string],[number]]]]`,

* where this algorithm means, "Take a member (the second item, the first output of member) of a list, take a member list of this list, etc.".

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the <a href="LICENSE">LICENSE.md</a> file for details

