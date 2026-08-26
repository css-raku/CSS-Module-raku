unit grammar CSS::Snapshot2026::Display::Gen::Grammar;
#| display: [ <display-outside> || <display-inside> ] | <display-listitem> | <display-internal> | <display-box> | <display-legacy>
rule decl:sym<display> { :i (display) ":" <val(/<prop-val-display> /, &?ROUTINE.WHY)>}
rule prop-val-display { :i [[<display-outside> :my $*A;<!{
    $*A++
}>|| <display-inside> :my $*B;<!{
    $*B++
}>]+] || <display-listitem> || <display-internal> || <display-box> || <display-legacy>  }
#| <display-outside> = block | inline | run-in
rule display-outside { :i [block | inline | "run-in" ]& <keyw>  }
#| <display-inside> = flow | flow-root | table | flex | grid | ruby
rule display-inside { :i [flow | "flow-root" | table | flex | grid | ruby ]& <keyw>  }
#| <display-listitem> = <display-outside>? && [ flow | flow-root ]? && list-item
rule display-listitem { :i [<display-outside> ? :my $*A;<!{
    $*A++
}>|| [[flow | "flow-root" ]& <keyw> ] ? :my $*B;<!{
    $*B++
}>|| ["list-item" & <keyw> ] :my $*C;<!{
    $*C++
}>]** 3 }
#| <display-internal> = table-row-group | table-header-group |                     table-footer-group | table-row | table-cell |                     table-column-group | table-column | table-caption |                     ruby-base | ruby-text | ruby-base-container |                     ruby-text-container
rule display-internal { :i ["table-row-group" | "table-header-group" | "table-footer-group" | "table-row" | "table-cell" | "table-column-group" | "table-column" | "table-caption" | "ruby-base" | "ruby-text" | "ruby-base-container" | "ruby-text-container" ]& <keyw>  }
#| <display-box> = contents | none
rule display-box { :i [contents | none ]& <keyw>  }
#| <display-legacy> = inline-block | inline-table | inline-flex | inline-grid
rule display-legacy { :i ["inline-block" | "inline-table" | "inline-flex" | "inline-grid" ]& <keyw>  }
#| order: <integer>
rule decl:sym<order> { :i (order) ":" <val(/<prop-val-order> /, &?ROUTINE.WHY)>}
rule prop-val-order { :i <integer> }
#| visibility: visible | hidden | collapse
rule decl:sym<visibility> { :i (visibility) ":" <val(/<prop-val-visibility> /, &?ROUTINE.WHY)>}
rule prop-val-visibility { :i [visible | hidden | collapse ]& <keyw>  }