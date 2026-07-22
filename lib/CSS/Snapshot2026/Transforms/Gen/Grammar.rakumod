unit grammar CSS::Snapshot2026::Transforms::Gen::Grammar;
#| transform: none | <transform-list>
rule decl:sym<transform> { :i (transform) ":" <val(/<css-val-transform> /, &?ROUTINE.WHY)>}
rule css-val-transform { :i none & <keyw> || <transform-list>  }
#| <transform-list> = <transform-function>+
rule transform-list { :i <transform-function> + }
#| <transform-function> = <matrix()> | <translate()> | <translateX()> | <translateY()> | <scale()> | <scaleX()> | <scaleY()> | <rotate()> | <skew()> | <skewX()> | <skewY()>
rule transform-function { :i <matrix> || <translate> || <translateX> || <translateY> || <scale> || <scaleX> || <scaleY> || <rotate> || <skew> || <skewX> || <skewY>  }
#| matrix( <number>#{6} )
rule matrix { :i "matrix(" [<number> ** 6% ","? || <usage(&?ROUTINE.WHY)> ] ")" }
#| translate( <length-percentage> , <length-percentage>? )
rule translate { :i "translate(" [<length-percentage> ["," <length-percentage> ]?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| translateX( <length-percentage> )
rule translateX { :i "translateX(" [<length-percentage> || <usage(&?ROUTINE.WHY)> ] ")" }
#| translateY( <length-percentage> )
rule translateY { :i "translateY(" [<length-percentage> || <usage(&?ROUTINE.WHY)> ] ")" }
#| scale( <number> , <number>? )
rule scale { :i "scale(" [<number> ["," <number> ]?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| scaleX( <number> )
rule scaleX { :i "scaleX(" [<number> || <usage(&?ROUTINE.WHY)> ] ")" }
#| scaleY( <number> )
rule scaleY { :i "scaleY(" [<number> || <usage(&?ROUTINE.WHY)> ] ")" }
#| rotate( [ <angle> | <zero> ] )
rule rotate { :i "rotate(" [[<angle> || <zero> ] || <usage(&?ROUTINE.WHY)> ] ")" }
#| skew( [ <angle> | <zero> ] , [ <angle> | <zero> ]? )
rule skew { :i "skew(" [[<angle> || <zero> ] ["," [<angle> || <zero> ] ]?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| skewX( [ <angle> | <zero> ] )
rule skewX { :i "skewX(" [[<angle> || <zero> ] || <usage(&?ROUTINE.WHY)> ] ")" }
#| skewY( [ <angle> | <zero> ] )
rule skewY { :i "skewY(" [[<angle> || <zero> ] || <usage(&?ROUTINE.WHY)> ] ")" }
#| transform-box: content-box | border-box | fill-box | stroke-box | view-box
rule decl:sym<transform-box> { :i ("transform-box") ":" <val(/<css-val-transform-box> /, &?ROUTINE.WHY)>}
rule css-val-transform-box { :i ["content-box" | "border-box" | "fill-box" | "stroke-box" | "view-box" ]& <keyw>  }
#| transform-origin: [ left | center | right | top | bottom | <length-percentage> ] |   [ left | center | right | <length-percentage> ]  [ top | center | bottom | <length-percentage> ] <length>? |  [ [ center | left | right ] && [ center | top | bottom ] ] <length>?
rule decl:sym<transform-origin> { :i ("transform-origin") ":" <val(/<css-val-transform-origin> /, &?ROUTINE.WHY)>}
rule css-val-transform-origin { :i [[left | center | right | top | bottom ]& <keyw>  || <length-percentage> ] || [[left | center | right ]& <keyw>  || <length-percentage> ] [[top | center | bottom ]& <keyw>  || <length-percentage> ] <length> ?  || [[[[center | left | right ]& <keyw> ] :my $*A;<!{
    $*A++
}>|| [[center | top | bottom ]& <keyw> ] :my $*B;<!{
    $*B++
}>]** 2] <length> ?   }
#| backface-visibility: visible | hidden
rule decl:sym<backface-visibility> { :i ("backface-visibility") ":" <val(/<css-val-backface-visibility> /, &?ROUTINE.WHY)>}
rule css-val-backface-visibility { :i [visible | hidden ]& <keyw>  }
#| perspective: none | <length [0,∞]>
rule decl:sym<perspective> { :i (perspective) ":" <val(/<css-val-perspective> /, &?ROUTINE.WHY)>}
rule css-val-perspective { :i none & <keyw> || <length>  }
#| perspective-origin: <position>
rule decl:sym<perspective-origin> { :i ("perspective-origin") ":" <val(/<css-val-perspective-origin> /, &?ROUTINE.WHY)>}
rule css-val-perspective-origin { :i <position> }
#| rotate: none | <angle> | [ x | y | z | <number>{3} ] && <angle>
rule decl:sym<rotate> { :i (rotate) ":" <val(/<css-val-rotate> /, &?ROUTINE.WHY)>}
rule css-val-rotate { :i none & <keyw> || <angle> || [[[x | y | z ]& <keyw>  || <number> ** 3 ] :my $*A;<!{
    $*A++
}>|| <angle> :my $*B;<!{
    $*B++
}>]** 2  }
#| scale: none | [ <number> | <percentage> ]{1,3}
rule decl:sym<scale> { :i (scale) ":" <val(/<css-val-scale> /, &?ROUTINE.WHY)>}
rule css-val-scale { :i none & <keyw> || [<number> || <percentage> ] ** 1..3  }
#| transform-style: flat | preserve-3d
rule decl:sym<transform-style> { :i ("transform-style") ":" <val(/<css-val-transform-style> /, &?ROUTINE.WHY)>}
rule css-val-transform-style { :i [flat | "preserve-3d" ]& <keyw>  }
#| translate: none | <length-percentage> [ <length-percentage> <length>? ]?
rule decl:sym<translate> { :i (translate) ":" <val(/<css-val-translate> /, &?ROUTINE.WHY)>}
rule css-val-translate { :i none & <keyw> || <length-percentage> [<length-percentage> <length> ? ] ?   }