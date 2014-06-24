use v6;

# CSS3 Font Extension Module
# specification: http://www.w3.org/TR/2013/WD-css3-fonts-20130212/
#
# nb this standard is under revision (as of Feb 2013). Biggest change
# is the proposed at-rule @font-feature-values

use CSS::Language::CSS3::Fonts::AtFontFace;
use CSS::Language::CSS3::Fonts::Variants;
use CSS::Language::CSS3::_Base;
use CSS::Language::CSS3::Fonts::Spec::Interface;
use CSS::Language::CSS3::Fonts::AtFontFace::Spec::Interface;

grammar CSS::Language::CSS3::Fonts::Syntax {
    rule font-description {<declarations=.CSS::Language::CSS3::Fonts::AtFontFace::declarations>}
    rule at-rule:sym<font-face> {(:i'font-face') <font-description> }
}

grammar CSS::Language::CSS3::Fonts:ver<20130212.000> 
    is CSS::Language::CSS3::Fonts::Syntax
    is CSS::Language::CSS3::Fonts::Variants
    is CSS::Language::CSS3::_Base
    does CSS::Language::CSS3::Fonts::Spec::Interface {

    # ---- Properties ----
    # Initial generation:
    # % etc/gen-properties.pl gen grammar etc/css3x-font-properties.txt
    # - font: [ [ <‘font-style’> || <font-variant-css21> || <‘font-weight’> || <‘font-stretch’> ]? <‘font-size’> [ / <‘line-height’> ]? <‘font-family’> ] | caption | icon | menu | message-box | small-caption | status-bar
    rule font-variant-css21 {:i [ normal | small\-caps ] & <keyw> }
    rule  decl:sym<font> {:i (font) ':'
                               <val(rx:i:s[:my @*SEEN; [ <font-style> <!seen(0)> | <font-variant=.font-variant-css21> <!seen(1)> | <font-weight> <!seen(2)> | <font-stretch> <!seen(3)> ]* <font-size> [ '/' <line-height> ]? <font-family> +% [ ',' ]
                               | [ caption | icon | menu | message\-box | small\-caption | status\-bar ] & <keyw>
                               ])> }

    # - font-family: [ <family-name> | <generic-family> ]#
    rule decl:sym<font-family> {:i (font\-family) ':' <val(rx:i:s[ <ref=.font-family> +% [ ',' ] ])> }
    rule font-family    {:i  [ <generic-family> || <family-name> ] }
    rule family-name    { <family-name=.identifiers> || <family-name=.string> }
    rule generic-family {:i [ serif | sans\-serif | cursive | fantasy | monospace ] & <generic-family=.identifier> }

    # - font-feature-settings: normal | <feature-tag-value>#
    rule decl:sym<font-feature-settings> {:i (font\-feature\-settings) ':'  <val(rx:i:s[ normal & <keyw> | <feature-tag-value> +% [ ',' ] ])> }

    # - font-kerning: auto | normal | none
    rule decl:sym<font-kerning> {:i (font\-kerning) ':'  <val(rx:i:s[ [ auto | normal | none ] & <keyw> ])> }

    # - font-language-override: normal | <string>
    rule decl:sym<font-language-override> {:i (font\-language\-override) ':'  <val(rx:i:s[ normal & <keyw> | <string> ])> }

    # - font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    rule absolute-size {:i [ [[xx|x]\-]?small | medium | [[xx|x]\-]?large ] & <keyw> }
    rule relative-size {:i [ larger | smaller ] & <keyw> }
    rule font-size {:i <absolute-size> | <relative-size> | <length> | <percentage> }
    rule decl:sym<font-size> {:i (font\-size) ':'  <val(rx:i:s[ <ref=.font-size> ])> }

    # - font-size-adjust: none | auto | <number>
    rule decl:sym<font-size-adjust> {:i (font\-size\-adjust) ':'  <val(rx:i:s[ [ none | auto ] & <keyw> | <number> ])> }

    # - font-stretch: normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded
    rule font-stretch {:i [ normal | ultra\-condensed | extra\-condensed | condensed | semi\-condensed | semi\-expanded | expanded | extra\-expanded | ultra\-expanded ] & <keyw> }
    rule decl:sym<font-stretch> {:i (font\-stretch) ':'  <val(rx:i:s[ <ref=.font-stretch> ])> }

    # - font-style: normal | italic | oblique
    rule font-style {:i [ normal | italic | oblique ] & <keyw> }
    rule decl:sym<font-style> {:i (font\-style) ':'  <val(rx:i:s[ <ref=.font-style> ])> }

    # - font-synthesis: none | [ weight || style ]
    rule decl:sym<font-synthesis> {:i (font\-synthesis) ':'  <val(rx:i:s[ none & <keyw> | [:my @*SEEN; [ [ weight <!seen(0)> | style <!seen(1)> ] & <keyw> ]+ ] ])> }

    # - font-variant: normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]
    rule decl:sym<font-variant> {:i (font\-variant) ':'  <val(rx:i:s[ [ [ normal | none ] & <keyw> | [:my @*SEEN; [ [ <common-lig-values> <!seen(0)> | <discretionary-lig-values> <!seen(1)> | <historical-lig-values> <!seen(2)> | <contextual-alt-values> <!seen(3)> | <stylistic> <!seen(4)> | historical\-forms & <keyw> <!seen(5)> | <styleset> <!seen(6)> | <character-variant> <!seen(7)> | <swash> <!seen(8)> | <ornaments> <!seen(9)> | <annotation> <!seen(10)> | [ [ small\-caps <!seen(11)> | all\-small\-caps <!seen(12)> | petite\-caps <!seen(13)> | all\-petite\-caps <!seen(14)> | unicase <!seen(15)> | titling\-caps ] & <keyw> ] <!seen(16)> | <numeric-figure-values> <!seen(17)> | <numeric-spacing-values> <!seen(18)> | <numeric-fraction-values> <!seen(19)> | ordinal & <keyw> <!seen(20)> | slashed\-zero & <keyw> <!seen(21)> | <east-asian-variant-values> <!seen(22)> | <east-asian-width-values> <!seen(23)> | ruby & <keyw> <!seen(24)> ] [ ',' ]? ]+ ]] ])> }

    # - font-variant-alternates: normal | [ stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) ]
    rule decl:sym<font-variant-alternates> {:i (font\-variant\-alternates) ':'  <val(rx:i:s[ normal & <keyw> | [:my @*SEEN;[ [ <stylistic> <!seen(0)> | historical\-forms & <keyw> <!seen(0)> | <styleset> <!seen(1)> | <character-variant> <!seen(2)> | <swash> <!seen(3)> | <ornaments> <!seen(4)> | <annotation> <!seen(5)> ]+ ]] ])> }

    # - font-variant-caps: normal | small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps
    rule decl:sym<font-variant-caps> {:i (font\-variant\-caps) ':'  <val(rx:i:s[ [ normal | small\-caps | all\-small\-caps | petite\-caps | all\-petite\-caps | unicase | titling\-caps ] & <keyw> ])> }

    # - font-variant-east-asian: normal | [ <east-asian-variant-values> || <east-asian-width-values> || ruby ]
    rule decl:sym<font-variant-east-asian> {:i (font\-variant\-east\-asian) ':'  <val(rx:i:s[ normal & <keyw> | [:my @*SEEN; [ <east-asian-variant-values> <!seen(0)> | <east-asian-width-values> <!seen(1)> | ruby & <keyw> <!seen(2)> ]+ ] ])> }

    # - font-variant-ligatures: normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ]
    rule decl:sym<font-variant-ligatures> {:i (font\-variant\-ligatures) ':'  <val(rx:i:s[ [ normal | none ] & <keyw> | [ [ <common-lig-values> | <discretionary-lig-values> | <historical-lig-values> | <contextual-alt-values> ]**1..4 ] ])> }

    # - font-variant-numeric: normal | [ <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero ]
    rule decl:sym<font-variant-numeric> {:i (font\-variant\-numeric) ':'  <val(rx:i:s[ normal & <keyw> | [:my @*SEEN; [ <numeric-figure-values> <!seen(0)> | <numeric-spacing-values> <!seen(1)> | <numeric-fraction-values> <!seen(2)> | ordinal & <keyw> <!seen(3)> | slashed\-zero & <keyw> <!seen(4)> ]+ ] ])> }

    # - font-variant-position: normal | sub | super
    rule decl:sym<font-variant-position> {:i (font\-variant\-position) ':'  <val(rx:i:s[ [ normal | sub | super ] & <keyw> ])> }

    # - font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    rule font-weight {:i [ normal | bold | bolder | lighter ] & <keyw> | [ 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ] & <number> }
    rule decl:sym<font-weight> {:i (font\-weight) ':'  <val(rx:i:s[ <ref=.font-weight> ])> }

    # - line-height: normal | <number> | <length> | <percentage> | inherit
    rule line-height {:i normal & <keyw> | <number> | <length> | <percentage> }
    rule decl:sym<line-height> {:i (line\-height) ':' <val(rx:i:s[ <ref=.line-height> ])> }
}

