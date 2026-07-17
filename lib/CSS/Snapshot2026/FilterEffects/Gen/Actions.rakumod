unit class CSS::Snapshot2026::FilterEffects::Gen::Actions;
method filter-value-list ($/) {
    make $.build.rule($/)
}
method filter-function ($/) {
    make $.build.rule($/)
}
method blur ($/) {
    $.make-func("blur", $/)
}
method brightness ($/) {
    $.make-func("brightness", $/)
}
method contrast ($/) {
    $.make-func("contrast", $/)
}
method drop-shadow ($/) {
    $.make-func("drop-shadow", $/)
}
method grayscale ($/) {
    $.make-func("grayscale", $/)
}
method hue-rotate ($/) {
    $.make-func("hue-rotate", $/)
}
method invert ($/) {
    $.make-func("invert", $/)
}
method opacity ($/) {
    $.make-func("opacity", $/)
}
method saturate ($/) {
    $.make-func("saturate", $/)
}
method sepia ($/) {
    $.make-func("sepia", $/)
}