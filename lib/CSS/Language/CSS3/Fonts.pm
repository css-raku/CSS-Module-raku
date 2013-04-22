use v6;

# CSS3 Font Extension Module
# specification: http://www.w3.org/TR/2013/WD-css3-fonts-20130212/
#
# nb this standard is under revision (as of Feb 2013). Biggest change
# is the proposed at-rule @font-feature-values

use CSS::Language::CSS3::Fonts::AtFontFace;
use CSS::Language::CSS3::_Base;

grammar CSS::Language::CSS3::Fonts::Syntax {
    rule font-description {<declarations=.CSS::Language::CSS3::Fonts::AtFontFace::declarations>}
    rule at-rule:sym<font-face> {(:i'font-face') <font-description> }
}

grammar CSS::Language::CSS3::Fonts:ver<20130212.000> 
    is CSS::Language::CSS3::Fonts::Syntax
    is CSS::Language::CSS3::_Base {

    # ---- Properties ----
    # Initial generation:
    # % etc/gen-properties.pl gen grammar etc/css3x-font-properties.txt
    # - font: [ [ <‘font-style’> || <font-variant-css21> || <‘font-weight’> || <‘font-stretch’> ]? <‘font-size’> [ / <‘line-height’> ]? <‘font-family’> ] | caption | icon | menu | message-box | small-caption | status-bar
    rule decl:sym<font> {:i (font) ':'  [ [ [ [ <font-style> | <font-variant-css21> | <font-weight> | <font-stretch> ]**1..4 ]? <font-size> [ '/ ' <line-height> ]? <font-family> ] | [ caption | icon | menu | message\-box | small\-caption | status\-bar ] & <keyw> || <any-args> ] }

    # - font-family: [ <family-name> | <generic-family> ]#
    token font-family {:i [ <family-name> | <generic-family> ] }
    rule decl:sym<font-family> {:i (font\-family) ':'  [ <font-family> | inherit || <any-args> ] }

    # - font-feature-settings: normal | <feature-tag-value>#
    rule decl:sym<font-feature-settings> {:i (font\-feature\-settings) ':'  [ normal & <keyw> | <feature-tag-value> || <any-args> ] }

    # - font-kerning: auto | normal | none
    rule decl:sym<font-kerning> {:i (font\-kerning) ':'  [ [ auto | normal | none ] & <keyw> || <any-args> ] }

    # - font-language-override: normal | <string>
    rule decl:sym<font-language-override> {:i (font\-language\-override) ':'  [ normal & <keyw> | <string> || <any-args> ] }

    # - font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    token font-size {:i <absolute-size> | <relative-size> | <length> | <percentage> }
    rule decl:sym<font-size> {:i (font\-size) ':'  [ <font-size> | inherit || <any-args> ] }

    # - font-size-adjust: none | auto | <number>
    rule decl:sym<font-size-adjust> {:i (font\-size\-adjust) ':'  [ [ none | auto ] & <keyw> | <number> || <any-args> ] }

    # - font-stretch: normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded
    token font-stretch {:i [ normal | ultra\-condensed | extra\-condensed | condensed | semi\-condensed | semi\-expanded | expanded | extra\-expanded | ultra\-expanded ] & <keyw> }
    rule decl:sym<font-stretch> {:i (font\-stretch) ':'  [ <font-stretch> | inherit || <any-args> ] }

    # - font-style: normal | italic | oblique
    token font-style {:i [ normal | italic | oblique ] & <keyw> }
    rule decl:sym<font-style> {:i (font\-style) ':'  [ <font-style> | inherit || <any-args> ] }

    # - font-synthesis: none | [ weight || style ]
    rule decl:sym<font-synthesis> {:i (font\-synthesis) ':'  [ none & <keyw> | [ [ [ weight | style ] & <keyw> ]**1..2 ] || <any-args> ] }

    # - font-variant: normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]
    rule decl:sym<font-variant> {:i (font\-variant) ':'  [ [ normal | none ] & <keyw> | [ [ <common-lig-values> | <discretionary-lig-values> | <historical-lig-values> | <contextual-alt-values> | <stylistic> | historical\-forms & <keyw> | <styleset> | <character-variant> | <swash> | <ornaments> | <annotation> | [ [ small\-caps | all\-small\-caps | petite\-caps | all\-petite\-caps | unicase | titling\-caps ] & <keyw> ] | <numeric-figure-values> | <numeric-spacing-values> | <numeric-fraction-values> | ordinal & <keyw> | slashed\-zero & <keyw> | <east-asian-variant-values> | <east-asian-width-values> | ruby & <keyw> ]**1..20 ] || <any-args> ] }

    # - font-variant-alternates: normal | [ stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) ]
    rule decl:sym<font-variant-alternates> {:i (font\-variant\-alternates) ':'  [ normal & <keyw> | [ [ <stylistic> | historical\-forms & <keyw> | <styleset> | <character-variant> | <swash> | <ornaments> | <annotation> ]**1..7 ] || <any-args> ] }

    # - font-variant-caps: normal | small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps
    rule decl:sym<font-variant-caps> {:i (font\-variant\-caps) ':'  [ [ normal | small\-caps | all\-small\-caps | petite\-caps | all\-petite\-caps | unicase | titling\-caps ] & <keyw> || <any-args> ] }

    # - font-variant-east-asian: normal | [ <east-asian-variant-values> || <east-asian-width-values> || ruby ]
    rule decl:sym<font-variant-east-asian> {:i (font\-variant\-east\-asian) ':'  [ normal & <keyw> | [ [ <east-asian-variant-values> | <east-asian-width-values> | ruby & <keyw> ]**1..3 ] || <any-args> ] }

    # - font-variant-ligatures: normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ]
    rule decl:sym<font-variant-ligatures> {:i (font\-variant\-ligatures) ':'  [ [ normal | none ] & <keyw> | [ [ <common-lig-values> | <discretionary-lig-values> | <historical-lig-values> | <contextual-alt-values> ]**1..4 ] || <any-args> ] }

    # - font-variant-numeric: normal | [ <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero ]
    rule decl:sym<font-variant-numeric> {:i (font\-variant\-numeric) ':'  [ normal & <keyw> | [ [ <numeric-figure-values> | <numeric-spacing-values> | <numeric-fraction-values> | ordinal & <keyw> | slashed\-zero & <keyw> ]**1..5 ] || <any-args> ] }

    # - font-variant-position: normal | sub | super
    rule decl:sym<font-variant-position> {:i (font\-variant\-position) ':'  [ [ normal | sub | super ] & <keyw> || <any-args> ] }

    # - font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    token font-weight {:i [ normal | bold | bolder | lighter ] & <keyw> | [ 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ] & <number> }
    rule decl:sym<font-weight> {:i (font\-weight) ':'  [ <font-weight> | inherit || <any-args> ] }

}

class CSS::Language::CSS3::Fonts::Actions 
    is CSS::Language::CSS3::_Base::Actions {

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

    method font-description($/) { make $<declarations>.ast }

    # ---- Properties ----

    method src($/) { make $.node($/) }
    method decl:sym<src>($/) {
        make $._make_decl($/, '<uri> [format(<string>#)]? | <font-face-name>');
    }

    method decl:sym<font-size-adjust>($/) {
        make $._make_decl($/, '<none> | <auto> | <number>');
    }

    method font-family($/) { make $.list($/) }
    method decl:sym<font-family>($/) {
        $._make_decl($/, '[[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]', :body($<font-family>));
    }

    method decl:sym<font-synthesis>($/) {
        make $._make_decl($/, '<none> | [ weight || style ]');
    }

}

