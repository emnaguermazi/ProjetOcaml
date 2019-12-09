open Graph
open Tools
open Gfile

(* Type of a path from a node to another node
   A path is represented by a list of (id,id,label) *)
type path = (id * id * int) list

(*Indicates if a path from source_node to destination_node exists in graph g.
  @raise Graphe_error if s (ou t) is unknown in the graph *)
val path_exist : int graph -> id -> id -> bool

(*Finds in the graph a list that includes all of paths from soucre_node to destination_node 
  @raise Graphe_error if s (ou d) is unknown in the graph *)
val find_path : int graph -> id -> id -> path

val min_capacity : path -> int
(*Print a list in terminal
  This function is used to print path to verify the result*)
val print_list : path -> unit

(*update the graph when having the value flot_min got by a path *)
val update_graph : int graph -> path -> int graph

val update_output : int graph -> (id * id * int) list -> int graph

val initalize_output : int graph -> int graph
(* apply the Ford-Fulkerson algorithm for graph g
   return a graph with flot max*)
val ford_fulkerson : int graph -> id -> id -> int graph


