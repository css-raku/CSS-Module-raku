unit grammar CSS::Module::Snapshot2026;

grammar Base {
    use CSS::Grammar::CSS4;
    also is CSS::Grammar::CSS4;

    use CSS::Specification::Base::Grammar;
    also does CSS::Specification::Base::Grammar;
}
also is Base;

use CSS::Module::CSS3::Values_and_Units;
also is CSS::Module::CSS3::Values_and_Units::Calc;

use CSS::Module::CSS3::Namespaces;
also is CSS::Module::CSS3::Namespaces;

use CSS::Snapshot2026::Grammar;
also is  CSS::Snapshot2026::Grammar;

use CSS::Module::Snapshot2026::Colors;
also is CSS::Module::Snapshot2026::Colors;

use CSS::Snapshot2026::External;
also does  CSS::Snapshot2026::External;

token proforma:sym<inherit> {:i inherit}
token proforma:sym<initial> {:i initial}

grammar AtColorProfile is Base {
    use CSS::Snapshot2026::Color::AtColorProfile::Gen::Grammar;
    also is CSS::Snapshot2026::Color::AtColorProfile::Gen::Grammar;

    use       CSS::Snapshot2026::Color::AtColorProfile::Gen::External;
    also does CSS::Snapshot2026::Color::AtColorProfile::Gen::External;

    method module(|c) {
        use CSS::Module;
        use CSS::Module::Snapshot2026::Actions;
        use CSS::Snapshot2026::Color::AtColorProfile::Metadata;
        my constant Metadata = CSS::Snapshot2026::Color::AtColorProfile::Metadata;
        # we share the actions class
        CSS::Module.new(
            :name<@color-profile>,
            :grammar($?CLASS),
	    :actions(CSS::Module::Snapshot2026::Actions),
	    :property-metadata($Metadata::property),
            :prop-names(Metadata::prop-names.enums),
            :index(&Metadata::index),
            |c
        );
    }
};
rule at-rule:sym<color-profile> {
    \@<at-rule=.AtColorProfile::at-rule-color-profile>
}

grammar AtFontFace is Base {
    use     CSS::Snapshot2026::Fonts::AtFontFace::Gen::Grammar;
    also is CSS::Snapshot2026::Fonts::AtFontFace::Gen::Grammar;

    use     CSS::Snapshot2026::Fonts::Defs::Gen::Grammar;
    also is CSS::Snapshot2026::Fonts::Defs::Gen::Grammar;

    use       CSS::Snapshot2026::Fonts::AtFontFace::Gen::External;
    also does CSS::Snapshot2026::Fonts::AtFontFace::Gen::External;

    use       CSS::Snapshot2026::Fonts::Defs::Gen::External;
    also does CSS::Snapshot2026::Fonts::Defs::Gen::External;

    method module(|c) {
        use CSS::Module;
        use CSS::Module::Snapshot2026::Actions;
        use CSS::Snapshot2026::Fonts::AtFontFace::Metadata;
        my constant Metadata = CSS::Snapshot2026::Fonts::AtFontFace::Metadata;
        # we share the actions class
        CSS::Module.new(
            :name<@fontface>,
            :grammar($?CLASS),
            :actions(CSS::Module::Snapshot2026::Actions),
            :property-metadata($Metadata::property),
            :prop-names(Metadata::prop-names.enums),
            :index(&Metadata::index),
            |c
        );
    }
}
rule at-rule:sym<font-face> {
    \@<at-rule=.AtFontFace::at-rule-font-face>
}

grammar AtFontFeatureValues is Base {
    use     CSS::Snapshot2026::Fonts::AtFontFeatureValues::Gen::Grammar;
    also is CSS::Snapshot2026::Fonts::AtFontFeatureValues::Gen::Grammar;

    use     CSS::Snapshot2026::Fonts::Defs::Gen::Grammar;
    also is CSS::Snapshot2026::Fonts::Defs::Gen::Grammar;

    use       CSS::Snapshot2026::Fonts::AtFontFeatureValues::Gen::External;
    also does CSS::Snapshot2026::Fonts::AtFontFeatureValues::Gen::External;

    use       CSS::Snapshot2026::Fonts::Defs::Gen::External;
    also does CSS::Snapshot2026::Fonts::Defs::Gen::External;

    method module(|c) {
        use CSS::Module;
        use CSS::Module::Snapshot2026::Actions;
        use CSS::Snapshot2026::Fonts::AtFontFeatureValues::Metadata;
        my constant Metadata = CSS::Snapshot2026::Fonts::AtFontFeatureValues::Metadata;
        # we share the actions class
        CSS::Module.new(
            :name<@font-feature-values>,
            :grammar($?CLASS),
            :actions(CSS::Module::Snapshot2026::Actions),
            :property-metadata($Metadata::property),
            :prop-names(Metadata::prop-names.enums),
            :index(&Metadata::index),
            |c
        );
    }
}
rule at-rule:sym<font-feature-values> {
    \@<at-rule=.AtFontFeatureValues::at-rule-font-feature-values>
}

grammar AtFontPaletteValues is Base {
    use     CSS::Snapshot2026::Fonts::AtFontPaletteValues::Gen::Grammar;
    also is CSS::Snapshot2026::Fonts::AtFontPaletteValues::Gen::Grammar;

    use     CSS::Snapshot2026::Fonts::Defs::Gen::Grammar;
    also is CSS::Snapshot2026::Fonts::Defs::Gen::Grammar;

    use       CSS::Snapshot2026::Fonts::AtFontPaletteValues::Gen::External;
    also does CSS::Snapshot2026::Fonts::AtFontPaletteValues::Gen::External;

    use       CSS::Snapshot2026::Fonts::Defs::Gen::External;
    also does CSS::Snapshot2026::Fonts::Defs::Gen::External;

    method module(|c) {
        use CSS::Module;
        use CSS::Module::Snapshot2026::Actions;
        use CSS::Snapshot2026::Fonts::AtFontPaletteValues::Metadata;
        my constant Metadata = CSS::Snapshot2026::Fonts::AtFontPaletteValues::Metadata;
        # we share the actions class
        CSS::Module.new(
            :name<@font-palette-values>,
            :grammar($?CLASS),
            :actions(CSS::Module::Snapshot2026::Actions),
            :property-metadata($Metadata::property),
            :prop-names(Metadata::prop-names.enums),
            :index(&Metadata::index),
            |c
        );
    }
}
rule at-rule:sym<font-palette-values> {
    \@<at-rule=.AtFontPaletteValues::at-rule-font-palette-values>
}

method module(|c) {
    use CSS::Module;
    use CSS::Module::Snapshot2026::Actions;
    use CSS::Snapshot2026::Metadata;
    my constant Metadata = CSS::Snapshot2026::Metadata;
    my $property-metadata = $Metadata::property;
    my $prop-names = Metadata::prop-names;
    my &index = &Metadata::index;

    CSS::Module.new(
        :name<Snapshot2026>,
        :grammar($?CLASS),
        :actions(CSS::Module::Snapshot2026::Actions),
        :$property-metadata,
        :$prop-names,
        :&index,
        :sub-module(
            '@color-profile' => AtColorProfile.module,
            '@font-face' => AtFontFace.module,
        ),
        |c
        );
}
