unit grammar CSS::Snapshot2026::Box::Gen::Grammar;
#| <visual-box> = content-box | padding-box | border-box
rule visual-box { :i ["content-box" | "padding-box" | "border-box" ]& <keyw>  }
#| margin: <'margin-top'>{1,4}
rule decl:sym<margin> { :i (margin) ":" <val(/<css-val-margin>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-margin { :i <css-val-margin-top> }
#| margin-bottom: <length-percentage> | auto
rule decl:sym<margin-bottom> { :i ("margin-bottom") ":" <val(/<css-val-margin-bottom> /, &?ROUTINE.WHY)>}
rule css-val-margin-bottom { :i <length-percentage> || auto & <keyw>  }
#| margin-left: <length-percentage> | auto
rule decl:sym<margin-left> { :i ("margin-left") ":" <val(/<css-val-margin-left> /, &?ROUTINE.WHY)>}
rule css-val-margin-left { :i <length-percentage> || auto & <keyw>  }
#| margin-right: <length-percentage> | auto
rule decl:sym<margin-right> { :i ("margin-right") ":" <val(/<css-val-margin-right> /, &?ROUTINE.WHY)>}
rule css-val-margin-right { :i <length-percentage> || auto & <keyw>  }
#| margin-top: <length-percentage> | auto
rule decl:sym<margin-top> { :i ("margin-top") ":" <val(/<css-val-margin-top> /, &?ROUTINE.WHY)>}
rule css-val-margin-top { :i <length-percentage> || auto & <keyw>  }
#| margin-trim: none | [ block || inline ] | [ block-start || inline-start || block-end || inline-end ]
rule decl:sym<margin-trim> { :i ("margin-trim") ":" <val(/<css-val-margin-trim> /, &?ROUTINE.WHY)>}
rule css-val-margin-trim { :i none & <keyw> || [[block & <keyw> :my $*A;<!{
    $*A++
}>|| inline & <keyw> :my $*B;<!{
    $*B++
}>]+] || [["block-start" & <keyw> :my $*C;<!{
    $*C++
}>|| "inline-start" & <keyw> :my $*D;<!{
    $*D++
}>|| "block-end" & <keyw> :my $*E;<!{
    $*E++
}>|| "inline-end" & <keyw> :my $*F;<!{
    $*F++
}>]+]  }
#| padding: <'padding-top'>{1,4}
rule decl:sym<padding> { :i (padding) ":" <val(/<css-val-padding>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-padding { :i <css-val-padding-top> }
#| padding-bottom: <length-percentage [0,∞]>
rule decl:sym<padding-bottom> { :i ("padding-bottom") ":" <val(/<css-val-padding-bottom> /, &?ROUTINE.WHY)>}
rule css-val-padding-bottom { :i <length-percentage> }
#| padding-left: <length-percentage [0,∞]>
rule decl:sym<padding-left> { :i ("padding-left") ":" <val(/<css-val-padding-left> /, &?ROUTINE.WHY)>}
rule css-val-padding-left { :i <length-percentage> }
#| padding-right: <length-percentage [0,∞]>
rule decl:sym<padding-right> { :i ("padding-right") ":" <val(/<css-val-padding-right> /, &?ROUTINE.WHY)>}
rule css-val-padding-right { :i <length-percentage> }
#| padding-top: <length-percentage [0,∞]>
rule decl:sym<padding-top> { :i ("padding-top") ":" <val(/<css-val-padding-top> /, &?ROUTINE.WHY)>}
rule css-val-padding-top { :i <length-percentage> }