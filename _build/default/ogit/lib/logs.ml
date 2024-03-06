type commit = {
    parents : Digest.t list;
    date : float;
    message : string;
    content : Digest.t
}
    
let date_fm _d = 
    let t= Unix.localtime _d in
    Format.sprintf "%02d:%02d:%02d-%02d/%02d/%d" t.tm_hour t.tm_min t.tm_sec t.tm_mday (t.tm_mon + 1) (t.tm_year+1900)

let rec concat_list l = 
    match l with
        | [] -> ""
        | [x] -> x
        | x::r -> x^";"^(concat_list r)

let set_head _l = 
    let oc = open_out ".ogit/HEAD" in
    let l = List.map Digest.to_hex _l in
    let l2 = concat_list l in
    Printf.fprintf oc "%s" l2;
    close_out oc ;;
      
let get_head () = 
    let ic = open_in ".ogit/HEAD" in 
    let line = input_line ic in
    let list = String.split_on_char ';' line in
    let l = List.map Digest.from_hex list in 
    close_in ic;
    l
         
let make_commit _s  _h =  
    let parents = get_head () in
    let date = Unix.time () in
    let message = _s in
    let content = _h in
    {parents; date; message; content}

let init_commit () = 
    let parents = [] in
    let date = Unix.time () in
    let message = "init commit" in
    let content = Objects.store_work_directory () in
    {parents; date; message; content}

let store_commit _c =
    let parent_2 = String.concat ";" (List.map Digest.to_hex _c.parents) ^ "\n" in
    let date_2 = date_fm _c.date ^ "\n" in
    let message_2 = _c.message ^ "\n" in
    let content_2 = Digest.to_hex _c.content in
    let s = parent_2 ^ date_2 ^ message_2 ^ content_2 in
    let oc = open_out (".ogit/logs/" ^ Digest.to_hex (Digest.string s)) in
    output_string oc s;
    close_out oc;
    Digest.string s

let date_fm_to_float s = Scanf.sscanf s "%d:%d:%d-%d/%d/%d" (fun h m s d mo y -> (Unix.mktime { 
     Unix.tm_hour = h; 
     Unix.tm_min = m; 
     Unix.tm_sec = s; 
     Unix.tm_mday = d; 
     Unix.tm_mon = mo - 1; 
     Unix.tm_year = y - 1900; 
     Unix.tm_wday = 0; Unix.tm_yday = 0; Unix.tm_isdst = false 
     })) |> fst

let read_commit _h =
  let file = "./ogit/logs/" ^ (Digest.to_hex _h) in
  let ic = open_in file in
  let line = input_line ic in
  let parents = String.split_on_char ';' line in
  let date =  (date_fm_to_float (input_line ic)) in
  let message = input_line ic in
  let content = Digest.from_hex (input_line ic) in
  close_in ic;
  { parents; date; message; content }
