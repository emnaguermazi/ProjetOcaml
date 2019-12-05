open Graph

let clone_nodes (graph : 'a graph) =
  n_fold graph new_node empty_graph

let gmap (graph : 'a graph) (f: 'a -> 'b) =
  let newest_arc gr id1 id2 lbl =
    let lab = f lbl
    in new_arc gr id1 id2 lab
  in 
  e_fold graph newest_arc (clone_nodes graph)

let add_arc graph id1 id2 n =
  match find_arc graph id1 id2 with
  | None -> new_arc graph id1 id2 n
  | Some lbl -> new_arc graph id1 id2 (lbl + n)