unit grammar CSS::Snapshot2026::Gen::Grammar;
#| all: initial | unset | revert | revert-layer | revert-rule
rule decl:sym<all> { :i (all) ":" <val(/<prop-val-all> /, &?ROUTINE.WHY)>}
rule prop-val-all { :i [initial | unset | revert | "revert-layer" | "revert-rule" ]& <keyw>  }