unit grammar CSS::Snapshot2026::Fonts::Defs::Gen::Grammar;
#| <font-family-name> = <identifiers> | <string>
rule font-family-name { :i <identifiers> || <string>  }
#| <font-variant-css2> = normal | small-caps
rule font-variant-css2 { :i [normal | "small-caps" ]& <keyw>  }
#| <font-feature-value-name> = <ident>
rule font-feature-value-name { :i <ident> }
#| <feature-tag-value> = <opentype-tag> [ <integer [0,∞]> | on | off ]?
rule feature-tag-value { :i <opentype-tag> [<integer> || [on | off ]& <keyw>  ] ?  }
#| <opentype-tag> = <string>
rule opentype-tag { :i <string> }
#| <east-asian-variant-values> = [ jis78 | jis83 | jis90 | jis04 | simplified | traditional ]
rule east-asian-variant-values { :i [[jis78 | jis83 | jis90 | jis04 | simplified | traditional ]& <keyw> ] }
#| <east-asian-width-values> = [ full-width | proportional-width ]
rule east-asian-width-values { :i [["full-width" | "proportional-width" ]& <keyw> ] }
#| <common-lig-values> = [ common-ligatures | no-common-ligatures ]
rule common-lig-values { :i [["common-ligatures" | "no-common-ligatures" ]& <keyw> ] }
#| <discretionary-lig-values> = [ discretionary-ligatures | no-discretionary-ligatures ]
rule discretionary-lig-values { :i [["discretionary-ligatures" | "no-discretionary-ligatures" ]& <keyw> ] }
#| <historical-lig-values> = [ historical-ligatures | no-historical-ligatures ]
rule historical-lig-values { :i [["historical-ligatures" | "no-historical-ligatures" ]& <keyw> ] }
#| <contextual-alt-values> = [ contextual | no-contextual ]
rule contextual-alt-values { :i [[contextual | "no-contextual" ]& <keyw> ] }
#| stylistic(<font-feature-value-name>)
rule stylistic { :i "stylistic(" [<font-feature-value-name> || <usage(&?ROUTINE.WHY)> ] ")" }
#| styleset(<font-feature-value-name>#)
rule styleset { :i "styleset(" [<font-feature-value-name> +% "," || <usage(&?ROUTINE.WHY)> ] ")" }
#| character-variant(<font-feature-value-name>#)
rule character-variant { :i "character-variant(" [<font-feature-value-name> +% "," || <usage(&?ROUTINE.WHY)> ] ")" }
#| swash(<font-feature-value-name>)
rule swash { :i "swash(" [<font-feature-value-name> || <usage(&?ROUTINE.WHY)> ] ")" }
#| ornaments(<font-feature-value-name>)
rule ornaments { :i "ornaments(" [<font-feature-value-name> || <usage(&?ROUTINE.WHY)> ] ")" }
#| annotation(<font-feature-value-name>)
rule annotation { :i "annotation(" [<font-feature-value-name> || <usage(&?ROUTINE.WHY)> ] ")" }
#| <numeric-figure-values> = [ lining-nums | oldstyle-nums ]
rule numeric-figure-values { :i [["lining-nums" | "oldstyle-nums" ]& <keyw> ] }
#| <numeric-spacing-values> = [ proportional-nums | tabular-nums ]
rule numeric-spacing-values { :i [["proportional-nums" | "tabular-nums" ]& <keyw> ] }
#| <numeric-fraction-values> = [ diagonal-fractions | stacked-fractions ]
rule numeric-fraction-values { :i [["diagonal-fractions" | "stacked-fractions" ]& <keyw> ] }
#| <font-weight-absolute> = [ normal | bold | <number [1,1000]> ]
rule font-weight-absolute { :i [[normal | bold ]& <keyw>  || <number> ] }