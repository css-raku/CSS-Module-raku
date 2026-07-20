unit grammar CSS::Snapshot2026::Motion::Gen::Grammar;
#| offset: [ <'offset-position'>? [ <'offset-path'> [ <'offset-distance'> || <'offset-rotate'> ]? ]? ]! [ / <'offset-anchor'> ]?
rule decl:sym<offset> { :i (offset) ":" <val(/<css-val-offset> /, &?ROUTINE.WHY)>}
rule css-val-offset { :i [<css-val-offset-position> ? [<css-val-offset-path> [[<css-val-offset-distance> :my $*A;<!{
    $*A++
}>|| <css-val-offset-rotate> :my $*B;<!{
    $*B++
}>]+] ? ] ? ] [<op("/")> <css-val-offset-anchor> ] ?  }
#| offset-anchor: auto | <position>
rule decl:sym<offset-anchor> { :i ("offset-anchor") ":" <val(/<css-val-offset-anchor> /, &?ROUTINE.WHY)>}
rule css-val-offset-anchor { :i auto & <keyw> || <position>  }
#| offset-distance: <length-percentage>
rule decl:sym<offset-distance> { :i ("offset-distance") ":" <val(/<css-val-offset-distance> /, &?ROUTINE.WHY)>}
rule css-val-offset-distance { :i <length-percentage> }
#| offset-path: none | <offset-path> || <coord-box>
rule decl:sym<offset-path> { :i ("offset-path") ":" <val(/<css-val-offset-path> /, &?ROUTINE.WHY)>}
rule css-val-offset-path { :i none & <keyw> || [<offset-path> :my $*A;<!{
    $*A++
}>|| <coord-box> :my $*B;<!{
    $*B++
}>]+  }
#| <offset-path> = <ray()> | <url> | <basic-shape>
rule offset-path { :i <ray> || <url> || <basic-shape>  }
#| ray( <angle> && <ray-size>? && contain? && [at <position>]? )
rule ray { :i "ray(" [[<angle> :my $*A;<!{
    $*A++
}>|| <ray-size> ? :my $*B;<!{
    $*B++
}>|| [contain & <keyw>] ? :my $*C;<!{
    $*C++
}>|| [at & <keyw> <position> ] ? :my $*D;<!{
    $*D++
}>]** 4 || <usage(&?ROUTINE.WHY)> ] ")" }
#| <ray-size> = <radial-extent> | sides
rule ray-size { :i <radial-extent> || sides & <keyw>  }
#| offset-position: normal | auto | <position>
rule decl:sym<offset-position> { :i ("offset-position") ":" <val(/<css-val-offset-position> /, &?ROUTINE.WHY)>}
rule css-val-offset-position { :i [normal | auto ]& <keyw>  || <position>  }
#| offset-rotate: [ auto | reverse ] || <angle>
rule decl:sym<offset-rotate> { :i ("offset-rotate") ":" <val(/<css-val-offset-rotate> /, &?ROUTINE.WHY)>}
rule css-val-offset-rotate { :i [[[auto | reverse ]& <keyw> ] :my $*A; <!{
    $*A++
}>|| <angle> :my $*B; <!{
    $*B++
}>]+ }