unit grammar CSS::Module::CSS3::Fonts::AtFontFace::Gen::Grammar;
#| font-family: <family-name>
rule decl:sym<font-family> { :i ("font-family") ":" <val(/<expr=.prop-val-font-family> /, &?ROUTINE.WHY)>}
rule prop-val-font-family { :i <family-name> }
#| <family-name> = <identifiers> | <string>
rule family-name { :i <identifiers> || <string>  }
#| font-feature-settings: normal | <feature-tag-value>#
rule decl:sym<font-feature-settings> { :i ("font-feature-settings") ":" <val(/<expr=.prop-val-font-feature-settings> /, &?ROUTINE.WHY)>}
rule prop-val-font-feature-settings { :i normal & <keyw>  || <feature-tag-value> +% <op(",")>  }
#| font-stretch: normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded
rule decl:sym<font-stretch> { :i ("font-stretch") ":" <val(/<expr=.prop-val-font-stretch> /, &?ROUTINE.WHY)>}
rule prop-val-font-stretch { :i [normal | "ultra-condensed" | "extra-condensed" | condensed | "semi-condensed" | "semi-expanded" | expanded | "extra-expanded" | "ultra-expanded" ]& <keyw>  }
#| font-style: normal | italic | oblique
rule decl:sym<font-style> { :i ("font-style") ":" <val(/<expr=.prop-val-font-style> /, &?ROUTINE.WHY)>}
rule prop-val-font-style { :i [normal | italic | oblique ]& <keyw>  }
#| font-variant: normal | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<expr=.prop-val-font-variant> /, &?ROUTINE.WHY)>}
rule prop-val-font-variant { :i normal & <keyw>  || [[<common-lig-values> :my $*A; <!{
    $*A++
}>| <discretionary-lig-values> :my $*B; <!{
    $*B++
}>| <historical-lig-values> :my $*C; <!{
    $*C++
}>| <contextual-alt-values> :my $*D; <!{
    $*D++
}>| <stylistic> :my $*E; <!{
    $*E++
}>| "historical-forms" & <keyw>  :my $*F; <!{
    $*F++
}>| <styleset> :my $*G; <!{
    $*G++
}>| <character-variant> :my $*H; <!{
    $*H++
}>| <swash> :my $*I; <!{
    $*I++
}>| <ornaments> :my $*J; <!{
    $*J++
}>| <annotation> :my $*K; <!{
    $*K++
}>| [["small-caps" | "all-small-caps" | "petite-caps" | "all-petite-caps" | unicase | "titling-caps" ]& <keyw> ] :my $*L; <!{
    $*L++
}>| <numeric-figure-values> :my $*M; <!{
    $*M++
}>| <numeric-spacing-values> :my $*N; <!{
    $*N++
}>| <numeric-fraction-values> :my $*O; <!{
    $*O++
}>| ordinal & <keyw>  :my $*P; <!{
    $*P++
}>| "slashed-zero" & <keyw>  :my $*Q; <!{
    $*Q++
}>| <east-asian-variant-values> :my $*R; <!{
    $*R++
}>| <east-asian-width-values> :my $*S; <!{
    $*S++
}>| ruby & <keyw>  :my $*T; <!{
    $*T++
}>]+]  }
#| font-weight: normal | bold | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
rule decl:sym<font-weight> { :i ("font-weight") ":" <val(/<expr=.prop-val-font-weight> /, &?ROUTINE.WHY)>}
rule prop-val-font-weight { :i [normal | bold ]& <keyw>  || [100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ]& <number>  }
#| src: <font-src-expr>#
rule decl:sym<src> { :i (src) ":" <val(/<expr=.prop-val-src> /, &?ROUTINE.WHY)>}
rule prop-val-src { :i <font-src-expr> +% <op(",")> }
#| <font-src-expr> = [<uri>|local(<string>)] [format(<string>#)]? | <font-face-name>
rule font-src-expr { :i [<uri> || <local> ] <format> ?  || <font-face-name>  }
#| <font-face-name> = <identifiers> | <string>
rule font-face-name { :i <identifiers> || <string>  }
#| unicode-range: <urange>#
rule decl:sym<unicode-range> { :i ("unicode-range") ":" <val(/<expr=.prop-val-unicode-range> /, &?ROUTINE.WHY)>}
rule prop-val-unicode-range { :i <urange> +% <op(",")> }
#| local(<font-face-name>)
rule local { :i "local(" [<font-face-name> || <usage(&?ROUTINE.WHY)> ] ")" }
#| format(<string>#)
rule format { :i "format(" [<string> +% "," || <usage(&?ROUTINE.WHY)> ] ")" }