open Graph
open Tools
open Gfile

type path = (id * id * int) list

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
  |[] -> []
  | a :: rest -> rest

let rec min_capacity path = match path with
  | [] -> failwith "Empty path 1!\n"
  | [(_,_,lbl)] -> lbl
  | (_,_,lbl) :: rest -> min lbl (min_capacity rest)

let rec update_graph gf path =
  let update_arcs graph id1 id2 n =
    let graph = add_arc graph id1 id2 (-n) in
    let graph = add_arc graph id2 id1 n in graph
  in
  match path with
  | [] -> failwith "Empty path 2!\n"
  | [(id1,id2,lbl)] -> update_arcs gf id1 id2 (min_capacity path)
  | (id1,id2,lbl) :: rest ->
    let gf = update_arcs gf id1 id2 (min_capacity path) in
    let gf = update_graph gf rest in gf

let rec ford_fulkerson gf s t flow =
  let path = find_path gf s t
  in match path with
  | [] -> flow
  | _ -> ford_fulkerson (update_graph gf path) s t (flow + (min_capacity path))

let rec print_list path = match path with
  |[] -> Printf.printf "\nend\n\n%!"
  |(id1,id2,lbl)::rest -> Printf.printf"\n%d , %d, %d\n\n%!" id1 id2 lbl; print_list rest

(*let remove_arc gf id1 id2 = match find_arc gf id1 id2 with
  | None -> raise (Graph_error ("Arc " ^ string_of_int id1 ^ " - " ^ string_of_int id1 ^ "does not exist"))
  | Some _ -> List.map(fun(a,out) -> if a=id1 && List.mem_assoc id2 out then (a, List.remove_assoc id2 out) else (a,out)) *)