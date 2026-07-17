unit grammar CSS::Snapshot2026::MultiCol::Gen::Grammar;
#| column-count: auto | <integer [1,∞]>
rule decl:sym<column-count> { :i ("column-count") ":" <val(/<css-val-column-count> /, &?ROUTINE.WHY)>}
rule css-val-column-count { :i auto & <keyw> || <integer>  }
#| column-fill: auto | balance | balance-all
rule decl:sym<column-fill> { :i ("column-fill") ":" <val(/<css-val-column-fill> /, &?ROUTINE.WHY)>}
rule css-val-column-fill { :i [auto | balance | "balance-all" ]& <keyw>  }
#| column-rule: <'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>
rule decl:sym<column-rule> { :i ("column-rule") ":" <val(/<css-val-column-rule> /, &?ROUTINE.WHY)>}
rule css-val-column-rule { :i [<css-val-column-rule-width> :my $*A;<!{
    $*A++
}>|| <css-val-column-rule-style> :my $*B;<!{
    $*B++
}>|| <css-val-column-rule-color> :my $*C;<!{
    $*C++
}>]+ }
#| column-rule-color: <color>
rule decl:sym<column-rule-color> { :i ("column-rule-color") ":" <val(/<css-val-column-rule-color> /, &?ROUTINE.WHY)>}
rule css-val-column-rule-color { :i <color> }
#| column-rule-style: <line-style>
rule decl:sym<column-rule-style> { :i ("column-rule-style") ":" <val(/<css-val-column-rule-style> /, &?ROUTINE.WHY)>}
rule css-val-column-rule-style { :i <line-style> }
#| column-rule-width: <line-width>
rule decl:sym<column-rule-width> { :i ("column-rule-width") ":" <val(/<css-val-column-rule-width> /, &?ROUTINE.WHY)>}
rule css-val-column-rule-width { :i <line-width> }
#| column-span: none | all
rule decl:sym<column-span> { :i ("column-span") ":" <val(/<css-val-column-span> /, &?ROUTINE.WHY)>}
rule css-val-column-span { :i [none | all ]& <keyw>  }
#| column-width: auto | <length [0,∞]>
rule decl:sym<column-width> { :i ("column-width") ":" <val(/<css-val-column-width> /, &?ROUTINE.WHY)>}
rule css-val-column-width { :i auto & <keyw> || <length>  }
#| columns: <'column-width'> || <'column-count'>
rule decl:sym<columns> { :i (columns) ":" <val(/<css-val-columns> /, &?ROUTINE.WHY)>}
rule css-val-columns { :i [<css-val-column-width> :my $*A; <!{
    $*A++
}>|| <css-val-column-count> :my $*B; <!{
    $*B++
}>]+ }