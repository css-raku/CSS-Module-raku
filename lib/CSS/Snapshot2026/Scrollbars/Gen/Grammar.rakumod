unit grammar CSS::Snapshot2026::Scrollbars::Gen::Grammar;
#| scrollbar-color: auto | <color>{2}
rule decl:sym<scrollbar-color> { :i ("scrollbar-color") ":" <val(/<css-val-scrollbar-color> /, &?ROUTINE.WHY)>}
rule css-val-scrollbar-color { :i auto & <keyw> || <color> ** 2  }
#| scrollbar-width: auto | thin | none
rule decl:sym<scrollbar-width> { :i ("scrollbar-width") ":" <val(/<css-val-scrollbar-width> /, &?ROUTINE.WHY)>}
rule css-val-scrollbar-width { :i [auto | thin | none ]& <keyw>  }