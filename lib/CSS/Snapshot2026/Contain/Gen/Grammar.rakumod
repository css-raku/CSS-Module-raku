unit grammar CSS::Snapshot2026::Contain::Gen::Grammar;
#| contain: none | strict | content | [ [size | inline-size] || layout || style || paint ]
rule decl:sym<contain> { :i (contain) ":" <val(/<css-val-contain> /, &?ROUTINE.WHY)>}
rule css-val-contain { :i [none | strict | content ]& <keyw>  || [[[[size | "inline-size" ]& <keyw> ] :my $*A;<!{
    $*A++
}>|| layout & <keyw> :my $*B;<!{
    $*B++
}>|| style & <keyw> :my $*C;<!{
    $*C++
}>|| paint & <keyw> :my $*D;<!{
    $*D++
}>]+]  }
#| content-visibility: visible | auto | hidden
rule decl:sym<content-visibility> { :i ("content-visibility") ":" <val(/<css-val-content-visibility> /, &?ROUTINE.WHY)>}
rule css-val-content-visibility { :i [visible | auto | hidden ]& <keyw>  }