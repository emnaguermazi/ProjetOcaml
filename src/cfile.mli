(* Read a graph from a file,
 * Write a graph to a file. *)

open Graph

type path = string

(* Creating a gfile from a cfile *)
val create_file: path -> path -> unit

val export: path -> string graph -> unit