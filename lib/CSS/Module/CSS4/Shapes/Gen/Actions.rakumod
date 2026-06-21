unit class CSS::Module::CSS4::Shapes::Gen::Actions;
method basic-shape ($/) {
    make $.build.rule($/)
}
method shape-rect ($/) {
    make $.build.rule($/)
}
method basic-shape-rect ($/) {
    make $.build.rule($/)
}
method circle ($/) {
    $.make-func("circle", $/)
}
method ellipse ($/) {
    $.make-func("ellipse", $/)
}
method inset ($/) {
    $.make-func("inset", $/)
}
method path ($/) {
    $.make-func("path", $/)
}
method polygon ($/) {
    $.make-func("polygon", $/)
}
method shape ($/) {
    $.make-func("shape", $/)
}
method xywh ($/) {
    $.make-func("xywh", $/)
}