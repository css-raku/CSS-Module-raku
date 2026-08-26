unit grammar CSS::Snapshot2026::Align::Gen::Grammar;
#| align-content: normal | <baseline-position> | <content-distribution> | <overflow-position>? <content-position>
rule decl:sym<align-content> { :i ("align-content") ":" <val(/<prop-val-align-content> /, &?ROUTINE.WHY)>}
rule prop-val-align-content { :i [normal & <keyw> ] || <baseline-position> || <content-distribution> || <overflow-position> ? <content-position>   }
#| <baseline-position> = [ first | last ]? && baseline
rule baseline-position { :i [[[first | last ]& <keyw> ] ? :my $*A;<!{
    $*A++
}>|| [baseline & <keyw> ] :my $*B;<!{
    $*B++
}>]** 2 }
#| <content-distribution> = space-between | space-around | space-evenly | stretch
rule content-distribution { :i ["space-between" | "space-around" | "space-evenly" | stretch ]& <keyw>  }
#| <content-position> = center | start | end | flex-start | flex-end
rule content-position { :i [center | start | end | "flex-start" | "flex-end" ]& <keyw>  }
#| <overflow-position> = unsafe | safe
rule overflow-position { :i [unsafe | safe ]& <keyw>  }
#| align-items: normal | stretch | <baseline-position> | <overflow-position>? <self-position>
rule decl:sym<align-items> { :i ("align-items") ":" <val(/<prop-val-align-items> /, &?ROUTINE.WHY)>}
rule prop-val-align-items { :i [normal | stretch ]& <keyw>  || <baseline-position> || <overflow-position> ? <self-position>   }
#| <self-position> = center | start | end | self-start | self-end | flex-start | flex-end
rule self-position { :i [center | start | end | "self-start" | "self-end" | "flex-start" | "flex-end" ]& <keyw>  }
#| align-self: auto | <overflow-position>? [ normal | <self-position> ]| stretch | <baseline-position>
rule decl:sym<align-self> { :i ("align-self") ":" <val(/<prop-val-align-self> /, &?ROUTINE.WHY)>}
rule prop-val-align-self { :i [auto & <keyw> ] || <overflow-position> ? [[normal & <keyw> ] || <self-position> ]  || [stretch & <keyw> ] || <baseline-position>  }
#| justify-content: normal | <content-distribution> | <overflow-position>? [ <content-position> | left | right ]
rule decl:sym<justify-content> { :i ("justify-content") ":" <val(/<prop-val-justify-content> /, &?ROUTINE.WHY)>}
rule prop-val-justify-content { :i [normal & <keyw> ] || <content-distribution> || <overflow-position> ? [<content-position> || [left | right ]& <keyw>  ]   }
#| justify-items: normal | stretch | <baseline-position> | <overflow-position>? [ <self-position> | left | right ] | legacy [ left | right | center ]?
rule decl:sym<justify-items> { :i ("justify-items") ":" <val(/<prop-val-justify-items> /, &?ROUTINE.WHY)>}
rule prop-val-justify-items { :i [normal | stretch ]& <keyw>  || <baseline-position> || <overflow-position> ? [<self-position> || [left | right ]& <keyw>  ]  || [legacy & <keyw> ] [[left | right | center ]& <keyw> ] ?   }
#| justify-self: auto | <overflow-position>? [ normal | <self-position> | left | right ] | stretch | <baseline-position>
rule decl:sym<justify-self> { :i ("justify-self") ":" <val(/<prop-val-justify-self> /, &?ROUTINE.WHY)>}
rule prop-val-justify-self { :i [auto & <keyw> ] || <overflow-position> ? [[normal & <keyw> ] || <self-position> || [left | right ]& <keyw>  ]  || [stretch & <keyw> ] || <baseline-position>  }
#| place-content: <'align-content'> <'justify-content'>?
rule decl:sym<place-content> { :i ("place-content") ":" <val(/<prop-val-place-content> /, &?ROUTINE.WHY)>}
rule prop-val-place-content { :i <prop-val-align-content> <prop-val-justify-content> ?  }
#| place-items: <'align-items'> <'justify-items'>?
rule decl:sym<place-items> { :i ("place-items") ":" <val(/<prop-val-place-items> /, &?ROUTINE.WHY)>}
rule prop-val-place-items { :i <prop-val-align-items> <prop-val-justify-items> ?  }
#| place-self: <'align-self'> <'justify-self'>?
rule decl:sym<place-self> { :i ("place-self") ":" <val(/<prop-val-place-self> /, &?ROUTINE.WHY)>}
rule prop-val-place-self { :i <prop-val-align-self> <prop-val-justify-self> ?  }
#| gap: <'row-gap'> <'column-gap'>?
rule decl:sym<gap> { :i (gap) ":" <val(/<prop-val-gap> /, &?ROUTINE.WHY)>}
rule prop-val-gap { :i <prop-val-row-gap> <prop-val-column-gap> ?  }
#| gap: <'row-gap'> <'column-gap'>?
rule decl:sym<grid-gap> { :i ("grid-gap") ":" <val(/<prop-val-grid-gap> /, &?ROUTINE.WHY)>}
rule prop-val-grid-gap { :i <prop-val-row-gap> <prop-val-column-gap> ?  }
#| row-gap: normal | <length-percentage [0,∞]>
rule decl:sym<row-gap> { :i ("row-gap") ":" <val(/<prop-val-row-gap> /, &?ROUTINE.WHY)>}
rule prop-val-row-gap { :i [normal & <keyw> ] || <length-percentage>  }
#| row-gap: normal | <length-percentage [0,∞]>
rule decl:sym<grid-row-gap> { :i ("grid-row-gap") ":" <val(/<prop-val-grid-row-gap> /, &?ROUTINE.WHY)>}
rule prop-val-grid-row-gap { :i [normal & <keyw> ] || <length-percentage>  }
#| row-gap: normal | <length-percentage [0,∞]>
rule decl:sym<column-gap> { :i ("column-gap") ":" <val(/<prop-val-column-gap> /, &?ROUTINE.WHY)>}
rule prop-val-column-gap { :i [normal & <keyw> ] || <length-percentage>  }
#| row-gap: normal | <length-percentage [0,∞]>
rule decl:sym<grid-column-gap> { :i ("grid-column-gap") ":" <val(/<prop-val-grid-column-gap> /, &?ROUTINE.WHY)>}
rule prop-val-grid-column-gap { :i [normal & <keyw> ] || <length-percentage>  }