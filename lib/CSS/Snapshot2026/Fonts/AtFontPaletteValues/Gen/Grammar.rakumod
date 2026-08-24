unit grammar CSS::Snapshot2026::Fonts::AtFontPaletteValues::Gen::Grammar;
#| @font-palette-values <dashed-ident> {  <declaration-list>}
rule decl:sym<@font-palette-values> { "\@"<at-rule=.at-rule-font-palette-values>}
rule at-rule-font-palette-values { (:i "font-palette-values") <dashed-ident> <op("\{")> <declaration-list> <op("}")>  }
#| <dashed-ident> = <custom-ident>
rule dashed-ident { :i <custom-ident> }
#| base-palette: light | dark | <integer [0,∞]>
rule decl:sym<base-palette> { :i ("base-palette") ":" <val(/<prop-val-base-palette> /, &?ROUTINE.WHY)>}
rule prop-val-base-palette { :i [light | dark ]& <keyw>  || <integer>  }
#| font-family: <font-family-name>#
rule decl:sym<font-family> { :i ("font-family") ":" <val(/<prop-val-font-family> /, &?ROUTINE.WHY)>}
rule prop-val-font-family { :i <font-family-name> +% <op(",")>? }
#| override-colors: [ <integer [0,∞]> <color> ]#
rule decl:sym<override-colors> { :i ("override-colors") ":" <val(/<prop-val-override-colors> /, &?ROUTINE.WHY)>}
rule prop-val-override-colors { :i [<integer> <color> ] +% <op(",")>? }