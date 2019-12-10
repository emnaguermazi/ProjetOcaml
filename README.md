# PROJECT : Funtionnal Programming in OCaml

This project is done by : [Emna GUERMAZI](https://github.com/emnaguermazi) & [Nguyet Ha TRAN](https://github.com/hatn23), students in 4IR-B2, INSA Toulouse.<br>

## Compiling instruction

A makefile also provides basic automation :
 - `make` to compile. This creates an ftest.native executable
 - `make format` to indent the entire project

## Discover the Project Modules 

The base project contains two modules and a main program: 

* `graph.mli` & `graph.ml` which define a module `Graph`
* `gfile.mli` & `gfile.ml` which define a module `Gfile`
* `ftest.ml`, the main program 

To generate an image from a dot file, type on command line: 

 `dot -Tpng your-dot-file > some-output-file` (if the png format is unrecognized, try svg)

### Part I : Ford-Fulkerson algorithm's implementation

In this part, we have to understand and implement the Ford-Fulkerson algorithm (in the module `fordfulkerson`, which define a module fordfulkerson), then test it on several examples and verify. We also created the module tool which contains severals additionnals functions used in the module fordfulkerson and the main program. 

### Part II : Ford-Fulkerson algorithm's use-case : Circulation–demand problem ([Max flow page](https://en.wikipedia.org/wiki/Maximum_flow_problem#Circulation%E2%80%93demand_problem))
-----------------------------------------------------------------------

Base project for Ocaml project on Ford-Fulkerson. This project contains some simple configuration files to facilitate editing Ocaml in VSCode.

To use, you should install the *OCaml* extension in VSCode. Other extensions might work as well but make sure there is only one installed.
Then open VSCode in the root directory of this repository.

Features :
 - full compilation as VSCode build task (Ctrl+Shift+b)
 - highlights of compilation errors as you type
 - code completion
 - automatic indentation on file save
