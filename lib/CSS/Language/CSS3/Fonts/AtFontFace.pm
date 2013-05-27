use v6;

grammar CSS::Language::CSS3::Fonts::AtFontFace {...}

use CSS::Language::CSS3::Fonts::Variants;
use CSS::Language::CSS3::_Base;

grammar CSS::Language::CSS3::Fonts::AtFontFace
    is CSS::Language::CSS3::Fonts::Variants
    is CSS::Language::CSS3::_Base {

    # @font-face declarations

    # ---- Functions ----
    rule format {:i'format(' [ <format=.string> | <format=.keyw> || <any-args> ] ')'}
    rule local  {:i'local(' [ <font-face-name=.identifiers> | <font-face-name=.string> || <any-args> ] ')'}

    # ---- Properties ----
    # Initial generation:
    # % etc/gen-properties.pl gen grammar etc/css3x-font-@fontface-properties.txt
    # - font-family: <family-name>
    rule decl:sym<font-family> {:i (font\-family) ':'  <val(rx:i:s[ <proforma> || <family-name=.identifiers> | <family-name=.string> ])> }

    # - font-feature-settings: normal | <feature-tag-value>#
    rule decl:sym<font-feature-settings> {:i (font\-feature\-settings) ':'  <val(rx:i:s[ normal & <keyw> | [ <feature-tag-value> [ ',' <feature-tag-value> ]* ] ])> }

    # - font-stretch: normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded
    rule decl:sym<font-stretch> {:i (font\-stretch) ':'  <val(rx:i:s[ [ normal | ultra\-condensed | extra\-condensed | condensed | semi\-condensed | semi\-expanded | expanded | extra\-expanded | ultra\-expanded ] & <keyw> ])> }

    # - font-style: normal | italic | oblique
    rule decl:sym<font-style> {:i (font\-style) ':'  <val(rx:i:s[ [ normal | italic | oblique ] & <keyw> || <misc> ])> }

    # - font-variant: normal | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]
    rule decl:sym<font-variant> {:i (font\-variant) ':'  <val(rx:i:s[ [ normal & <keyw> | [ [ <common-lig-values> | <discretionary-lig-values> | <historical-lig-values> | <contextual-alt-values> | <stylistic> | historical\-forms & <keyw> | <styleset> | <character-variant> | <swash> | <ornaments> | <annotation> | [ [ small\-caps | all\-small\-caps | petite\-caps | all\-petite\-caps | unicase | titling\-caps ] & <keyw> ] | <numeric-figure-values> | <numeric-spacing-values> | <numeric-fraction-values> | ordinal & <keyw> | slashed\-zero & <keyw> | <east-asian-variant-values> | <east-asian-width-values> | ruby & <keyw> ] ','? ]**1..20 ] ])> }

    # - font-weight: normal | bold | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    rule decl:sym<font-weight> {:i (font\-weight) ':'  <val(rx:i:s[ [ normal | bold ] & <keyw> | [ 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ] & <number> ])> }

    # - src: [ <uri> [format(<string>#)]? | <font-face-name> ]#
    token src { <uri> <format>? | <local> <format>? | <font-face-name=.identifiers> }
    rule decl:sym<src> {:i (src) ':' <val(rx:i:s[ <src> +% [ ',' ] ])> }

    # - unicode-range: <urange>#
    rule decl:sym<unicode-range> {:i (unicode\-range) ':' <val(rx:i:s[ <urange> +% ',' ])> }

}
