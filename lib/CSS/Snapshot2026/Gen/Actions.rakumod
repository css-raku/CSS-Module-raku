unit class CSS::Snapshot2026::Gen::Actions;
method at-rule:sym<import> ($/) {
    make $<at-rule-import>.ast
}
method at-rule-import ($/) {
    make $.build.at-rule($/)
}
method layer-name ($/) {
    make $.build.rule($/)
}
method import-conditions ($/) {
    make $.build.rule($/)
}
method at-rule:sym<layer> ($/) {
    make $<at-rule-layer>.ast
}
method at-rule-layer ($/) {
    make $.build.at-rule($/)
}
method supports-condition ($/) {
    make $.build.rule($/)
}
method supports-in-parens ($/) {
    make $.build.rule($/)
}
method supports-feature ($/) {
    make $.build.rule($/)
}
method supports-decl ($/) {
    make $.build.rule($/)
}
method general-enclosed ($/) {
    make $.build.rule($/)
}
method function ($/) {
    make $.build.rule($/)
}
method at-rule:sym<namespace> ($/) {
    make $<at-rule-namespace>.ast
}
method at-rule-namespace ($/) {
    make $.build.at-rule($/)
}
method namespace-prefix ($/) {
    make $.build.rule($/)
}
method supports ($/) {
    $.make-func("supports", $/)
}
