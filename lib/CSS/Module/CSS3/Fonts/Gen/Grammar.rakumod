unit grammar CSS::Module::CSS3::Fonts::Gen::Grammar;
#| font: [ [ <‘font-style’> || <font-variant-css21> || <‘font-weight’> || <‘font-stretch’> ]? <‘font-size’> [ / <‘line-height’> ]? <‘font-family’> ] | caption | icon | menu | message-box | small-caption | status-bar
rule decl:sym<font> { :i (font) ":" <val(/<expr=.expr-font> /, &?ROUTINE.WHY)>}
rule expr-font { :i [[[:my @S; <expr-font-style><!{
    @S[0]++
}>| <font-variant-css21><!{
    @S[1]++
}>| <expr-font-weight><!{
    @S[2]++
}>| <expr-font-stretch><!{
    @S[3]++
}>]+] ? <expr-font-size> [<op("/")> <expr-line-height> ] ? <expr-font-family> ] || [caption | icon | menu | "message-box" | "small-caption" | "status-bar" ]& <keyw>   }
#| normal | small-caps
rule font-variant-css21 { :i [normal | "small-caps" ]& <keyw>  }
#| font-family: [ <generic-family> | <family-name> ]#
rule decl:sym<font-family> { :i ("font-family") ":" <val(/<expr=.expr-font-family> /, &?ROUTINE.WHY)>}
rule expr-font-family { :i [<generic-family> || <family-name> ] +% <op(",")> }
#| serif | sans-serif | cursive | fantasy | monospace
rule generic-family { :i [serif | "sans-serif" | cursive | fantasy | monospace ]& <keyw>  }
#| <identifiers> | <string>
rule family-name { :i <identifiers> || <string>  }
#| font-feature-settings: normal | <feature-tag-value>#
rule decl:sym<font-feature-settings> { :i ("font-feature-settings") ":" <val(/<expr=.expr-font-feature-settings> /, &?ROUTINE.WHY)>}
rule expr-font-feature-settings { :i normal & <keyw>  || <feature-tag-value> +% <op(",")>  }
#| font-kerning: auto | normal | none
rule decl:sym<font-kerning> { :i ("font-kerning") ":" <val(/<expr=.expr-font-kerning> /, &?ROUTINE.WHY)>}
rule expr-font-kerning { :i [auto | normal | none ]& <keyw>  }
#| font-language-override: normal | <string>
rule decl:sym<font-language-override> { :i ("font-language-override") ":" <val(/<expr=.expr-font-language-override> /, &?ROUTINE.WHY)>}
rule expr-font-language-override { :i normal & <keyw>  || <string>  }
#| font-size: <absolute-size> | <relative-size> | <length> | <percentage>
rule decl:sym<font-size> { :i ("font-size") ":" <val(/<expr=.expr-font-size> /, &?ROUTINE.WHY)>}
rule expr-font-size { :i <absolute-size> || <relative-size> || <length> || <percentage>  }
#| font-size-adjust: none | auto | <number>
rule decl:sym<font-size-adjust> { :i ("font-size-adjust") ":" <val(/<expr=.expr-font-size-adjust> /, &?ROUTINE.WHY)>}
rule expr-font-size-adjust { :i [none | auto ]& <keyw>  || <number>  }
#| xx-small | x-small | small | medium | large | x-large | xx-large
rule absolute-size { :i ["xx-small" | "x-small" | small | medium | large | "x-large" | "xx-large" ]& <keyw>  }
#| larger | smaller
rule relative-size { :i [larger | smaller ]& <keyw>  }
#| font-stretch: normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded
rule decl:sym<font-stretch> { :i ("font-stretch") ":" <val(/<expr=.expr-font-stretch> /, &?ROUTINE.WHY)>}
rule expr-font-stretch { :i [normal | "ultra-condensed" | "extra-condensed" | condensed | "semi-condensed" | "semi-expanded" | expanded | "extra-expanded" | "ultra-expanded" ]& <keyw>  }
#| font-style: normal | italic | oblique
rule decl:sym<font-style> { :i ("font-style") ":" <val(/<expr=.expr-font-style> /, &?ROUTINE.WHY)>}
rule expr-font-style { :i [normal | italic | oblique ]& <keyw>  }
#| font-synthesis: none | [ weight || style ]
rule decl:sym<font-synthesis> { :i ("font-synthesis") ":" <val(/<expr=.expr-font-synthesis> /, &?ROUTINE.WHY)>}
rule expr-font-synthesis { :i none & <keyw>  || [[:my @S; weight & <keyw> <!{
    @S[0]++
}>| style & <keyw> <!{
    @S[1]++
}>]+]  }
#| font-variant: normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name> #) || character-variant(<feature-value-name> #) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<expr=.expr-font-variant> /, &?ROUTINE.WHY)>}
rule expr-font-variant { :i [normal | none ]& <keyw>  || [[:my @S; <common-lig-values><!{
    @S[0]++
}>| <discretionary-lig-values><!{
    @S[1]++
}>| <historical-lig-values><!{
    @S[2]++
}>| <contextual-alt-values><!{
    @S[3]++
}>| <stylistic><!{
    @S[4]++
}>| "historical-forms" & <keyw> <!{
    @S[5]++
}>| <styleset><!{
    @S[6]++
}>| <character-variant><!{
    @S[7]++
}>| <swash><!{
    @S[8]++
}>| <ornaments><!{
    @S[9]++
}>| <annotation><!{
    @S[10]++
}>| [["small-caps" | "all-small-caps" | "petite-caps" | "all-petite-caps" | unicase | "titling-caps" ]& <keyw> ]<!{
    @S[11]++
}>| <numeric-figure-values><!{
    @S[12]++
}>| <numeric-spacing-values><!{
    @S[13]++
}>| <numeric-fraction-values><!{
    @S[14]++
}>| ordinal & <keyw> <!{
    @S[15]++
}>| "slashed-zero" & <keyw> <!{
    @S[16]++
}>| <east-asian-variant-values><!{
    @S[17]++
}>| <east-asian-width-values><!{
    @S[18]++
}>| ruby & <keyw> <!{
    @S[19]++
}>]+]  }
#| font-variant-alternates: normal | [ stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) ]
rule decl:sym<font-variant-alternates> { :i ("font-variant-alternates") ":" <val(/<expr=.expr-font-variant-alternates> /, &?ROUTINE.WHY)>}
rule expr-font-variant-alternates { :i normal & <keyw>  || [[:my @S; <stylistic><!{
    @S[0]++
}>| "historical-forms" & <keyw> <!{
    @S[1]++
}>| <styleset><!{
    @S[2]++
}>| <character-variant><!{
    @S[3]++
}>| <swash><!{
    @S[4]++
}>| <ornaments><!{
    @S[5]++
}>| <annotation><!{
    @S[6]++
}>]+]  }
#| font-variant-caps: normal | small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps
rule decl:sym<font-variant-caps> { :i ("font-variant-caps") ":" <val(/<expr=.expr-font-variant-caps> /, &?ROUTINE.WHY)>}
rule expr-font-variant-caps { :i [normal | "small-caps" | "all-small-caps" | "petite-caps" | "all-petite-caps" | unicase | "titling-caps" ]& <keyw>  }
#| font-variant-east-asian: normal | [ <east-asian-variant-values> || <east-asian-width-values> || ruby ]
rule decl:sym<font-variant-east-asian> { :i ("font-variant-east-asian") ":" <val(/<expr=.expr-font-variant-east-asian> /, &?ROUTINE.WHY)>}
rule expr-font-variant-east-asian { :i normal & <keyw>  || [[:my @S; <east-asian-variant-values><!{
    @S[0]++
}>| <east-asian-width-values><!{
    @S[1]++
}>| ruby & <keyw> <!{
    @S[2]++
}>]+]  }
#| font-variant-ligatures: normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ]
rule decl:sym<font-variant-ligatures> { :i ("font-variant-ligatures") ":" <val(/<expr=.expr-font-variant-ligatures> /, &?ROUTINE.WHY)>}
rule expr-font-variant-ligatures { :i [normal | none ]& <keyw>  || [[:my @S; <common-lig-values><!{
    @S[0]++
}>| <discretionary-lig-values><!{
    @S[1]++
}>| <historical-lig-values><!{
    @S[2]++
}>| <contextual-alt-values><!{
    @S[3]++
}>]+]  }
#| font-variant-numeric: normal | [ <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero ]
rule decl:sym<font-variant-numeric> { :i ("font-variant-numeric") ":" <val(/<expr=.expr-font-variant-numeric> /, &?ROUTINE.WHY)>}
rule expr-font-variant-numeric { :i normal & <keyw>  || [[:my @S; <numeric-figure-values><!{
    @S[0]++
}>| <numeric-spacing-values><!{
    @S[1]++
}>| <numeric-fraction-values><!{
    @S[2]++
}>| ordinal & <keyw> <!{
    @S[3]++
}>| "slashed-zero" & <keyw> <!{
    @S[4]++
}>]+]  }
#| font-variant-position: normal | sub | super
rule decl:sym<font-variant-position> { :i ("font-variant-position") ":" <val(/<expr=.expr-font-variant-position> /, &?ROUTINE.WHY)>}
rule expr-font-variant-position { :i [normal | sub | super ]& <keyw>  }
#| font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
rule decl:sym<font-weight> { :i ("font-weight") ":" <val(/<expr=.expr-font-weight> /, &?ROUTINE.WHY)>}
rule expr-font-weight { :i [normal | bold | bolder | lighter ]& <keyw>  || [100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ]& <number>  }
#| line-height: normal | <number> | <length> | <percentage>
rule decl:sym<line-height> { :i ("line-height") ":" <val(/<expr=.expr-line-height> /, &?ROUTINE.WHY)>}
rule expr-line-height { :i normal & <keyw>  || <number> || <length> || <percentage>  }