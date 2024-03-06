(** fichier commands.ml **)
(** fonctions représentant les commandes ogit **)

let ogit_init () =
  let ogit_dir = ".ogit" in
  let logs_dir = ".ogit/logs" in
  let objects_dir = ".ogit/objects" in
  if Sys.file_exists ogit_dir then
    failwith (ogit_dir ^ " already exists")
  else begin
    ignore(Sys.command (Format.sprintf "mkdir %s" ogit_dir));
    ignore(Sys.command (Format.sprintf "mkdir %s" logs_dir));
    ignore(Sys.command (Format.sprintf "mkdir %s" objects_dir));
  end

let ogit_commit _msg = 
  if not (Sys.file_exists ".ogit") then
    failwith "Not an ogit repository"
  else
    let hash_dir = (Objects.store_work_directory ()) in
    let mess = (Logs.make_commit _msg hash_dir) in
    let nv_commit = (Logs.store_commit mess) in
    Logs.set_head [nv_commit]

let ogit_checkout _hash = 
  if not (Sys.file_exists ".ogit") then
    failwith "Not an ogit repository"
  else
    let hash_dir = (Objects.store_work_directory ()) in
    let mess = (Logs.make_commit _msg) in
    let nv_commit = (Logs.store_commit mess) in
    Logs.set_head [nv_commit]


let ogit_log () = failwith "TODO"

let ogit_merge _hash = failwith "TODO"
