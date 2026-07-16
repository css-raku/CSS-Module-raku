unit grammar CSS::Snapshot2026::Transforms::Gen::Grammar;
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