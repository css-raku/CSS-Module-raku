unit grammar CSS::Snapshot2026::Grid::Gen::Grammar;
#| grid: <'grid-template'> |! <'grid-template-rows'> / [ auto-flow && dense? ] <'grid-auto-columns'>? |! [ auto-flow && dense? ] <'grid-auto-rows'>? / <'grid-template-columns'>
rule decl:sym<grid> { :i (grid) ":" <val(/<prop-val-grid> /, &?ROUTINE.WHY)>}
rule prop-val-grid { :i <prop-val-grid-template-rows> <op("/")> [["auto-flow" & <keyw> :my $*A;<!{
    $*A++
}>|| [dense & <keyw>] ? :my $*B;<!{
    $*B++
}>]** 2] <prop-val-grid-auto-columns> ?  || [["auto-flow" & <keyw> :my $*C;<!{
    $*C++
}>|| [dense & <keyw>] ? :my $*D;<!{
    $*D++
}>]** 2] <prop-val-grid-auto-rows> ? <op("/")> <prop-val-grid-template-columns>  || <prop-val-grid-template>  }
#| grid-area: <grid-line> [ / <grid-line> ]{0,3}
rule decl:sym<grid-area> { :i ("grid-area") ":" <val(/<prop-val-grid-area> /, &?ROUTINE.WHY)>}
rule prop-val-grid-area { :i <grid-line> [<op("/")> <grid-line> ] ** 0..3  }
#| grid-auto-columns: <track-size>+
rule decl:sym<grid-auto-columns> { :i ("grid-auto-columns") ":" <val(/<prop-val-grid-auto-columns> /, &?ROUTINE.WHY)>}
rule prop-val-grid-auto-columns { :i <track-size> + }
#| grid-auto-flow: [ row | column ] || dense
rule decl:sym<grid-auto-flow> { :i ("grid-auto-flow") ":" <val(/<prop-val-grid-auto-flow> /, &?ROUTINE.WHY)>}
rule prop-val-grid-auto-flow { :i [[[row | column ]& <keyw> ] :my $*A;<!{
    $*A++
}>|| dense & <keyw> :my $*B;<!{
    $*B++
}>]+ }
#| grid-auto-rows: <track-size>+
rule decl:sym<grid-auto-rows> { :i ("grid-auto-rows") ":" <val(/<prop-val-grid-auto-rows> /, &?ROUTINE.WHY)>}
rule prop-val-grid-auto-rows { :i <track-size> + }
#| grid-column: <grid-line> [ / <grid-line> ]?
rule decl:sym<grid-column> { :i ("grid-column") ":" <val(/<prop-val-grid-column> /, &?ROUTINE.WHY)>}
rule prop-val-grid-column { :i <grid-line> [<op("/")> <grid-line> ] ?  }
#| grid-column-end: <grid-line>
rule decl:sym<grid-column-end> { :i ("grid-column-end") ":" <val(/<prop-val-grid-column-end> /, &?ROUTINE.WHY)>}
rule prop-val-grid-column-end { :i <grid-line> }
#| grid-column-start: <grid-line>
rule decl:sym<grid-column-start> { :i ("grid-column-start") ":" <val(/<prop-val-grid-column-start> /, &?ROUTINE.WHY)>}
rule prop-val-grid-column-start { :i <grid-line> }
#| grid-row: <grid-line> [ / <grid-line> ]?
rule decl:sym<grid-row> { :i ("grid-row") ":" <val(/<prop-val-grid-row> /, &?ROUTINE.WHY)>}
rule prop-val-grid-row { :i <grid-line> [<op("/")> <grid-line> ] ?  }
#| grid-row-end: <grid-line>
rule decl:sym<grid-row-end> { :i ("grid-row-end") ":" <val(/<prop-val-grid-row-end> /, &?ROUTINE.WHY)>}
rule prop-val-grid-row-end { :i <grid-line> }
#| grid-row-start: <grid-line>
rule decl:sym<grid-row-start> { :i ("grid-row-start") ":" <val(/<prop-val-grid-row-start> /, &?ROUTINE.WHY)>}
rule prop-val-grid-row-start { :i <grid-line> }
#| grid-template: none | [ <'grid-template-rows'> / <'grid-template-columns'> ] | [ <line-names>? <string> <track-size>? <line-names>? ]+ [ / <explicit-track-list> ]?
rule decl:sym<grid-template> { :i ("grid-template") ":" <val(/<prop-val-grid-template> /, &?ROUTINE.WHY)>}
rule prop-val-grid-template { :i none & <keyw> || [<prop-val-grid-template-rows> <op("/")> <prop-val-grid-template-columns> ] || [<line-names> ? <string> <track-size> ? <line-names> ? ] + [<op("/")> <explicit-track-list> ] ?   }
#| grid-template-areas: none | <string>+
rule decl:sym<grid-template-areas> { :i ("grid-template-areas") ":" <val(/<prop-val-grid-template-areas> /, &?ROUTINE.WHY)>}
rule prop-val-grid-template-areas { :i none & <keyw> || <string> +  }
#| grid-template-columns: none | <track-list> | <auto-track-list>
rule decl:sym<grid-template-columns> { :i ("grid-template-columns") ":" <val(/<prop-val-grid-template-columns> /, &?ROUTINE.WHY)>}
rule prop-val-grid-template-columns { :i none & <keyw> || <track-list> || <auto-track-list>  }
#| grid-template-rows: none | <track-list> | <auto-track-list>
rule decl:sym<grid-template-rows> { :i ("grid-template-rows") ":" <val(/<prop-val-grid-template-rows> /, &?ROUTINE.WHY)>}
rule prop-val-grid-template-rows { :i none & <keyw> || <track-list> || <auto-track-list>  }
#| <track-list> = [ <line-names>? [ <track-size> | <track-repeat> ] ]+ <line-names>?
rule track-list { :i [<line-names> ? [<track-size> || <track-repeat> ] ] + <line-names> ?  }
#| <auto-track-list> = [ <line-names>? [ <fixed-size> | <fixed-repeat> ] ]* <line-names>? <auto-repeat>                        [ <line-names>? [ <fixed-size> | <fixed-repeat> ] ]* <line-names>?
rule auto-track-list { :i [<line-names> ? [<fixed-size> || <fixed-repeat> ] ] * <line-names> ? <auto-repeat> [<line-names> ? [<fixed-size> || <fixed-repeat> ] ] * <line-names> ?  }
#| <explicit-track-list> = [ <line-names>? <track-size> ]+ <line-names>?
rule explicit-track-list { :i [<line-names> ? <track-size> ] + <line-names> ?  }
#| <track-size> = <track-breadth> | <track-minmax>  | fit-content( <length-percentage [0,∞]> )
rule track-size { :i <track-breadth> || <track-minmax> || <fit-content>  }
#| minmax( <inflexible-breadth> , <track-breadth> )
rule track-minmax { :i "minmax(" [<inflexible-breadth> "," <track-breadth>  || <usage(&?ROUTINE.WHY)> ] ")" }
#| <fixed-size> = <fixed-breadth> | <fixed-minmax> | <track-minmax>
rule fixed-size { :i <fixed-breadth> || <fixed-minmax> || <track-minmax>  }
#| minmax( <fixed-breadth> , <track-breadth> )
rule fixed-minmax { :i "minmax(" [<fixed-breadth> "," <track-breadth>  || <usage(&?ROUTINE.WHY)> ] ")" }
#| <track-breadth> = <length-percentage [0,∞]> | <flex [0,∞]> | min-content | max-content | auto
rule track-breadth { :i <length-percentage> || <flex> || ["min-content" | "max-content" | auto ]& <keyw>   }
#| <inflexible-breadth> = <length-percentage [0,∞]> | min-content | max-content | auto
rule inflexible-breadth { :i <length-percentage> || ["min-content" | "max-content" | auto ]& <keyw>   }
#| <fixed-breadth> = <length-percentage [0,∞]>
rule fixed-breadth { :i <length-percentage> }
#| <line-names> = '[' <custom-ident>* ']'
rule line-names { :i <op("[")> <custom-ident> * <op("]")>  }
#| repeat( [ <integer [1,∞]> ] , [ <line-names>? <track-size> ]+ <line-names>? )
rule track-repeat { :i "repeat(" [<integer> "," [<line-names> ? <track-size> ] + <line-names> ?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| repeat( [ auto-fill | auto-fit ] , [ <line-names>? <fixed-size> ]+ <line-names>? )
rule auto-repeat { :i "repeat(" [[["auto-fill" | "auto-fit" ]& <keyw> ] "," [<line-names> ? <fixed-size> ] + <line-names> ?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| repeat( [ <integer [1,∞]> ] , [ <line-names>? <fixed-size> ]+ <line-names>? )
rule fixed-repeat { :i "repeat(" [<integer> "," [<line-names> ? <fixed-size> ] + <line-names> ?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| fit-content( <length-percentage> )
rule fit-content { :i "fit-content(" [<length-percentage> || <usage(&?ROUTINE.WHY)> ] ")" }
#| <grid-line> = auto | <custom-ident> |  [ [ <integer [-∞,-1]> | <integer [1,∞]> ] && <custom-ident>? ] |  [ span && [ <integer [1,∞]> || <custom-ident> ] ]
rule grid-line { :i auto & <keyw> || <custom-ident> || [[[<integer> || <integer> ] :my $*A; <!{
    $*A++
}>|| <custom-ident> ? :my $*B; <!{
    $*B++
}>]** 2] || [[span & <keyw> :my $*C; <!{
    $*C++
}>|| [[<integer> :my $*E; <!{
    $*E++
}>|| <custom-ident> :my $*F; <!{
    $*F++
}>]+] :my $*D; <!{
    $*D++
}>]** 2]  }