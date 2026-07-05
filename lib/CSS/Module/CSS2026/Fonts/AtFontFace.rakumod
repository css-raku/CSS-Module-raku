unit grammar CSS::Module::CSS2026::Fonts::AtFontFace;

use CSS::Grammar::CSS4;
also is CSS::Grammar::CSS4;

use CSS::Specification::Base::Grammar;
also does CSS::Specification::Base::Grammar;

use     CSS::Snapshot2026::Fonts::AtFontFace::Gen::Grammar;
also is CSS::Snapshot2026::Fonts::AtFontFace::Gen::Grammar;

use     CSS::Snapshot2026::Fonts::Defs::Gen::Grammar;
also is CSS::Snapshot2026::Fonts::Defs::Gen::Grammar;

use       CSS::Snapshot2026::Fonts::AtFontFace::Gen::External;
also does CSS::Snapshot2026::Fonts::AtFontFace::Gen::External;

use       CSS::Snapshot2026::Fonts::Defs::Gen::External;
also does CSS::Snapshot2026::Fonts::Defs::Gen::External;

class Actions {
    use CSS::Grammar::Actions;
    also is CSS::Grammar::Actions;

    use CSS::Specification::Base::Actions;
    also does CSS::Specification::Base::Actions;

    use     CSS::Snapshot2026::Fonts::AtFontFace::Gen::Actions;
    also is CSS::Snapshot2026::Fonts::AtFontFace::Gen::Actions;

    use     CSS::Snapshot2026::Fonts::Defs::Gen::Actions;
    also is CSS::Snapshot2026::Fonts::Defs::Gen::Actions;
}

# declare ourselves as a distinct submodule
method module(|c) {
    use CSS::Module;
    use CSS::Module::CSS2026::Actions;
    use CSS::Snapshot2026::Fonts::AtFontFace::Metadata;
    my constant Metadata = CSS::Snapshot2026::Fonts::AtFontFace::Metadata;
    # we share the actions class
    CSS::Module.new(
        :name<@fontface>,
        :grammar($?CLASS),
	:actions(Actions),
	:property-metadata($Metadata::property),
        :prop-names(Metadata::prop-names.enums),
        :index(&Metadata::index),
        |c
    );
}
 
