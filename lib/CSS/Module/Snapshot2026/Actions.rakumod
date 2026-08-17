unit class CSS::Module::Snapshot2026::Actions;

class Base {
    use CSS::Grammar::Actions;
    also is CSS::Grammar::Actions;

    use CSS::Specification::Base::Actions;
    also does CSS::Specification::Base::Actions;
}
also is Base;

use CSS::Module::CSS3::Values_and_Units;
also is CSS::Module::CSS3::Values_and_Units::Actions::Calc;

use CSS::Module::CSS3::Namespaces;
also is CSS::Module::CSS3::Namespaces::Actions;

use CSS::Snapshot2026::Actions;
also is CSS::Snapshot2026::Actions;

use     CSS::Module::Snapshot2026::Colors;
also is CSS::Module::Snapshot2026::Colors::Actions;

method at-rule:sym<color-profile>($/) {
    class AtColorProfile is Base {
        use CSS::Snapshot2026::Color::AtColorProfile::Gen::Actions;
        also is CSS::Snapshot2026::Color::AtColorProfile::Gen::Actions;
    }
    my AtColorProfile $actions .= new;
    $actions.at-rule-color-profile($<at-rule>);
    make $<at-rule>.ast;
}

method at-rule:sym<font-face>($/) {
    class AtFontFace is Base {
        use     CSS::Snapshot2026::Fonts::AtFontFace::Gen::Actions;
        also is CSS::Snapshot2026::Fonts::AtFontFace::Gen::Actions;

        use     CSS::Snapshot2026::Fonts::Defs::Gen::Actions;
        also is CSS::Snapshot2026::Fonts::Defs::Gen::Actions;
    }
    my AtFontFace $actions .= new;
    $actions.at-rule-font-face($<at-rule>);
    make $<at-rule>.ast;
}

method build {
    use CSS::Grammar::AST;
    my class builder is CSS::Grammar::AST {
        method proforma { ['inherit', 'initial'] }
    }
}
