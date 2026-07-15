unit grammar CSS::Snapshot2026::Speech::Gen::Grammar;
#| cue: <'cue-before'> <'cue-after'>?
rule decl:sym<cue> { :i (cue) ":" <val(/<css-val-cue> /, &?ROUTINE.WHY)>}
rule css-val-cue { :i <css-val-cue-before> <css-val-cue-after> ?  }
#| cue-after: <url> <decibel>? | none
rule decl:sym<cue-after> { :i ("cue-after") ":" <val(/<css-val-cue-after> /, &?ROUTINE.WHY)>}
rule css-val-cue-after { :i <url> <decibel> ?  || none & <keyw>  }
#| cue-before: <url> <decibel>? | none
rule decl:sym<cue-before> { :i ("cue-before") ":" <val(/<css-val-cue-before> /, &?ROUTINE.WHY)>}
rule css-val-cue-before { :i <url> <decibel> ?  || none & <keyw>  }
#| pause: <'pause-before'> <'pause-after'>?
rule decl:sym<pause> { :i (pause) ":" <val(/<css-val-pause> /, &?ROUTINE.WHY)>}
rule css-val-pause { :i <css-val-pause-before> <css-val-pause-after> ?  }
#| pause-after: <time [0s,∞]> | none | x-weak | weak | medium | strong | x-strong
rule decl:sym<pause-after> { :i ("pause-after") ":" <val(/<css-val-pause-after> /, &?ROUTINE.WHY)>}
rule css-val-pause-after { :i <time> || [none | "x-weak" | weak | medium | strong | "x-strong" ]& <keyw>   }
#| pause-before: <time [0s,∞]> | none | x-weak | weak | medium | strong | x-strong
rule decl:sym<pause-before> { :i ("pause-before") ":" <val(/<css-val-pause-before> /, &?ROUTINE.WHY)>}
rule css-val-pause-before { :i <time> || [none | "x-weak" | weak | medium | strong | "x-strong" ]& <keyw>   }
#| rest: <'rest-before'> <'rest-after'>?
rule decl:sym<rest> { :i (rest) ":" <val(/<css-val-rest> /, &?ROUTINE.WHY)>}
rule css-val-rest { :i <css-val-rest-before> <css-val-rest-after> ?  }
#| rest-after: <time [0s,∞]> | none | x-weak | weak | medium | strong | x-strong
rule decl:sym<rest-after> { :i ("rest-after") ":" <val(/<css-val-rest-after> /, &?ROUTINE.WHY)>}
rule css-val-rest-after { :i <time> || [none | "x-weak" | weak | medium | strong | "x-strong" ]& <keyw>   }
#| rest-before: <time [0s,∞]> | none | x-weak | weak | medium | strong | x-strong
rule decl:sym<rest-before> { :i ("rest-before") ":" <val(/<css-val-rest-before> /, &?ROUTINE.WHY)>}
rule css-val-rest-before { :i <time> || [none | "x-weak" | weak | medium | strong | "x-strong" ]& <keyw>   }
#| speak: auto | never | always
rule decl:sym<speak> { :i (speak) ":" <val(/<css-val-speak> /, &?ROUTINE.WHY)>}
rule css-val-speak { :i [auto | never | always ]& <keyw>  }
#| speak-as: normal | spell-out || digits || [ literal-punctuation | no-punctuation ]
rule decl:sym<speak-as> { :i ("speak-as") ":" <val(/<css-val-speak-as> /, &?ROUTINE.WHY)>}
rule css-val-speak-as { :i [[normal | "spell-out" ]& <keyw>  :my $*A;<!{
    $*A++
}>|| digits & <keyw> :my $*B;<!{
    $*B++
}>|| [["literal-punctuation" | "no-punctuation" ]& <keyw> ] :my $*C;<!{
    $*C++
}>]+ }
#| voice-balance: <number> | left | center | right | leftwards | rightwards
rule decl:sym<voice-balance> { :i ("voice-balance") ":" <val(/<css-val-voice-balance> /, &?ROUTINE.WHY)>}
rule css-val-voice-balance { :i <number> || [left | center | right | leftwards | rightwards ]& <keyw>   }
#| voice-duration: auto | <time [0s,∞]>
rule decl:sym<voice-duration> { :i ("voice-duration") ":" <val(/<css-val-voice-duration> /, &?ROUTINE.WHY)>}
rule css-val-voice-duration { :i auto & <keyw> || <time>  }
#| voice-family: [ <voice-family-name> | <generic-voice> ]# | preserve
rule decl:sym<voice-family> { :i ("voice-family") ":" <val(/<css-val-voice-family> /, &?ROUTINE.WHY)>}
rule css-val-voice-family { :i [<voice-family-name> || <generic-voice> ] +% <op(",")>? || preserve & <keyw>  }
#| <voice-family-name> = <string> | <identifiers>
rule voice-family-name { :i <string> || <identifiers>  }
#| <generic-voice> = <age>? <gender> <integer [1,∞]>?
rule generic-voice { :i <age> ? <gender> <integer> ?  }
#| <age> = child | young | old
rule age { :i [child | young | old ]& <keyw>  }
#| <gender> = male | female | neutral
rule gender { :i [male | female | neutral ]& <keyw>  }
#| voice-pitch: <frequency [0Hz,∞]> && absolute | [ [ x-low | low | medium | high | x-high ] || [ <frequency [0Hz,∞]> | <semitones> | <percentage> ] ]
rule decl:sym<voice-pitch> { :i ("voice-pitch") ":" <val(/<css-val-voice-pitch> /, &?ROUTINE.WHY)>}
rule css-val-voice-pitch { :i [<frequency> :my $*A;<!{
    $*A++
}>|| absolute & <keyw> :my $*B;<!{
    $*B++
}>]** 2 || [[[["x-low" | low | medium | high | "x-high" ]& <keyw> ] :my $*C;<!{
    $*C++
}>|| [<frequency> || <semitones> || <percentage> ] :my $*D;<!{
    $*D++
}>]+]  }
#| voice-range: <frequency [0Hz,∞]> && absolute | [ [ x-low | low | medium | high | x-high ] || [ <frequency [0Hz,∞]> | <semitones> | <percentage> ] ]
rule decl:sym<voice-range> { :i ("voice-range") ":" <val(/<css-val-voice-range> /, &?ROUTINE.WHY)>}
rule css-val-voice-range { :i [<frequency> :my $*A;<!{
    $*A++
}>|| absolute & <keyw> :my $*B;<!{
    $*B++
}>]** 2 || [[[["x-low" | low | medium | high | "x-high" ]& <keyw> ] :my $*C;<!{
    $*C++
}>|| [<frequency> || <semitones> || <percentage> ] :my $*D;<!{
    $*D++
}>]+]  }
#| voice-rate: [ normal | x-slow | slow | medium | fast | x-fast ] || <percentage [0,∞]>
rule decl:sym<voice-rate> { :i ("voice-rate") ":" <val(/<css-val-voice-rate> /, &?ROUTINE.WHY)>}
rule css-val-voice-rate { :i [[[normal | "x-slow" | slow | medium | fast | "x-fast" ]& <keyw> ] :my $*A;<!{
    $*A++
}>|| <percentage> :my $*B;<!{
    $*B++
}>]+ }
#| voice-stress: normal | strong | moderate | none | reduced
rule decl:sym<voice-stress> { :i ("voice-stress") ":" <val(/<css-val-voice-stress> /, &?ROUTINE.WHY)>}
rule css-val-voice-stress { :i [normal | strong | moderate | none | reduced ]& <keyw>  }
#| voice-volume: silent | [ [ x-soft | soft | medium | loud | x-loud ] || <decibel> ]
rule decl:sym<voice-volume> { :i ("voice-volume") ":" <val(/<css-val-voice-volume> /, &?ROUTINE.WHY)>}
rule css-val-voice-volume { :i silent & <keyw> || [[[["x-soft" | soft | medium | loud | "x-loud" ]& <keyw> ] :my $*A; <!{
    $*A++
}>|| <decibel> :my $*B; <!{
    $*B++
}>]+]  }