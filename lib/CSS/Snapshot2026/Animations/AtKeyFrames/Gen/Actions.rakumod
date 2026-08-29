unit class CSS::Snapshot2026::Animations::AtKeyFrames::Gen::Actions;
method at-rule:sym<keyframes> ($/) {
    make $<at-rule-keyframes>.ast
}
method at-rule-keyframes ($/) {
    make $.build.at-rule($/)
}
method keyframes-name ($/) {
    make $.build.rule($/)
}
method keyframe-block ($/) {
    make $.build.rule($/)
}
method keyframe-selector ($/) {
    make $.build.rule($/)
}