unit grammar CSS::Snapshot2026::ColorAdjust::Gen::Grammar;
#| color-adjust: <'print-color-adjust'>
rule decl:sym<color-adjust> { :i ("color-adjust") ":" <val(/<prop-val-color-adjust> /, &?ROUTINE.WHY)>}
rule prop-val-color-adjust { :i <prop-val-print-color-adjust> }
#| color-scheme: normal | [ light | dark | <custom-ident> ]+ && only?
rule decl:sym<color-scheme> { :i ("color-scheme") ":" <val(/<prop-val-color-scheme> /, &?ROUTINE.WHY)>}
rule prop-val-color-scheme { :i normal & <keyw> || [[[light | dark ]& <keyw>  || <custom-ident> ] + :my $*A;<!{
    $*A++
}>|| [only & <keyw>] ? :my $*B;<!{
    $*B++
}>]** 2  }
#| forced-color-adjust: auto | none | preserve-parent-color
rule decl:sym<forced-color-adjust> { :i ("forced-color-adjust") ":" <val(/<prop-val-forced-color-adjust> /, &?ROUTINE.WHY)>}
rule prop-val-forced-color-adjust { :i [auto | none | "preserve-parent-color" ]& <keyw>  }
#| print-color-adjust: economy | exact
rule decl:sym<print-color-adjust> { :i ("print-color-adjust") ":" <val(/<prop-val-print-color-adjust> /, &?ROUTINE.WHY)>}
rule prop-val-print-color-adjust { :i [economy | exact ]& <keyw>  }