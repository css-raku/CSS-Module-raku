unit grammar CSS::Snapshot2026::FlexBox::Gen::Grammar;
#| align-content: flex-start | flex-end | center | space-between | space-around | stretch
rule decl:sym<align-content> { :i ("align-content") ":" <val(/<css-val-align-content> /, &?ROUTINE.WHY)>}
rule css-val-align-content { :i ["flex-start" | "flex-end" | center | "space-between" | "space-around" | stretch ]& <keyw>  }
#| align-items: flex-start | flex-end | center | baseline | stretch
rule decl:sym<align-items> { :i ("align-items") ":" <val(/<css-val-align-items> /, &?ROUTINE.WHY)>}
rule css-val-align-items { :i ["flex-start" | "flex-end" | center | baseline | stretch ]& <keyw>  }
#| align-self: auto | flex-start | flex-end | center | baseline | stretch
rule decl:sym<align-self> { :i ("align-self") ":" <val(/<css-val-align-self> /, &?ROUTINE.WHY)>}
rule css-val-align-self { :i [auto | "flex-start" | "flex-end" | center | baseline | stretch ]& <keyw>  }
#| flex: none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]
rule decl:sym<flex> { :i (flex) ":" <val(/<css-val-flex> /, &?ROUTINE.WHY)>}
rule css-val-flex { :i none & <keyw> || [[<css-val-flex-grow> <css-val-flex-shrink> ?  :my $*A;<!{
    $*A++
}>|| <css-val-flex-basis> :my $*B;<!{
    $*B++
}>]+]  }
#| flex-basis: content | <.'width'>
rule decl:sym<flex-basis> { :i ("flex-basis") ":" <val(/<css-val-flex-basis> /, &?ROUTINE.WHY)>}
rule css-val-flex-basis { :i content & <keyw> || <css-val-width>  }
#| flex-direction: row | row-reverse | column | column-reverse
rule decl:sym<flex-direction> { :i ("flex-direction") ":" <val(/<css-val-flex-direction> /, &?ROUTINE.WHY)>}
rule css-val-flex-direction { :i [row | "row-reverse" | column | "column-reverse" ]& <keyw>  }
#| flex-flow: <'flex-direction'> || <'flex-wrap'>
rule decl:sym<flex-flow> { :i ("flex-flow") ":" <val(/<css-val-flex-flow> /, &?ROUTINE.WHY)>}
rule css-val-flex-flow { :i [<css-val-flex-direction> :my $*A;<!{
    $*A++
}>|| <css-val-flex-wrap> :my $*B;<!{
    $*B++
}>]+ }
#| flex-grow: <number [0,∞]>
rule decl:sym<flex-grow> { :i ("flex-grow") ":" <val(/<css-val-flex-grow> /, &?ROUTINE.WHY)>}
rule css-val-flex-grow { :i <number> }
#| flex-shrink: <number [0,∞]>
rule decl:sym<flex-shrink> { :i ("flex-shrink") ":" <val(/<css-val-flex-shrink> /, &?ROUTINE.WHY)>}
rule css-val-flex-shrink { :i <number> }
#| flex-wrap: nowrap | wrap | wrap-reverse
rule decl:sym<flex-wrap> { :i ("flex-wrap") ":" <val(/<css-val-flex-wrap> /, &?ROUTINE.WHY)>}
rule css-val-flex-wrap { :i [nowrap | wrap | "wrap-reverse" ]& <keyw>  }
#| justify-content: flex-start | flex-end | center | space-between | space-around
rule decl:sym<justify-content> { :i ("justify-content") ":" <val(/<css-val-justify-content> /, &?ROUTINE.WHY)>}
rule css-val-justify-content { :i ["flex-start" | "flex-end" | center | "space-between" | "space-around" ]& <keyw>  }