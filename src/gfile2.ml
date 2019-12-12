open Graph
open Printf

type path = string

(* Format of text files:
   % This is a comment

   % A node with its id .
   n 1
   n 2

   % Edges: e source dest label
   e 3 1 11
   e 0 2 8

*)

let write_file path graph =

  (* Open a write-file. *)
  let ff = open_out path in

  (* Write in this file. *)
  fprintf ff "%% This is a graph.\n\n" ;

  (* Write all nodes (with fake coordinates) *)
  n_iter_sorted graph (fun id -> fprintf ff "n %f\n" (float_of_int id)) ;
  fprintf ff "\n" ;

  (* Write all arcs *)
  e_iter graph (fun id1 id2 lbl -> fprintf ff "e %d %d %s\n" id1 id2 lbl) ;

  fprintf ff "\n%% End of graph\n" ;

  close_out ff ;
  ()

(* Reads a line with a node. *)
let read_node graph line =
  try Scanf.sscanf line "n %d" (fun id -> new_node graph id)
  with e ->
    Printf.printf "Cannot read node in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "read_node"

(* Reads a line with an arc. *)
let read_arc graph line =
  try Scanf.sscanf line "e %d %d %s" (fun id1 id2 label -> new_arc graph id1 id2 label)
  with e ->
    Printf.printf "Cannot read arc in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "read_arc"

(* Reads a comment or fail. *)
(*let read_comment graph line =
  try Scanf.sscanf line " %%" graph
  with _ ->
    Printf.printf "Unknown line:\n%s\n%!" line ;
    failwith "read_comment"*)

let from_file path =

  let infile = open_in path in

  (* Read all lines until end of file. *)
  let rec loop graph =
    try
      let line = input_line infile in

      (* Remove leading and trailing spaces. *)
      (*let line = String.trim line in*)

      let graph2 =
        (* Ignore empty lines *)
        if line = "" then (graph)

        (* The first character of a line determines its content : n or e. *)
        else match line.[0] with
          | 'n' -> (read_node graph line)
          | 'e' -> (read_arc graph line)
          (* It should be a comment, otherwise we complain. *)
          | _ -> graph
      in      
      loop graph2

    with End_of_file -> graph (* Done *)
  in

  let final_graph = loop empty_graph in

  close_in infile ;
  final_graph

let export path graph =

  (* Open a write-file. *)
  let ff = open_out path in

  (* Write in this file. *)
  fprintf ff "digraph finite_state_machine {\n";
  fprintf ff "rankdir=LR;\n";
  fprintf ff "Size=\"8,5\"\n";
  fprintf ff "node [shape = circle];\n";

  (* Write all nodes (with fake coordinates) *)
  e_iter graph (fun id1 id2 lbl -> fprintf ff "%d -> %d [ label = %s ]\n" id1 id2 lbl) ;
  fprintf ff "}\n" ;

  close_out ff ;
  ()