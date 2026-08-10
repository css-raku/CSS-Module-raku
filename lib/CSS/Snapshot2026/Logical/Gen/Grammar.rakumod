unit grammar CSS::Snapshot2026::Logical::Gen::Grammar;
#| block-size: <.'width'>
rule decl:sym<block-size> { :i ("block-size") ":" <val(/<prop-val-block-size> /, &?ROUTINE.WHY)>}
rule prop-val-block-size { :i <prop-val-width> }
#| border-block: <.'border-block-start'>
rule decl:sym<border-block> { :i ("border-block") ":" <val(/<prop-val-border-block> /, &?ROUTINE.WHY)>}
rule prop-val-border-block { :i <prop-val-border-block-start> }
#| border-block-color: <.'border-top-color'>{1,2}
rule decl:sym<border-block-color> { :i ("border-block-color") ":" <val(/<prop-val-border-block-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-block-color { :i <prop-val-border-top-color> ** 1..2 }
#| border-block-end: <.'border-top-width'> || <.'border-top-style'> || <color>
rule decl:sym<border-block-end> { :i ("border-block-end") ":" <val(/<prop-val-border-block-end> /, &?ROUTINE.WHY)>}
rule prop-val-border-block-end { :i [<prop-val-border-top-width> :my $*A;<!{
    $*A++
}>|| <prop-val-border-top-style> :my $*B;<!{
    $*B++
}>|| <color> :my $*C;<!{
    $*C++
}>]+ }
#| border-block-end-color: <.'border-top-color'>
rule decl:sym<border-block-end-color> { :i ("border-block-end-color") ":" <val(/<prop-val-border-block-end-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-block-end-color { :i <prop-val-border-top-color> }
#| border-block-end-style: <.'border-top-style'>
rule decl:sym<border-block-end-style> { :i ("border-block-end-style") ":" <val(/<prop-val-border-block-end-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-block-end-style { :i <prop-val-border-top-style> }
#| border-block-end-width: <.'border-top-width'>
rule decl:sym<border-block-end-width> { :i ("border-block-end-width") ":" <val(/<prop-val-border-block-end-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-block-end-width { :i <prop-val-border-top-width> }
#| border-block-start: <.'border-top-width'> || <.'border-top-style'> || <color>
rule decl:sym<border-block-start> { :i ("border-block-start") ":" <val(/<prop-val-border-block-start> /, &?ROUTINE.WHY)>}
rule prop-val-border-block-start { :i [<prop-val-border-top-width> :my $*A;<!{
    $*A++
}>|| <prop-val-border-top-style> :my $*B;<!{
    $*B++
}>|| <color> :my $*C;<!{
    $*C++
}>]+ }
#| border-block-start-color: <.'border-top-color'>
rule decl:sym<border-block-start-color> { :i ("border-block-start-color") ":" <val(/<prop-val-border-block-start-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-block-start-color { :i <prop-val-border-top-color> }
#| border-block-start-style: <.'border-top-style'>
rule decl:sym<border-block-start-style> { :i ("border-block-start-style") ":" <val(/<prop-val-border-block-start-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-block-start-style { :i <prop-val-border-top-style> }
#| border-block-start-width: <.'border-top-width'>
rule decl:sym<border-block-start-width> { :i ("border-block-start-width") ":" <val(/<prop-val-border-block-start-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-block-start-width { :i <prop-val-border-top-width> }
#| border-block-style: <.'border-top-style'>{1,2}
rule decl:sym<border-block-style> { :i ("border-block-style") ":" <val(/<prop-val-border-block-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-block-style { :i <prop-val-border-top-style> ** 1..2 }
#| border-block-width: <.'border-top-width'>{1,2}
rule decl:sym<border-block-width> { :i ("border-block-width") ":" <val(/<prop-val-border-block-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-block-width { :i <prop-val-border-top-width> ** 1..2 }
#| border-end-end-radius: <.'border-top-left-radius'>
rule decl:sym<border-end-end-radius> { :i ("border-end-end-radius") ":" <val(/<prop-val-border-end-end-radius> /, &?ROUTINE.WHY)>}
rule prop-val-border-end-end-radius { :i <prop-val-border-top-left-radius> }
#| border-end-start-radius: <.'border-top-left-radius'>
rule decl:sym<border-end-start-radius> { :i ("border-end-start-radius") ":" <val(/<prop-val-border-end-start-radius> /, &?ROUTINE.WHY)>}
rule prop-val-border-end-start-radius { :i <prop-val-border-top-left-radius> }
#| border-inline: <.'border-block-start'>
rule decl:sym<border-inline> { :i ("border-inline") ":" <val(/<prop-val-border-inline> /, &?ROUTINE.WHY)>}
rule prop-val-border-inline { :i <prop-val-border-block-start> }
#| border-inline-color: <.'border-top-color'>{1,2}
rule decl:sym<border-inline-color> { :i ("border-inline-color") ":" <val(/<prop-val-border-inline-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-inline-color { :i <prop-val-border-top-color> ** 1..2 }
#| border-inline-end: <.'border-top-width'> || <.'border-top-style'> || <color>
rule decl:sym<border-inline-end> { :i ("border-inline-end") ":" <val(/<prop-val-border-inline-end> /, &?ROUTINE.WHY)>}
rule prop-val-border-inline-end { :i [<prop-val-border-top-width> :my $*A;<!{
    $*A++
}>|| <prop-val-border-top-style> :my $*B;<!{
    $*B++
}>|| <color> :my $*C;<!{
    $*C++
}>]+ }
#| border-inline-end-color: <.'border-top-color'>
rule decl:sym<border-inline-end-color> { :i ("border-inline-end-color") ":" <val(/<prop-val-border-inline-end-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-inline-end-color { :i <prop-val-border-top-color> }
#| border-inline-end-style: <.'border-top-style'>
rule decl:sym<border-inline-end-style> { :i ("border-inline-end-style") ":" <val(/<prop-val-border-inline-end-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-inline-end-style { :i <prop-val-border-top-style> }
#| border-inline-end-width: <.'border-top-width'>
rule decl:sym<border-inline-end-width> { :i ("border-inline-end-width") ":" <val(/<prop-val-border-inline-end-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-inline-end-width { :i <prop-val-border-top-width> }
#| border-inline-start: <.'border-top-width'> || <.'border-top-style'> || <color>
rule decl:sym<border-inline-start> { :i ("border-inline-start") ":" <val(/<prop-val-border-inline-start> /, &?ROUTINE.WHY)>}
rule prop-val-border-inline-start { :i [<prop-val-border-top-width> :my $*A;<!{
    $*A++
}>|| <prop-val-border-top-style> :my $*B;<!{
    $*B++
}>|| <color> :my $*C;<!{
    $*C++
}>]+ }
#| border-inline-start-color: <.'border-top-color'>
rule decl:sym<border-inline-start-color> { :i ("border-inline-start-color") ":" <val(/<prop-val-border-inline-start-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-inline-start-color { :i <prop-val-border-top-color> }
#| border-inline-start-style: <.'border-top-style'>
rule decl:sym<border-inline-start-style> { :i ("border-inline-start-style") ":" <val(/<prop-val-border-inline-start-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-inline-start-style { :i <prop-val-border-top-style> }
#| border-inline-start-width: <.'border-top-width'>
rule decl:sym<border-inline-start-width> { :i ("border-inline-start-width") ":" <val(/<prop-val-border-inline-start-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-inline-start-width { :i <prop-val-border-top-width> }
#| border-inline-style: <.'border-top-style'>{1,2}
rule decl:sym<border-inline-style> { :i ("border-inline-style") ":" <val(/<prop-val-border-inline-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-inline-style { :i <prop-val-border-top-style> ** 1..2 }
#| border-inline-width: <.'border-top-width'>{1,2}
rule decl:sym<border-inline-width> { :i ("border-inline-width") ":" <val(/<prop-val-border-inline-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-inline-width { :i <prop-val-border-top-width> ** 1..2 }
#| border-start-end-radius: <.'border-top-left-radius'>
rule decl:sym<border-start-end-radius> { :i ("border-start-end-radius") ":" <val(/<prop-val-border-start-end-radius> /, &?ROUTINE.WHY)>}
rule prop-val-border-start-end-radius { :i <prop-val-border-top-left-radius> }
#| border-start-start-radius: <.'border-top-left-radius'>
rule decl:sym<border-start-start-radius> { :i ("border-start-start-radius") ":" <val(/<prop-val-border-start-start-radius> /, &?ROUTINE.WHY)>}
rule prop-val-border-start-start-radius { :i <prop-val-border-top-left-radius> }
#| inline-size: <.'width'>
rule decl:sym<inline-size> { :i ("inline-size") ":" <val(/<prop-val-inline-size> /, &?ROUTINE.WHY)>}
rule prop-val-inline-size { :i <prop-val-width> }
#| inset: <.'top'>{1,4}
rule decl:sym<inset> { :i (inset) ":" <val(/<prop-val-inset>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-inset { :i <prop-val-top> }
#| inset-block: <.'top'>{1,2}
rule decl:sym<inset-block> { :i ("inset-block") ":" <val(/<prop-val-inset-block> /, &?ROUTINE.WHY)>}
rule prop-val-inset-block { :i <prop-val-top> ** 1..2 }
#| inset-block-end: <.'top'>
rule decl:sym<inset-block-end> { :i ("inset-block-end") ":" <val(/<prop-val-inset-block-end> /, &?ROUTINE.WHY)>}
rule prop-val-inset-block-end { :i <prop-val-top> }
#| inset-block-start: <.'top'>
rule decl:sym<inset-block-start> { :i ("inset-block-start") ":" <val(/<prop-val-inset-block-start> /, &?ROUTINE.WHY)>}
rule prop-val-inset-block-start { :i <prop-val-top> }
#| inset-inline: <.'top'>{1,2}
rule decl:sym<inset-inline> { :i ("inset-inline") ":" <val(/<prop-val-inset-inline> /, &?ROUTINE.WHY)>}
rule prop-val-inset-inline { :i <prop-val-top> ** 1..2 }
#| inset-inline-end: <.'top'>
rule decl:sym<inset-inline-end> { :i ("inset-inline-end") ":" <val(/<prop-val-inset-inline-end> /, &?ROUTINE.WHY)>}
rule prop-val-inset-inline-end { :i <prop-val-top> }
#| inset-inline-start: <.'top'>
rule decl:sym<inset-inline-start> { :i ("inset-inline-start") ":" <val(/<prop-val-inset-inline-start> /, &?ROUTINE.WHY)>}
rule prop-val-inset-inline-start { :i <prop-val-top> }
#| margin-block: <.'margin-top'>{1,2}
rule decl:sym<margin-block> { :i ("margin-block") ":" <val(/<prop-val-margin-block> /, &?ROUTINE.WHY)>}
rule prop-val-margin-block { :i <prop-val-margin-top> ** 1..2 }
#| margin-block-end: <.'margin-top'>
rule decl:sym<margin-block-end> { :i ("margin-block-end") ":" <val(/<prop-val-margin-block-end> /, &?ROUTINE.WHY)>}
rule prop-val-margin-block-end { :i <prop-val-margin-top> }
#| margin-block-start: <.'margin-top'>
rule decl:sym<margin-block-start> { :i ("margin-block-start") ":" <val(/<prop-val-margin-block-start> /, &?ROUTINE.WHY)>}
rule prop-val-margin-block-start { :i <prop-val-margin-top> }
#| margin-inline: <.'margin-top'>{1,2}
rule decl:sym<margin-inline> { :i ("margin-inline") ":" <val(/<prop-val-margin-inline> /, &?ROUTINE.WHY)>}
rule prop-val-margin-inline { :i <prop-val-margin-top> ** 1..2 }
#| margin-inline-end: <.'margin-top'>
rule decl:sym<margin-inline-end> { :i ("margin-inline-end") ":" <val(/<prop-val-margin-inline-end> /, &?ROUTINE.WHY)>}
rule prop-val-margin-inline-end { :i <prop-val-margin-top> }
#| margin-inline-start: <.'margin-top'>
rule decl:sym<margin-inline-start> { :i ("margin-inline-start") ":" <val(/<prop-val-margin-inline-start> /, &?ROUTINE.WHY)>}
rule prop-val-margin-inline-start { :i <prop-val-margin-top> }
#| max-block-size: <.'max-width'>
rule decl:sym<max-block-size> { :i ("max-block-size") ":" <val(/<prop-val-max-block-size> /, &?ROUTINE.WHY)>}
rule prop-val-max-block-size { :i <prop-val-max-width> }
#| max-inline-size: <.'max-width'>
rule decl:sym<max-inline-size> { :i ("max-inline-size") ":" <val(/<prop-val-max-inline-size> /, &?ROUTINE.WHY)>}
rule prop-val-max-inline-size { :i <prop-val-max-width> }
#| min-block-size: <.'min-width'>
rule decl:sym<min-block-size> { :i ("min-block-size") ":" <val(/<prop-val-min-block-size> /, &?ROUTINE.WHY)>}
rule prop-val-min-block-size { :i <prop-val-min-width> }
#| min-inline-size: <.'min-width'>
rule decl:sym<min-inline-size> { :i ("min-inline-size") ":" <val(/<prop-val-min-inline-size> /, &?ROUTINE.WHY)>}
rule prop-val-min-inline-size { :i <prop-val-min-width> }
#| padding-block: <.'padding-top'>{1,2}
rule decl:sym<padding-block> { :i ("padding-block") ":" <val(/<prop-val-padding-block> /, &?ROUTINE.WHY)>}
rule prop-val-padding-block { :i <prop-val-padding-top> ** 1..2 }
#| padding-block-end: <.'padding-top'>
rule decl:sym<padding-block-end> { :i ("padding-block-end") ":" <val(/<prop-val-padding-block-end> /, &?ROUTINE.WHY)>}
rule prop-val-padding-block-end { :i <prop-val-padding-top> }
#| padding-block-start: <.'padding-top'>
rule decl:sym<padding-block-start> { :i ("padding-block-start") ":" <val(/<prop-val-padding-block-start> /, &?ROUTINE.WHY)>}
rule prop-val-padding-block-start { :i <prop-val-padding-top> }
#| padding-inline: <.'padding-top'>{1,2}
rule decl:sym<padding-inline> { :i ("padding-inline") ":" <val(/<prop-val-padding-inline> /, &?ROUTINE.WHY)>}
rule prop-val-padding-inline { :i <prop-val-padding-top> ** 1..2 }
#| padding-inline-end: <.'padding-top'>
rule decl:sym<padding-inline-end> { :i ("padding-inline-end") ":" <val(/<prop-val-padding-inline-end> /, &?ROUTINE.WHY)>}
rule prop-val-padding-inline-end { :i <prop-val-padding-top> }
#| padding-inline-start: <.'padding-top'>
rule decl:sym<padding-inline-start> { :i ("padding-inline-start") ":" <val(/<prop-val-padding-inline-start> /, &?ROUTINE.WHY)>}
rule prop-val-padding-inline-start { :i <prop-val-padding-top> }