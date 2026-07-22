unit class CSS::Snapshot2026::Transforms::Gen::Actions;
method transform-list ($/) {
    make $.build.rule($/)
}
method transform-function ($/) {
    make $.build.rule($/)
}
method matrix ($/) {
    $.make-func("matrix", $/)
}
method rotate ($/) {
    $.make-func("rotate", $/)
}
method scale ($/) {
    $.make-func("scale", $/)
}
method scaleX ($/) {
    $.make-func("scaleX", $/)
}
method scaleY ($/) {
    $.make-func("scaleY", $/)
}
method skew ($/) {
    $.make-func("skew", $/)
}
method skewX ($/) {
    $.make-func("skewX", $/)
}
method skewY ($/) {
    $.make-func("skewY", $/)
}
method translate ($/) {
    $.make-func("translate", $/)
}
method translateX ($/) {
    $.make-func("translateX", $/)
}
method translateY ($/) {
    $.make-func("translateY", $/)
}