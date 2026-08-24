unit class CSS::Snapshot2026::Fonts::AtFontFeatureValues::Gen::Actions;
method at-rule:sym<font-feature-values> ($/) {
    make $<at-rule-font-feature-values>.ast
}
method at-rule-font-feature-values ($/) {
    make $.build.at-rule($/)
}
method font-feature-value-name ($/) {
    make $.build.rule($/)
}
method font-feature-index ($/) {
    make $.build.rule($/)
}
method font-feature-property ($/) {
    make $.build.rule($/)
}
method swash-declaration-list ($/) {
    make $.build.rule($/)
}
method at-rule:sym<swash> ($/) {
    make $<at-rule-swash>.ast
}
method at-rule-swash ($/) {
    make $.build.at-rule($/)
}
method at-rule:sym<ornaments> ($/) {
    make $<at-rule-ornaments>.ast
}
method at-rule-ornaments ($/) {
    make $.build.at-rule($/)
}
method at-rule:sym<annotation> ($/) {
    make $<at-rule-annotation>.ast
}
method at-rule-annotation ($/) {
    make $.build.at-rule($/)
}