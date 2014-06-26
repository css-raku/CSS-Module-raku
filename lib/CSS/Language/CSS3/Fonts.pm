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
use CSS::Language::CSS3::Fonts::Spec::Grammar;
use CSS::Language::CSS3::Fonts::Spec::Actions;
use CSS::Language::CSS3::Fonts::AtFontFace::Spec::Interface;
use CSS::Language::CSS3::Fonts::AtFontFace::Spec::Actions;

grammar CSS::Language::CSS3::Fonts:ver<20130212.000> 
    is CSS::Language::CSS3::Fonts::Variants
    is CSS::Language::CSS3::Fonts::Spec::Grammar
    is CSS::Language::CSS3::_Base
    does CSS::Language::CSS3::Fonts::Spec::Interface {

    rule font-description {<declarations=.CSS::Language::CSS3::Fonts::AtFontFace::declarations>}
    rule at-rule:sym<font-face> {(:i'font-face') <font-description> }

    # ---- Expressions ----
    rule expr-font {:i [ [ [ [:my @*SEEN; <expr-font-style> <!seen(0)> | <font-variant=.font-variant-css21> <!seen(1)> | <expr-font-weight> <!seen(2)> | <expr-font-stretch> <!seen(3)> ]+ ]? <expr-font-size> [ '/' <expr-line-height> ]? <expr-font-family> ] | [ caption | icon | menu | message\-box | small\-caption | status\-bar ] & <keyw> ] }
    rule font-variant-css21 {:i [ normal | small\-caps ] & <keyw> }
    rule expr-font-family    {:i  [ <generic-family> || <family-name> ] +% ',' }
    rule family-name    { <family-name=.identifiers> || <family-name=.string> }
    rule generic-family {:i [ serif | sans\-serif | cursive | fantasy | monospace ] & <generic-family=.identifier> }
    rule absolute-size {:i [ [[xx|x]\-]?small | medium | [[xx|x]\-]?large ] & <keyw> }
    rule relative-size {:i [ larger | smaller ] & <keyw> }
    rule expr-font-size {:i <absolute-size> | <relative-size> | <length> | <percentage> }
}

# ----------------------------------------------------------------------

class CSS::Language::CSS3::Fonts::Actions
    is CSS::Language::CSS3::Fonts::Variants::Actions
    is CSS::Language::CSS3::Fonts::Spec::Actions
    is CSS::Language::CSS3::Fonts::AtFontFace::Spec::Actions
    is CSS::Language::CSS3::_Base::Actions
    does CSS::Language::CSS3::Fonts::Spec::Interface
    does CSS::Language::CSS3::Fonts::AtFontFace::Spec::Interface {

    method at-rule:sym<font-face>($/) { make $.at-rule($/) }
##
##    method format($/) {
##        return $.warning("usage: format(type)")
##            if $<any-args>;
##
##        make $<format>.ast;
##    }
##
##    method local($/) {
##        return $.warning("usage: local(font-face-name)")
##            if $<any-args>;
##
##        make $<font-face-name>.ast;
##    }
##
    method font-face-name { make $<font-face-name>.ast }
    method expr-font-family($/) { make $.list($/) }
    method family-name($/) { make $<family-name>.ast }
    method generic-family($/) { make $<generic-family>.ast }
    method absolute-size($/) { make $.token($<keyw>.ast) }
    method relative-size($/) { make $.token($<keyw>.ast) }
    method expr-font-size($/) { make $.list($/) }
    method font-variant-css21($/) { make $.list($/) }
##    method src($/) { make $.node($/) }

}

