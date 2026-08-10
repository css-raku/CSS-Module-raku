unit grammar CSS::Snapshot2026::Speech::Gen::Grammar;
#| cue: <'cue-before'> <'cue-after'>?
rule decl:sym<cue> { :i (cue) ":" <val(/<prop-val-cue> /, &?ROUTINE.WHY)>}
rule prop-val-cue { :i <prop-val-cue-before> <prop-val-cue-after> ?  }
#| cue-after: <url> <decibel>? | none
rule decl:sym<cue-after> { :i ("cue-after") ":" <val(/<prop-val-cue-after> /, &?ROUTINE.WHY)>}
rule prop-val-cue-after { :i <url> <decibel> ?  || none & <keyw>  }
#| cue-before: <url> <decibel>? | none
rule decl:sym<cue-before> { :i ("cue-before") ":" <val(/<prop-val-cue-before> /, &?ROUTINE.WHY)>}
rule prop-val-cue-before { :i <url> <decibel> ?  || none & <keyw>  }
#| pause: <'pause-before'> <'pause-after'>?
rule decl:sym<pause> { :i (pause) ":" <val(/<prop-val-pause> /, &?ROUTINE.WHY)>}
rule prop-val-pause { :i <prop-val-pause-before> <prop-val-pause-after> ?  }
#| pause-after: <time [0s,∞]> | none | x-weak | weak | medium | strong | x-strong
rule decl:sym<pause-after> { :i ("pause-after") ":" <val(/<prop-val-pause-after> /, &?ROUTINE.WHY)>}
rule prop-val-pause-after { :i <time> || [none | "x-weak" | weak | medium | strong | "x-strong" ]& <keyw>   }
#| pause-before: <time [0s,∞]> | none | x-weak | weak | medium | strong | x-strong
rule decl:sym<pause-before> { :i ("pause-before") ":" <val(/<prop-val-pause-before> /, &?ROUTINE.WHY)>}
rule prop-val-pause-before { :i <time> || [none | "x-weak" | weak | medium | strong | "x-strong" ]& <keyw>   }
#| rest: <'rest-before'> <'rest-after'>?
rule decl:sym<rest> { :i (rest) ":" <val(/<prop-val-rest> /, &?ROUTINE.WHY)>}
rule prop-val-rest { :i <prop-val-rest-before> <prop-val-rest-after> ?  }
#| rest-after: <time [0s,∞]> | none | x-weak | weak | medium | strong | x-strong
rule decl:sym<rest-after> { :i ("rest-after") ":" <val(/<prop-val-rest-after> /, &?ROUTINE.WHY)>}
rule prop-val-rest-after { :i <time> || [none | "x-weak" | weak | medium | strong | "x-strong" ]& <keyw>   }
#| rest-before: <time [0s,∞]> | none | x-weak | weak | medium | strong | x-strong
rule decl:sym<rest-before> { :i ("rest-before") ":" <val(/<prop-val-rest-before> /, &?ROUTINE.WHY)>}
rule prop-val-rest-before { :i <time> || [none | "x-weak" | weak | medium | strong | "x-strong" ]& <keyw>   }
#| speak: auto | never | always
rule decl:sym<speak> { :i (speak) ":" <val(/<prop-val-speak> /, &?ROUTINE.WHY)>}
rule prop-val-speak { :i [auto | never | always ]& <keyw>  }
#| speak-as: normal | spell-out || digits || [ literal-punctuation | no-punctuation ]
rule decl:sym<speak-as> { :i ("speak-as") ":" <val(/<prop-val-speak-as> /, &?ROUTINE.WHY)>}
rule prop-val-speak-as { :i [[normal | "spell-out" ]& <keyw>  :my $*A;<!{
    $*A++
}>|| digits & <keyw> :my $*B;<!{
    $*B++
}>|| [["literal-punctuation" | "no-punctuation" ]& <keyw> ] :my $*C;<!{
    $*C++
}>]+ }
#| voice-balance: <number> | left | center | right | leftwards | rightwards
rule decl:sym<voice-balance> { :i ("voice-balance") ":" <val(/<prop-val-voice-balance> /, &?ROUTINE.WHY)>}
rule prop-val-voice-balance { :i <number> || [left | center | right | leftwards | rightwards ]& <keyw>   }
#| voice-duration: auto | <time [0s,∞]>
rule decl:sym<voice-duration> { :i ("voice-duration") ":" <val(/<prop-val-voice-duration> /, &?ROUTINE.WHY)>}
rule prop-val-voice-duration { :i auto & <keyw> || <time>  }
#| voice-family: [ <voice-family-name> | <generic-voice> ]# | preserve
rule decl:sym<voice-family> { :i ("voice-family") ":" <val(/<prop-val-voice-family> /, &?ROUTINE.WHY)>}
rule prop-val-voice-family { :i [<voice-family-name> || <generic-voice> ] +% <op(",")>? || preserve & <keyw>  }
#| <voice-family-name> = <string> | <identifiers>
rule voice-family-name { :i <string> || <identifiers>  }
#| <generic-voice> = <age>? <gender> <integer [1,∞]>?
rule generic-voice { :i <age> ? <gender> <integer> ?  }
#| <age> = child | young | old
rule age { :i [child | young | old ]& <keyw>  }
#| <gender> = male | female | neutral
rule gender { :i [male | female | neutral ]& <keyw>  }
#| voice-pitch: <frequency [0Hz,∞]> && absolute | [ [ x-low | low | medium | high | x-high ] || [ <frequency [0Hz,∞]> | <semitones> | <percentage> ] ]
rule decl:sym<voice-pitch> { :i ("voice-pitch") ":" <val(/<prop-val-voice-pitch> /, &?ROUTINE.WHY)>}
rule prop-val-voice-pitch { :i [<frequency> :my $*A;<!{
    $*A++
}>|| absolute & <keyw> :my $*B;<!{
    $*B++
}>]** 2 || [[[["x-low" | low | medium | high | "x-high" ]& <keyw> ] :my $*C;<!{
    $*C++
}>|| [<frequency> || <semitones> || <percentage> ] :my $*D;<!{
    $*D++
}>]+]  }
#| voice-range: <frequency [0Hz,∞]> && absolute | [ [ x-low | low | medium | high | x-high ] || [ <frequency [0Hz,∞]> | <semitones> | <percentage> ] ]
rule decl:sym<voice-range> { :i ("voice-range") ":" <val(/<prop-val-voice-range> /, &?ROUTINE.WHY)>}
rule prop-val-voice-range { :i [<frequency> :my $*A;<!{
    $*A++
}>|| absolute & <keyw> :my $*B;<!{
    $*B++
}>]** 2 || [[[["x-low" | low | medium | high | "x-high" ]& <keyw> ] :my $*C;<!{
    $*C++
}>|| [<frequency> || <semitones> || <percentage> ] :my $*D;<!{
    $*D++
}>]+]  }
#| voice-rate: [ normal | x-slow | slow | medium | fast | x-fast ] || <percentage [0,∞]>
rule decl:sym<voice-rate> { :i ("voice-rate") ":" <val(/<prop-val-voice-rate> /, &?ROUTINE.WHY)>}
rule prop-val-voice-rate { :i [[[normal | "x-slow" | slow | medium | fast | "x-fast" ]& <keyw> ] :my $*A;<!{
    $*A++
}>|| <percentage> :my $*B;<!{
    $*B++
}>]+ }
#| voice-stress: normal | strong | moderate | none | reduced
rule decl:sym<voice-stress> { :i ("voice-stress") ":" <val(/<prop-val-voice-stress> /, &?ROUTINE.WHY)>}
rule prop-val-voice-stress { :i [normal | strong | moderate | none | reduced ]& <keyw>  }
#| voice-volume: silent | [ [ x-soft | soft | medium | loud | x-loud ] || <decibel> ]
rule decl:sym<voice-volume> { :i ("voice-volume") ":" <val(/<prop-val-voice-volume> /, &?ROUTINE.WHY)>}
rule prop-val-voice-volume { :i silent & <keyw> || [[[["x-soft" | soft | medium | loud | "x-loud" ]& <keyw> ] :my $*A; <!{
    $*A++
}>|| <decibel> :my $*B; <!{
    $*B++
}>]+]  }