unit grammar CSS::Snapshot2026::Fonts::AtFontFace::Gen::Grammar;
#| ascent-override: normal | <percentage [0,∞]>
rule decl:sym<ascent-override> { :i ("ascent-override") ":" <val(/<prop-val-ascent-override> /, &?ROUTINE.WHY)>}
rule prop-val-ascent-override { :i normal & <keyw> || <percentage>  }
#| descent-override: normal | <percentage [0,∞]>
rule decl:sym<descent-override> { :i ("descent-override") ":" <val(/<prop-val-descent-override> /, &?ROUTINE.WHY)>}
rule prop-val-descent-override { :i normal & <keyw> || <percentage>  }
#| font-display: auto | block | swap | fallback | optional
rule decl:sym<font-display> { :i ("font-display") ":" <val(/<prop-val-font-display> /, &?ROUTINE.WHY)>}
rule prop-val-font-display { :i [auto | block | swap | fallback | optional ]& <keyw>  }
#| font-family: <font-family-name>
rule decl:sym<font-family> { :i ("font-family") ":" <val(/<prop-val-font-family> /, &?ROUTINE.WHY)>}
rule prop-val-font-family { :i <font-family-name> }
#| font-feature-settings: normal | <feature-tag-value>#
rule decl:sym<font-feature-settings> { :i ("font-feature-settings") ":" <val(/<prop-val-font-feature-settings> /, &?ROUTINE.WHY)>}
rule prop-val-font-feature-settings { :i normal & <keyw> || <feature-tag-value> +% <op(",")>?  }
#| font-language-override: normal | <string>
rule decl:sym<font-language-override> { :i ("font-language-override") ":" <val(/<prop-val-font-language-override> /, &?ROUTINE.WHY)>}
rule prop-val-font-language-override { :i normal & <keyw> || <string>  }
#| font-named-instance: auto | <string>
rule decl:sym<font-named-instance> { :i ("font-named-instance") ":" <val(/<prop-val-font-named-instance> /, &?ROUTINE.WHY)>}
rule prop-val-font-named-instance { :i auto & <keyw> || <string>  }
#| font-style: auto | normal | italic | left | right | oblique [ <angle [-90deg,90deg]>{1,2} ]?
rule decl:sym<font-style> { :i ("font-style") ":" <val(/<prop-val-font-style> /, &?ROUTINE.WHY)>}
rule prop-val-font-style { :i [auto | normal | italic | left | right | oblique ]& <keyw>  [<angle> ** 1..2] ?  }
#| font-variation-settings: normal | [ <string> <number>]#
rule decl:sym<font-variation-settings> { :i ("font-variation-settings") ":" <val(/<prop-val-font-variation-settings> /, &?ROUTINE.WHY)>}
rule prop-val-font-variation-settings { :i normal & <keyw> || [<string> <number> ] +% <op(",")>?  }
#| font-weight: auto | <font-weight-absolute>{1,2}
rule decl:sym<font-weight> { :i ("font-weight") ":" <val(/<prop-val-font-weight> /, &?ROUTINE.WHY)>}
rule prop-val-font-weight { :i auto & <keyw> || <font-weight-absolute> ** 1..2  }
#| font-width: auto | <'font-width'>{1,2}
rule decl:sym<font-width> { :i ("font-width") ":" <val(/<prop-val-font-width> /, &?ROUTINE.WHY)>}
rule prop-val-font-width { :i auto & <keyw> || <prop-val-font-width> ** 1..2  }
#| line-gap-override: normal | <percentage [0,∞]>
rule decl:sym<line-gap-override> { :i ("line-gap-override") ":" <val(/<prop-val-line-gap-override> /, &?ROUTINE.WHY)>}
rule prop-val-line-gap-override { :i normal & <keyw> || <percentage>  }
#| src: <font-src>#
rule decl:sym<src> { :i (src) ":" <val(/<prop-val-src> /, &?ROUTINE.WHY)>}
rule prop-val-src { :i <font-src> +% <op(",")>? }
#| <font-src> = <url> [ format( <font-format> ) ]? [ tech( <font-tech># ) ]? | local( <font-family-name> )
rule font-src { :i <url> <format> ? <tech> ?  || <local>  }
#| format( <font-format> )
rule format { :i "format(" [<font-format> || <usage(&?ROUTINE.WHY)> ] ")" }
#| tech( <font-tech># )
rule tech { :i "tech(" [<font-tech> +% ","? || <usage(&?ROUTINE.WHY)> ] ")" }
#| local( <font-family-name> )
rule local { :i "local(" [<font-family-name> || <usage(&?ROUTINE.WHY)> ] ")" }
#| <font-format> = [ <string> | collection | embedded-opentype | opentype      | svg | truetype | woff | woff2 ]
rule font-format { :i [<string> || [collection | "embedded-opentype" | opentype | svg | truetype | woff | woff2 ]& <keyw>  ] }
#| <font-tech> = [ <font-features-tech> | <color-font-tech>      | variations | palettes | incremental ]
rule font-tech { :i [<font-features-tech> || <color-font-tech> || [variations | palettes | incremental ]& <keyw>  ] }
#| <font-features-tech> = [ features-opentype | features-aat | features-graphite ]
rule font-features-tech { :i [["features-opentype" | "features-aat" | "features-graphite" ]& <keyw> ] }
#| <color-font-tech> = [ color-COLRv0 | color-COLRv1 | color-SVG | color-sbix | color-CBDT ]
rule color-font-tech { :i [["color-COLRv0" | "color-COLRv1" | "color-SVG" | "color-sbix" | "color-CBDT" ]& <keyw> ] }
#| unicode-range: <unicode-range>#
rule decl:sym<unicode-range> { :i ("unicode-range") ":" <val(/<prop-val-unicode-range> /, &?ROUTINE.WHY)>}
rule prop-val-unicode-range { :i <unicode-range> +% <op(",")>? }