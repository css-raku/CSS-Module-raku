unit grammar CSS::Snapshot2026::Text::Gen::Grammar;
#| hanging-punctuation: none | [ first || [ force-end | allow-end ] || last ]
rule decl:sym<hanging-punctuation> { :i ("hanging-punctuation") ":" <val(/<prop-val-hanging-punctuation> /, &?ROUTINE.WHY)>}
rule prop-val-hanging-punctuation { :i none & <keyw> || [[first & <keyw> :my $*A;<!{
    $*A++
}>|| [["force-end" | "allow-end" ]& <keyw> ] :my $*B;<!{
    $*B++
}>|| last & <keyw> :my $*C;<!{
    $*C++
}>]+]  }
#| hyphens: none | manual | auto
rule decl:sym<hyphens> { :i (hyphens) ":" <val(/<prop-val-hyphens> /, &?ROUTINE.WHY)>}
rule prop-val-hyphens { :i [none | manual | auto ]& <keyw>  }
#| letter-spacing: normal | <length>
rule decl:sym<letter-spacing> { :i ("letter-spacing") ":" <val(/<prop-val-letter-spacing> /, &?ROUTINE.WHY)>}
rule prop-val-letter-spacing { :i normal & <keyw> || <length>  }
#| line-break: auto | loose | normal | strict | anywhere
rule decl:sym<line-break> { :i ("line-break") ":" <val(/<prop-val-line-break> /, &?ROUTINE.WHY)>}
rule prop-val-line-break { :i [auto | loose | normal | strict | anywhere ]& <keyw>  }
#| overflow-wrap: normal | break-word | anywhere
rule decl:sym<overflow-wrap> { :i ("overflow-wrap") ":" <val(/<prop-val-overflow-wrap> /, &?ROUTINE.WHY)>}
rule prop-val-overflow-wrap { :i [normal | "break-word" | anywhere ]& <keyw>  }
#| overflow-wrap: normal | break-word | anywhere
rule decl:sym<word-wrap> { :i ("word-wrap") ":" <val(/<prop-val-word-wrap> /, &?ROUTINE.WHY)>}
rule prop-val-word-wrap { :i [normal | "break-word" | anywhere ]& <keyw>  }
#| tab-size: <number [0,∞]> | <length [0,∞]>
rule decl:sym<tab-size> { :i ("tab-size") ":" <val(/<prop-val-tab-size> /, &?ROUTINE.WHY)>}
rule prop-val-tab-size { :i <number> || <length>  }
#| text-align: start | end | left | right | center | justify | match-parent | justify-all
rule decl:sym<text-align> { :i ("text-align") ":" <val(/<prop-val-text-align> /, &?ROUTINE.WHY)>}
rule prop-val-text-align { :i [start | end | left | right | center | justify | "match-parent" | "justify-all" ]& <keyw>  }
#| text-align-all: start | end | left | right | center | justify | match-parent
rule decl:sym<text-align-all> { :i ("text-align-all") ":" <val(/<prop-val-text-align-all> /, &?ROUTINE.WHY)>}
rule prop-val-text-align-all { :i [start | end | left | right | center | justify | "match-parent" ]& <keyw>  }
#| text-align-last: auto | start | end | left | right | center | justify | match-parent
rule decl:sym<text-align-last> { :i ("text-align-last") ":" <val(/<prop-val-text-align-last> /, &?ROUTINE.WHY)>}
rule prop-val-text-align-last { :i [auto | start | end | left | right | center | justify | "match-parent" ]& <keyw>  }
#| text-indent: [ <length-percentage> ] && hanging? && each-line?
rule decl:sym<text-indent> { :i ("text-indent") ":" <val(/<prop-val-text-indent> /, &?ROUTINE.WHY)>}
rule prop-val-text-indent { :i [<length-percentage> :my $*A;<!{
    $*A++
}>|| [hanging & <keyw>] ? :my $*B;<!{
    $*B++
}>|| ["each-line" & <keyw>] ? :my $*C;<!{
    $*C++
}>]** 3 }
#| text-justify: auto | none | inter-word | inter-character
rule decl:sym<text-justify> { :i ("text-justify") ":" <val(/<prop-val-text-justify> /, &?ROUTINE.WHY)>}
rule prop-val-text-justify { :i [auto | none | "inter-word" | "inter-character" ]& <keyw>  }
#| text-transform: none | [capitalize | uppercase | lowercase ] || full-width || full-size-kana
rule decl:sym<text-transform> { :i ("text-transform") ":" <val(/<prop-val-text-transform> /, &?ROUTINE.WHY)>}
rule prop-val-text-transform { :i none & <keyw> || [[[capitalize | uppercase | lowercase ]& <keyw> ] :my $*A;<!{
    $*A++
}>|| "full-width" & <keyw> :my $*B;<!{
    $*B++
}>|| "full-size-kana" & <keyw> :my $*C;<!{
    $*C++
}>]+  }
#| white-space: normal | pre | nowrap | pre-wrap | break-spaces | pre-line
rule decl:sym<white-space> { :i ("white-space") ":" <val(/<prop-val-white-space> /, &?ROUTINE.WHY)>}
rule prop-val-white-space { :i [normal | pre | nowrap | "pre-wrap" | "break-spaces" | "pre-line" ]& <keyw>  }
#| word-break: normal | keep-all | break-all | break-word
rule decl:sym<word-break> { :i ("word-break") ":" <val(/<prop-val-word-break> /, &?ROUTINE.WHY)>}
rule prop-val-word-break { :i [normal | "keep-all" | "break-all" | "break-word" ]& <keyw>  }
#| word-spacing: normal | <length>
rule decl:sym<word-spacing> { :i ("word-spacing") ":" <val(/<prop-val-word-spacing> /, &?ROUTINE.WHY)>}
rule prop-val-word-spacing { :i normal & <keyw> || <length>  }