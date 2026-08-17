unit class CSS::Snapshot2026::Fonts::AtFontFace::Gen::Actions;
method at-rule:sym<font-face> ($/) {
    make $<at-rule-font-face>.ast
}
method at-rule-font-face ($/) {
    make $.build.at-rule($/)
}