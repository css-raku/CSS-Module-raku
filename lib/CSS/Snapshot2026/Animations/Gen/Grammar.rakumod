unit grammar CSS::Snapshot2026::Animations::Gen::Grammar;
#| animation: <single-animation>#
rule decl:sym<animation> { :i (animation) ":" <val(/<prop-val-animation> /, &?ROUTINE.WHY)>}
rule prop-val-animation { :i <single-animation> +% <op(",")>? }
#| <single-animation> = <time [0s,∞]> || <easing-function> || <time> || <single-animation-iteration-count> || <single-animation-direction> || <single-animation-fill-mode> || <single-animation-play-state> || [ none | <keyframes-name> ]
rule single-animation { :i [<time> :my $*A;<!{
    $*A++
}>|| <easing-function> :my $*B;<!{
    $*B++
}>|| <time> :my $*C;<!{
    $*C++
}>|| <single-animation-iteration-count> :my $*D;<!{
    $*D++
}>|| <single-animation-direction> :my $*E;<!{
    $*E++
}>|| <single-animation-fill-mode> :my $*F;<!{
    $*F++
}>|| <single-animation-play-state> :my $*G;<!{
    $*G++
}>|| [[none & <keyw> ] || <keyframes-name> ] :my $*H;<!{
    $*H++
}>]+ }
#| <single-animation-iteration-count> = infinite | <number [0,∞]>
rule single-animation-iteration-count { :i [infinite & <keyw> ] || <number>  }
#| <single-animation-direction> = normal | reverse | alternate | alternate-reverse
rule single-animation-direction { :i [normal | reverse | alternate | "alternate-reverse" ]& <keyw>  }
#| <single-animation-fill-mode> = none | forwards | backwards | both
rule single-animation-fill-mode { :i [none | forwards | backwards | both ]& <keyw>  }
#| <single-animation-play-state> = running | paused
rule single-animation-play-state { :i [running | paused ]& <keyw>  }
#| animation-delay: <time>#
rule decl:sym<animation-delay> { :i ("animation-delay") ":" <val(/<prop-val-animation-delay> /, &?ROUTINE.WHY)>}
rule prop-val-animation-delay { :i <time> +% <op(",")>? }
#| animation-direction: <single-animation-direction>#
rule decl:sym<animation-direction> { :i ("animation-direction") ":" <val(/<prop-val-animation-direction> /, &?ROUTINE.WHY)>}
rule prop-val-animation-direction { :i <single-animation-direction> +% <op(",")>? }
#| animation-duration: <time [0s,∞]>#
rule decl:sym<animation-duration> { :i ("animation-duration") ":" <val(/<prop-val-animation-duration> /, &?ROUTINE.WHY)>}
rule prop-val-animation-duration { :i <time> +% <op(",")>? }
#| animation-fill-mode: <single-animation-fill-mode>#
rule decl:sym<animation-fill-mode> { :i ("animation-fill-mode") ":" <val(/<prop-val-animation-fill-mode> /, &?ROUTINE.WHY)>}
rule prop-val-animation-fill-mode { :i <single-animation-fill-mode> +% <op(",")>? }
#| animation-iteration-count: <single-animation-iteration-count>#
rule decl:sym<animation-iteration-count> { :i ("animation-iteration-count") ":" <val(/<prop-val-animation-iteration-count> /, &?ROUTINE.WHY)>}
rule prop-val-animation-iteration-count { :i <single-animation-iteration-count> +% <op(",")>? }
#| animation-name: [ none | <keyframes-name> ]#
rule decl:sym<animation-name> { :i ("animation-name") ":" <val(/<prop-val-animation-name> /, &?ROUTINE.WHY)>}
rule prop-val-animation-name { :i [[none & <keyw> ] || <keyframes-name> ] +% <op(",")>? }
#| <keyframes-name> = <custom-ident> | <string>
rule keyframes-name { :i <custom-ident> || <string>  }
#| animation-play-state: <single-animation-play-state>#
rule decl:sym<animation-play-state> { :i ("animation-play-state") ":" <val(/<prop-val-animation-play-state> /, &?ROUTINE.WHY)>}
rule prop-val-animation-play-state { :i <single-animation-play-state> +% <op(",")>? }
#| animation-timing-function: <easing-function>#
rule decl:sym<animation-timing-function> { :i ("animation-timing-function") ":" <val(/<prop-val-animation-timing-function> /, &?ROUTINE.WHY)>}
rule prop-val-animation-timing-function { :i <easing-function> +% <op(",")>? }
#| <easing-function> = <linear-easing-function> | <cubic-bezier-easing-function> | <step-easing-function>
rule easing-function { :i <linear-easing-function> || <cubic-bezier-easing-function> || <step-easing-function>  }
#| <linear-easing-function> = linear | <linear()>
rule linear-easing-function { :i [linear & <keyw> ] || <linear>  }
#| linear( [ <number> && <percentage>{0,2} ]# )
rule linear { :i "linear(" [[[<number> :my $*A;<!{
    $*A++
}>|| <percentage> ** 0..2 :my $*B;<!{
    $*B++
}>]** 2] +% ","? || <usage(&?ROUTINE.WHY)> ] ")" }
#| <cubic-bezier-easing-function> = ease | ease-in | ease-out | ease-in-out | <cubic-bezier()>
rule cubic-bezier-easing-function { :i [ease | "ease-in" | "ease-out" | "ease-in-out" ]& <keyw>  || <cubic-bezier>  }
#| cubic-bezier( [ <number [0,1]>, <number> ]#{2} )
rule cubic-bezier { :i "cubic-bezier(" [[<number> "," <number> ] ** 2% ","? || <usage(&?ROUTINE.WHY)> ] ")" }
#| <step-easing-function> = step-start | step-end | <steps()>
rule step-easing-function { :i ["step-start" | "step-end" ]& <keyw>  || <steps>  }
#| steps( <integer>, <step-position>?)
rule steps { :i "steps(" [<integer> ["," <step-position> ]?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| <step-position> = jump-start | jump-end | jump-none | jump-both | start | end
rule step-position { :i ["jump-start" | "jump-end" | "jump-none" | "jump-both" | start | end ]& <keyw>  }