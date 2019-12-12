open Graph
open Cfile
open Tools
open Gfile2
open Fordfulkerson


let () =

  if Array.length Sys.argv <> 4 then
    begin
      Printf.printf "\nUsage: %s infile outfile graphfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;

  let infile = Sys.argv.(1) 
  and outfile = Sys.argv.(3)
  and graphfile = Sys.argv.(2)

  in
  Cfile.create_file infile graphfile;
  let graph = Gfile2.from_file graphfile in
  let igraph = gmap graph int_of_string in

  (* Rewrite the graph that has been read. *)
  let () = 
    Cfile.export graphfile graph;
    Cfile.export outfile (gmap (ford_fulkerson igraph 0 100) string_of_int );

  in
  ()