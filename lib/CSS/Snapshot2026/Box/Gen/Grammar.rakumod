unit grammar CSS::Snapshot2026::Box::Gen::Grammar;
#| <visual-box> = content-box | padding-box | border-box
rule visual-box { :i ["content-box" | "padding-box" | "border-box" ]& <keyw>  }
#| <margin-width> = <length-percentage> | auto
rule margin-width { :i <length-percentage> || [auto & <keyw> ]  }
#| margin: <margin-width>{1,4}
rule decl:sym<margin> { :i (margin) ":" <val(/<prop-val-margin>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-margin { :i <margin-width> }
#| margin-bottom: <margin-width>
rule decl:sym<margin-bottom> { :i ("margin-bottom") ":" <val(/<prop-val-margin-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-margin-bottom { :i <margin-width> }
#| margin-left: <margin-width>
rule decl:sym<margin-left> { :i ("margin-left") ":" <val(/<prop-val-margin-left> /, &?ROUTINE.WHY)>}
rule prop-val-margin-left { :i <margin-width> }
#| margin-right: <margin-width>
rule decl:sym<margin-right> { :i ("margin-right") ":" <val(/<prop-val-margin-right> /, &?ROUTINE.WHY)>}
rule prop-val-margin-right { :i <margin-width> }
#| margin-top: <margin-width>
rule decl:sym<margin-top> { :i ("margin-top") ":" <val(/<prop-val-margin-top> /, &?ROUTINE.WHY)>}
rule prop-val-margin-top { :i <margin-width> }
#| margin-trim: none | [ block || inline ] | [ block-start || inline-start || block-end || inline-end ]
rule decl:sym<margin-trim> { :i ("margin-trim") ":" <val(/<prop-val-margin-trim> /, &?ROUTINE.WHY)>}
rule prop-val-margin-trim { :i [none & <keyw> ] || [[[block & <keyw> ] :my $*A;<!{
    $*A++
}>|| [inline & <keyw> ] :my $*B;<!{
    $*B++
}>]+] || [[["block-start" & <keyw> ] :my $*C;<!{
    $*C++
}>|| ["inline-start" & <keyw> ] :my $*D;<!{
    $*D++
}>|| ["block-end" & <keyw> ] :my $*E;<!{
    $*E++
}>|| ["inline-end" & <keyw> ] :my $*F;<!{
    $*F++
}>]+]  }
#| padding: <length-percentage [0,∞]>{1,4}
rule decl:sym<padding> { :i (padding) ":" <val(/<prop-val-padding>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-padding { :i <length-percentage> }
#| padding-bottom: <length-percentage [0,∞]>
rule decl:sym<padding-bottom> { :i ("padding-bottom") ":" <val(/<prop-val-padding-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-padding-bottom { :i <length-percentage> }
#| padding-left: <length-percentage [0,∞]>
rule decl:sym<padding-left> { :i ("padding-left") ":" <val(/<prop-val-padding-left> /, &?ROUTINE.WHY)>}
rule prop-val-padding-left { :i <length-percentage> }
#| padding-right: <length-percentage [0,∞]>
rule decl:sym<padding-right> { :i ("padding-right") ":" <val(/<prop-val-padding-right> /, &?ROUTINE.WHY)>}
rule prop-val-padding-right { :i <length-percentage> }
#| padding-top: <length-percentage [0,∞]>
rule decl:sym<padding-top> { :i ("padding-top") ":" <val(/<prop-val-padding-top> /, &?ROUTINE.WHY)>}
rule prop-val-padding-top { :i <length-percentage> }