unit grammar CSS::Module::CSS4::Images::Gen::Grammar;
#| <image> = <url> | <gradient>
rule image { :i <url> || <gradient>  }
#| <radial-size> = <radial-extent> | <length [0,∞]> | <length-percentage [0,∞]>{2}
rule radial-size { :i <radial-extent> || <length> || <length-percentage> ** 2  }
#| <radial-extent> = closest-corner | closest-side | farthest-corner | farthest-side
rule radial-extent { :i ["closest-corner" | "closest-side" | "farthest-corner" | "farthest-side" ]& <keyw>  }
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