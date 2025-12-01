unit grammar CSS::Module::CSS3::Fonts::Gen::Grammar;
#| font: [ [ <‘font-style’> || <font-variant-css21> || <‘font-weight’> || <‘font-stretch’> ]? <‘font-size’> [ / <‘line-height’> ]? <‘font-family’># ] | caption | icon | menu | message-box | small-caption | status-bar
rule decl:sym<font> { :i (font) ":" <val(/<css-val-font> /, &?ROUTINE.WHY)>}
rule css-val-font { :i [[[<css-val-font-style> :my $*A; <!{
    $*A++
}>|| <font-variant-css21> :my $*B; <!{
    $*B++
}>|| <css-val-font-weight> :my $*C; <!{
    $*C++
}>|| <css-val-font-stretch> :my $*D; <!{
    $*D++
}>]+] ? <css-val-font-size> [<op("/")> <css-val-line-height> ] ? <css-val-font-family> +% <op(",")> ] || [caption | icon | menu | "message-box" | "small-caption" | "status-bar" ]& <keyw>   }
#| <font-variant-css21> = normal | small-caps
rule font-variant-css21 { :i [normal | "small-caps" ]& <keyw>  }
#| font-family: [ <generic-family> | <family-name> ]#
rule decl:sym<font-family> { :i ("font-family") ":" <val(/<css-val-font-family> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-font-family { :i [<generic-family> || <family-name> ] }
#| <generic-family> = serif | sans-serif | cursive | fantasy | monospace
rule generic-family { :i [serif | "sans-serif" | cursive | fantasy | monospace ]& <keyw>  }
#| <family-name> = <identifiers> | <string>
rule family-name { :i <identifiers> || <string>  }
#| font-feature-settings: normal | <feature-tag-value>#
rule decl:sym<font-feature-settings> { :i ("font-feature-settings") ":" <val(/<css-val-font-feature-settings> /, &?ROUTINE.WHY)>}
rule css-val-font-feature-settings { :i normal & <keyw> || <feature-tag-value> +% <op(",")>  }
#| font-kerning: auto | normal | none
rule decl:sym<font-kerning> { :i ("font-kerning") ":" <val(/<css-val-font-kerning> /, &?ROUTINE.WHY)>}
rule css-val-font-kerning { :i [auto | normal | none ]& <keyw>  }
#| font-language-override: normal | <string>
rule decl:sym<font-language-override> { :i ("font-language-override") ":" <val(/<css-val-font-language-override> /, &?ROUTINE.WHY)>}
rule css-val-font-language-override { :i normal & <keyw> || <string>  }
#| font-size: <absolute-size> | <relative-size> | <length> | <percentage>
rule decl:sym<font-size> { :i ("font-size") ":" <val(/<css-val-font-size> /, &?ROUTINE.WHY)>}
rule css-val-font-size { :i <absolute-size> || <relative-size> || <length> || <percentage>  }
#| font-size-adjust: none | auto | <number>
rule decl:sym<font-size-adjust> { :i ("font-size-adjust") ":" <val(/<css-val-font-size-adjust> /, &?ROUTINE.WHY)>}
rule css-val-font-size-adjust { :i [none | auto ]& <keyw>  || <number>  }
#| <absolute-size> = xx-small | x-small | small | medium | large | x-large | xx-large
rule absolute-size { :i ["xx-small" | "x-small" | small | medium | large | "x-large" | "xx-large" ]& <keyw>  }
#| <relative-size> = larger | smaller
rule relative-size { :i [larger | smaller ]& <keyw>  }
#| font-stretch: normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded
rule decl:sym<font-stretch> { :i ("font-stretch") ":" <val(/<css-val-font-stretch> /, &?ROUTINE.WHY)>}
rule css-val-font-stretch { :i [normal | "ultra-condensed" | "extra-condensed" | condensed | "semi-condensed" | "semi-expanded" | expanded | "extra-expanded" | "ultra-expanded" ]& <keyw>  }
#| font-style: normal | italic | oblique
rule decl:sym<font-style> { :i ("font-style") ":" <val(/<css-val-font-style> /, &?ROUTINE.WHY)>}
rule css-val-font-style { :i [normal | italic | oblique ]& <keyw>  }
#| font-synthesis: none | [ weight || style ]
rule decl:sym<font-synthesis> { :i ("font-synthesis") ":" <val(/<css-val-font-synthesis> /, &?ROUTINE.WHY)>}
rule css-val-font-synthesis { :i none & <keyw> || [[weight & <keyw> :my $*A; <!{
    $*A++
}>|| style & <keyw> :my $*B; <!{
    $*B++
}>]+]  }
#| font-variant: normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name> #) || character-variant(<feature-value-name> #) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<css-val-font-variant> /, &?ROUTINE.WHY)>}
rule css-val-font-variant { :i [normal | none ]& <keyw>  || [[<common-lig-values> :my $*A; <!{
    $*A++
}>|| <discretionary-lig-values> :my $*B; <!{
    $*B++
}>|| <historical-lig-values> :my $*C; <!{
    $*C++
}>|| <contextual-alt-values> :my $*D; <!{
    $*D++
}>|| <stylistic> :my $*E; <!{
    $*E++
}>|| "historical-forms" & <keyw> :my $*F; <!{
    $*F++
}>|| <styleset> :my $*G; <!{
    $*G++
}>|| <character-variant> :my $*H; <!{
    $*H++
}>|| <swash> :my $*I; <!{
    $*I++
}>|| <ornaments> :my $*J; <!{
    $*J++
}>|| <annotation> :my $*K; <!{
    $*K++
}>|| [["small-caps" | "all-small-caps" | "petite-caps" | "all-petite-caps" | unicase | "titling-caps" ]& <keyw> ] :my $*L; <!{
    $*L++
}>|| <numeric-figure-values> :my $*M; <!{
    $*M++
}>|| <numeric-spacing-values> :my $*N; <!{
    $*N++
}>|| <numeric-fraction-values> :my $*O; <!{
    $*O++
}>|| ordinal & <keyw> :my $*P; <!{
    $*P++
}>|| "slashed-zero" & <keyw> :my $*Q; <!{
    $*Q++
}>|| <east-asian-variant-values> :my $*R; <!{
    $*R++
}>|| <east-asian-width-values> :my $*S; <!{
    $*S++
}>|| ruby & <keyw> :my $*T; <!{
    $*T++
}>]+]  }
#| font-variant-alternates: normal | [ stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) ]
rule decl:sym<font-variant-alternates> { :i ("font-variant-alternates") ":" <val(/<css-val-font-variant-alternates> /, &?ROUTINE.WHY)>}
rule css-val-font-variant-alternates { :i normal & <keyw> || [[<stylistic> :my $*A; <!{
    $*A++
}>|| "historical-forms" & <keyw> :my $*B; <!{
    $*B++
}>|| <styleset> :my $*C; <!{
    $*C++
}>|| <character-variant> :my $*D; <!{
    $*D++
}>|| <swash> :my $*E; <!{
    $*E++
}>|| <ornaments> :my $*F; <!{
    $*F++
}>|| <annotation> :my $*G; <!{
    $*G++
}>]+]  }
#| font-variant-caps: normal | small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps
rule decl:sym<font-variant-caps> { :i ("font-variant-caps") ":" <val(/<css-val-font-variant-caps> /, &?ROUTINE.WHY)>}
rule css-val-font-variant-caps { :i [normal | "small-caps" | "all-small-caps" | "petite-caps" | "all-petite-caps" | unicase | "titling-caps" ]& <keyw>  }
#| font-variant-east-asian: normal | [ <east-asian-variant-values> || <east-asian-width-values> || ruby ]
rule decl:sym<font-variant-east-asian> { :i ("font-variant-east-asian") ":" <val(/<css-val-font-variant-east-asian> /, &?ROUTINE.WHY)>}
rule css-val-font-variant-east-asian { :i normal & <keyw> || [[<east-asian-variant-values> :my $*A; <!{
    $*A++
}>|| <east-asian-width-values> :my $*B; <!{
    $*B++
}>|| ruby & <keyw> :my $*C; <!{
    $*C++
}>]+]  }
#| font-variant-ligatures: normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ]
rule decl:sym<font-variant-ligatures> { :i ("font-variant-ligatures") ":" <val(/<css-val-font-variant-ligatures> /, &?ROUTINE.WHY)>}
rule css-val-font-variant-ligatures { :i [normal | none ]& <keyw>  || [[<common-lig-values> :my $*A; <!{
    $*A++
}>|| <discretionary-lig-values> :my $*B; <!{
    $*B++
}>|| <historical-lig-values> :my $*C; <!{
    $*C++
}>|| <contextual-alt-values> :my $*D; <!{
    $*D++
}>]+]  }
#| font-variant-numeric: normal | [ <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero ]
rule decl:sym<font-variant-numeric> { :i ("font-variant-numeric") ":" <val(/<css-val-font-variant-numeric> /, &?ROUTINE.WHY)>}
rule css-val-font-variant-numeric { :i normal & <keyw> || [[<numeric-figure-values> :my $*A; <!{
    $*A++
}>|| <numeric-spacing-values> :my $*B; <!{
    $*B++
}>|| <numeric-fraction-values> :my $*C; <!{
    $*C++
}>|| ordinal & <keyw> :my $*D; <!{
    $*D++
}>|| "slashed-zero" & <keyw> :my $*E; <!{
    $*E++
}>]+]  }
#| font-variant-position: normal | sub | super
rule decl:sym<font-variant-position> { :i ("font-variant-position") ":" <val(/<css-val-font-variant-position> /, &?ROUTINE.WHY)>}
rule css-val-font-variant-position { :i [normal | sub | super ]& <keyw>  }
#| font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
rule decl:sym<font-weight> { :i ("font-weight") ":" <val(/<css-val-font-weight> /, &?ROUTINE.WHY)>}
rule css-val-font-weight { :i [normal | bold | bolder | lighter ]& <keyw>  || [100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ]& <number>  }
#| line-height: normal | <number> | <length> | <percentage>
rule decl:sym<line-height> { :i ("line-height") ":" <val(/<css-val-line-height> /, &?ROUTINE.WHY)>}
rule css-val-line-height { :i normal & <keyw> || <number> || <length> || <percentage>  }