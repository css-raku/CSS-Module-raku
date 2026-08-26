unit grammar CSS::Snapshot2026::Contain::Gen::Grammar;
#| contain: none | strict | content | [ [size | inline-size] || layout || style || paint ]
rule decl:sym<contain> { :i (contain) ":" <val(/<prop-val-contain> /, &?ROUTINE.WHY)>}
rule prop-val-contain { :i [none | strict | content ]& <keyw>  || [[[[size | "inline-size" ]& <keyw> ] :my $*A;<!{
    $*A++
}>|| [layout & <keyw> ] :my $*B;<!{
    $*B++
}>|| [style & <keyw> ] :my $*C;<!{
    $*C++
}>|| [paint & <keyw> ] :my $*D;<!{
    $*D++
}>]+]  }
#| content-visibility: visible | auto | hidden
rule decl:sym<content-visibility> { :i ("content-visibility") ":" <val(/<prop-val-content-visibility> /, &?ROUTINE.WHY)>}
rule prop-val-content-visibility { :i [visible | auto | hidden ]& <keyw>  }