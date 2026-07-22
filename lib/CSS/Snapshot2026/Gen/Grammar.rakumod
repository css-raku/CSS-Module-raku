unit grammar CSS::Snapshot2026::Gen::Grammar;
#| all: initial | unset | revert | revert-layer | revert-rule
rule decl:sym<all> { :i (all) ":" <val(/<css-val-all> /, &?ROUTINE.WHY)>}
rule css-val-all { :i [initial | unset | revert | "revert-layer" | "revert-rule" ]& <keyw>  }