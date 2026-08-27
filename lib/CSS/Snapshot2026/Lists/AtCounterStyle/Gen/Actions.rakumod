unit class CSS::Snapshot2026::Lists::AtCounterStyle::Gen::Actions;
method at-rule:sym<counter-style> ($/) {
    make $<at-rule-counter-style>.ast
}
method at-rule-counter-style ($/) {
    make $.build.at-rule($/)
}
method symbol ($/) {
    make $.build.rule($/)
}
method counter-style-name ($/) {
    make $.build.rule($/)
}