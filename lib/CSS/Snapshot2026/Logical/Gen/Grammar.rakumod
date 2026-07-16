unit grammar CSS::Snapshot2026::Logical::Gen::Grammar;
#| Name: Value
rule decl:sym<Name> { :i (Name) ":" <val(/<css-val-Name> /, &?ROUTINE.WHY)>}
rule css-val-Name { :i Value & <keyw> }
#| block-size: <'width'>
rule decl:sym<block-size> { :i ("block-size") ":" <val(/<css-val-block-size> /, &?ROUTINE.WHY)>}
rule css-val-block-size { :i <css-val-width> }
#| border-block: <'border-block-start'>
rule decl:sym<border-block> { :i ("border-block") ":" <val(/<css-val-border-block> /, &?ROUTINE.WHY)>}
rule css-val-border-block { :i <css-val-border-block-start> }
#| border-block-color: <'border-top-color'>{1,2}
rule decl:sym<border-block-color> { :i ("border-block-color") ":" <val(/<css-val-border-block-color> /, &?ROUTINE.WHY)>}
rule css-val-border-block-color { :i <css-val-border-top-color> ** 1..2 }
#| border-block-end: <'border-top-width'> || <'border-top-style'> || <color>
rule decl:sym<border-block-end> { :i ("border-block-end") ":" <val(/<css-val-border-block-end> /, &?ROUTINE.WHY)>}
rule css-val-border-block-end { :i [<css-val-border-top-width> :my $*A;<!{
    $*A++
}>|| <css-val-border-top-style> :my $*B;<!{
    $*B++
}>|| <color> :my $*C;<!{
    $*C++
}>]+ }
#| border-block-end-color: <'border-top-color'>
rule decl:sym<border-block-end-color> { :i ("border-block-end-color") ":" <val(/<css-val-border-block-end-color> /, &?ROUTINE.WHY)>}
rule css-val-border-block-end-color { :i <css-val-border-top-color> }
#| border-block-end-style: <'border-top-style'>
rule decl:sym<border-block-end-style> { :i ("border-block-end-style") ":" <val(/<css-val-border-block-end-style> /, &?ROUTINE.WHY)>}
rule css-val-border-block-end-style { :i <css-val-border-top-style> }
#| border-block-end-width: <'border-top-width'>
rule decl:sym<border-block-end-width> { :i ("border-block-end-width") ":" <val(/<css-val-border-block-end-width> /, &?ROUTINE.WHY)>}
rule css-val-border-block-end-width { :i <css-val-border-top-width> }
#| border-block-start: <'border-top-width'> || <'border-top-style'> || <color>
rule decl:sym<border-block-start> { :i ("border-block-start") ":" <val(/<css-val-border-block-start> /, &?ROUTINE.WHY)>}
rule css-val-border-block-start { :i [<css-val-border-top-width> :my $*A;<!{
    $*A++
}>|| <css-val-border-top-style> :my $*B;<!{
    $*B++
}>|| <color> :my $*C;<!{
    $*C++
}>]+ }
#| border-block-start-color: <'border-top-color'>
rule decl:sym<border-block-start-color> { :i ("border-block-start-color") ":" <val(/<css-val-border-block-start-color> /, &?ROUTINE.WHY)>}
rule css-val-border-block-start-color { :i <css-val-border-top-color> }
#| border-block-start-style: <'border-top-style'>
rule decl:sym<border-block-start-style> { :i ("border-block-start-style") ":" <val(/<css-val-border-block-start-style> /, &?ROUTINE.WHY)>}
rule css-val-border-block-start-style { :i <css-val-border-top-style> }
#| border-block-start-width: <'border-top-width'>
rule decl:sym<border-block-start-width> { :i ("border-block-start-width") ":" <val(/<css-val-border-block-start-width> /, &?ROUTINE.WHY)>}
rule css-val-border-block-start-width { :i <css-val-border-top-width> }
#| border-block-style: <'border-top-style'>{1,2}
rule decl:sym<border-block-style> { :i ("border-block-style") ":" <val(/<css-val-border-block-style> /, &?ROUTINE.WHY)>}
rule css-val-border-block-style { :i <css-val-border-top-style> ** 1..2 }
#| border-block-width: <'border-top-width'>{1,2}
rule decl:sym<border-block-width> { :i ("border-block-width") ":" <val(/<css-val-border-block-width> /, &?ROUTINE.WHY)>}
rule css-val-border-block-width { :i <css-val-border-top-width> ** 1..2 }
#| border-end-end-radius: <'border-top-left-radius'>
rule decl:sym<border-end-end-radius> { :i ("border-end-end-radius") ":" <val(/<css-val-border-end-end-radius> /, &?ROUTINE.WHY)>}
rule css-val-border-end-end-radius { :i <css-val-border-top-left-radius> }
#| border-end-start-radius: <'border-top-left-radius'>
rule decl:sym<border-end-start-radius> { :i ("border-end-start-radius") ":" <val(/<css-val-border-end-start-radius> /, &?ROUTINE.WHY)>}
rule css-val-border-end-start-radius { :i <css-val-border-top-left-radius> }
#| border-inline: <'border-block-start'>
rule decl:sym<border-inline> { :i ("border-inline") ":" <val(/<css-val-border-inline> /, &?ROUTINE.WHY)>}
rule css-val-border-inline { :i <css-val-border-block-start> }
#| border-inline-color: <'border-top-color'>{1,2}
rule decl:sym<border-inline-color> { :i ("border-inline-color") ":" <val(/<css-val-border-inline-color> /, &?ROUTINE.WHY)>}
rule css-val-border-inline-color { :i <css-val-border-top-color> ** 1..2 }
#| border-inline-end: <'border-top-width'> || <'border-top-style'> || <color>
rule decl:sym<border-inline-end> { :i ("border-inline-end") ":" <val(/<css-val-border-inline-end> /, &?ROUTINE.WHY)>}
rule css-val-border-inline-end { :i [<css-val-border-top-width> :my $*A;<!{
    $*A++
}>|| <css-val-border-top-style> :my $*B;<!{
    $*B++
}>|| <color> :my $*C;<!{
    $*C++
}>]+ }
#| border-inline-end-color: <'border-top-color'>
rule decl:sym<border-inline-end-color> { :i ("border-inline-end-color") ":" <val(/<css-val-border-inline-end-color> /, &?ROUTINE.WHY)>}
rule css-val-border-inline-end-color { :i <css-val-border-top-color> }
#| border-inline-end-style: <'border-top-style'>
rule decl:sym<border-inline-end-style> { :i ("border-inline-end-style") ":" <val(/<css-val-border-inline-end-style> /, &?ROUTINE.WHY)>}
rule css-val-border-inline-end-style { :i <css-val-border-top-style> }
#| border-inline-end-width: <'border-top-width'>
rule decl:sym<border-inline-end-width> { :i ("border-inline-end-width") ":" <val(/<css-val-border-inline-end-width> /, &?ROUTINE.WHY)>}
rule css-val-border-inline-end-width { :i <css-val-border-top-width> }
#| border-inline-start: <'border-top-width'> || <'border-top-style'> || <color>
rule decl:sym<border-inline-start> { :i ("border-inline-start") ":" <val(/<css-val-border-inline-start> /, &?ROUTINE.WHY)>}
rule css-val-border-inline-start { :i [<css-val-border-top-width> :my $*A;<!{
    $*A++
}>|| <css-val-border-top-style> :my $*B;<!{
    $*B++
}>|| <color> :my $*C;<!{
    $*C++
}>]+ }
#| border-inline-start-color: <'border-top-color'>
rule decl:sym<border-inline-start-color> { :i ("border-inline-start-color") ":" <val(/<css-val-border-inline-start-color> /, &?ROUTINE.WHY)>}
rule css-val-border-inline-start-color { :i <css-val-border-top-color> }
#| border-inline-start-style: <'border-top-style'>
rule decl:sym<border-inline-start-style> { :i ("border-inline-start-style") ":" <val(/<css-val-border-inline-start-style> /, &?ROUTINE.WHY)>}
rule css-val-border-inline-start-style { :i <css-val-border-top-style> }
#| border-inline-start-width: <'border-top-width'>
rule decl:sym<border-inline-start-width> { :i ("border-inline-start-width") ":" <val(/<css-val-border-inline-start-width> /, &?ROUTINE.WHY)>}
rule css-val-border-inline-start-width { :i <css-val-border-top-width> }
#| border-inline-style: <'border-top-style'>{1,2}
rule decl:sym<border-inline-style> { :i ("border-inline-style") ":" <val(/<css-val-border-inline-style> /, &?ROUTINE.WHY)>}
rule css-val-border-inline-style { :i <css-val-border-top-style> ** 1..2 }
#| border-inline-width: <'border-top-width'>{1,2}
rule decl:sym<border-inline-width> { :i ("border-inline-width") ":" <val(/<css-val-border-inline-width> /, &?ROUTINE.WHY)>}
rule css-val-border-inline-width { :i <css-val-border-top-width> ** 1..2 }
#| border-start-end-radius: <'border-top-left-radius'>
rule decl:sym<border-start-end-radius> { :i ("border-start-end-radius") ":" <val(/<css-val-border-start-end-radius> /, &?ROUTINE.WHY)>}
rule css-val-border-start-end-radius { :i <css-val-border-top-left-radius> }
#| border-start-start-radius: <'border-top-left-radius'>
rule decl:sym<border-start-start-radius> { :i ("border-start-start-radius") ":" <val(/<css-val-border-start-start-radius> /, &?ROUTINE.WHY)>}
rule css-val-border-start-start-radius { :i <css-val-border-top-left-radius> }
#| inline-size: <'width'>
rule decl:sym<inline-size> { :i ("inline-size") ":" <val(/<css-val-inline-size> /, &?ROUTINE.WHY)>}
rule css-val-inline-size { :i <css-val-width> }
#| inset: <'top'>{1,4}
rule decl:sym<inset> { :i (inset) ":" <val(/<css-val-inset>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-inset { :i <css-val-top> }
#| inset-block: <'top'>{1,2}
rule decl:sym<inset-block> { :i ("inset-block") ":" <val(/<css-val-inset-block> /, &?ROUTINE.WHY)>}
rule css-val-inset-block { :i <css-val-top> ** 1..2 }
#| inset-block-end: <'top'>
rule decl:sym<inset-block-end> { :i ("inset-block-end") ":" <val(/<css-val-inset-block-end> /, &?ROUTINE.WHY)>}
rule css-val-inset-block-end { :i <css-val-top> }
#| inset-block-start: <'top'>
rule decl:sym<inset-block-start> { :i ("inset-block-start") ":" <val(/<css-val-inset-block-start> /, &?ROUTINE.WHY)>}
rule css-val-inset-block-start { :i <css-val-top> }
#| inset-inline: <'top'>{1,2}
rule decl:sym<inset-inline> { :i ("inset-inline") ":" <val(/<css-val-inset-inline> /, &?ROUTINE.WHY)>}
rule css-val-inset-inline { :i <css-val-top> ** 1..2 }
#| inset-inline-end: <'top'>
rule decl:sym<inset-inline-end> { :i ("inset-inline-end") ":" <val(/<css-val-inset-inline-end> /, &?ROUTINE.WHY)>}
rule css-val-inset-inline-end { :i <css-val-top> }
#| inset-inline-start: <'top'>
rule decl:sym<inset-inline-start> { :i ("inset-inline-start") ":" <val(/<css-val-inset-inline-start> /, &?ROUTINE.WHY)>}
rule css-val-inset-inline-start { :i <css-val-top> }
#| margin-block: <'margin-top'>{1,2}
rule decl:sym<margin-block> { :i ("margin-block") ":" <val(/<css-val-margin-block> /, &?ROUTINE.WHY)>}
rule css-val-margin-block { :i <css-val-margin-top> ** 1..2 }
#| margin-block-end: <'margin-top'>
rule decl:sym<margin-block-end> { :i ("margin-block-end") ":" <val(/<css-val-margin-block-end> /, &?ROUTINE.WHY)>}
rule css-val-margin-block-end { :i <css-val-margin-top> }
#| margin-block-start: <'margin-top'>
rule decl:sym<margin-block-start> { :i ("margin-block-start") ":" <val(/<css-val-margin-block-start> /, &?ROUTINE.WHY)>}
rule css-val-margin-block-start { :i <css-val-margin-top> }
#| margin-inline: <'margin-top'>{1,2}
rule decl:sym<margin-inline> { :i ("margin-inline") ":" <val(/<css-val-margin-inline> /, &?ROUTINE.WHY)>}
rule css-val-margin-inline { :i <css-val-margin-top> ** 1..2 }
#| margin-inline-end: <'margin-top'>
rule decl:sym<margin-inline-end> { :i ("margin-inline-end") ":" <val(/<css-val-margin-inline-end> /, &?ROUTINE.WHY)>}
rule css-val-margin-inline-end { :i <css-val-margin-top> }
#| margin-inline-start: <'margin-top'>
rule decl:sym<margin-inline-start> { :i ("margin-inline-start") ":" <val(/<css-val-margin-inline-start> /, &?ROUTINE.WHY)>}
rule css-val-margin-inline-start { :i <css-val-margin-top> }
#| max-block-size: <'max-width'>
rule decl:sym<max-block-size> { :i ("max-block-size") ":" <val(/<css-val-max-block-size> /, &?ROUTINE.WHY)>}
rule css-val-max-block-size { :i <css-val-max-width> }
#| max-inline-size: <'max-width'>
rule decl:sym<max-inline-size> { :i ("max-inline-size") ":" <val(/<css-val-max-inline-size> /, &?ROUTINE.WHY)>}
rule css-val-max-inline-size { :i <css-val-max-width> }
#| min-block-size: <'min-width'>
rule decl:sym<min-block-size> { :i ("min-block-size") ":" <val(/<css-val-min-block-size> /, &?ROUTINE.WHY)>}
rule css-val-min-block-size { :i <css-val-min-width> }
#| min-inline-size: <'min-width'>
rule decl:sym<min-inline-size> { :i ("min-inline-size") ":" <val(/<css-val-min-inline-size> /, &?ROUTINE.WHY)>}
rule css-val-min-inline-size { :i <css-val-min-width> }
#| padding-block: <'padding-top'>{1,2}
rule decl:sym<padding-block> { :i ("padding-block") ":" <val(/<css-val-padding-block> /, &?ROUTINE.WHY)>}
rule css-val-padding-block { :i <css-val-padding-top> ** 1..2 }
#| padding-block-end: <'padding-top'>
rule decl:sym<padding-block-end> { :i ("padding-block-end") ":" <val(/<css-val-padding-block-end> /, &?ROUTINE.WHY)>}
rule css-val-padding-block-end { :i <css-val-padding-top> }
#| padding-block-start: <'padding-top'>
rule decl:sym<padding-block-start> { :i ("padding-block-start") ":" <val(/<css-val-padding-block-start> /, &?ROUTINE.WHY)>}
rule css-val-padding-block-start { :i <css-val-padding-top> }
#| padding-inline: <'padding-top'>{1,2}
rule decl:sym<padding-inline> { :i ("padding-inline") ":" <val(/<css-val-padding-inline> /, &?ROUTINE.WHY)>}
rule css-val-padding-inline { :i <css-val-padding-top> ** 1..2 }
#| padding-inline-end: <'padding-top'>
rule decl:sym<padding-inline-end> { :i ("padding-inline-end") ":" <val(/<css-val-padding-inline-end> /, &?ROUTINE.WHY)>}
rule css-val-padding-inline-end { :i <css-val-padding-top> }
#| padding-inline-start: <'padding-top'>
rule decl:sym<padding-inline-start> { :i ("padding-inline-start") ":" <val(/<css-val-padding-inline-start> /, &?ROUTINE.WHY)>}
rule css-val-padding-inline-start { :i <css-val-padding-top> }