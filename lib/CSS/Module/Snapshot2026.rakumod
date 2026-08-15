unit grammar CSS::Module::Snapshot2026;

grammar Base {
    use CSS::Grammar::CSS4;
    also is CSS::Grammar::CSS4;

    use CSS::Module::CSS3::Values_and_Units;
    also is CSS::Module::CSS3::Values_and_Units::Calc;

    use CSS::Module::CSS3::Namespaces;
    also is CSS::Module::CSS3::Namespaces;

    use CSS::Specification::Base::Grammar;
    also does CSS::Specification::Base::Grammar;

    use CSS::Snapshot2026::Grammar;
    also is  CSS::Snapshot2026::Grammar;

    use CSS::Module::Snapshot2026::Colors;
    also is CSS::Module::Snapshot2026::Colors;

    use CSS::Snapshot2026::External;
    also does  CSS::Snapshot2026::External;
}
also is Base;

use CSS::Snapshot2026::Color::AtColorProfile::Gen::Grammar;
grammar AtColorProfile is CSS::Snapshot2026::Color::AtColorProfile::Gen::Grammar is Base {
};
rule at-rule:sym<color-profile> {
    \@<at-rule=.AtColorProfile::at-rule-color-profile>
}

token proforma:sym<inherit> {:i inherit}
token proforma:sym<initial> {:i initial}

method module(|c) {
    use CSS::Module::Snapshot2026::Actions;
    use CSS::Module::Snapshot2026::Fonts::AtFontFace;
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
        :sub-module('@font-face' => CSS::Module::Snapshot2026::Fonts::AtFontFace.module),
        |c
        );
}
