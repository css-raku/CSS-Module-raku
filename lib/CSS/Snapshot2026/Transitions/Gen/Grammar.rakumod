unit grammar CSS::Snapshot2026::Transitions::Gen::Grammar;
#| transition: <single-transition>#
rule decl:sym<transition> { :i (transition) ":" <val(/<prop-val-transition> /, &?ROUTINE.WHY)>}
rule prop-val-transition { :i <single-transition> +% <op(",")>? }
#| <single-transition> = [ none | <single-transition-property> ] || <time> || <easing-function> || <time>
rule single-transition { :i [[[none & <keyw> ] || <single-transition-property> ] :my $*A;<!{
    $*A++
}>|| <time> :my $*B;<!{
    $*B++
}>|| <easing-function> :my $*C;<!{
    $*C++
}>|| <time> :my $*D;<!{
    $*D++
}>]+ }
#| <single-transition-property> = all | <custom-ident>
rule single-transition-property { :i [all & <keyw> ] || <custom-ident>  }
#| transition-delay: <time>#
rule decl:sym<transition-delay> { :i ("transition-delay") ":" <val(/<prop-val-transition-delay> /, &?ROUTINE.WHY)>}
rule prop-val-transition-delay { :i <time> +% <op(",")>? }
#| transition-duration: <time [0s,∞]>#
rule decl:sym<transition-duration> { :i ("transition-duration") ":" <val(/<prop-val-transition-duration> /, &?ROUTINE.WHY)>}
rule prop-val-transition-duration { :i <time> +% <op(",")>? }
#| transition-property: none | <single-transition-property>#
rule decl:sym<transition-property> { :i ("transition-property") ":" <val(/<prop-val-transition-property> /, &?ROUTINE.WHY)>}
rule prop-val-transition-property { :i [none & <keyw> ] || <single-transition-property> +% <op(",")>?  }
#| transition-timing-function: <easing-function>#
rule decl:sym<transition-timing-function> { :i ("transition-timing-function") ":" <val(/<prop-val-transition-timing-function> /, &?ROUTINE.WHY)>}
rule prop-val-transition-timing-function { :i <easing-function> +% <op(",")>? }
#| view-transition-name: none | <custom-ident>
rule decl:sym<view-transition-name> { :i ("view-transition-name") ":" <val(/<prop-val-view-transition-name> /, &?ROUTINE.WHY)>}
rule prop-val-view-transition-name { :i [none & <keyw> ] || <custom-ident>  }