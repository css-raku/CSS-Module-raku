unit grammar CSS::Snapshot2026::WillChange::Gen::Grammar;
#| will-change: auto | <animateable-feature>#
rule decl:sym<will-change> { :i ("will-change") ":" <val(/<prop-val-will-change> /, &?ROUTINE.WHY)>}
rule prop-val-will-change { :i auto & <keyw> || <animateable-feature> +% <op(",")>?  }
#| <animateable-feature> = scroll-position | contents | <custom-ident>
rule animateable-feature { :i ["scroll-position" | contents ]& <keyw>  || <custom-ident>  }