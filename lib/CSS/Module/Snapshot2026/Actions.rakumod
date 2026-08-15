unit class CSS::Module::Snapshot2026::Actions;

class Base {
    use CSS::Grammar::Actions;
    also is CSS::Grammar::Actions;

    use CSS::Module::CSS3::Values_and_Units;
    also is CSS::Module::CSS3::Values_and_Units::Actions::Calc;

    use CSS::Module::CSS3::Namespaces;
    also is CSS::Module::CSS3::Namespaces::Actions;

    use CSS::Specification::Base::Actions;
    also does CSS::Specification::Base::Actions;

    use CSS::Snapshot2026::Actions;
    also is CSS::Snapshot2026::Actions;

    use     CSS::Module::Snapshot2026::Colors;
    also is CSS::Module::Snapshot2026::Colors::Actions;
}
also is Base;

method at-rule:sym<color-profile>($/) {
    use CSS::Snapshot2026::Color::AtColorProfile::Gen::Actions;
    class AtColorProfile is CSS::Snapshot2026::Color::AtColorProfile::Gen::Actions is Base {
    }
    my AtColorProfile $actions .= new;
    $actions.at-rule-color-profile($<at-rule>);
    make $<at-rule>.ast;
}
use CSS::Snapshot2026::Color::AtColorProfile::Gen::Actions;
also is CSS::Snapshot2026::Color::AtColorProfile::Gen::Actions;

method build {
    use CSS::Grammar::AST;
    my class builder is CSS::Grammar::AST {
        method proforma { ['inherit', 'initial'] }
    }
}
