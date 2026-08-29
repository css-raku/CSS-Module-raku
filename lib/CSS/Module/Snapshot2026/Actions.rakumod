unit class CSS::Module::Snapshot2026::Actions;

use CSS::Grammar::Actions;
also is CSS::Grammar::Actions;

use CSS::Specification::Base::Actions;
also does CSS::Specification::Base::Actions;

use CSS::Module::CSS3::Values_and_Units;
also is CSS::Module::CSS3::Values_and_Units::Actions::Calc;

use CSS::Module::CSS3::Namespaces;
also is CSS::Module::CSS3::Namespaces::Actions;

use CSS::Snapshot2026::Actions;
also is CSS::Snapshot2026::Actions;

use     CSS::Module::Snapshot2026::Colors;
also is CSS::Module::Snapshot2026::Colors::Actions;

use CSS::Snapshot2026::Color::AtColorProfile::Gen::Actions;
also is CSS::Snapshot2026::Color::AtColorProfile::Gen::Actions;
method at-rule:sym<color-profile>($/) {
    make $<at-rule>.ast;
}

use CSS::Snapshot2026::Lists::AtCounterStyle::Gen::Actions;
also is CSS::Snapshot2026::Lists::AtCounterStyle::Gen::Actions;
method at-rule:sym<counter-style>($/) {
    make $<at-rule>.ast;
}

use     CSS::Snapshot2026::Fonts::AtFontFace::Gen::Actions;
also is CSS::Snapshot2026::Fonts::AtFontFace::Gen::Actions;
method at-rule:sym<font-face>($/) {
    make $<at-rule>.ast;
}

use     CSS::Snapshot2026::Fonts::Defs::Gen::Actions;
also is CSS::Snapshot2026::Fonts::Defs::Gen::Actions;

use     CSS::Snapshot2026::Fonts::AtFontFeatureValues::Gen::Actions;
also is CSS::Snapshot2026::Fonts::AtFontFeatureValues::Gen::Actions;
method at-rule:sym<font-feature-values>($/) {
    make $<at-rule>.ast;
}

use     CSS::Snapshot2026::Fonts::AtFontPaletteValues::Gen::Actions;
also is CSS::Snapshot2026::Fonts::AtFontPaletteValues::Gen::Actions;
method at-rule:sym<font-palette-values>($/) {
    make $<at-rule>.ast;
}

use CSS::Snapshot2026::Animations::AtKeyFrames::Gen::Actions;
also is CSS::Snapshot2026::Animations::AtKeyFrames::Gen::Actions;
method at-rule:sym<keyframes>($/) {
    make $<at-rule>.ast;
}

method build {
    use CSS::Grammar::AST;
    my class builder is CSS::Grammar::AST {
        method proforma { ['inherit', 'initial', 'unset', 'revert', 'revert-layer', 'revert-rule'] }
    }
}
