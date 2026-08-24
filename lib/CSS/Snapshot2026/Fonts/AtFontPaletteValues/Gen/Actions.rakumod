unit class CSS::Snapshot2026::Fonts::AtFontPaletteValues::Gen::Actions;
method at-rule:sym<font-palette-values> ($/) {
    make $<at-rule-font-palette-values>.ast
}
method at-rule-font-palette-values ($/) {
    make $.build.at-rule($/)
}
method dashed-ident ($/) {
    make $.build.rule($/)
}