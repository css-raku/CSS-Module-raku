unit grammar CSS::Snapshot2026::Compositing::Gen::Grammar;
#| background-blend-mode: <blend-mode>#
rule decl:sym<background-blend-mode> { :i ("background-blend-mode") ":" <val(/<prop-val-background-blend-mode> /, &?ROUTINE.WHY)>}
rule prop-val-background-blend-mode { :i <blend-mode> +% <op(",")>? }
#| isolation: <isolation-mode>
rule decl:sym<isolation> { :i (isolation) ":" <val(/<prop-val-isolation> /, &?ROUTINE.WHY)>}
rule prop-val-isolation { :i <isolation-mode> }
#| mix-blend-mode: <blend-mode>
rule decl:sym<mix-blend-mode> { :i ("mix-blend-mode") ":" <val(/<prop-val-mix-blend-mode> /, &?ROUTINE.WHY)>}
rule prop-val-mix-blend-mode { :i <blend-mode> }
#| <blend-mode> = normal |  darken | multiply | color-burn |  lighten | screen | color-dodge |  overlay | soft-light | hard-light |  difference | exclusion |  hue | saturation | color | luminosity
rule blend-mode { :i [normal | darken | multiply | "color-burn" | lighten | screen | "color-dodge" | overlay | "soft-light" | "hard-light" | difference | exclusion | hue | saturation | color | luminosity ]& <keyw>  }
#| <isolation-mode> = auto | isolate
rule isolation-mode { :i [auto | isolate ]& <keyw>  }