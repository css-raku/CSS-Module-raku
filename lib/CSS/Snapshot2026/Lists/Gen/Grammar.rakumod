unit grammar CSS::Snapshot2026::Lists::Gen::Grammar;
#| counter-increment: [ <counter-name> <integer>? ]+ | none
rule decl:sym<counter-increment> { :i ("counter-increment") ":" <val(/<css-val-counter-increment> /, &?ROUTINE.WHY)>}
rule css-val-counter-increment { :i [<counter-name> <integer> ? ] + || none & <keyw>  }
#| <counter-name> = <identifier>
rule counter-name { :i <identifier> }
#| reversed( <counter-name> )
rule reversed-counter-name { :i "reversed(" [<counter-name> || <usage(&?ROUTINE.WHY)> ] ")" }
#| reversed( <counter-name> )
rule reversed { :i "reversed(" [<counter-name> || <usage(&?ROUTINE.WHY)> ] ")" }
#| <counter-style> = decimal | decimal-leading-zero | arabic-indic | armenian | upper-armenian | lower-armenian | bengali | cambodian | khmer | cjk-decimal | devanagari | georgian | gujarati | gurmukhi | hebrew | kannada | lao | malayalam | mongolian | myanmar | oriya | persian | lower-roman | upper-roman | tamil | telugu | thai | tibetan | <identifier>
rule counter-style { :i [decimal | "decimal-leading-zero" | "arabic-indic" | armenian | "upper-armenian" | "lower-armenian" | bengali | cambodian | khmer | "cjk-decimal" | devanagari | georgian | gujarati | gurmukhi | hebrew | kannada | lao | malayalam | mongolian | myanmar | oriya | persian | "lower-roman" | "upper-roman" | tamil | telugu | thai | tibetan ]& <keyw>  || <identifier>  }
#| counter-reset: [ <counter-name> <integer>? | <reversed-counter-name> <integer>? ]+ | none
rule decl:sym<counter-reset> { :i ("counter-reset") ":" <val(/<css-val-counter-reset> /, &?ROUTINE.WHY)>}
rule css-val-counter-reset { :i [<counter-name> <integer> ?  || <reversed-counter-name> <integer> ?  ] + || none & <keyw>  }
#| counter-set: [ <counter-name> <integer>? ]+ | none
rule decl:sym<counter-set> { :i ("counter-set") ":" <val(/<css-val-counter-set> /, &?ROUTINE.WHY)>}
rule css-val-counter-set { :i [<counter-name> <integer> ? ] + || none & <keyw>  }
#| list-style: <'list-style-position'> || <'list-style-image'> || <'list-style-type'>
rule decl:sym<list-style> { :i ("list-style") ":" <val(/<css-val-list-style> /, &?ROUTINE.WHY)>}
rule css-val-list-style { :i [<css-val-list-style-position> :my $*A;<!{
    $*A++
}>|| <css-val-list-style-image> :my $*B;<!{
    $*B++
}>|| <css-val-list-style-type> :my $*C;<!{
    $*C++
}>]+ }
#| list-style-image: <image> | none
rule decl:sym<list-style-image> { :i ("list-style-image") ":" <val(/<css-val-list-style-image> /, &?ROUTINE.WHY)>}
rule css-val-list-style-image { :i <image> || none & <keyw>  }
#| list-style-position: inside | outside
rule decl:sym<list-style-position> { :i ("list-style-position") ":" <val(/<css-val-list-style-position> /, &?ROUTINE.WHY)>}
rule css-val-list-style-position { :i [inside | outside ]& <keyw>  }
#| list-style-type: <counter-style> | <string> | none
rule decl:sym<list-style-type> { :i ("list-style-type") ":" <val(/<css-val-list-style-type> /, &?ROUTINE.WHY)>}
rule css-val-list-style-type { :i <counter-style> || <string> || none & <keyw>  }
#| marker-side: match-self | match-parent
rule decl:sym<marker-side> { :i ("marker-side") ":" <val(/<css-val-marker-side> /, &?ROUTINE.WHY)>}
rule css-val-marker-side { :i ["match-self" | "match-parent" ]& <keyw>  }