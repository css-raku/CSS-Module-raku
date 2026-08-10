unit grammar CSS::Snapshot2026::PagedMedia::Gen::Grammar;
#| size: <length>{1,2} | auto | [ <page-size> || [ portrait | landscape] ]
rule decl:sym<size> { :i (size) ":" <val(/<prop-val-size> /, &?ROUTINE.WHY)>}
rule prop-val-size { :i <length> ** 1..2 || auto & <keyw> || [[<page-size> :my $*A;<!{
    $*A++
}>|| [[portrait | landscape ]& <keyw> ] :my $*B;<!{
    $*B++
}>]+]  }
#| <page-size> = a3 | a4 | a5 | b4 | b5 | letter | legal | ledger
rule page-size { :i [a3 | a4 | a5 | b4 | b5 | letter | legal | ledger ]& <keyw>  }