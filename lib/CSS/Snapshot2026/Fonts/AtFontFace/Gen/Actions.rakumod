unit class CSS::Snapshot2026::Fonts::AtFontFace::Gen::Actions;
method font-src ($/) {
    make $.build.rule($/)
}
method font-format ($/) {
    make $.build.rule($/)
}
method font-tech ($/) {
    make $.build.rule($/)
}
method font-features-tech ($/) {
    make $.build.rule($/)
}
method color-font-tech ($/) {
    make $.build.rule($/)
}
method format ($/) {
    $.make-func("format", $/)
}
method local ($/) {
    $.make-func("local", $/)
}
method tech ($/) {
    $.make-func("tech", $/)
}