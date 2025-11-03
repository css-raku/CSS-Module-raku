unit grammar CSS::Module::CSS3::PagedMedia::Gen::Grammar;
#| size: <length>{1,2} | auto | [ <page-size> || [ portrait | landscape] ]
rule decl:sym<size> { :i (size) ":" <val(/<expr=.expr-size> /, &?ROUTINE.WHY)>}
rule expr-size { :i <length> ** 1..2 || auto & <keyw>  || [[<page-size>:my $a; <!{
    $a++
}>| [[portrait | landscape ]& <keyw> ]:my $b; <!{
    $b++
}>]+]  }
#| a3 | a4 | a5 | b4 | b5 | letter | legal | ledger
rule page-size { :i [a3 | a4 | a5 | b4 | b5 | letter | legal | ledger ]& <keyw>  }