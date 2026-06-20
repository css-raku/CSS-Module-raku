unit grammar CSS::Module::CSS4::Shapes::Gen::Grammar;
#| shape-image-threshold: <opacity-value>
rule decl:sym<shape-image-threshold> { :i ("shape-image-threshold") ":" <val(/<css-val-shape-image-threshold> /, &?ROUTINE.WHY)>}
rule css-val-shape-image-threshold { :i <opacity-value> }
#| shape-margin: <length-percentage [0,∞]>
rule decl:sym<shape-margin> { :i ("shape-margin") ":" <val(/<css-val-shape-margin> /, &?ROUTINE.WHY)>}
rule css-val-shape-margin { :i <length-percentage> }
#| shape-outside: none | [ <basic-shape> || <shape-box> ] | <image>
rule decl:sym<shape-outside> { :i ("shape-outside") ":" <val(/<css-val-shape-outside> /, &?ROUTINE.WHY)>}
rule css-val-shape-outside { :i none & <keyw> || [[<basic-shape> :my $*A; <!{
    $*A++
}>|| <shape-box> :my $*B; <!{
    $*B++
}>]+] || <image>  }