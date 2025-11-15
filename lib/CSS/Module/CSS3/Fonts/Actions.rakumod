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

    use       CSS::Module::CSS3::Fonts::Gen::External;
    also does CSS::Module::CSS3::Fonts::Gen::External;

    use       CSS::Module::CSS3::Fonts::AtFontFace::Gen::External;
    also does CSS::Module::CSS3::Fonts::AtFontFace::Gen::External;

    use CSS::Grammar::AST :CSSObject;

    method at-rule:sym<font-face>($/) { make $.build.at-rule($/) }
    method font-description($/)   { make $<declarations>.ast }
    method font-variant-css21($/) { make $.build.token($.build.list($/), :type<expr:font-variant>) }
    method font-src-expr($/)      { $.expr($/) }

}
