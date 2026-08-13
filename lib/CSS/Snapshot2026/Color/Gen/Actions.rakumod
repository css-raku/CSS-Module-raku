unit class CSS::Snapshot2026::Color::Gen::Actions;
method opacity-value ($/) {
    make $.build.rule($/)
}
method color-space ($/) {
    make $.build.rule($/)
}
method rectangular-color-space ($/) {
    make $.build.rule($/)
}
method polar-color-space ($/) {
    make $.build.rule($/)
}
method custom-color-space ($/) {
    make $.build.rule($/)
}
method hue-interpolation-method ($/) {
    make $.build.rule($/)
}
method color-interpolation-method ($/) {
    make $.build.rule($/)
}
method xyz-space ($/) {
    make $.build.rule($/)
}
method hue ($/) {
    make $.build.rule($/)
}
method system-color ($/) {
    make $.build.rule($/)
}
method at-rule:sym<color-profile> ($/) {
    make $<at-rule-color-profile>.ast
}
method at-rule-color-profile ($/) {
    make $.build.at-rule($/)
}
method hsl ($/) {
    $.make-func("hsl", $/)
}
method hsla ($/) {
    $.make-func("hsla", $/)
}
method rgb ($/) {
    $.make-func("rgb", $/)
}
method rgba ($/) {
    $.make-func("rgba", $/)
}