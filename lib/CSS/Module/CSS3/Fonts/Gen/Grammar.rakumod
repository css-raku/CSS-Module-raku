unit grammar CSS::Module::CSS3::Fonts::Gen::Grammar;
#| font: [ [ <‘font-style’> || <font-variant-css21> || <‘font-weight’> || <‘font-stretch’> ]? <‘font-size’> [ / <‘line-height’> ]? <‘font-family’> ] | caption | icon | menu | message-box | small-caption | status-bar
rule decl:sym<font> { :i (font) ":" <val(/<expr=.expr-font> /, &?ROUTINE.WHY)>}
rule expr-font { :i [[[<expr-font-style>:my $a; <!{
    $a++
}>| <font-variant-css21>:my $b; <!{
    $b++
}>| <expr-font-weight>:my $c; <!{
    $c++
}>| <expr-font-stretch>:my $d; <!{
    $d++
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
rule expr-font-synthesis { :i none & <keyw>  || [[weight & <keyw> :my $a; <!{
    $a++
}>| style & <keyw> :my $b; <!{
    $b++
}>]+]  }
#| font-variant: normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name> #) || character-variant(<feature-value-name> #) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<expr=.expr-font-variant> /, &?ROUTINE.WHY)>}
rule expr-font-variant { :i [normal | none ]& <keyw>  || [[<common-lig-values>:my $a; <!{
    $a++
}>| <discretionary-lig-values>:my $b; <!{
    $b++
}>| <historical-lig-values>:my $c; <!{
    $c++
}>| <contextual-alt-values>:my $d; <!{
    $d++
}>| <stylistic>:my $e; <!{
    $e++
}>| "historical-forms" & <keyw> :my $f; <!{
    $f++
}>| <styleset>:my $g; <!{
    $g++
}>| <character-variant>:my $h; <!{
    $h++
}>| <swash>:my $i; <!{
    $i++
}>| <ornaments>:my $j; <!{
    $j++
}>| <annotation>:my $k; <!{
    $k++
}>| [["small-caps" | "all-small-caps" | "petite-caps" | "all-petite-caps" | unicase | "titling-caps" ]& <keyw> ]:my $l; <!{
    $l++
}>| <numeric-figure-values>:my $m; <!{
    $m++
}>| <numeric-spacing-values>:my $n; <!{
    $n++
}>| <numeric-fraction-values>:my $o; <!{
    $o++
}>| ordinal & <keyw> :my $p; <!{
    $p++
}>| "slashed-zero" & <keyw> :my $q; <!{
    $q++
}>| <east-asian-variant-values>:my $r; <!{
    $r++
}>| <east-asian-width-values>:my $s; <!{
    $s++
}>| ruby & <keyw> :my $t; <!{
    $t++
}>]+]  }
#| font-variant-alternates: normal | [ stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) ]
rule decl:sym<font-variant-alternates> { :i ("font-variant-alternates") ":" <val(/<expr=.expr-font-variant-alternates> /, &?ROUTINE.WHY)>}
rule expr-font-variant-alternates { :i normal & <keyw>  || [[<stylistic>:my $a; <!{
    $a++
}>| "historical-forms" & <keyw> :my $b; <!{
    $b++
}>| <styleset>:my $c; <!{
    $c++
}>| <character-variant>:my $d; <!{
    $d++
}>| <swash>:my $e; <!{
    $e++
}>| <ornaments>:my $f; <!{
    $f++
}>| <annotation>:my $g; <!{
    $g++
}>]+]  }
#| font-variant-caps: normal | small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps
rule decl:sym<font-variant-caps> { :i ("font-variant-caps") ":" <val(/<expr=.expr-font-variant-caps> /, &?ROUTINE.WHY)>}
rule expr-font-variant-caps { :i [normal | "small-caps" | "all-small-caps" | "petite-caps" | "all-petite-caps" | unicase | "titling-caps" ]& <keyw>  }
#| font-variant-east-asian: normal | [ <east-asian-variant-values> || <east-asian-width-values> || ruby ]
rule decl:sym<font-variant-east-asian> { :i ("font-variant-east-asian") ":" <val(/<expr=.expr-font-variant-east-asian> /, &?ROUTINE.WHY)>}
rule expr-font-variant-east-asian { :i normal & <keyw>  || [[<east-asian-variant-values>:my $a; <!{
    $a++
}>| <east-asian-width-values>:my $b; <!{
    $b++
}>| ruby & <keyw> :my $c; <!{
    $c++
}>]+]  }
#| font-variant-ligatures: normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ]
rule decl:sym<font-variant-ligatures> { :i ("font-variant-ligatures") ":" <val(/<expr=.expr-font-variant-ligatures> /, &?ROUTINE.WHY)>}
rule expr-font-variant-ligatures { :i [normal | none ]& <keyw>  || [[<common-lig-values>:my $a; <!{
    $a++
}>| <discretionary-lig-values>:my $b; <!{
    $b++
}>| <historical-lig-values>:my $c; <!{
    $c++
}>| <contextual-alt-values>:my $d; <!{
    $d++
}>]+]  }
#| font-variant-numeric: normal | [ <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero ]
rule decl:sym<font-variant-numeric> { :i ("font-variant-numeric") ":" <val(/<expr=.expr-font-variant-numeric> /, &?ROUTINE.WHY)>}
rule expr-font-variant-numeric { :i normal & <keyw>  || [[<numeric-figure-values>:my $a; <!{
    $a++
}>| <numeric-spacing-values>:my $b; <!{
    $b++
}>| <numeric-fraction-values>:my $c; <!{
    $c++
}>| ordinal & <keyw> :my $d; <!{
    $d++
}>| "slashed-zero" & <keyw> :my $e; <!{
    $e++
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