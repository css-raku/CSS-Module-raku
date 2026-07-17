unit grammar CSS::Snapshot2026::ColorAdjust::Gen::Grammar;
#| color-adjust: <'print-color-adjust'>
rule decl:sym<color-adjust> { :i ("color-adjust") ":" <val(/<css-val-color-adjust> /, &?ROUTINE.WHY)>}
rule css-val-color-adjust { :i <css-val-print-color-adjust> }
#| color-scheme: normal | [ light | dark | <custom-ident> ]+ && only?
rule decl:sym<color-scheme> { :i ("color-scheme") ":" <val(/<css-val-color-scheme> /, &?ROUTINE.WHY)>}
rule css-val-color-scheme { :i normal & <keyw> || [[[light | dark ]& <keyw>  || <custom-ident> ] + :my $*A;<!{
    $*A++
}>|| [only & <keyw>] ? :my $*B;<!{
    $*B++
}>]** 2  }
#| forced-color-adjust: auto | none | preserve-parent-color
rule decl:sym<forced-color-adjust> { :i ("forced-color-adjust") ":" <val(/<css-val-forced-color-adjust> /, &?ROUTINE.WHY)>}
rule css-val-forced-color-adjust { :i [auto | none | "preserve-parent-color" ]& <keyw>  }
#| print-color-adjust: economy | exact
rule decl:sym<print-color-adjust> { :i ("print-color-adjust") ":" <val(/<css-val-print-color-adjust> /, &?ROUTINE.WHY)>}
rule css-val-print-color-adjust { :i [economy | exact ]& <keyw>  }