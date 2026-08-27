unit grammar CSS::Snapshot2026::Lists::AtCounterStyle::Gen::Grammar;
#| @counter-style <counter-style-name> <declarations>
rule decl:sym<@counter-style> { "\@"<at-rule=.at-rule-counter-style>}
rule at-rule-counter-style { (:i "counter-style") <counter-style-name> <declarations>  }
#| additive-symbols: [ <integer [0,∞]> && <symbol> ]#
rule decl:sym<additive-symbols> { :i ("additive-symbols") ":" <val(/<prop-val-additive-symbols> /, &?ROUTINE.WHY)>}
rule prop-val-additive-symbols { :i [[<integer> :my $*A;<!{
    $*A++
}>|| <symbol> :my $*B;<!{
    $*B++
}>]** 2] +% <op(",")>? }
#| <symbol> = <string> | <image> | <custom-ident>
rule symbol { :i <string> || <image> || <custom-ident>  }
#| fallback: <counter-style-name>
rule decl:sym<fallback> { :i (fallback) ":" <val(/<prop-val-fallback> /, &?ROUTINE.WHY)>}
rule prop-val-fallback { :i <counter-style-name> }
#| <counter-style-name> = <custom-ident>
rule counter-style-name { :i <custom-ident> }
#| negative: <symbol> <symbol>?
rule decl:sym<negative> { :i (negative) ":" <val(/<prop-val-negative> /, &?ROUTINE.WHY)>}
rule prop-val-negative { :i <symbol> <symbol> ?  }
#| pad: <integer [0,∞]> && <symbol>
rule decl:sym<pad> { :i (pad) ":" <val(/<prop-val-pad> /, &?ROUTINE.WHY)>}
rule prop-val-pad { :i [<integer> :my $*A;<!{
    $*A++
}>|| <symbol> :my $*B;<!{
    $*B++
}>]** 2 }
#| prefix: <symbol>
rule decl:sym<prefix> { :i (prefix) ":" <val(/<prop-val-prefix> /, &?ROUTINE.WHY)>}
rule prop-val-prefix { :i <symbol> }
#| range: [ [ <integer> | infinite ]{2} ]# | auto
rule decl:sym<range> { :i (range) ":" <val(/<prop-val-range> /, &?ROUTINE.WHY)>}
rule prop-val-range { :i [[<integer> || [infinite & <keyw> ] ] ** 2] +% <op(",")>? || [auto & <keyw> ]  }
#| speak-as: auto | bullets | numbers | words | spell-out | <counter-style-name>
rule decl:sym<speak-as> { :i ("speak-as") ":" <val(/<prop-val-speak-as> /, &?ROUTINE.WHY)>}
rule prop-val-speak-as { :i [auto | bullets | numbers | words | "spell-out" ]& <keyw>  || <counter-style-name>  }
#| suffix: <symbol>
rule decl:sym<suffix> { :i (suffix) ":" <val(/<prop-val-suffix> /, &?ROUTINE.WHY)>}
rule prop-val-suffix { :i <symbol> }
#| symbols: <symbol>+
rule decl:sym<symbols> { :i (symbols) ":" <val(/<prop-val-symbols> /, &?ROUTINE.WHY)>}
rule prop-val-symbols { :i <symbol> + }
#| system: cyclic | numeric | alphabetic | symbolic | additive | [fixed <integer>?] | [ extends <counter-style-name> ]
rule decl:sym<system> { :i (system) ":" <val(/<prop-val-system> /, &?ROUTINE.WHY)>}
rule prop-val-system { :i [cyclic | numeric | alphabetic | symbolic | additive ]& <keyw>  || [[fixed & <keyw> ] <integer> ? ] || [[extends & <keyw> ] <counter-style-name> ]  }