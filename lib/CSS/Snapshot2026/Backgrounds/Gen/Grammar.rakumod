unit grammar CSS::Snapshot2026::Backgrounds::Gen::Grammar;
#| background: <bg-layer>#? , <final-bg-layer>
rule decl:sym<background> { :i (background) ":" <val(/<prop-val-background> /, &?ROUTINE.WHY)>}
rule prop-val-background { :i [:!r <bg-layer> +% <op(",")> <op(",")>]? <final-bg-layer>  }
#| <bg-layer> = <'background-image'> || <'background-position'> [ / <'background-size'> ]? || <'background-repeat'> || <'background-attachment'> || <'background-clip'>
rule bg-layer { :i [<prop-val-background-image> :my $*A;<!{
    $*A++
}>|| <prop-val-background-position> [<op("/")> <prop-val-background-size> ] ?  :my $*B;<!{
    $*B++
}>|| <prop-val-background-repeat> :my $*C;<!{
    $*C++
}>|| <prop-val-background-attachment> :my $*D;<!{
    $*D++
}>|| <prop-val-background-clip> :my $*E;<!{
    $*E++
}>]+ }
#| <final-bg-layer> = <'background-image'> || <'background-position'> [ / <'background-size'>{1,2} ]? || <'background-repeat'> || <'background-attachment'> || <'background-clip'> || <'background-color'>
rule final-bg-layer { :i [<prop-val-background-image> :my $*A;<!{
    $*A++
}>|| <prop-val-background-position> [<op("/")> <prop-val-background-size> ** 1..2 ] ?  :my $*B;<!{
    $*B++
}>|| <prop-val-background-repeat> :my $*C;<!{
    $*C++
}>|| <prop-val-background-attachment> :my $*D;<!{
    $*D++
}>|| <prop-val-background-clip> :my $*E;<!{
    $*E++
}>|| <prop-val-background-color> :my $*F;<!{
    $*F++
}>]+ }
#| <bg-position> = [ [ left | center | right | top | bottom | <length-percentage> ] |! [ left | center | right | <length-percentage> ] [ top | center | bottom | <length-percentage> ] |!! [ center | [ left | right ] <length-percentage>? ] && [ center | [ top | bottom ] <length-percentage>? ]]
rule bg-position { :i [[[center & <keyw> || [[left | right ]& <keyw> ] <length-percentage> ?  ] :my $*A;<!{
    $*A++
}>|| [center & <keyw> || [[top | bottom ]& <keyw> ] <length-percentage> ?  ] :my $*B;<!{
    $*B++
}>]** 2 || [[left | center | right ]& <keyw>  || <length-percentage> ] [[top | center | bottom ]& <keyw>  || <length-percentage> ]  || [[left | center | right | top | bottom ]& <keyw>  || <length-percentage> ] ] }
#| background-attachment: <attachment>#
rule decl:sym<background-attachment> { :i ("background-attachment") ":" <val(/<prop-val-background-attachment> /, &?ROUTINE.WHY)>}
rule prop-val-background-attachment { :i <attachment> +% <op(",")>? }
#| <attachment> = scroll | fixed | local
rule attachment { :i [scroll | fixed | local ]& <keyw>  }
#| background-clip: <visual-box>#
rule decl:sym<background-clip> { :i ("background-clip") ":" <val(/<prop-val-background-clip> /, &?ROUTINE.WHY)>}
rule prop-val-background-clip { :i <visual-box> +% <op(",")>? }
#| background-color: <color>
rule decl:sym<background-color> { :i ("background-color") ":" <val(/<prop-val-background-color> /, &?ROUTINE.WHY)>}
rule prop-val-background-color { :i <color> }
#| background-image: <bg-image>#
rule decl:sym<background-image> { :i ("background-image") ":" <val(/<prop-val-background-image> /, &?ROUTINE.WHY)>}
rule prop-val-background-image { :i <bg-image> +% <op(",")>? }
#| <bg-image> = <image> | none
rule bg-image { :i <image> || none & <keyw>  }
#| background-origin: <visual-box>#
rule decl:sym<background-origin> { :i ("background-origin") ":" <val(/<prop-val-background-origin> /, &?ROUTINE.WHY)>}
rule prop-val-background-origin { :i <visual-box> +% <op(",")>? }
#| background-position: <bg-position>#
rule decl:sym<background-position> { :i ("background-position") ":" <val(/<prop-val-background-position> /, &?ROUTINE.WHY)>}
rule prop-val-background-position { :i <bg-position> +% <op(",")>? }
#| background-repeat: <repeat-style>#
rule decl:sym<background-repeat> { :i ("background-repeat") ":" <val(/<prop-val-background-repeat> /, &?ROUTINE.WHY)>}
rule prop-val-background-repeat { :i <repeat-style> +% <op(",")>? }
#| <repeat-style> = repeat-x | repeat-y | [repeat | space | round | no-repeat]{1,2}
rule repeat-style { :i ["repeat-x" | "repeat-y" ]& <keyw>  || [[repeat | space | round | "no-repeat" ]& <keyw> ] ** 1..2  }
#| background-size: <bg-size>#
rule decl:sym<background-size> { :i ("background-size") ":" <val(/<prop-val-background-size> /, &?ROUTINE.WHY)>}
rule prop-val-background-size { :i <bg-size> +% <op(",")>? }
#| <bg-size> = [ <length-percentage [0,∞]> | auto ]{1,2} | cover | contain
rule bg-size { :i [<length-percentage> || auto & <keyw> ] ** 1..2 || [cover | contain ]& <keyw>   }
#| <line-width> = <length [0,∞]> | thin | medium | thick
rule line-width { :i <length> || [thin | medium | thick ]& <keyw>   }
#| <line-style> = none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset
rule line-style { :i [none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw>  }
#| border-bottom: <'border-bottom-width'> || <'border-bottom-style'> || <'border-bottom-color'>
rule decl:sym<border-bottom> { :i ("border-bottom") ":" <val(/<prop-val-border-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom { :i [<prop-val-border-bottom-width> :my $*A;<!{
    $*A++
}>|| <prop-val-border-bottom-style> :my $*B;<!{
    $*B++
}>|| <prop-val-border-bottom-color> :my $*C;<!{
    $*C++
}>]+ }
#| border-bottom-color: <color>
rule decl:sym<border-bottom-color> { :i ("border-bottom-color") ":" <val(/<prop-val-border-bottom-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-color { :i <color> }
#| border-bottom-left-radius: <length-percentage [0,∞]>{1,2}
rule decl:sym<border-bottom-left-radius> { :i ("border-bottom-left-radius") ":" <val(/<prop-val-border-bottom-left-radius> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-left-radius { :i <length-percentage> ** 1..2 }
#| border-bottom-right-radius: <length-percentage [0,∞]>{1,2}
rule decl:sym<border-bottom-right-radius> { :i ("border-bottom-right-radius") ":" <val(/<prop-val-border-bottom-right-radius> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-right-radius { :i <length-percentage> ** 1..2 }
#| border-bottom-style: <line-style>
rule decl:sym<border-bottom-style> { :i ("border-bottom-style") ":" <val(/<prop-val-border-bottom-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-style { :i <line-style> }
#| border-bottom-width: <line-width>
rule decl:sym<border-bottom-width> { :i ("border-bottom-width") ":" <val(/<prop-val-border-bottom-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-width { :i <line-width> }
#| border-color: <color>{1,4}
rule decl:sym<border-color> { :i ("border-color") ":" <val(/<prop-val-border-color>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-color { :i <color> }
#| border-image: <'border-image-source'> || <'border-image-slice'> [ / <'border-image-width'> | / <'border-image-width'>? / <'border-image-outset'> ]? || <'border-image-repeat'>
rule decl:sym<border-image> { :i ("border-image") ":" <val(/<prop-val-border-image> /, &?ROUTINE.WHY)>}
rule prop-val-border-image { :i [<prop-val-border-image-source> :my $*A;<!{
    $*A++
}>|| <prop-val-border-image-slice> [<op("/")> <prop-val-border-image-width>  || <op("/")> <prop-val-border-image-width> ? <op("/")> <prop-val-border-image-outset>  ] ?  :my $*B;<!{
    $*B++
}>|| <prop-val-border-image-repeat> :my $*C;<!{
    $*C++
}>]+ }
#| border-image-outset: [ <length [0,∞]> | <number [0,∞]> ]{1,4}
rule decl:sym<border-image-outset> { :i ("border-image-outset") ":" <val(/<prop-val-border-image-outset>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-image-outset { :i [<length> || <number> ] }
#| border-image-repeat: [ stretch | repeat | round | space ]{1,2}
rule decl:sym<border-image-repeat> { :i ("border-image-repeat") ":" <val(/<prop-val-border-image-repeat> /, &?ROUTINE.WHY)>}
rule prop-val-border-image-repeat { :i [[stretch | repeat | round | space ]& <keyw> ] ** 1..2 }
#| border-image-slice: [<number [0,∞]> | <percentage [0,∞]>]{1,4} && fill?
rule decl:sym<border-image-slice> { :i ("border-image-slice") ":" <val(/<prop-val-border-image-slice> /, &?ROUTINE.WHY)>}
rule prop-val-border-image-slice { :i [[<number> || <percentage> ] ** 1..4 :my $*A;<!{
    $*A++
}>|| [fill & <keyw>] ? :my $*B;<!{
    $*B++
}>]** 2 }
#| border-image-source: none | <image>
rule decl:sym<border-image-source> { :i ("border-image-source") ":" <val(/<prop-val-border-image-source> /, &?ROUTINE.WHY)>}
rule prop-val-border-image-source { :i none & <keyw> || <image>  }
#| border-image-width: [ <length-percentage [0,∞]> | <number [0,∞]> | auto ]{1,4}
rule decl:sym<border-image-width> { :i ("border-image-width") ":" <val(/<prop-val-border-image-width>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-image-width { :i [<length-percentage> || <number> || auto & <keyw> ] }
#| border-left: <'border-left-width'> || <'border-left-style'> || <'border-left-color'>
rule decl:sym<border-left> { :i ("border-left") ":" <val(/<prop-val-border-left> /, &?ROUTINE.WHY)>}
rule prop-val-border-left { :i [<prop-val-border-left-width> :my $*A;<!{
    $*A++
}>|| <prop-val-border-left-style> :my $*B;<!{
    $*B++
}>|| <prop-val-border-left-color> :my $*C;<!{
    $*C++
}>]+ }
#| border-left-color: <color>
rule decl:sym<border-left-color> { :i ("border-left-color") ":" <val(/<prop-val-border-left-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-left-color { :i <color> }
#| border-left-style: <line-style>
rule decl:sym<border-left-style> { :i ("border-left-style") ":" <val(/<prop-val-border-left-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-left-style { :i <line-style> }
#| border-left-width: <line-width>
rule decl:sym<border-left-width> { :i ("border-left-width") ":" <val(/<prop-val-border-left-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-left-width { :i <line-width> }
#| border-radius: <border-radius>{1,4}
rule decl:sym<border-radius> { :i ("border-radius") ":" <val(/<prop-val-border-radius>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-radius { :i <border-radius> }
#| <border-radius> = <length-percentage [0,∞]> [ / <length-percentage [0,∞]>{1,4} ]?
rule border-radius { :i <length-percentage> [<op("/")> <length-percentage> ** 1..4 ] ?  }
#| border-right: <'border-right-width'> || <'border-right-style'> || <'border-right-color'>
rule decl:sym<border-right> { :i ("border-right") ":" <val(/<prop-val-border-right> /, &?ROUTINE.WHY)>}
rule prop-val-border-right { :i [<prop-val-border-right-width> :my $*A;<!{
    $*A++
}>|| <prop-val-border-right-style> :my $*B;<!{
    $*B++
}>|| <prop-val-border-right-color> :my $*C;<!{
    $*C++
}>]+ }
#| border-right-color: <color>
rule decl:sym<border-right-color> { :i ("border-right-color") ":" <val(/<prop-val-border-right-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-right-color { :i <color> }
#| border-right-style: <line-style>
rule decl:sym<border-right-style> { :i ("border-right-style") ":" <val(/<prop-val-border-right-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-right-style { :i <line-style> }
#| border-right-width: <line-width>
rule decl:sym<border-right-width> { :i ("border-right-width") ":" <val(/<prop-val-border-right-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-right-width { :i <line-width> }
#| border-style: <line-style>{1,4}
rule decl:sym<border-style> { :i ("border-style") ":" <val(/<prop-val-border-style>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-style { :i <line-style> }
#| border-top: <'border-top-width'> || <'border-top-style'> || <'border-top-color'>
rule decl:sym<border-top> { :i ("border-top") ":" <val(/<prop-val-border-top> /, &?ROUTINE.WHY)>}
rule prop-val-border-top { :i [<prop-val-border-top-width> :my $*A;<!{
    $*A++
}>|| <prop-val-border-top-style> :my $*B;<!{
    $*B++
}>|| <prop-val-border-top-color> :my $*C;<!{
    $*C++
}>]+ }
#| border-top-color: <color>
rule decl:sym<border-top-color> { :i ("border-top-color") ":" <val(/<prop-val-border-top-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-color { :i <color> }
#| border-top-left-radius: <border-radius>{1,2}
rule decl:sym<border-top-left-radius> { :i ("border-top-left-radius") ":" <val(/<prop-val-border-top-left-radius> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-left-radius { :i <border-radius> ** 1..2 }
#| border-top-right-radius: <border-radius>{1,2}
rule decl:sym<border-top-right-radius> { :i ("border-top-right-radius") ":" <val(/<prop-val-border-top-right-radius> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-right-radius { :i <border-radius> ** 1..2 }
#| border-top-style: <line-style>
rule decl:sym<border-top-style> { :i ("border-top-style") ":" <val(/<prop-val-border-top-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-style { :i <line-style> }
#| border-top-width: <line-width>
rule decl:sym<border-top-width> { :i ("border-top-width") ":" <val(/<prop-val-border-top-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-width { :i <line-width> }
#| border-width: <line-width>{1,4}
rule decl:sym<border-width> { :i ("border-width") ":" <val(/<prop-val-border-width>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-width { :i <line-width> }
#| box-shadow: none | <shadow>#
rule decl:sym<box-shadow> { :i ("box-shadow") ":" <val(/<prop-val-box-shadow> /, &?ROUTINE.WHY)>}
rule prop-val-box-shadow { :i none & <keyw> || <shadow> +% <op(",")>?  }
#| <shadow> = <color>? && [ <length>{2} [ <length [0,∞]> <length>? ]? ] && inset?
rule shadow { :i [<color> ? :my $*A; <!{
    $*A++
}>|| [<length> ** 2 [<length> <length> ? ] ? ] :my $*B; <!{
    $*B++
}>|| [inset & <keyw>] ? :my $*C; <!{
    $*C++
}>]** 3 }