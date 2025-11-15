unit class CSS::Module::CSS3::Fonts::AtFontFace::Gen::Actions;
method family-name ($/) {
    make $.build.rule($/)
}
method font-src-expr ($/) {
    make $.build.rule($/)
}
method font-face-name ($/) {
    make $.build.rule($/)
}
method format ($/) {
    $.make-func("format", $/)
}
method local ($/) {
    $.make-func("local", $/)
}