use v6;

class CSS::Module::CSS3::Fonts::Actions {

    use     CSS::Module::CSS3::_Base::Actions;
    also is CSS::Module::CSS3::_Base::Actions;

    use     CSS::Module::CSS3::Fonts::Variants;
    also is CSS::Module::CSS3::Fonts::Variants::Actions;

    use     CSS::Module::CSS3::Fonts::Gen::Actions;
    also is CSS::Module::CSS3::Fonts::Gen::Actions;

    use     CSS::Module::CSS3::Fonts::AtFontFace::Gen::Actions;
    also is CSS::Module::CSS3::Fonts::AtFontFace::Gen::Actions;

    use       CSS::Module::CSS3::Fonts::Gen::Interface;
    also does CSS::Module::CSS3::Fonts::Gen::Interface;

    use       CSS::Module::CSS3::Fonts::AtFontFace::Gen::Interface;
    also does CSS::Module::CSS3::Fonts::AtFontFace::Gen::Interface;

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
