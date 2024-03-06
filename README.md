# projet-pf-2022-2023-ogit
Projet de programmation fonctionnelle L3 info Valrose - Mini git en OCaml

https://docs.google.com/document/d/1OtQM95PCcBlJC8e2BRh-VQypuq-xDqIrDWZYESsvR9w/edit?usp=sharing

## FEATURES
Un git simplifié programmé en Ocaml.

## TESTS
Les tests ont été effectués dans ogit/test, certaines fonctions ont été aussi testé manuellement via des exemples.

Objects: l'ensemble des tests ont été validé mis à part pour merge_work_directory_I, et le soucis d'affichage de tree (à cause de Sys.readdir).


Logs: Le dune runtest ne renvoie rien. *

Commands:
Dune runtest ne renvoyait rien avant de faire ogit_checkout

Donc l'ordre des erreurs de tests est la suivante:  merge_work_directory_I => ogit_checkout et la suite de commands.ml

*Nous sommes également conscient que la validation des tests dans ogit/test ne reflètent pas complètement l'indéfectibilité des fonctions.
Il faut ajouter à cela des tests encore plus rigoureux (difficiles à trouver) auquelles certaines fonctions donnent des réponses négatives. (KNOWN ISSUES)


## KNOWN ISSUES
Objects:
clean_work_directory: Nous n'avons pas réussi à traiter le cas du fichier versionné à conserver dans les sous-repertoires de dossier avec une
fonction annexe.
merge_work_directory_I : De multiples problèmes ont fait que nous n'avons pas pu terminer. On a essayer de manipuler les appels de fonctions en vain, problème de
typage.

Logs:
Le dune runtest ne renvoyant rien, nous ne savons pas s'il y a des issues.

Commands:
Le dune runtest ne renvoyant rien avant ogit_checkout, nous ne savons pas s'il y a des issues avant cette fonction. Et nous avons pas pu finir le reste.
On a eu des soucis avec dune pour le module In_channel.
