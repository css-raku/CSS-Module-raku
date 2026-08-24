unit grammar CSS::Snapshot2026::Fonts::AtFontFeatureValues::Gen::Grammar;
#| @font-feature-values <font-family-name># <declarations>
rule decl:sym<@font-feature-values> { "\@"<at-rule=.at-rule-font-feature-values>}
rule at-rule-font-feature-values { (:i "font-feature-values") <font-family-name> +% <op(",")>? <declarations>  }
#| font-display: auto | block | swap | fallback | optional
rule decl:sym<font-display> { :i ("font-display") ":" <val(/<prop-val-font-display> /, &?ROUTINE.WHY)>}
rule prop-val-font-display { :i [auto | block | swap | fallback | optional ]& <keyw>  }
#| <font-feature-value-name> = <ident>
rule font-feature-value-name { :i <Ident> }
#| <font-feature-index> = <integer>
rule font-feature-index { :i <integer> }
#| <font-feature-property> = <font-feature-value-name> : <font-feature-index> <end-decl>
rule font-feature-property { :i <font-feature-value-name> <op(":")> <font-feature-index> <end-decl>  }
#| <swash-declaration-list> = [ <font-feature-property> ]*
rule swash-declaration-list { :i <font-feature-property> * }
#| @swash { <swash-declaration-list> }
rule decl:sym<@swash> { "\@"<at-rule=.at-rule-swash>}
rule at-rule-swash { (:i swash) <op("\{")> <swash-declaration-list> <op("}")>  }
#| @ornaments { <declaration-list> }
rule decl:sym<@ornaments> { "\@"<at-rule=.at-rule-ornaments>}
rule at-rule-ornaments { (:i ornaments) <op("\{")> <declaration-list> <op("}")>  }
#| @annotation { <declaration-list> }
rule decl:sym<@annotation> { "\@"<at-rule=.at-rule-annotation>}
rule at-rule-annotation { (:i annotation) <op("\{")> <declaration-list> <op("}")>  }