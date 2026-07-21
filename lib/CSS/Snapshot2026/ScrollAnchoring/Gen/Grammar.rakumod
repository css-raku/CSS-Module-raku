unit grammar CSS::Snapshot2026::ScrollAnchoring::Gen::Grammar;
#| overflow-anchor: auto | none
rule decl:sym<overflow-anchor> { :i ("overflow-anchor") ":" <val(/<css-val-overflow-anchor> /, &?ROUTINE.WHY)>}
rule css-val-overflow-anchor { :i [auto | none ]& <keyw>  }