unit class CSS::Snapshot2026::Color::AtColorProfile::Gen::Actions;
method at-rule:sym<color-profile> ($/) {
    make $<at-rule-color-profile>.ast
}
method at-rule-color-profile ($/) {
    make $.build.at-rule($/)
}