type t =
| Text of string 
| Directory of (string * bool * Digest.t * t) list

let hash _obj  = 
  match _obj with 
  | Text s -> Digest.string s
  | Directory l -> 
    let rec aux l acc = 
      match l with 
      | [] -> acc
      | (name, isdir, h, _)::tl -> 
          let st = (name ^ ";" ^ (if isdir then "d" else "t") ^ ";" ^ (Digest.to_hex h)) in
          aux tl ((if acc = "" then (st) else (acc ^ "\n" ^ st) ))
    in
    Digest.string (aux l "")

let is_known _h =
  Sys.file_exists (".ogit/objects/" ^ (Digest.to_hex _h))

let read_text_object _h =
  let ic = open_in (".ogit/objects/" ^ (Digest.to_hex _h)) in
  let n = in_channel_length ic in
  let s = really_input_string ic n in
  close_in ic;
  s

let store_object _obj =  
  let s = match _obj with 
    | Text s -> s
    | Directory l -> 
      let rec aux l acc = 
        match l with 
        | [] -> acc
        | (name, isdir, h, _)::tl -> 
            let st = (name ^ ";" ^ (if isdir then "d" else "t") ^ ";" ^ (Digest.to_hex h)) in
            aux tl ((if acc = "" then (st) else (acc ^ "\n" ^ st) ))
      in
      aux l ""
  in
  let oc = open_out (".ogit/objects/"^(Digest.to_hex (Digest.string s))) in
  output_string oc s;
  close_out oc;
  Digest.string s

let store_work_directory () =  
  let rec aux dir = 
    let l = Sys.readdir dir in
    let rec aux2 l acc = 
      match l with 
      | [] -> acc
      | hd::tl -> 
        if hd.[0] = '.'
          then aux2 tl acc
        else
          let s = dir ^ "/" ^ hd in
          if Sys.is_directory s then 
            let obj= Directory (aux s) in 
            aux2 tl (acc@[(hd, true, (store_object (obj)), obj)])
          else 
            let ic = open_in s in
            let n = in_channel_length ic in
            let s2 = really_input_string ic n in
            close_in ic;
            aux2 tl (acc@[(hd, false, (store_object (Text s2)), Text s2)])
    in 
    aux2 (Array.to_list l) []
  in 
  store_object (Directory (aux "./"))

let rec read_directory_object _h = 
  let s = read_text_object _h in
  let l = String.split_on_char '\n' s in 
  let rec aux l acc= 
    match l with 
    | [] -> acc
    | hd::tl -> 
        let l2 = String.split_on_char ';' hd in
        match l2 with 
        | [name; "t"; h] -> aux tl (acc@[(name, false, (Digest.from_hex h), Text (read_text_object (Digest.from_hex h)))])
        | [name; "d"; h] -> aux tl (acc@[(name, true, (Digest.from_hex h), (read_directory_object (Digest.from_hex h)))]);
        | _ -> failwith "erreur"
  in 
  Directory (aux l [])

(** fonction qui supprime tout les
fichier et supprime les dossier, ceux ne commençant pas par un "." avec des commande unix       **)
let clean_work_directory () =
  ignore (Sys.command "rm -Rf [^.]*");;


let restore_work_directory _obj = 
  let rec aux dir obj = 
    match obj with 
    | Text s -> 
        let oc = open_out (dir) in 
        output_string oc s; 
        close_out oc 
    | Directory l -> 
        if not (Sys.file_exists dir) then ignore(Sys.command (Format.sprintf "mkdir %s" dir)); 
        let rec aux2 l = 
          match l with 
          | [] -> () 
          | (name, _, _, obj)::tl -> aux (dir^"/"^name) obj; 
              aux2 tl; 
        in 
        aux2 l 
  in 
  aux "." _obj

let merge_work_directory_I _obj = 
  failwith "TODO"



