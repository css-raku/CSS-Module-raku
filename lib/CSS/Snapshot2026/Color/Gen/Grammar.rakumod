unit grammar CSS::Snapshot2026::Color::Gen::Grammar;
#| <opacity-value> = <number> | <percentage>
rule opacity-value { :i <number> || <percentage>  }
#| <color-space> = <rectangular-color-space> | <polar-color-space> | <custom-color-space>
rule color-space { :i <rectangular-color-space> || <polar-color-space> || <custom-color-space>  }
#| <rectangular-color-space> = srgb | srgb-linear | display-p3 | display-p3-linear | a98-rgb | prophoto-rgb | rec2020 | lab | oklab | <xyz-space>
rule rectangular-color-space { :i [srgb | "srgb-linear" | "display-p3" | "display-p3-linear" | "a98-rgb" | "prophoto-rgb" | rec2020 | lab | oklab ]& <keyw>  || <xyz-space>  }
#| <polar-color-space> = hsl | hwb | lch | oklch
rule polar-color-space { :i [hsl | hwb | lch | oklch ]& <keyw>  }
#| <custom-color-space> = <dashed-ident>
rule custom-color-space { :i <dashed-ident> }
#| <hue-interpolation-method> = [ shorter | longer | increasing | decreasing ] hue
rule hue-interpolation-method { :i [[shorter | longer | increasing | decreasing ]& <keyw> ] hue & <keyw>  }
#| <color-interpolation-method> = in [ <rectangular-color-space> | <polar-color-space> <hue-interpolation-method>? | <custom-color-space> ]
rule color-interpolation-method { :i in & <keyw> [<rectangular-color-space> || <polar-color-space> <hue-interpolation-method> ?  || <custom-color-space> ]  }
#| <xyz-space> = xyz | xyz-d50 | xyz-d65
rule xyz-space { :i [xyz | "xyz-d50" | "xyz-d65" ]& <keyw>  }
#| rgb([<number> | <percentage>]#{3} [[,|/] <alpha-value>]?)
rule rgb { :i "rgb(" [[<number> || <percentage> ] ** 3% ","? [["," || <op("/")> ] <alpha-value> ] ?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| rgba([<number> | <percentage>]#{3} [[,|/] <alpha-value>]?)
rule rgba { :i "rgba(" [[<number> || <percentage> ] ** 3% ","? [["," || <op("/")> ] <alpha-value> ] ?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| hsl(    [<hue> | none] ,?  [<percentage> | <number> | none] ,?    [<percentage> | <number> | none] [,|/]? [ <alpha-value>]?)
rule hsl { :i "hsl(" [[<hue> || none & <keyw> ] [","] ? [<percentage> || <number> || none & <keyw> ] [","] ? [<percentage> || <number> || none & <keyw> ] ["," || <op("/")> ] ? <alpha-value> ?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| hsla(    [<hue> | none] ,?  [<percentage> | <number> | none] ,?    [<percentage> | <number> | none] [,|/]? [ <alpha-value>]?)
rule hsla { :i "hsla(" [[<hue> || none & <keyw> ] [","] ? [<percentage> || <number> || none & <keyw> ] [","] ? [<percentage> || <number> || none & <keyw> ] ["," || <op("/")> ] ? <alpha-value> ?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| <hue> = <number> | <angle>
rule hue { :i <number> || <angle>  }
#| <system-color> = AccentColor | AccentColorText | ActiveText | ButtonBorder | ButtonFace| ButtonText | Canvas | CanvasText | Field | FieldText| GrayText | Highlight | HighlightText| LinkText | Mark | MarkText | SelectedItem | SelectedItemText | VisitedText
rule system-color { :i [AccentColor | AccentColorText | ActiveText | ButtonBorder | ButtonFace | ButtonText | Canvas | CanvasText | Field | FieldText | GrayText | Highlight | HighlightText | LinkText | Mark | MarkText | SelectedItem | SelectedItemText | VisitedText ]& <keyw>  }
#| color: <color> | <system-color>
rule decl:sym<color> { :i (color) ":" <val(/<css-val-color> /, &?ROUTINE.WHY)>}
rule css-val-color { :i <color> || <system-color>  }
#| opacity: <opacity-value>
rule decl:sym<opacity> { :i (opacity) ":" <val(/<css-val-opacity> /, &?ROUTINE.WHY)>}
rule css-val-opacity { :i <opacity-value> }