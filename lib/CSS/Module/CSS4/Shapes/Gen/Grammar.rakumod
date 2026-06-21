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