unit grammar CSS::Snapshot2026::TextDecor::Gen::Grammar;
#| text-decoration: <'text-decoration-line'> || <'text-decoration-style'> || <'text-decoration-color'>
rule decl:sym<text-decoration> { :i ("text-decoration") ":" <val(/<css-val-text-decoration> /, &?ROUTINE.WHY)>}
rule css-val-text-decoration { :i [<css-val-text-decoration-line> :my $*A;<!{
    $*A++
}>|| <css-val-text-decoration-style> :my $*B;<!{
    $*B++
}>|| <css-val-text-decoration-color> :my $*C;<!{
    $*C++
}>]+ }
#| text-decoration-color: <color>
rule decl:sym<text-decoration-color> { :i ("text-decoration-color") ":" <val(/<css-val-text-decoration-color> /, &?ROUTINE.WHY)>}
rule css-val-text-decoration-color { :i <color> }
#| text-decoration-line: none | [ underline || overline || line-through || blink ]
rule decl:sym<text-decoration-line> { :i ("text-decoration-line") ":" <val(/<css-val-text-decoration-line> /, &?ROUTINE.WHY)>}
rule css-val-text-decoration-line { :i none & <keyw> || [[underline & <keyw> :my $*A;<!{
    $*A++
}>|| overline & <keyw> :my $*B;<!{
    $*B++
}>|| "line-through" & <keyw> :my $*C;<!{
    $*C++
}>|| blink & <keyw> :my $*D;<!{
    $*D++
}>]+]  }
#| text-decoration-style: solid | double | dotted | dashed | wavy
rule decl:sym<text-decoration-style> { :i ("text-decoration-style") ":" <val(/<css-val-text-decoration-style> /, &?ROUTINE.WHY)>}
rule css-val-text-decoration-style { :i [solid | double | dotted | dashed | wavy ]& <keyw>  }
#| text-emphasis: <'text-emphasis-style'> || <'text-emphasis-color'>
rule decl:sym<text-emphasis> { :i ("text-emphasis") ":" <val(/<css-val-text-emphasis> /, &?ROUTINE.WHY)>}
rule css-val-text-emphasis { :i [<css-val-text-emphasis-style> :my $*A;<!{
    $*A++
}>|| <css-val-text-emphasis-color> :my $*B;<!{
    $*B++
}>]+ }
#| text-emphasis-color: <color>
rule decl:sym<text-emphasis-color> { :i ("text-emphasis-color") ":" <val(/<css-val-text-emphasis-color> /, &?ROUTINE.WHY)>}
rule css-val-text-emphasis-color { :i <color> }
#| text-emphasis-position: [ over | under ] && [ right | left ]?
rule decl:sym<text-emphasis-position> { :i ("text-emphasis-position") ":" <val(/<css-val-text-emphasis-position> /, &?ROUTINE.WHY)>}
rule css-val-text-emphasis-position { :i [[[over | under ]& <keyw> ] :my $*A;<!{
    $*A++
}>|| [[right | left ]& <keyw> ] ? :my $*B;<!{
    $*B++
}>]** 2 }
#| text-emphasis-style: none | [ [ filled | open ] || [ dot | circle | double-circle | triangle | sesame ] ] | <string>
rule decl:sym<text-emphasis-style> { :i ("text-emphasis-style") ":" <val(/<css-val-text-emphasis-style> /, &?ROUTINE.WHY)>}
rule css-val-text-emphasis-style { :i none & <keyw> || [[[[filled | open ]& <keyw> ] :my $*A;<!{
    $*A++
}>|| [[dot | circle | "double-circle" | triangle | sesame ]& <keyw> ] :my $*B;<!{
    $*B++
}>]+] || <string>  }
#| text-shadow: none | [ <color>? && [ <length>{2} <length [0,∞]>? ] ]#
rule decl:sym<text-shadow> { :i ("text-shadow") ":" <val(/<css-val-text-shadow> /, &?ROUTINE.WHY)>}
rule css-val-text-shadow { :i none & <keyw> || [[<color> ? :my $*A;<!{
    $*A++
}>|| [<length> ** 2 <length> ? ] :my $*B;<!{
    $*B++
}>]** 2] +% <op(",")>?  }
#| text-underline-position: auto | [ under || [ left | right ] ]
rule decl:sym<text-underline-position> { :i ("text-underline-position") ":" <val(/<css-val-text-underline-position> /, &?ROUTINE.WHY)>}
rule css-val-text-underline-position { :i auto & <keyw> || [[under & <keyw> :my $*A; <!{
    $*A++
}>|| [[left | right ]& <keyw> ] :my $*B; <!{
    $*B++
}>]+]  }