use v6;

use CSS::Module::CSS3::Fonts::Variants;
use CSS::Module::CSS3::_Base;
use CSS::Module::CSS3::Fonts::AtFontFace::Gen::Interface;
use CSS::Module::CSS3::Fonts::AtFontFace::Gen::Grammar;

grammar CSS::Module::CSS3::Fonts::AtFontFace
    is CSS::Module::CSS3::Fonts::Variants
    is CSS::Module::CSS3::Fonts::AtFontFace::Gen::Grammar
    is CSS::Module::CSS3::_Base
    does CSS::Module::CSS3::Fonts::AtFontFace::Gen::Interface {

    # declare ourselves as a distinct submodule
    method module {
        use CSS::Module;
        use CSS::Module::CSS3::Actions;
        use CSS::Module::CSS3::Fonts::AtFontFace::Metadata;
        # we share the actions class
        state $ = CSS::Module.new(
            :name<@font-face>,
            :grammar($?CLASS),
	    :actions(CSS::Module::CSS3::Actions),
	    :property-metadata($CSS::Module::CSS3::Fonts::AtFontFace::Metadata::property),
            :prop-names(CSS::Module::CSS3::Fonts::AtFontFace::Metadata::prop-names),
            :index(&CSS::Module::CSS3::Fonts::AtFontFace::Metadata::index),
	    );
    }
    # @font-face declarations

    # ---- Functions ----
    rule format {:i ('format')'(' [ <string> | <keyw> || <any-args> ] ')'}
    rule local  {:i ('local')'(' [ <font-face-name> || <any-args> ] ')'}
}
