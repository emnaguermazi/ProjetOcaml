# PROJECT : Funtionnal Programming in OCaml

This project is done by : [Emna GUERMAZI](https://github.com/emnaguermazi) & [Nguyet Ha TRAN](https://github.com/hatn23), students in 4IR-B2, INSA Toulouse.<br>

## Compiling instruction

A makefile also provides basic automation :
 - `make` to compile. This creates ftest.native and ctest.native executable
 - `make format` to indent the entire project

## Discover the Project Modules 

The base project contains two modules and a main program: 

* `graph.mli` & `graph.ml` which define a module `Graph`
* `gfile.mli` & `gfile.ml` which define a module `Gfile`
* `ftest.ml`, the main program 

To generate an image from a dot file, type on command line: 

 `dot -Tpng your-dot-file > some-output-file` (if the png format is unrecognized, try svg)

### Part 1 : Ford-Fulkerson algorithm's implementation

In this part, we have to understand and implement the Ford-Fulkerson algorithm (in the module `fordfulkerson`, which define a module fordfulkerson), then test it on several examples and verify. We also created the module tool which contains severals additionnals functions used in the module fordfulkerson and the main program. 

### Part 2 : Ford-Fulkerson algorithm's use-case : Circulation–demand problem ([Max flow page](https://en.wikipedia.org/wiki/Maximum_flow_problem#Circulation%E2%80%93demand_problem))

Find a use-case of this algorithm and write a program that solves the problem. <br>
We build 2 modules named `Cfile` and `Gfile2`. The module `Cfile` translate a circulation-demand problem into a flow graph problem and the module `Gfile2` is another version of the module `Gfile` which input file has a slightly different format.<br>
We created somes input text files with the imposed format, they have to contain the following elements:
* Source node with its supply capacity. By example, a source has id ***1*** with supply capacity ***5*** is presented as : ***S 1 5***
* Destination node with its demand capacity. By example, a destination has id ***2*** with demand capcity ***20*** is presented as : ***T 2 20***
* Node
* Transport roads between nodes, as well as its maximal capacity. By example, a transport road between node ***1*** and node ***2*** with a maximal capacity of ***20 products***, it is presented as : ***R 1 2 20***

In this part, the project contains : 
* `cfile.mli` & `cfile.ml` defining module `Cfile`.
* `gfile2.mli` & `gfile2.ml` defining module `Gfile2`.
* `ctest.ml`, part 2's main program.

## Project's validity testing 

In order to test the project's validity, we ran the programs on some examples and compared the results with those obtained by using other tools/programs, by calculating by hand and paper, etc. 

### I. Ford Fulkerson algorithm testing : the following commands are used to test Part 1  
 
* `./ftest.native graphs/graph1.txt 0 3 graphs/g_output1.txt` where `graph1.txt` is the text-formatted input graph and `g_output_1` is the result graph. Here we choose `0` and `3` as source and sink. 

* `dot -Tpng g_output_1.txt > g_output_1_0_3_flow25.png` to visualize the text-formatted result graph by converting it into an image. 

Other similar commands are used to test with the text-formatted input graph `graph2.txt` and `graph3.txt`.


### II. Transport case testing : the following commands are used to test Part 2  

* `./ctest.native graphs/circulation1.txt Graphs/c_graph1.txt Graphs/c_output1.txt` where `circulation1.txt` is the transport's problem written in the correct format precised in part 2,`c_graph1.txt` is the text-formatted input graph (obtained by translating the circulation-demand problem) and `c_output1.txt` is the result graph.

* `dot -Tpng Graphs/c_graph1.txt > Graphs/c_graph1.png` to visualize the starting graph.

* `dot -Tpng Graphs/c_output1.txt > Graphs/c_output1.png` to visualize the result graph.

Other similar commands are used to test with another circulation-demand problem in `circulation2.txt`.


