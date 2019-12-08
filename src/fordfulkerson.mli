open Graph
open Tools
open Gfile

type path = (id * id * int) list

val find_path : int graph -> id -> id -> path

val min_capacity : path -> int

val update_graph : int graph -> path -> int graph

val ford_fulkerson : int graph -> id -> id -> int -> int

val print_list : path -> unit

val update_graph2 : int graph -> path -> int graph

val ford_fulkerson2 : int graph -> id -> id -> int -> int
