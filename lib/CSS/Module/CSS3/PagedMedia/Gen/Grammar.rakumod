use v6;
#  -- DO NOT EDIT --
# generated by: make-modules.raku;

unit grammar CSS::Module::CSS3::PagedMedia::Gen::Grammar;


#| size: <length>{1,2} | auto | [ <page-size> || [ portrait | landscape] ]
rule decl:sym<size> {:i (size) ':' <val( rx{ <expr=.expr-size> }, &?ROUTINE.WHY)> }
rule expr-size {:i :my @*SEEN; [ <length> ** 1..2 || auto & <keyw> || [ [ <page-size> <!seen(0)> | [ [ portrait | landscape ] & <keyw> ] <!seen(1)> ]+ ] ] }

#| page-size: a3 | a4 | a5 | b4 | b5 | letter | legal | ledger
rule page-size {:i [ a3 | a4 | a5 | b4 | b5 | letter | legal | ledger ] & <keyw> }
