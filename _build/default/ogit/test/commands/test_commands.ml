open Ogitlib
open Commands

(* on se place dans le répertoire repo/ *)
let repo_root = "../../../../../repo"
let () = 
  Sys.chdir repo_root

(* on prepare le repertoire .ogit *)
let _ = Sys.command "rm -rf .ogit"


(* test de ogit_init *)
let () = Format.printf "@.EXECUTION DE ogit_init@."
let _ = ogit_init ()

let () = Format.printf "@.NOMBRE DE LOGS : %d@." (Array.length (Sys.readdir ".ogit/logs"))
let () = Format.printf "@.EXECUTION DE LA COMMANDE SHELL ls .ogit/objects@."
let _ = Sys.command "ls .ogit/objects"
let first_commit = (In_channel.with_open_text ".ogit/HEAD" In_channel.input_all)


(* test de ogit_commit *)
let () = Format.printf "@.AJOUT D'UN FICHIER VIDE ET EXECUTION de ogit_commit@."
let _ = Sys.command "echo >empty.txt"
let _ = ogit_commit "vide"

let () = Format.printf "@.EXECUTION DE LA COMMANDE SHELL tree@."
let _ = Sys.command "tree"

let () = Format.printf "@.NOMBRE DE LOGS : %d@." (Array.length (Sys.readdir ".ogit/logs"))
let () = Format.printf "@.EXECUTION DE LA COMMANDE SHELL ls .ogit/objects@."
let _ = Sys.command "ls .ogit/objects"

let second_commit = (In_channel.with_open_text ".ogit/HEAD" In_channel.input_all)

