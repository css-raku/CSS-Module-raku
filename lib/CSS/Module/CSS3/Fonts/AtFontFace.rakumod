use v6;

# grammar for @font-face rule
grammar CSS::Module::CSS3::Fonts::AtFontFace {

    use     CSS::Module::CSS3::Fonts::Variants;
    also is CSS::Module::CSS3::Fonts::Variants;

    use     CSS::Module::CSS3::Fonts::AtFontFace::Gen::Grammar;
    also is CSS::Module::CSS3::Fonts::AtFontFace::Gen::Grammar;

    use     CSS::Module::CSS3::_Base;
    also is CSS::Module::CSS3::_Base;

    use       CSS::Module::CSS3::Fonts::AtFontFace::Gen::Interface;
    also does CSS::Module::CSS3::Fonts::AtFontFace::Gen::Interface;

    # declare ourselves as a distinct submodule
    method module(|c) {
        use CSS::Module;
        use CSS::Module::CSS3::Actions;
        use CSS::Module::CSS3::Fonts::AtFontFace::Metadata;
        my constant Metadata = CSS::Module::CSS3::Fonts::AtFontFace::Metadata;
        # we share the actions class
        CSS::Module.new(
            :name<@fontface>,
            :grammar($?CLASS),
	    :actions(CSS::Module::CSS3::Actions),
	    :property-metadata($Metadata::property),
            :prop-names(Metadata::prop-names.enums),
            :index(&Metadata::index),
            |c
	    );
    }
    # @font-face declarations

    # ---- Functions ----
    rule format {:i ('format')'(' [ <string> | <keyw> || <any-args> ] ')'}
    rule local  {:i ('local')'(' [ <font-face-name> || <any-args> ] ')'}
}
