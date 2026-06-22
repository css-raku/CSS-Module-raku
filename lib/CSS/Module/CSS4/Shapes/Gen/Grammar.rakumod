unit grammar CSS::Module::CSS4::Shapes::Gen::Grammar;
#| shape-image-threshold: <opacity-value>
rule decl:sym<shape-image-threshold> { :i ("shape-image-threshold") ":" <val(/<css-val-shape-image-threshold> /, &?ROUTINE.WHY)>}
rule css-val-shape-image-threshold { :i <opacity-value> }
#| shape-margin: <length-percentage [0,∞]>
rule decl:sym<shape-margin> { :i ("shape-margin") ":" <val(/<css-val-shape-margin> /, &?ROUTINE.WHY)>}
rule css-val-shape-margin { :i <length-percentage> }
#| shape-outside: none | [ <basic-shape> || <shape-box> ] | <image>
rule decl:sym<shape-outside> { :i ("shape-outside") ":" <val(/<css-val-shape-outside> /, &?ROUTINE.WHY)>}
rule css-val-shape-outside { :i none & <keyw> || [[<basic-shape> :my $*A;<!{
    $*A++
}>|| <shape-box> :my $*B;<!{
    $*B++
}>]+] || <image>  }
#| <basic-shape> = <basic-shape-rect> | <circle()> | <ellipse()> |  <polygon()> | <path()> | <shape-rect>
rule basic-shape { :i <basic-shape-rect> || <circle> || <ellipse> || <polygon> || <path> || <shape-rect>  }
#| inset( <length-percentage>{1,4} [ round <'border-radius'> ]? )
rule inset { :i "inset(" [<length-percentage> ** 1..4 [round & <keyw> <css-val-border-radius> ] ?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| xywh( <length-percentage>{2} <length-percentage [0,∞]>{2} [ round <'border-radius'> ]?)
rule xywh { :i "xywh(" [<length-percentage> ** 2 <length-percentage> ** 2 [round & <keyw> <css-val-border-radius> ] ?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| <shape-box> = <visual-box> | margin-box | half-border-box
rule shape-box { :i <visual-box> || ["margin-box" | "half-border-box" ]& <keyw>   }
#| <shape-rect> = rect([ <length-percentage> | auto ]{4} [ round <'border-radius'> ]?)
rule shape-rect { :i <rect> }
#| <basic-shape-rect> = <inset()> | <rect()> | <xywh()>
rule basic-shape-rect { :i <inset> || <rect> || <xywh>  }
#| circle( <radial-size>? [ at <position> ]? )
rule circle { :i "circle(" [<radial-size> ? [at & <keyw> <position> ] ?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| ellipse( <radial-size>? [ at <position> ]?)
rule ellipse { :i "ellipse(" [<radial-size> ? [at & <keyw> <position> ] ?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| polygon( <'fill-rule'>? [ round <length> ]? , [<length-percentage> <length-percentage>]# )
rule polygon { :i "polygon(" [<css-val-fill-rule> ? [round & <keyw> <length> ] ? "," [<length-percentage> <length-percentage> ] +% ","  || <usage(&?ROUTINE.WHY)> ] ")" }
#| path( <'fill-rule'>? , <string> )
rule path { :i "path(" [<css-val-fill-rule> ? "," <string>  || <usage(&?ROUTINE.WHY)> ] ")" }
#| shape( <'fill-rule'>? from <position> , <shape-command>#)
rule shape { :i "shape(" [<css-val-fill-rule> ? from & <keyw> <position> "," <shape-command> +% ","  || <usage(&?ROUTINE.WHY)> ] ")" }
#| <shape-command> = <move-command> | <line-command> | close |                  <horizontal-line-command> | <vertical-line-command> |                  <curve-command> | <smooth-command> | <arc-command>
rule shape-command { :i <move-command> || <line-command> || close & <keyw> || <horizontal-line-command> || <vertical-line-command> || <curve-command> || <smooth-command> || <arc-command>  }
#| <move-command> = move <command-end-point>
rule move-command { :i move & <keyw> <command-end-point>  }
#| <line-command> = line <command-end-point>
rule line-command { :i line & <keyw> <command-end-point>  }
#| <horizontal-line-command> = hline        [ to [ <length-percentage> | left | center | right | x-start | x-end ]        | by <length-percentage> ]
rule horizontal-line-command { :i hline & <keyw> [to & <keyw> [<length-percentage> || [left | center | right | "x-start" | "x-end" ]& <keyw>  ]  || by & <keyw> <length-percentage>  ]  }
#| <vertical-line-command> = vline        [ to [ <length-percentage> | top | center | bottom | y-start | y-end ]        | by <length-percentage> ]
rule vertical-line-command { :i vline & <keyw> [to & <keyw> [<length-percentage> || [top | center | bottom | "y-start" | "y-end" ]& <keyw>  ]  || by & <keyw> <length-percentage>  ]  }
#| <curve-command> = curve        [ [ to <position> with <control-point> [ / <control-point> ]? ]        | [ by <coordinate-pair> with <relative-control-point> [ / <relative-control-point> ]? ] ]
rule curve-command { :i curve & <keyw> [[to & <keyw> <position> with & <keyw> <control-point> [<op("/")> <control-point> ] ? ] || [by & <keyw> <coordinate-pair> with & <keyw> <relative-control-point> [<op("/")> <relative-control-point> ] ? ] ]  }
#| <smooth-command> = smooth        [ [ to <position> [ with <control-point> ]? ]        | [ by <coordinate-pair> [ with <relative-control-point> ]? ] ]
rule smooth-command { :i smooth & <keyw> [[to & <keyw> <position> [with & <keyw> <control-point> ] ? ] || [by & <keyw> <coordinate-pair> [with & <keyw> <relative-control-point> ] ? ] ]  }
#| <arc-command> = arc <command-end-point>            [ [ of <length-percentage>{1,2} ]              && <arc-sweep>? && <arc-size>? && [rotate <angle>]? ]
rule arc-command { :i arc & <keyw> <command-end-point> [[[of & <keyw> <length-percentage> ** 1..2 ] :my $*A;<!{
    $*A++
}>|| <arc-sweep> ? :my $*B;<!{
    $*B++
}>|| <arc-size> ? :my $*C;<!{
    $*C++
}>|| [rotate & <keyw> <angle> ] ? :my $*D;<!{
    $*D++
}>]** 4]  }
#| <command-end-point> = [ to <position> | by <coordinate-pair> ]
rule command-end-point { :i [to & <keyw> <position>  || by & <keyw> <coordinate-pair>  ] }
#| <control-point> = [ <position> | <relative-control-point> ]
rule control-point { :i [<position> || <relative-control-point> ] }
#| <relative-control-point> = <coordinate-pair> [ from [ start | end | origin ] ]?
rule relative-control-point { :i <coordinate-pair> [from & <keyw> [[start | end | origin ]& <keyw> ] ] ?  }
#| <coordinate-pair> = <length-percentage>{2}
rule coordinate-pair { :i <length-percentage> ** 2 }
#| <arc-sweep> = cw | ccw
rule arc-sweep { :i [cw | ccw ]& <keyw>  }
#| <arc-size> = large | small
rule arc-size { :i [large | small ]& <keyw>  }