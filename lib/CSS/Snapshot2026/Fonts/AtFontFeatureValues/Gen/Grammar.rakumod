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
#| <font-feature-declaration-list> = [ <font-feature-property> ]*
rule font-feature-declaration-list { :i <font-feature-property> * }
#| @stylistic { <font-feature-declaration-list> }
rule decl:sym<@stylistic> { "\@"<at-rule=.at-rule-stylistic>}
rule at-rule-stylistic { (:i stylistic) "\{" <font-feature-declaration-list> "}"  }
#| @historical-forms { <font-feature-declaration-list> }
rule decl:sym<@historical-forms> { "\@"<at-rule=.at-rule-historical-forms>}
rule at-rule-historical-forms { (:i "historical-forms") "\{" <font-feature-declaration-list> "}"  }
#| @styleset { <font-feature-declaration-list> }
rule decl:sym<@styleset> { "\@"<at-rule=.at-rule-styleset>}
rule at-rule-styleset { (:i styleset) "\{" <font-feature-declaration-list> "}"  }
#| @character-variant { <font-feature-declaration-list> }
rule decl:sym<@character-variant> { "\@"<at-rule=.at-rule-character-variant>}
rule at-rule-character-variant { (:i "character-variant") "\{" <font-feature-declaration-list> "}"  }
#| @swash { <font-feature-declaration-list> }
rule decl:sym<@swash> { "\@"<at-rule=.at-rule-swash>}
rule at-rule-swash { (:i swash) "\{" <font-feature-declaration-list> "}"  }
#| @ornaments { <font-feature-declaration-list> }
rule decl:sym<@ornaments> { "\@"<at-rule=.at-rule-ornaments>}
rule at-rule-ornaments { (:i ornaments) "\{" <font-feature-declaration-list> "}"  }
#| @annotation { <font-feature-declaration-list> }
rule decl:sym<@annotation> { "\@"<at-rule=.at-rule-annotation>}
rule at-rule-annotation { (:i annotation) "\{" <font-feature-declaration-list> "}"  }