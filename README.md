# projet-pf-2022-2023-ogit
Functional Programming Project L3 Computer Science Valrose - Mini git in OCaml

https://docs.google.com/document/d/1OtQM95PCcBlJC8e2BRh-VQypuq-xDqIrDWZYESsvR9w/edit?usp=sharing

## FEATURES
A simplified git programmed in OCaml.

## TESTS
Tests were conducted in `ogit/test`, with some functions also tested manually via examples.

Objects: All tests were validated except for `merge_work_directory_I`, and there was an issue displaying `tree` (due to `Sys.readdir`).

Logs: `dune runtest` does not return anything. *

Commands:
`dune runtest` did not return anything before running `ogit_checkout`.

Therefore, the order of test errors is as follows: `merge_work_directory_I` => `ogit_checkout` and the rest of `commands.ml`.

*We are also aware that passing the tests in `ogit/test` does not completely reflect the infallibility of the functions. Additional, more rigorous tests (which are difficult to find) are needed, to which some functions provide negative responses. (KNOWN ISSUES)

## KNOWN ISSUES
Objects:
`clean_work_directory`: We were unable to handle the case of a versioned file to be preserved in subdirectories with an auxiliary function.
`merge_work_directory_I`: Multiple issues prevented us from completing this. We attempted to manipulate function calls in vain, facing typing problems.

Logs:
Since `dune runtest` does not return anything, we do not know if there are any issues.

Commands:
Since `dune runtest` did not return anything before `ogit_checkout`, we do not know if there are any issues before this function. We were unable to finish the rest. We had issues with `dune` for the `In_channel` module.