# ----------------------------------------------------------------------

class CSS::Language::CSS3::Fonts::Actions
    is CSS::Language::CSS3::Fonts::Variants::Actions
    is CSS::Language::CSS3::_Base::Actions
    does CSS::Language::CSS3::Fonts::Spec::Interface
    does CSS::Language::CSS3::Fonts::AtFontFace::Spec::Interface {

    method at-rule:sym<font-face>($/) { make $.at-rule($/) }

    method format($/) {
        return $.warning("usage: format(type)")
            if $<any-args>;

        make $<format>.ast;
    }

    method local($/) {
        return $.warning("usage: local(font-face-name)")
            if $<any-args>;

        make $<font-face-name>.ast;
    }

    method font-face-name { make $<font-face-name>.ast }

    method font-description($/) { make $<declarations>.ast }

    # ---- Properties ----

    #= font: [ <‘font-style’> || <font-variant=.font-variant-css21> || <‘font-weight’> || <‘font-stretch’> ]? <‘font-size’> [ / <‘line-height’> ]? <‘font-family’> ] | caption | icon | menu | message-box | small-caption | status-bar
    method decl:sym<font>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= font-family: [[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]
    method decl:sym<font-family>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method font-family($/) { make $.list($/) }
    method family-name($/) { make $<family-name>.ast }
    method generic-family($/) { make $<generic-family>.ast }

    #= font-feature-settings: normal | <feature-tag-value>#
    method decl:sym<font-feature-settings>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= font-kerning: auto | normal | none
    method decl:sym<font-kerning>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= font-language-override: normal | <string>
    method decl:sym<font-language-override>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    method decl:sym<font-size>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method absolute-size($/) { make $.token($<keyw>.ast) }
    method relative-size($/) { make $.token($<keyw>.ast) }
    method font-size($/) { make $.list($/) }

    #= font-size-adjust: <none> | <auto> | <number>
    method decl:sym<font-size-adjust>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= font-stretch: normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded
    method decl:sym<font-stretch>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method font-stretch($/) { make $.list($/) }

    #= font-style: normal | italic | oblique
    method decl:sym<font-style>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method font-style($/) { make $.list($/) }

    method decl:sym<font-synthesis>($/) {
        make make $._decl($0, $<val>, '<none> | [ weight || style ]');
    }

    #= font-variant: normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]
    method decl:sym<font-variant>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method font-variant-css21($/) { make $.list($/) }

    #= font-variant-alternates: normal | [ stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) ]
    method decl:sym<font-variant-alternates>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= font-variant-caps: normal | small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps
    method decl:sym<font-variant-caps>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= font-variant-east-asian: normal | [ <east-asian-variant-values> || <east-asian-width-values> || ruby ]
    method decl:sym<font-variant-east-asian>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= font-variant-ligatures: normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ]
    method decl:sym<font-variant-ligatures>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= font-variant-numeric: normal | [ <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero ]
    method decl:sym<font-variant-numeric>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= font-variant-position: normal | sub | super
    method decl:sym<font-variant-position>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    method decl:sym<font-weight>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method font-weight($/) { make $.list($/) }

    #= line-height: normal | <number> | <length> | <percentage>
    method decl:sym<line-height>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method line-height($/) { make $.list($/); }

    #= src: <uri> [format(<string>#)]? | <font-face-name>
    method decl:sym<src>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method src($/) { make $.node($/) }

}

