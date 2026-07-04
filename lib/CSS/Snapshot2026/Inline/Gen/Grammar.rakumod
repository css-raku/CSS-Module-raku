unit grammar CSS::Snapshot2026::Inline::Gen::Grammar;
#| alignment-baseline: baseline | text-bottom | alphabetic | ideographic | middle | central | mathematical | text-top
rule decl:sym<alignment-baseline> { :i ("alignment-baseline") ":" <val(/<css-val-alignment-baseline> /, &?ROUTINE.WHY)>}
rule css-val-alignment-baseline { :i [baseline | "text-bottom" | alphabetic | ideographic | middle | central | mathematical | "text-top" ]& <keyw>  }
#| baseline-shift: <length-percentage> | sub | super | top | center | bottom
rule decl:sym<baseline-shift> { :i ("baseline-shift") ":" <val(/<css-val-baseline-shift> /, &?ROUTINE.WHY)>}
rule css-val-baseline-shift { :i <length-percentage> || [sub | super | top | center | bottom ]& <keyw>   }
#| baseline-source: auto | first | last
rule decl:sym<baseline-source> { :i ("baseline-source") ":" <val(/<css-val-baseline-source> /, &?ROUTINE.WHY)>}
rule css-val-baseline-source { :i [auto | first | last ]& <keyw>  }
#| dominant-baseline: auto | text-bottom | alphabetic | ideographic | middle | central | mathematical | hanging | text-top
rule decl:sym<dominant-baseline> { :i ("dominant-baseline") ":" <val(/<css-val-dominant-baseline> /, &?ROUTINE.WHY)>}
rule css-val-dominant-baseline { :i [auto | "text-bottom" | alphabetic | ideographic | middle | central | mathematical | hanging | "text-top" ]& <keyw>  }
#| initial-letter: normal | <number [1,∞]> <integer [1,∞]> | <number [1,∞]> && [ drop | raise ]?
rule decl:sym<initial-letter> { :i ("initial-letter") ":" <val(/<css-val-initial-letter> /, &?ROUTINE.WHY)>}
rule css-val-initial-letter { :i normal & <keyw> || <number> <integer>  || [<number> :my $*A;<!{
    $*A++
}>|| [[drop | raise ]& <keyw> ] ? :my $*B;<!{
    $*B++
}>]** 2  }
#| initial-letter-align: [ border-box? [ alphabetic | ideographic | hanging | leading ]? ]!
rule decl:sym<initial-letter-align> { :i ("initial-letter-align") ":" <val(/<css-val-initial-letter-align> /, &?ROUTINE.WHY)>}
rule css-val-initial-letter-align { :i [["border-box" & <keyw>] ? [[alphabetic | ideographic | hanging | leading ]& <keyw> ] ? ] }
#| initial-letter-wrap: none | first | all | grid | <length-percentage>
rule decl:sym<initial-letter-wrap> { :i ("initial-letter-wrap") ":" <val(/<css-val-initial-letter-wrap> /, &?ROUTINE.WHY)>}
rule css-val-initial-letter-wrap { :i [none | first | all | grid ]& <keyw>  || <length-percentage>  }
#| inline-sizing: normal | stretch
rule decl:sym<inline-sizing> { :i ("inline-sizing") ":" <val(/<css-val-inline-sizing> /, &?ROUTINE.WHY)>}
rule css-val-inline-sizing { :i [normal | stretch ]& <keyw>  }
#| line-fit-edge: leading | <text-edge>
rule decl:sym<line-fit-edge> { :i ("line-fit-edge") ":" <val(/<css-val-line-fit-edge> /, &?ROUTINE.WHY)>}
rule css-val-line-fit-edge { :i leading & <keyw> || <text-edge>  }
#| <text-edge> = [ text | ideographic | ideographic-ink ]              | [ text | ideographic | ideographic-ink | cap | ex ]                [ text | ideographic | ideographic-ink | alphabetic ]
rule text-edge { :i [[text | ideographic | "ideographic-ink" ]& <keyw> ] || [[text | ideographic | "ideographic-ink" | cap | ex ]& <keyw> ] [[text | ideographic | "ideographic-ink" | alphabetic ]& <keyw> ]   }
#| line-height: normal | <number [0,∞]> | <length-percentage [0,∞]>
rule decl:sym<line-height> { :i ("line-height") ":" <val(/<css-val-line-height> /, &?ROUTINE.WHY)>}
rule css-val-line-height { :i normal & <keyw> || <number> || <length-percentage>  }
#| text-box: normal | <'text-box-trim'> || <'text-box-edge'>
rule decl:sym<text-box> { :i ("text-box") ":" <val(/<css-val-text-box> /, &?ROUTINE.WHY)>}
rule css-val-text-box { :i normal & <keyw> || [<css-val-text-box-trim> :my $*A;<!{
    $*A++
}>|| <css-val-text-box-edge> :my $*B;<!{
    $*B++
}>]+  }
#| text-box-edge: auto | <text-edge>
rule decl:sym<text-box-edge> { :i ("text-box-edge") ":" <val(/<css-val-text-box-edge> /, &?ROUTINE.WHY)>}
rule css-val-text-box-edge { :i auto & <keyw> || <text-edge>  }
#| text-box-trim: none | trim-start | trim-end | trim-both
rule decl:sym<text-box-trim> { :i ("text-box-trim") ":" <val(/<css-val-text-box-trim> /, &?ROUTINE.WHY)>}
rule css-val-text-box-trim { :i [none | "trim-start" | "trim-end" | "trim-both" ]& <keyw>  }
#| vertical-align: [ first | last] || <'alignment-baseline'> || <'baseline-shift'>
rule decl:sym<vertical-align> { :i ("vertical-align") ":" <val(/<css-val-vertical-align> /, &?ROUTINE.WHY)>}
rule css-val-vertical-align { :i [[[first | last ]& <keyw> ] :my $*A; <!{
    $*A++
}>|| <css-val-alignment-baseline> :my $*B; <!{
    $*B++
}>|| <css-val-baseline-shift> :my $*C; <!{
    $*C++
}>]+ }