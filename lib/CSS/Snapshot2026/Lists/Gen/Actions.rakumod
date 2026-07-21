unit class CSS::Snapshot2026::Lists::Gen::Actions;
method counter-name ($/) {
    make $.build.rule($/)
}
method reversed-counter-name ($/) {
    $.make-func("reversed", $/)
}
method counter-style ($/) {
    make $.build.rule($/)
}