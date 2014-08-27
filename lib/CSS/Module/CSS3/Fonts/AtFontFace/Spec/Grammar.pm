use v6;
#  -- DO NOT EDIT --
# generated by: css-gen-properties.pl --grammar=CSS::Module::CSS3::Fonts::AtFontFace::Spec::Grammar --proforma etc/css3x-font-@fontface-properties.txt

grammar CSS::Module::CSS3::Fonts::AtFontFace::Spec::Grammar {

    #| font-family: <family-name>
    rule decl:sym<font-family> {:i (font\-family) ':'  [ <proforma> || <expr=.expr-font-family> || <any-args> ] }
    rule expr-font-family {:i <family-name> }

    #| font-feature-settings: normal | <feature-tag-value>#
    rule decl:sym<font-feature-settings> {:i (font\-feature\-settings) ':'  [ <proforma> || <expr=.expr-font-feature-settings> || <any-args> ] }
    rule expr-font-feature-settings {:i [ normal & <keyw> | <feature-tag-value> +% ',' ] }

    #| font-stretch: normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded
    rule decl:sym<font-stretch> {:i (font\-stretch) ':'  [ <proforma> || <expr=.expr-font-stretch> || <any-args> ] }
    rule expr-font-stretch {:i [ normal | ultra\-condensed | extra\-condensed | condensed | semi\-condensed | semi\-expanded | expanded | extra\-expanded | ultra\-expanded ] & <keyw> }

    #| font-style: normal | italic | oblique
    rule decl:sym<font-style> {:i (font\-style) ':'  [ <proforma> || <expr=.expr-font-style> || <any-args> ] }
    rule expr-font-style {:i [ normal | italic | oblique ] & <keyw> }

    #| font-variant: normal | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]
    rule decl:sym<font-variant> {:i (font\-variant) ':'  [ <proforma> || <expr=.expr-font-variant> || <any-args> ] }
    rule expr-font-variant {:i [ normal & <keyw> | [ [:my @*SEEN; <common-lig-values> <!seen(0)> | <discretionary-lig-values> <!seen(1)> | <historical-lig-values> <!seen(2)> | <contextual-alt-values> <!seen(3)> | <stylistic> <!seen(4)> | historical\-forms & <keyw> <!seen(5)> | <styleset> <!seen(6)> | <character-variant> <!seen(7)> | <swash> <!seen(8)> | <ornaments> <!seen(9)> | <annotation> <!seen(10)> | [ [ small\-caps | all\-small\-caps | petite\-caps | all\-petite\-caps | unicase | titling\-caps ] & <keyw> ] <!seen(11)> | <numeric-figure-values> <!seen(12)> | <numeric-spacing-values> <!seen(13)> | <numeric-fraction-values> <!seen(14)> | ordinal & <keyw> <!seen(15)> | slashed\-zero & <keyw> <!seen(16)> | <east-asian-variant-values> <!seen(17)> | <east-asian-width-values> <!seen(18)> | ruby & <keyw> <!seen(19)> ]+ ] ] }

    #| font-weight: normal | bold | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    rule decl:sym<font-weight> {:i (font\-weight) ':'  [ <proforma> || <expr=.expr-font-weight> || <any-args> ] }
    rule expr-font-weight {:i [ [ normal | bold ] & <keyw> | [ 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ] & <number> ] }

    #| src: [ [<uri>|local(<string>)] [format(<string>#)]? | <font-face-name> ]#
    rule decl:sym<src> {:i (src) ':'  [ <proforma> || <expr=.expr-src> || <any-args> ] }
    rule expr-src {:i [ [ [ [ <uri> | <local> ] ] [ <format> ]? | <font-face-name> ] ] +% ',' }

    #| unicode-range: <urange>#
    rule decl:sym<unicode-range> {:i (unicode\-range) ':'  [ <proforma> || <expr=.expr-unicode-range> || <any-args> ] }
    rule expr-unicode-range {:i <urange> +% ',' }
}
