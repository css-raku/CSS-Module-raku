use v6;

use CSS::Module::CSS3::Fonts::Variants;
use CSS::Module::CSS3::_Base;
use CSS::Module::CSS3::Fonts::AtFontFace::Spec::Interface;
use CSS::Module::CSS3::Fonts::AtFontFace::Spec::Grammar;

grammar CSS::Module::CSS3::Fonts::AtFontFace
    is CSS::Module::CSS3::Fonts::Variants
    is CSS::Module::CSS3::Fonts::AtFontFace::Spec::Grammar
    is CSS::Module::CSS3::_Base
    does CSS::Module::CSS3::Fonts::AtFontFace::Spec::Interface {

    # declare ourselves as a distinct submodule
    method module {
        use CSS::Module;
        # we share the actions class
        require ::('CSS::Module::CSS3');
        my $actions = ::('CSS::Module::CSS3').module.actions;
        use CSS::Module::CSS3::Fonts::AtFontFace::Metadata;
        my %property-metadata = %$CSS::Module::CSS3::Fonts::AtFontFace::Metadata::property;
        state $this //= CSS::Module.new( :grammar($?CLASS),
					 :$actions,
					 :%property-metadata,
	    );
    }
    # @font-face declarations

    # ---- Functions ----
    rule format {:i('format')'(' [ <string> | <keyw> || <any-args> ] ')'}
    rule local  {:i('local')'(' [ <font-face-name> || <any-args> ] ')'}
}
