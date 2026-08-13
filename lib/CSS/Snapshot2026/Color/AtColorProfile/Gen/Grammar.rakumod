unit grammar CSS::Snapshot2026::Color::AtColorProfile::Gen::Grammar;
#| components: <ident>#
rule decl:sym<components> { :i (components) ":" <val(/<prop-val-components> /, &?ROUTINE.WHY)>}
rule prop-val-components { :i <css-ident> +% <op(",")>? }
#| rendering-intent: relative-colorimetric | absolute-colorimetric | perceptual | saturation
rule decl:sym<rendering-intent> { :i ("rendering-intent") ":" <val(/<prop-val-rendering-intent> /, &?ROUTINE.WHY)>}
rule prop-val-rendering-intent { :i ["relative-colorimetric" | "absolute-colorimetric" | perceptual | saturation ]& <keyw>  }
#| src: <url>
rule decl:sym<src> { :i (src) ":" <val(/<prop-val-src> /, &?ROUTINE.WHY)>}
rule prop-val-src { :i <url> }