unit class CSS::Snapshot2026::Grid::Gen::Actions;
method track-list ($/) {
    make $.build.rule($/)
}
method auto-track-list ($/) {
    make $.build.rule($/)
}
method explicit-track-list ($/) {
    make $.build.rule($/)
}
method track-size ($/) {
    make $.build.rule($/)
}
method track-minmax ($/) {
    $.make-func("minmax", $/)
}
method fixed-size ($/) {
    make $.build.rule($/)
}
method fixed-minmax ($/) {
    $.make-func("minmax", $/)
}
method track-breadth ($/) {
    make $.build.rule($/)
}
method inflexible-breadth ($/) {
    make $.build.rule($/)
}
method fixed-breadth ($/) {
    make $.build.rule($/)
}
method line-names ($/) {
    make $.build.rule($/)
}
method track-repeat ($/) {
    $.make-func("repeat", $/)
}
method auto-repeat ($/) {
    $.make-func("repeat", $/)
}
method fixed-repeat ($/) {
    $.make-func("repeat", $/)
}
method grid-line ($/) {
    make $.build.rule($/)
}
method fit-content ($/) {
    $.make-func("fit-content", $/)
}