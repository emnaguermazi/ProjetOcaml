open Graph
open Tools
open Gfile

type path = (id * id * int) list

let path_exist gf s t =
  if not (node_exists gf s) then raise (Graph_error ("Node " ^ string_of_int s ^ " does not exists in the graph."))
  else if not (node_exists gf t) then raise (Graph_error ("Node " ^ string_of_int t ^ " does not exists in the graph."))
  else
    let rec loop acu s =
      (*For each node 'id' at which 's' can reach
        Check by recursive if it exist a path from 'id' to 't' *)		
      List.exists (fun (id,_) -> 
          if List.mem id acu then false else if (id=t) then true else loop (id::acu) id ) (out_arcs gf s)
    in loop [] s


let find_path gf s t =
  let rec find_arcs gf list_arcs marked t = match list_arcs with
    | []-> assert false
    | (id1,id2,lbl)::rest -> if id2 = t then list_arcs else
        let new_marked = id2::marked in
        (* Check all the out_arcs from id2 then choose all the node which are not marked*)
        let list_node_not_marked = List.filter (fun(id,_) -> not (List.mem id new_marked)) (out_arcs gf id2) in
        (*Find from theese node a path to t
          if a path exist -> return it
          else check the next node*)
        let rec loop list = match list with
          | [] -> [] 
          | (id,lbl)::rest -> 
            match find_arcs gf ((id2,id,lbl)::list_arcs) new_marked t with
            | [] -> loop rest
            | path -> path
        in loop list_node_not_marked
  in
  if not (node_exists gf s) then raise(Graph_error ("Node " ^ string_of_int s ^ " does not exist in the graph."))
  else if not (node_exists gf t) then raise(Graph_error ("Node " ^ string_of_int t ^ " does not exist in the graph."))
  else assert (s<>t);
  match List.rev (find_arcs gf [(s,s,0)] [s] t) with
  | [] -> []
  | id :: rest -> rest

let rec min_capacity path = match path with
  | [] -> failwith "Empty path 1!\n"
  | [(_,_,lbl)] -> lbl
  | (_,_,lbl) :: rest -> min lbl (min_capacity rest)

let rec print_list path = match path with
  | [] -> Printf.printf "\nend\n\n%!"
  | (id1,id2,lbl)::rest -> Printf.printf"\n%d , %d, %d\n\n%!" id1 id2 lbl; print_list rest

let update_graph gf path =
  let min = min_capacity path in
  let rec update_path gf path = match path with
    | [] -> gf
    | (id1,id2,lbl)::rest -> 
      if lbl = min 
      (*lbl = min -> remove*) 
      then update_path(remove_arc gf id1 id2) rest 
      else update_path (update_arc gf id1 id2 (lbl - min)) rest 
  in
  let rec update_rev_path gf path = match path with
    | [] -> gf
    | (id1,id2,_)::rest -> 
      match find_arc gf id1 id2 with
      | None -> update_rev_path (new_arc gf id2 id1 min ) rest
      | Some n -> update_rev_path ( update_arc gf id2 id1 (n + min) ) rest
  in update_rev_path (update_path gf path) path

let update_output gf path = 
  let min = min_capacity path in 
  let rec update_path gf path = match path with
    | [] -> gf
    | (id1,id2,_)::rest -> 
      match (find_arc gf id1 id2,find_arc gf id2 id1) with 
      | (None,None) ->  update_path (new_arc gf id1 id2 min ) rest  (*if this arc does not exists, we add it into the graph *)
      | (None,Some x) -> update_path (if x>min then new_arc gf id1 id2 (x-min) else remove_arc gf id2 id1  ) rest
      | (Some x,_) -> update_path ( update_arc gf id1 id2 (x + min) ) rest (*if it already exists, increase this value by adding flow_min  *)
  in update_path gf path	

let initalize_output gf =  
  List.fold_left new_node empty_graph (find_nodes gf) 

let rec ford_fulkerson gf s t =
  let output = initalize_output gf in  
  let rec loop gf flow output =
    if (path_exist gf s t) then
      let path = find_path gf s t in
      let min = min_capacity path in
      let flow_max = flow + min in
      print_list path;
      let new_output = update_output output path in
      let new_graph = update_graph gf path in 
      loop new_graph flow_max new_output
    else (output,flow)
  in let (result,flow_max) = loop gf 0 output in
  begin
    Printf.printf "Result : Flow max = %d\n" flow_max;
    result 
  end




