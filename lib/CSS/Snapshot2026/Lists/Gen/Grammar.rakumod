unit grammar CSS::Snapshot2026::Lists::Gen::Grammar;
#| counter-increment: [ <counter-name> <integer>? ]+ | none
rule decl:sym<counter-increment> { :i ("counter-increment") ":" <val(/<prop-val-counter-increment> /, &?ROUTINE.WHY)>}
rule prop-val-counter-increment { :i [<counter-name> <integer> ? ] + || [none & <keyw> ]  }
#| <counter-name> = <identifier>
rule counter-name { :i <identifier> }
#| reversed( <counter-name> )
rule reversed-counter-name { :i "reversed(" [<counter-name> || <usage(&?ROUTINE.WHY)> ] ")" }
#| counter-reset: [ <counter-name> <integer>? | <reversed-counter-name> <integer>? ]+ | none
rule decl:sym<counter-reset> { :i ("counter-reset") ":" <val(/<prop-val-counter-reset> /, &?ROUTINE.WHY)>}
rule prop-val-counter-reset { :i [<counter-name> <integer> ?  || <reversed-counter-name> <integer> ?  ] + || [none & <keyw> ]  }
#| counter-set: [ <counter-name> <integer>? ]+ | none
rule decl:sym<counter-set> { :i ("counter-set") ":" <val(/<prop-val-counter-set> /, &?ROUTINE.WHY)>}
rule prop-val-counter-set { :i [<counter-name> <integer> ? ] + || [none & <keyw> ]  }
#| list-style: <'list-style-position'> || <'list-style-image'> || <'list-style-type'>
rule decl:sym<list-style> { :i ("list-style") ":" <val(/<prop-val-list-style> /, &?ROUTINE.WHY)>}
rule prop-val-list-style { :i [<prop-val-list-style-position> :my $*A;<!{
    $*A++
}>|| <prop-val-list-style-image> :my $*B;<!{
    $*B++
}>|| <prop-val-list-style-type> :my $*C;<!{
    $*C++
}>]+ }
#| list-style-image: <image> | none
rule decl:sym<list-style-image> { :i ("list-style-image") ":" <val(/<prop-val-list-style-image> /, &?ROUTINE.WHY)>}
rule prop-val-list-style-image { :i <image> || [none & <keyw> ]  }
#| list-style-position: inside | outside
rule decl:sym<list-style-position> { :i ("list-style-position") ":" <val(/<prop-val-list-style-position> /, &?ROUTINE.WHY)>}
rule prop-val-list-style-position { :i [inside | outside ]& <keyw>  }
#| list-style-type: <counter-style> | <string> | none
rule decl:sym<list-style-type> { :i ("list-style-type") ":" <val(/<prop-val-list-style-type> /, &?ROUTINE.WHY)>}
rule prop-val-list-style-type { :i <counter-style> || <string> || [none & <keyw> ]  }
#| marker-side: match-self | match-parent
rule decl:sym<marker-side> { :i ("marker-side") ":" <val(/<prop-val-marker-side> /, &?ROUTINE.WHY)>}
rule prop-val-marker-side { :i ["match-self" | "match-parent" ]& <keyw>  }
#| <counter-style> = <counter-style-name> | <symbols()>
rule counter-style { :i <counter-style-name> || <symbols>  }
#| <counter-style-name> = decimal | decimal-leading-zero | arabic-indic | armenian |    upper-armenian | lower-armenian | bengali | cambodian | khmer | cjk-decimal |    devanagari | georgian | gujarati | gurmukhi | hebrew | kannada | lao | malayalam    | mongolian | myanmar | oriya | persian | lower-roman | upper-roman | tamil |    telugu | thai | tibetan | lower-alpha | lower-latin | upper-alpha | upper-latin |    lower-greek | disc | circle | square | disclosure-open | disclosure-closed |    cjk-earthly-branch | cjk-earthly-stem | japanese-informal | japanese-formal |    korean-hangul-formal | korean-hanja-informal | korean-hanja-formal |    simp-chinese-informal | simp-chinese-formal | trad-chinese-informal |    trad-chinese-formal | korean-hangul-formal | korean-hanja-informal |    korean-hanja-formal | cjk-decimal | ethiopic-numeric
rule counter-style-name { :i [decimal | "decimal-leading-zero" | "arabic-indic" | armenian | "upper-armenian" | "lower-armenian" | bengali | cambodian | khmer | "cjk-decimal" | devanagari | georgian | gujarati | gurmukhi | hebrew | kannada | lao | malayalam | mongolian | myanmar | oriya | persian | "lower-roman" | "upper-roman" | tamil | telugu | thai | tibetan | "lower-alpha" | "lower-latin" | "upper-alpha" | "upper-latin" | "lower-greek" | disc | circle | square | "disclosure-open" | "disclosure-closed" | "cjk-earthly-branch" | "cjk-earthly-stem" | "japanese-informal" | "japanese-formal" | "korean-hangul-formal" | "korean-hanja-informal" | "korean-hanja-formal" | "simp-chinese-informal" | "simp-chinese-formal" | "trad-chinese-informal" | "trad-chinese-formal" | "korean-hangul-formal" | "korean-hanja-informal" | "korean-hanja-formal" | "cjk-decimal" | "ethiopic-numeric" ]& <keyw>  }
#| symbols( <symbols-type>? [ <string> | <image> ]+ )
rule symbols { :i "symbols(" [<symbols-type> ? [<string> || <image> ] +  || <usage(&?ROUTINE.WHY)> ] ")" }
#| <symbols-type> = cyclic | numeric | alphabetic | symbolic | fixed
rule symbols-type { :i [cyclic | numeric | alphabetic | symbolic | fixed ]& <keyw>  }