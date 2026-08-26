unit grammar CSS::Snapshot2026::Motion::Gen::Grammar;
#| offset: [ <'offset-position'>? [ <'offset-path'> [ <'offset-distance'> || <'offset-rotate'> ]? ]? ]! [ / <'offset-anchor'> ]?
rule decl:sym<offset> { :i (offset) ":" <val(/<prop-val-offset> /, &?ROUTINE.WHY)>}
rule prop-val-offset { :i [<prop-val-offset-position> ? [<prop-val-offset-path> [[<prop-val-offset-distance> :my $*A;<!{
    $*A++
}>|| <prop-val-offset-rotate> :my $*B;<!{
    $*B++
}>]+] ? ] ? ] [<op("/")> <prop-val-offset-anchor> ] ?  }
#| offset-anchor: auto | <position>
rule decl:sym<offset-anchor> { :i ("offset-anchor") ":" <val(/<prop-val-offset-anchor> /, &?ROUTINE.WHY)>}
rule prop-val-offset-anchor { :i [auto & <keyw> ] || <position>  }
#| offset-distance: <length-percentage>
rule decl:sym<offset-distance> { :i ("offset-distance") ":" <val(/<prop-val-offset-distance> /, &?ROUTINE.WHY)>}
rule prop-val-offset-distance { :i <length-percentage> }
#| offset-path: none | <offset-path> || <coord-box>
rule decl:sym<offset-path> { :i ("offset-path") ":" <val(/<prop-val-offset-path> /, &?ROUTINE.WHY)>}
rule prop-val-offset-path { :i [none & <keyw> ] || [<offset-path> :my $*A;<!{
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
}>|| [contain & <keyw> ] ? :my $*C;<!{
    $*C++
}>|| [[at & <keyw> ] <position> ] ? :my $*D;<!{
    $*D++
}>]** 4 || <usage(&?ROUTINE.WHY)> ] ")" }
#| <ray-size> = <radial-extent> | sides
rule ray-size { :i <radial-extent> || [sides & <keyw> ]  }
#| offset-position: normal | auto | <position>
rule decl:sym<offset-position> { :i ("offset-position") ":" <val(/<prop-val-offset-position> /, &?ROUTINE.WHY)>}
rule prop-val-offset-position { :i [normal | auto ]& <keyw>  || <position>  }
#| offset-rotate: [ auto | reverse ] || <angle>
rule decl:sym<offset-rotate> { :i ("offset-rotate") ":" <val(/<prop-val-offset-rotate> /, &?ROUTINE.WHY)>}
rule prop-val-offset-rotate { :i [[[auto | reverse ]& <keyw> ] :my $*A; <!{
    $*A++
}>|| <angle> :my $*B; <!{
    $*B++
}>]+ }