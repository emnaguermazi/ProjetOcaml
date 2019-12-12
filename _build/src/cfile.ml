open Graph
open Printf

type path = string

(* Format of text files:

   S id p  -> Source(Factory)'s id with capacity p(p is the production rate of the factory )
   T id d  -> Destination(Village)'s id with capacity d( d is the demand rate of the village)

   % Road with its capacity c
   R id1 id2 c

*)


(* Reads a line with a source. *)
let read_source line outfile =
  try Scanf.sscanf line "S %s %s" (fun id lbl -> fprintf outfile "n %s\n"  id;
                                    fprintf outfile "e 0 %s %s\n"id lbl;)
  with e ->
    Printf.printf "Cannot read source in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "read_source"

(* Reads a line with a destination. *)
let read_destination line outfile =
  try Scanf.sscanf line "T %s %s"  (fun id lbl -> fprintf outfile "n %s \n" id;
                                     fprintf outfile "e %s 100 %s\n"  id lbl;)
  with e ->
    Printf.printf "Cannot read arc in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "read_destination"

let read_transport line outfile =
  try Scanf.sscanf line "R %s %s %s" (fun id1 id2 lbl ->
      fprintf outfile "e %s %s %s\n" id1 id2 lbl;)
  with e ->
    Printf.printf "Cannot read line - %s:\n%s\n" (Printexc.to_string e) line ;
    failwith "read_transport"

let create_file infile outfile =

  let fx = open_in infile in
  let ff = open_out outfile in

  (* Create 2 points : Source and Destination*)
  fprintf ff "n 0\n";
  fprintf ff "n 100\n";

  (* Read all lines until end of file. *)
  let rec loop () =
    try
      let line = input_line fx in
      let () =
        (* Ignore empty lines *)
        if line = "" then ()

        (* The first character of a line determines its content : S, D or C.
         * Else it will be ignored *)
        else match line.[0] with
          | 'S' -> read_source line ff
          | 'T' -> read_destination line ff
          | 'R' -> read_transport line ff 
          | _ -> ()
      in                 
      loop ()        
    with End_of_file -> ()
  in
  loop ();
  close_out ff;
  close_in fx;
  ()

let export path graph = 
  (* Open a write-file. *)
  let ff = open_out path in

  (* Write in this file. *)
  fprintf ff "digraph finite_state_machine {\n" ;
  fprintf ff "  rankdir=LR;\n" ;
  fprintf ff "  size=\"8,5\"\n" ;
  fprintf ff "  node [shape = circle];\n";

  (* Write all arcs *)
  (*The output graph must not contain 2 "imaginary" points : the "main" source and the "main" destination*)
  e_iter graph (fun id1 id2 lbl -> if (id1 <> 0 && id1 <> 100 && id2 <> 0&& id2 <> 100 )then fprintf ff "LR_%d -> LR_%d [ label = %s ]\n" id1 id2 lbl) ;
  (*e_iter graph (fun id1 id2 lbl -> fprintf ff "LR_%d -> LR_%d [ label = %s ]\n" id1 id2 lbl) ;*)
  fprintf ff "}" ;

  close_out ff ;
  ()

