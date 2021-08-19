use v6;

use CSS::Module::CSS3::_Base::Actions;
use CSS::Module::CSS3::Fonts::Variants;
use CSS::Module::CSS3::Fonts::Gen::Actions;
use CSS::Module::CSS3::Fonts::AtFontFace::Gen::Interface;
use CSS::Module::CSS3::Fonts::Gen::Interface;
use CSS::Module::CSS3::Fonts::AtFontFace::Gen::Actions;

class CSS::Module::CSS3::Fonts::Actions
    is CSS::Module::CSS3::_Base::Actions
    is CSS::Module::CSS3::Fonts::Variants::Actions
    is CSS::Module::CSS3::Fonts::Gen::Actions
    is CSS::Module::CSS3::Fonts::AtFontFace::Gen::Actions
    does CSS::Module::CSS3::Fonts::Gen::Interface
    does CSS::Module::CSS3::Fonts::AtFontFace::Gen::Interface {

    use CSS::Grammar::AST :CSSObject;

    method at-rule:sym<font-face>($/) { make $.build.at-rule($/) }

    method format($/) {
        return $.warning("usage: format(type)")
            if $<any-args>;

        make $.build.func( $0.lc, $.build.list($/) );
    }

    method local($/) {
        return $.warning("usage: local(font-face-name)")
            if $<any-args>;

        make $.build.func( $0.lc, $.build.list($/) );
    }

    method font-description($/)   { make $<declarations>.ast }
    method font-variant-css21($/) { make $.build.token($.build.list($/), :type<expr:font-variant>) }
    method font-src-expr($/)      { $.expr($/) }

}
