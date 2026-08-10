unit grammar CSS::Snapshot2026::FlexBox::Gen::Grammar;
#| align-content: flex-start | flex-end | center | space-between | space-around | stretch
rule decl:sym<align-content> { :i ("align-content") ":" <val(/<prop-val-align-content> /, &?ROUTINE.WHY)>}
rule prop-val-align-content { :i ["flex-start" | "flex-end" | center | "space-between" | "space-around" | stretch ]& <keyw>  }
#| align-items: flex-start | flex-end | center | baseline | stretch
rule decl:sym<align-items> { :i ("align-items") ":" <val(/<prop-val-align-items> /, &?ROUTINE.WHY)>}
rule prop-val-align-items { :i ["flex-start" | "flex-end" | center | baseline | stretch ]& <keyw>  }
#| align-self: auto | flex-start | flex-end | center | baseline | stretch
rule decl:sym<align-self> { :i ("align-self") ":" <val(/<prop-val-align-self> /, &?ROUTINE.WHY)>}
rule prop-val-align-self { :i [auto | "flex-start" | "flex-end" | center | baseline | stretch ]& <keyw>  }
#| flex: none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]
rule decl:sym<flex> { :i (flex) ":" <val(/<prop-val-flex> /, &?ROUTINE.WHY)>}
rule prop-val-flex { :i none & <keyw> || [[<prop-val-flex-grow> <prop-val-flex-shrink> ?  :my $*A;<!{
    $*A++
}>|| <prop-val-flex-basis> :my $*B;<!{
    $*B++
}>]+]  }
#| flex-basis: content | <.'width'>
rule decl:sym<flex-basis> { :i ("flex-basis") ":" <val(/<prop-val-flex-basis> /, &?ROUTINE.WHY)>}
rule prop-val-flex-basis { :i content & <keyw> || <prop-val-width>  }
#| flex-direction: row | row-reverse | column | column-reverse
rule decl:sym<flex-direction> { :i ("flex-direction") ":" <val(/<prop-val-flex-direction> /, &?ROUTINE.WHY)>}
rule prop-val-flex-direction { :i [row | "row-reverse" | column | "column-reverse" ]& <keyw>  }
#| flex-flow: <'flex-direction'> || <'flex-wrap'>
rule decl:sym<flex-flow> { :i ("flex-flow") ":" <val(/<prop-val-flex-flow> /, &?ROUTINE.WHY)>}
rule prop-val-flex-flow { :i [<prop-val-flex-direction> :my $*A;<!{
    $*A++
}>|| <prop-val-flex-wrap> :my $*B;<!{
    $*B++
}>]+ }
#| flex-grow: <number [0,∞]>
rule decl:sym<flex-grow> { :i ("flex-grow") ":" <val(/<prop-val-flex-grow> /, &?ROUTINE.WHY)>}
rule prop-val-flex-grow { :i <number> }
#| flex-shrink: <number [0,∞]>
rule decl:sym<flex-shrink> { :i ("flex-shrink") ":" <val(/<prop-val-flex-shrink> /, &?ROUTINE.WHY)>}
rule prop-val-flex-shrink { :i <number> }
#| flex-wrap: nowrap | wrap | wrap-reverse
rule decl:sym<flex-wrap> { :i ("flex-wrap") ":" <val(/<prop-val-flex-wrap> /, &?ROUTINE.WHY)>}
rule prop-val-flex-wrap { :i [nowrap | wrap | "wrap-reverse" ]& <keyw>  }
#| justify-content: flex-start | flex-end | center | space-between | space-around
rule decl:sym<justify-content> { :i ("justify-content") ":" <val(/<prop-val-justify-content> /, &?ROUTINE.WHY)>}
rule prop-val-justify-content { :i ["flex-start" | "flex-end" | center | "space-between" | "space-around" ]& <keyw>  }