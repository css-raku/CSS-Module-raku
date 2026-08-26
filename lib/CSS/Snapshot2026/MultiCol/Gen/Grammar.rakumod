unit grammar CSS::Snapshot2026::MultiCol::Gen::Grammar;
#| column-count: auto | <integer [1,∞]>
rule decl:sym<column-count> { :i ("column-count") ":" <val(/<prop-val-column-count> /, &?ROUTINE.WHY)>}
rule prop-val-column-count { :i [auto & <keyw> ] || <integer>  }
#| column-fill: auto | balance | balance-all
rule decl:sym<column-fill> { :i ("column-fill") ":" <val(/<prop-val-column-fill> /, &?ROUTINE.WHY)>}
rule prop-val-column-fill { :i [auto | balance | "balance-all" ]& <keyw>  }
#| column-rule: <'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>
rule decl:sym<column-rule> { :i ("column-rule") ":" <val(/<prop-val-column-rule> /, &?ROUTINE.WHY)>}
rule prop-val-column-rule { :i [<prop-val-column-rule-width> :my $*A;<!{
    $*A++
}>|| <prop-val-column-rule-style> :my $*B;<!{
    $*B++
}>|| <prop-val-column-rule-color> :my $*C;<!{
    $*C++
}>]+ }
#| column-rule-color: <color>
rule decl:sym<column-rule-color> { :i ("column-rule-color") ":" <val(/<prop-val-column-rule-color> /, &?ROUTINE.WHY)>}
rule prop-val-column-rule-color { :i <color> }
#| column-rule-style: <line-style>
rule decl:sym<column-rule-style> { :i ("column-rule-style") ":" <val(/<prop-val-column-rule-style> /, &?ROUTINE.WHY)>}
rule prop-val-column-rule-style { :i <line-style> }
#| column-rule-width: <line-width>
rule decl:sym<column-rule-width> { :i ("column-rule-width") ":" <val(/<prop-val-column-rule-width> /, &?ROUTINE.WHY)>}
rule prop-val-column-rule-width { :i <line-width> }
#| column-span: none | all
rule decl:sym<column-span> { :i ("column-span") ":" <val(/<prop-val-column-span> /, &?ROUTINE.WHY)>}
rule prop-val-column-span { :i [none | all ]& <keyw>  }
#| column-width: auto | <length [0,∞]>
rule decl:sym<column-width> { :i ("column-width") ":" <val(/<prop-val-column-width> /, &?ROUTINE.WHY)>}
rule prop-val-column-width { :i [auto & <keyw> ] || <length>  }
#| columns: <'column-width'> || <'column-count'>
rule decl:sym<columns> { :i (columns) ":" <val(/<prop-val-columns> /, &?ROUTINE.WHY)>}
rule prop-val-columns { :i [<prop-val-column-width> :my $*A; <!{
    $*A++
}>|| <prop-val-column-count> :my $*B; <!{
    $*B++
}>]+ }