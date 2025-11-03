unit grammar CSS::Module::CSS3::Fonts::AtFontFace::Gen::Grammar;
#| font-family: <family-name>
rule decl:sym<font-family> { :i ("font-family") ":" <val(/<expr=.expr-font-family> /, &?ROUTINE.WHY)>}
rule expr-font-family { :i <family-name> }
#| <identifiers> | <string>
rule family-name { :i <identifiers> || <string>  }
#| font-feature-settings: normal | <feature-tag-value>#
rule decl:sym<font-feature-settings> { :i ("font-feature-settings") ":" <val(/<expr=.expr-font-feature-settings> /, &?ROUTINE.WHY)>}
rule expr-font-feature-settings { :i normal & <keyw>  || <feature-tag-value> +% <op(",")>  }
#| font-stretch: normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded
rule decl:sym<font-stretch> { :i ("font-stretch") ":" <val(/<expr=.expr-font-stretch> /, &?ROUTINE.WHY)>}
rule expr-font-stretch { :i [normal | "ultra-condensed" | "extra-condensed" | condensed | "semi-condensed" | "semi-expanded" | expanded | "extra-expanded" | "ultra-expanded" ]& <keyw>  }
#| font-style: normal | italic | oblique
rule decl:sym<font-style> { :i ("font-style") ":" <val(/<expr=.expr-font-style> /, &?ROUTINE.WHY)>}
rule expr-font-style { :i [normal | italic | oblique ]& <keyw>  }
#| font-variant: normal | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<expr=.expr-font-variant> /, &?ROUTINE.WHY)>}
rule expr-font-variant { :i normal & <keyw>  || [[<common-lig-values>:my $a; <!{
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
#| font-weight: normal | bold | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
rule decl:sym<font-weight> { :i ("font-weight") ":" <val(/<expr=.expr-font-weight> /, &?ROUTINE.WHY)>}
rule expr-font-weight { :i [normal | bold ]& <keyw>  || [100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ]& <number>  }
#| src: <font-src-expr>#
rule decl:sym<src> { :i (src) ":" <val(/<expr=.expr-src> /, &?ROUTINE.WHY)>}
rule expr-src { :i <font-src-expr> +% <op(",")> }
#| [<uri>|local(<string>)] [format(<string>#)]? | <font-face-name>
rule font-src-expr { :i [<uri> || <local> ] <format> ?  || <font-face-name>  }
#| <identifiers> | <string>
rule font-face-name { :i <identifiers> || <string>  }
#| unicode-range: <urange>#
rule decl:sym<unicode-range> { :i ("unicode-range") ":" <val(/<expr=.expr-unicode-range> /, &?ROUTINE.WHY)>}
rule expr-unicode-range { :i <urange> +% <op(",")> }