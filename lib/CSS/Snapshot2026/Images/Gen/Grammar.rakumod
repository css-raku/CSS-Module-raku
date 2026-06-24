unit grammar CSS::Snapshot2026::Images::Gen::Grammar;
#| <image> = <url> | <gradient>
rule image { :i <url> || <gradient>  }
#| <gradient> = <linear-gradient()> | <repeating-linear-gradient()> |  <radial-gradient()> | <repeating-radial-gradient()>
rule gradient { :i <linear-gradient> || <repeating-linear-gradient> || <radial-gradient> || <repeating-radial-gradient>  }
#| linear-gradient( [ <linear-gradient-syntax> ] )
rule linear-gradient { :i "linear-gradient(" [<linear-gradient-syntax> || <usage(&?ROUTINE.WHY)> ] ")" }
#| <linear-gradient-syntax> = [ <angle> | <zero> | to <side-or-corner> ]? , <color-stop-list>
rule linear-gradient-syntax { :i [<angle> || <zero> || to & <keyw> <side-or-corner>  ] ? <op(",")> <color-stop-list>  }
#| <color-stop-list> = <linear-color-stop> , [ <linear-color-hint>? , <linear-color-stop> ]#?
rule color-stop-list { :i <linear-color-stop> <op(",")> [<linear-color-hint> ? <op(",")> <linear-color-stop> ] *  }
#| <linear-color-stop> = <color> <length-percentage>?
rule linear-color-stop { :i <color> <length-percentage> ?  }
#| <linear-color-hint> = <length-percentage>
rule linear-color-hint { :i <length-percentage> }
#| <side-or-corner> = [left | right] || [top | bottom]
rule side-or-corner { :i [[[left | right ]& <keyw> ] :my $*A;<!{
    $*A++
}>|| [[top | bottom ]& <keyw> ] :my $*B;<!{
    $*B++
}>]+ }
#| <radial-size> = <radial-extent> | <length [0,∞]> | <length-percentage [0,∞]>{2}
rule radial-size { :i <radial-extent> || <length> || <length-percentage> ** 2  }
#| <radial-extent> = closest-corner | closest-side | farthest-corner | farthest-side
rule radial-extent { :i ["closest-corner" | "closest-side" | "farthest-corner" | "farthest-side" ]& <keyw>  }
#| radial-gradient( [ <radial-gradient-syntax> ] )
rule radial-gradient { :i "radial-gradient(" [<radial-gradient-syntax> || <usage(&?ROUTINE.WHY)> ] ")" }
#| <radial-gradient-syntax> = [ <radial-shape> || <radial-size> ]? [ at <position> ]? ,  <color-stop-list>
rule radial-gradient-syntax { :i [[<radial-shape> :my $*A;<!{
    $*A++
}>|| <radial-size> :my $*B;<!{
    $*B++
}>]+] ? [at & <keyw> <position> ] ? <op(",")> <color-stop-list>  }
#| <radial-shape> = circle | ellipse
rule radial-shape { :i [circle | ellipse ]& <keyw>  }
#| repeating-linear-gradient( [ <linear-gradient-syntax> ] )
rule repeating-linear-gradient { :i "repeating-linear-gradient(" [<linear-gradient-syntax> || <usage(&?ROUTINE.WHY)> ] ")" }
#| repeating-radial-gradient( [ <radial-gradient-syntax> ] )
rule repeating-radial-gradient { :i "repeating-radial-gradient(" [<radial-gradient-syntax> || <usage(&?ROUTINE.WHY)> ] ")" }
#| <zero> = 0
rule zero { :i 0 & <number> }
#| image-orientation: from-image | none | [ <angle> || flip ]
rule decl:sym<image-orientation> { :i ("image-orientation") ":" <val(/<css-val-image-orientation> /, &?ROUTINE.WHY)>}
rule css-val-image-orientation { :i ["from-image" | none ]& <keyw>  || [[<angle> :my $*A;<!{
    $*A++
}>|| flip & <keyw> :my $*B;<!{
    $*B++
}>]+]  }
#| image-rendering: auto | smooth | high-quality | pixelated | crisp-edges
rule decl:sym<image-rendering> { :i ("image-rendering") ":" <val(/<css-val-image-rendering> /, &?ROUTINE.WHY)>}
rule css-val-image-rendering { :i [auto | smooth | "high-quality" | pixelated | "crisp-edges" ]& <keyw>  }
#| object-fit: fill | contain | cover | none | scale-down
rule decl:sym<object-fit> { :i ("object-fit") ":" <val(/<css-val-object-fit> /, &?ROUTINE.WHY)>}
rule css-val-object-fit { :i [fill | contain | cover | none | "scale-down" ]& <keyw>  }
#| object-position: <position>
rule decl:sym<object-position> { :i ("object-position") ":" <val(/<css-val-object-position> /, &?ROUTINE.WHY)>}
rule css-val-object-position { :i <position> }