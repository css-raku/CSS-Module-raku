unit grammar CSS::Module::CSS4::Masking::Gen::Grammar;
#| clip: <rect()> | auto
rule decl:sym<clip> { :i (clip) ":" <val(/<css-val-clip> /, &?ROUTINE.WHY)>}
rule css-val-clip { :i <rect> || auto & <keyw>  }
#| clip-path: <clip-source> | [ <basic-shape> || <geometry-box> ] | none
rule decl:sym<clip-path> { :i ("clip-path") ":" <val(/<css-val-clip-path> /, &?ROUTINE.WHY)>}
rule css-val-clip-path { :i <clip-source> || [[<basic-shape> :my $*A;<!{
    $*A++
}>|| <geometry-box> :my $*B;<!{
    $*B++
}>]+] || none & <keyw>  }
#| clip-rule: nonzero | evenodd
rule decl:sym<clip-rule> { :i ("clip-rule") ":" <val(/<css-val-clip-rule> /, &?ROUTINE.WHY)>}
rule css-val-clip-rule { :i [nonzero | evenodd ]& <keyw>  }
#| mask: <mask-layer>#
rule decl:sym<mask> { :i (mask) ":" <val(/<css-val-mask> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-mask { :i <mask-layer> }
#| mask-border: <'mask-border-source'> || <'mask-border-slice'> [ / <'mask-border-width'>? [ / <'mask-border-outset'> ]? ]? || <'mask-border-repeat'> || <'mask-border-mode'>
rule decl:sym<mask-border> { :i ("mask-border") ":" <val(/<css-val-mask-border> /, &?ROUTINE.WHY)>}
rule css-val-mask-border { :i [<css-val-mask-border-source> :my $*A;<!{
    $*A++
}>|| <css-val-mask-border-slice> [<op("/")> <css-val-mask-border-width> ? [<op("/")> <css-val-mask-border-outset> ] ? ] ?  :my $*B;<!{
    $*B++
}>|| <css-val-mask-border-repeat> :my $*C;<!{
    $*C++
}>|| <css-val-mask-border-mode> :my $*D;<!{
    $*D++
}>]+ }
#| mask-border-mode: luminance | alpha
rule decl:sym<mask-border-mode> { :i ("mask-border-mode") ":" <val(/<css-val-mask-border-mode> /, &?ROUTINE.WHY)>}
rule css-val-mask-border-mode { :i [luminance | alpha ]& <keyw>  }
#| mask-border-outset: <'border-image-outset'>
rule decl:sym<mask-border-outset> { :i ("mask-border-outset") ":" <val(/<css-val-mask-border-outset> /, &?ROUTINE.WHY)>}
rule css-val-mask-border-outset { :i <css-val-border-image-outset> }
#| mask-border-repeat: <'border-image-repeat'>
rule decl:sym<mask-border-repeat> { :i ("mask-border-repeat") ":" <val(/<css-val-mask-border-repeat> /, &?ROUTINE.WHY)>}
rule css-val-mask-border-repeat { :i <css-val-border-image-repeat> }
#| mask-border-slice: <'border-image-slice'>
rule decl:sym<mask-border-slice> { :i ("mask-border-slice") ":" <val(/<css-val-mask-border-slice> /, &?ROUTINE.WHY)>}
rule css-val-mask-border-slice { :i <css-val-border-image-slice> }
#| mask-border-source: <'border-image-source'>
rule decl:sym<mask-border-source> { :i ("mask-border-source") ":" <val(/<css-val-mask-border-source> /, &?ROUTINE.WHY)>}
rule css-val-mask-border-source { :i <css-val-border-image-source> }
#| mask-border-width: <'border-image-width'>
rule decl:sym<mask-border-width> { :i ("mask-border-width") ":" <val(/<css-val-mask-border-width> /, &?ROUTINE.WHY)>}
rule css-val-mask-border-width { :i <css-val-border-image-width> }
#| mask-clip: [ <coord-box> | no-clip ]#
rule decl:sym<mask-clip> { :i ("mask-clip") ":" <val(/<css-val-mask-clip> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-mask-clip { :i [<coord-box> || "no-clip" & <keyw> ] }
#| mask-composite: <compositing-operator>#
rule decl:sym<mask-composite> { :i ("mask-composite") ":" <val(/<css-val-mask-composite> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-mask-composite { :i <compositing-operator> }
#| mask-image: <mask-reference>#
rule decl:sym<mask-image> { :i ("mask-image") ":" <val(/<css-val-mask-image> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-mask-image { :i <mask-reference> }
#| mask-mode: <masking-mode>#
rule decl:sym<mask-mode> { :i ("mask-mode") ":" <val(/<css-val-mask-mode> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-mask-mode { :i <masking-mode> }
#| mask-origin: <coord-box>#
rule decl:sym<mask-origin> { :i ("mask-origin") ":" <val(/<css-val-mask-origin> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-mask-origin { :i <coord-box> }
#| mask-position: <position>#
rule decl:sym<mask-position> { :i ("mask-position") ":" <val(/<css-val-mask-position> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-mask-position { :i <position> }
#| mask-repeat: <repeat-style>#
rule decl:sym<mask-repeat> { :i ("mask-repeat") ":" <val(/<css-val-mask-repeat> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-mask-repeat { :i <repeat-style> }
#| mask-size: <bg-size>#
rule decl:sym<mask-size> { :i ("mask-size") ":" <val(/<css-val-mask-size> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-mask-size { :i <bg-size> }
#| mask-type: luminance | alpha
rule decl:sym<mask-type> { :i ("mask-type") ":" <val(/<css-val-mask-type> /, &?ROUTINE.WHY)>}
rule css-val-mask-type { :i [luminance | alpha ]& <keyw>  }