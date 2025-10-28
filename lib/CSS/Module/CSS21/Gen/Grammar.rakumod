unit grammar CSS::Module::CSS21::Gen::Grammar;
#| azimuth: <angle> | [ <direction> || <behind> ] | <delta>
rule decl:sym<azimuth> { :i (azimuth) ":" <val(/<expr=.expr-azimuth> /, &?ROUTINE.WHY)>}
rule expr-azimuth { :i <angle> || [[:my @S; <direction><!{
    @S[0]++
}>| <behind><!{
    @S[1]++
}>]+] || <delta>  }
#| leftwards | rightwards
rule delta { :i [leftwards | rightwards ]& <keyw>  }
#| left-side | far-left | left | center-left | center | center-right | right | far-right | right-side
rule direction { :i ["left-side" | "far-left" | left | "center-left" | center | "center-right" | right | "far-right" | "right-side" ]& <keyw>  }
#| behind
rule behind { :i behind & <keyw>  }
#| background-attachment: scroll | fixed
rule decl:sym<background-attachment> { :i ("background-attachment") ":" <val(/<expr=.expr-background-attachment> /, &?ROUTINE.WHY)>}
rule expr-background-attachment { :i [scroll | fixed ]& <keyw>  }
#| background-color: <color> | transparent
rule decl:sym<background-color> { :i ("background-color") ":" <val(/<expr=.expr-background-color> /, &?ROUTINE.WHY)>}
rule expr-background-color { :i <color> || transparent & <keyw>   }
#| background-image: <uri> | none
rule decl:sym<background-image> { :i ("background-image") ":" <val(/<expr=.expr-background-image> /, &?ROUTINE.WHY)>}
rule expr-background-image { :i <uri> || none & <keyw>   }
#| background-position: [ [ <percentage> | <length> | <align> ] [ <percentage> | <length> | <valign> ]? ] | [ <align> || <valign> ]
rule decl:sym<background-position> { :i ("background-position") ":" <val(/<expr=.expr-background-position> /, &?ROUTINE.WHY)>}
rule expr-background-position { :i [[<percentage> || <length> || <align> ] [<percentage> || <length> || <valign> ] ? ] || [[:my @S; <align><!{
    @S[0]++
}>| <valign><!{
    @S[1]++
}>]+]  }
#| left | center | right
rule align { :i [left | center | right ]& <keyw>  }
#| top | center | bottom
rule valign { :i [top | center | bottom ]& <keyw>  }
#| background-repeat: repeat | repeat-x | repeat-y | no-repeat
rule decl:sym<background-repeat> { :i ("background-repeat") ":" <val(/<expr=.expr-background-repeat> /, &?ROUTINE.WHY)>}
rule expr-background-repeat { :i [repeat | "repeat-x" | "repeat-y" | "no-repeat" ]& <keyw>  }
#| background: ['background-color' || 'background-image' || 'background-repeat' || 'background-attachment' || 'background-position']
rule decl:sym<background> { :i (background) ":" <val(/<expr=.expr-background> /, &?ROUTINE.WHY)>}
rule expr-background { :i [[:my @S; <expr-background-color><!{
    @S[0]++
}>| <expr-background-image><!{
    @S[1]++
}>| <expr-background-repeat><!{
    @S[2]++
}>| <expr-background-attachment><!{
    @S[3]++
}>| <expr-background-position><!{
    @S[4]++
}>]+] }
#| border-collapse: collapse | separate
rule decl:sym<border-collapse> { :i ("border-collapse") ":" <val(/<expr=.expr-border-collapse> /, &?ROUTINE.WHY)>}
rule expr-border-collapse { :i [collapse | separate ]& <keyw>  }
#| border-color: [ <color> | transparent ]{1,4}
rule decl:sym<border-color> { :i ("border-color") ":" <val(/<expr=.expr-border-color>** 1..4 /, &?ROUTINE.WHY)>}
rule expr-border-color { :i [<color> || transparent & <keyw>  ] }
#| border-spacing: <length> <length>?
rule decl:sym<border-spacing> { :i ("border-spacing") ":" <val(/<expr=.expr-border-spacing> /, &?ROUTINE.WHY)>}
rule expr-border-spacing { :i <length> <length> ?  }
#| border-style: <border-style>{1,4}
rule decl:sym<border-style> { :i ("border-style") ":" <val(/<expr=.expr-border-style>** 1..4 /, &?ROUTINE.WHY)>}
rule expr-border-style { :i <border-style> }
#| none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset
rule border-style { :i [none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw>  }
#| border-top: [ 'border-top-width' || 'border-top-style' || 'border-top-color' ]
rule decl:sym<border-top> { :i ("border-top") ":" <val(/<expr=.expr-border-top> /, &?ROUTINE.WHY)>}
rule expr-border-top { :i [[:my @S; <expr-border-top-width><!{
    @S[0]++
}>| <expr-border-top-style><!{
    @S[1]++
}>| <expr-border-top-color><!{
    @S[2]++
}>]+] }
#| border-right: [ 'border-right-width' || 'border-right-style' || 'border-right-color' ]
rule decl:sym<border-right> { :i ("border-right") ":" <val(/<expr=.expr-border-right> /, &?ROUTINE.WHY)>}
rule expr-border-right { :i [[:my @S; <expr-border-right-width><!{
    @S[0]++
}>| <expr-border-right-style><!{
    @S[1]++
}>| <expr-border-right-color><!{
    @S[2]++
}>]+] }
#| border-bottom: [ 'border-bottom-width' || 'border-bottom-style' || 'border-bottom-color' ]
rule decl:sym<border-bottom> { :i ("border-bottom") ":" <val(/<expr=.expr-border-bottom> /, &?ROUTINE.WHY)>}
rule expr-border-bottom { :i [[:my @S; <expr-border-bottom-width><!{
    @S[0]++
}>| <expr-border-bottom-style><!{
    @S[1]++
}>| <expr-border-bottom-color><!{
    @S[2]++
}>]+] }
#| border-left: [ 'border-left-width' || 'border-left-style' || 'border-left-color' ]
rule decl:sym<border-left> { :i ("border-left") ":" <val(/<expr=.expr-border-left> /, &?ROUTINE.WHY)>}
rule expr-border-left { :i [[:my @S; <expr-border-left-width><!{
    @S[0]++
}>| <expr-border-left-style><!{
    @S[1]++
}>| <expr-border-left-color><!{
    @S[2]++
}>]+] }
#| border-top-color: <color> | transparent
rule decl:sym<border-top-color> { :i ("border-top-color") ":" <val(/<expr=.expr-border-top-color> /, &?ROUTINE.WHY)>}
rule expr-border-top-color { :i <color> || transparent & <keyw>   }
#| border-top-color: <color> | transparent
rule decl:sym<border-right-color> { :i ("border-right-color") ":" <val(/<expr=.expr-border-right-color> /, &?ROUTINE.WHY)>}
rule expr-border-right-color { :i <color> || transparent & <keyw>   }
#| border-top-color: <color> | transparent
rule decl:sym<border-bottom-color> { :i ("border-bottom-color") ":" <val(/<expr=.expr-border-bottom-color> /, &?ROUTINE.WHY)>}
rule expr-border-bottom-color { :i <color> || transparent & <keyw>   }
#| border-top-color: <color> | transparent
rule decl:sym<border-left-color> { :i ("border-left-color") ":" <val(/<expr=.expr-border-left-color> /, &?ROUTINE.WHY)>}
rule expr-border-left-color { :i <color> || transparent & <keyw>   }
#| border-top-style: <border-style>
rule decl:sym<border-top-style> { :i ("border-top-style") ":" <val(/<expr=.expr-border-top-style> /, &?ROUTINE.WHY)>}
rule expr-border-top-style { :i <border-style> }
#| border-top-style: <border-style>
rule decl:sym<border-right-style> { :i ("border-right-style") ":" <val(/<expr=.expr-border-right-style> /, &?ROUTINE.WHY)>}
rule expr-border-right-style { :i <border-style> }
#| border-top-style: <border-style>
rule decl:sym<border-bottom-style> { :i ("border-bottom-style") ":" <val(/<expr=.expr-border-bottom-style> /, &?ROUTINE.WHY)>}
rule expr-border-bottom-style { :i <border-style> }
#| border-top-style: <border-style>
rule decl:sym<border-left-style> { :i ("border-left-style") ":" <val(/<expr=.expr-border-left-style> /, &?ROUTINE.WHY)>}
rule expr-border-left-style { :i <border-style> }
#| border-top-width: <border-width>
rule decl:sym<border-top-width> { :i ("border-top-width") ":" <val(/<expr=.expr-border-top-width> /, &?ROUTINE.WHY)>}
rule expr-border-top-width { :i <border-width> }
#| border-top-width: <border-width>
rule decl:sym<border-right-width> { :i ("border-right-width") ":" <val(/<expr=.expr-border-right-width> /, &?ROUTINE.WHY)>}
rule expr-border-right-width { :i <border-width> }
#| border-top-width: <border-width>
rule decl:sym<border-bottom-width> { :i ("border-bottom-width") ":" <val(/<expr=.expr-border-bottom-width> /, &?ROUTINE.WHY)>}
rule expr-border-bottom-width { :i <border-width> }
#| border-top-width: <border-width>
rule decl:sym<border-left-width> { :i ("border-left-width") ":" <val(/<expr=.expr-border-left-width> /, &?ROUTINE.WHY)>}
rule expr-border-left-width { :i <border-width> }
#| border-width: <border-width>{1,4}
rule decl:sym<border-width> { :i ("border-width") ":" <val(/<expr=.expr-border-width>** 1..4 /, &?ROUTINE.WHY)>}
rule expr-border-width { :i <border-width> }
#| thin | medium | thick | <length>
rule border-width { :i [thin | medium | thick ]& <keyw>  || <length>  }
#| border: [ 'border-width' || 'border-style' || 'border-color' ]
rule decl:sym<border> { :i (border) ":" <val(/<expr=.expr-border> /, &?ROUTINE.WHY)>}
rule expr-border { :i [[:my @S; <expr-border-width><!{
    @S[0]++
}>| <expr-border-style><!{
    @S[1]++
}>| <expr-border-color><!{
    @S[2]++
}>]+] }
#| bottom: <length> | <percentage> | auto
rule decl:sym<bottom> { :i (bottom) ":" <val(/<expr=.expr-bottom> /, &?ROUTINE.WHY)>}
rule expr-bottom { :i <length> || <percentage> || auto & <keyw>   }
#| caption-side: top | bottom
rule decl:sym<caption-side> { :i ("caption-side") ":" <val(/<expr=.expr-caption-side> /, &?ROUTINE.WHY)>}
rule expr-caption-side { :i [top | bottom ]& <keyw>  }
#| clear: none | left | right | both
rule decl:sym<clear> { :i (clear) ":" <val(/<expr=.expr-clear> /, &?ROUTINE.WHY)>}
rule expr-clear { :i [none | left | right | both ]& <keyw>  }
#| clip: <shape> | auto
rule decl:sym<clip> { :i (clip) ":" <val(/<expr=.expr-clip> /, &?ROUTINE.WHY)>}
rule expr-clip { :i <shape> || auto & <keyw>   }
#| color: <color>
rule decl:sym<color> { :i (color) ":" <val(/<expr=.expr-color> /, &?ROUTINE.WHY)>}
rule expr-color { :i <color> }
#| content: normal | none | [ <string> | <uri> | <counter> | <counters> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+
rule decl:sym<content> { :i (content) ":" <val(/<expr=.expr-content> /, &?ROUTINE.WHY)>}
rule expr-content { :i [normal | none ]& <keyw>  || [<string> || <uri> || <counter> || <counters> || <attr> || ["open-quote" | "close-quote" | "no-open-quote" | "no-close-quote" ]& <keyw>  ] +  }
#| counter-increment: none | [ <identifier> <integer>? ]+
rule decl:sym<counter-increment> { :i ("counter-increment") ":" <val(/<expr=.expr-counter-increment> /, &?ROUTINE.WHY)>}
rule expr-counter-increment { :i none & <keyw>  || [<identifier> <integer> ? ] +  }
#| counter-reset: none | [ <identifier> <integer>? ]+
rule decl:sym<counter-reset> { :i ("counter-reset") ":" <val(/<expr=.expr-counter-reset> /, &?ROUTINE.WHY)>}
rule expr-counter-reset { :i none & <keyw>  || [<identifier> <integer> ? ] +  }
#| cue-after: <uri> | none
rule decl:sym<cue-after> { :i ("cue-after") ":" <val(/<expr=.expr-cue-after> /, &?ROUTINE.WHY)>}
rule expr-cue-after { :i <uri> || none & <keyw>   }
#| cue-before: <uri> | none
rule decl:sym<cue-before> { :i ("cue-before") ":" <val(/<expr=.expr-cue-before> /, &?ROUTINE.WHY)>}
rule expr-cue-before { :i <uri> || none & <keyw>   }
#| cue: [ 'cue-before' || 'cue-after' ]
rule decl:sym<cue> { :i (cue) ":" <val(/<expr=.expr-cue> /, &?ROUTINE.WHY)>}
rule expr-cue { :i [[:my @S; <expr-cue-before><!{
    @S[0]++
}>| <expr-cue-after><!{
    @S[1]++
}>]+] }
#| cursor: [ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ]
rule decl:sym<cursor> { :i (cursor) ":" <val(/<expr=.expr-cursor> /, &?ROUTINE.WHY)>}
rule expr-cursor { :i [[<uri> <op(",")> ] * [[auto | crosshair | default | pointer | move | "e-resize" | "ne-resize" | "nw-resize" | "n-resize" | "se-resize" | "sw-resize" | "s-resize" | "w-resize" | text | wait | help | progress ]& <keyw> ] ] }
#| direction: ltr | rtl
rule decl:sym<direction> { :i (direction) ":" <val(/<expr=.expr-direction> /, &?ROUTINE.WHY)>}
rule expr-direction { :i [ltr | rtl ]& <keyw>  }
#| display: inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none
rule decl:sym<display> { :i (display) ":" <val(/<expr=.expr-display> /, &?ROUTINE.WHY)>}
rule expr-display { :i [inline | block | "list-item" | "inline-block" | table | "inline-table" | "table-row-group" | "table-header-group" | "table-footer-group" | "table-row" | "table-column-group" | "table-column" | "table-cell" | "table-caption" | none ]& <keyw>  }
#| elevation: <angle> | <tilt>
rule decl:sym<elevation> { :i (elevation) ":" <val(/<expr=.expr-elevation> /, &?ROUTINE.WHY)>}
rule expr-elevation { :i <angle> || <tilt>  }
#| below | level | above | higher | lower
rule tilt { :i [below | level | above | higher | lower ]& <keyw>  }
#| empty-cells: show | hide
rule decl:sym<empty-cells> { :i ("empty-cells") ":" <val(/<expr=.expr-empty-cells> /, &?ROUTINE.WHY)>}
rule expr-empty-cells { :i [show | hide ]& <keyw>  }
#| float: left | right | none
rule decl:sym<float> { :i (float) ":" <val(/<expr=.expr-float> /, &?ROUTINE.WHY)>}
rule expr-float { :i [left | right | none ]& <keyw>  }
#| font-family: [ <generic-family> | <family-name> ]#
rule decl:sym<font-family> { :i ("font-family") ":" <val(/<expr=.expr-font-family> /, &?ROUTINE.WHY)>}
rule expr-font-family { :i [<generic-family> || <family-name> ] +% <op(",")> }
#| serif | sans-serif | cursive | fantasy | monospace
rule generic-family { :i [serif | "sans-serif" | cursive | fantasy | monospace ]& <keyw>  }
#| <identifiers> | <string>
rule family-name { :i <identifiers> || <string>  }
#| font-size: <absolute-size> | <relative-size> | <length>
rule decl:sym<font-size> { :i ("font-size") ":" <val(/<expr=.expr-font-size> /, &?ROUTINE.WHY)>}
rule expr-font-size { :i <absolute-size> || <relative-size> || <length>  }
#| xx-small | x-small | small | medium | large | x-large | xx-large
rule absolute-size { :i ["xx-small" | "x-small" | small | medium | large | "x-large" | "xx-large" ]& <keyw>  }
#| larger | smaller | <percentage>
rule relative-size { :i [larger | smaller ]& <keyw>  || <percentage>  }
#| font-style: normal | italic | oblique
rule decl:sym<font-style> { :i ("font-style") ":" <val(/<expr=.expr-font-style> /, &?ROUTINE.WHY)>}
rule expr-font-style { :i [normal | italic | oblique ]& <keyw>  }
#| font-variant: normal | small-caps
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<expr=.expr-font-variant> /, &?ROUTINE.WHY)>}
rule expr-font-variant { :i [normal | "small-caps" ]& <keyw>  }
#| font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
rule decl:sym<font-weight> { :i ("font-weight") ":" <val(/<expr=.expr-font-weight> /, &?ROUTINE.WHY)>}
rule expr-font-weight { :i [normal | bold | bolder | lighter ]& <keyw>  || [100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ]& <number>  }
#| font: [ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family' ] | caption | icon | menu | message-box | small-caption | status-bar
rule decl:sym<font> { :i (font) ":" <val(/<expr=.expr-font> /, &?ROUTINE.WHY)>}
rule expr-font { :i [[[:my @S; <expr-font-style><!{
    @S[0]++
}>| <expr-font-variant><!{
    @S[1]++
}>| <expr-font-weight><!{
    @S[2]++
}>]+] ? <expr-font-size> [<op("/")> <expr-line-height> ] ? <expr-font-family> ] || [caption | icon | menu | "message-box" | "small-caption" | "status-bar" ]& <keyw>   }
#| height: <length> | <percentage> | auto
rule decl:sym<height> { :i (height) ":" <val(/<expr=.expr-height> /, &?ROUTINE.WHY)>}
rule expr-height { :i <length> || <percentage> || auto & <keyw>   }
#| left: <length> | <percentage> | auto
rule decl:sym<left> { :i (left) ":" <val(/<expr=.expr-left> /, &?ROUTINE.WHY)>}
rule expr-left { :i <length> || <percentage> || auto & <keyw>   }
#| letter-spacing: normal | <length>
rule decl:sym<letter-spacing> { :i ("letter-spacing") ":" <val(/<expr=.expr-letter-spacing> /, &?ROUTINE.WHY)>}
rule expr-letter-spacing { :i normal & <keyw>  || <length>  }
#| line-height: normal | <number> | <length> | <percentage>
rule decl:sym<line-height> { :i ("line-height") ":" <val(/<expr=.expr-line-height> /, &?ROUTINE.WHY)>}
rule expr-line-height { :i normal & <keyw>  || <number> || <length> || <percentage>  }
#| list-style-image: <uri> | none
rule decl:sym<list-style-image> { :i ("list-style-image") ":" <val(/<expr=.expr-list-style-image> /, &?ROUTINE.WHY)>}
rule expr-list-style-image { :i <uri> || none & <keyw>   }
#| list-style-position: inside | outside
rule decl:sym<list-style-position> { :i ("list-style-position") ":" <val(/<expr=.expr-list-style-position> /, &?ROUTINE.WHY)>}
rule expr-list-style-position { :i [inside | outside ]& <keyw>  }
#| list-style-type: disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none
rule decl:sym<list-style-type> { :i ("list-style-type") ":" <val(/<expr=.expr-list-style-type> /, &?ROUTINE.WHY)>}
rule expr-list-style-type { :i [disc | circle | square | decimal | "decimal-leading-zero" | "lower-roman" | "upper-roman" | "lower-greek" | "lower-latin" | "upper-latin" | armenian | georgian | "lower-alpha" | "upper-alpha" | none ]& <keyw>  }
#| list-style: [ 'list-style-type' || 'list-style-position' || 'list-style-image' ]
rule decl:sym<list-style> { :i ("list-style") ":" <val(/<expr=.expr-list-style> /, &?ROUTINE.WHY)>}
rule expr-list-style { :i [[:my @S; <expr-list-style-type><!{
    @S[0]++
}>| <expr-list-style-position><!{
    @S[1]++
}>| <expr-list-style-image><!{
    @S[2]++
}>]+] }
#| margin-right: <margin-width>
rule decl:sym<margin-right> { :i ("margin-right") ":" <val(/<expr=.expr-margin-right> /, &?ROUTINE.WHY)>}
rule expr-margin-right { :i <margin-width> }
#| margin-right: <margin-width>
rule decl:sym<margin-left> { :i ("margin-left") ":" <val(/<expr=.expr-margin-left> /, &?ROUTINE.WHY)>}
rule expr-margin-left { :i <margin-width> }
#| margin-top: <margin-width>
rule decl:sym<margin-top> { :i ("margin-top") ":" <val(/<expr=.expr-margin-top> /, &?ROUTINE.WHY)>}
rule expr-margin-top { :i <margin-width> }
#| margin-top: <margin-width>
rule decl:sym<margin-bottom> { :i ("margin-bottom") ":" <val(/<expr=.expr-margin-bottom> /, &?ROUTINE.WHY)>}
rule expr-margin-bottom { :i <margin-width> }
#| margin: <margin-width>{1,4}
rule decl:sym<margin> { :i (margin) ":" <val(/<expr=.expr-margin>** 1..4 /, &?ROUTINE.WHY)>}
rule expr-margin { :i <margin-width> }
#| <length> | <percentage> | auto
rule margin-width { :i <length> || <percentage> || auto & <keyw>   }
#| max-height: <length> | <percentage> | none
rule decl:sym<max-height> { :i ("max-height") ":" <val(/<expr=.expr-max-height> /, &?ROUTINE.WHY)>}
rule expr-max-height { :i <length> || <percentage> || none & <keyw>   }
#| max-width: <length> | <percentage> | none
rule decl:sym<max-width> { :i ("max-width") ":" <val(/<expr=.expr-max-width> /, &?ROUTINE.WHY)>}
rule expr-max-width { :i <length> || <percentage> || none & <keyw>   }
#| min-height: <length> | <percentage>
rule decl:sym<min-height> { :i ("min-height") ":" <val(/<expr=.expr-min-height> /, &?ROUTINE.WHY)>}
rule expr-min-height { :i <length> || <percentage>  }
#| min-width: <length> | <percentage>
rule decl:sym<min-width> { :i ("min-width") ":" <val(/<expr=.expr-min-width> /, &?ROUTINE.WHY)>}
rule expr-min-width { :i <length> || <percentage>  }
#| opacity: <number>
rule decl:sym<opacity> { :i (opacity) ":" <val(/<expr=.expr-opacity> /, &?ROUTINE.WHY)>}
rule expr-opacity { :i <number> }
#| orphans: <integer>
rule decl:sym<orphans> { :i (orphans) ":" <val(/<expr=.expr-orphans> /, &?ROUTINE.WHY)>}
rule expr-orphans { :i <integer> }
#| outline-color: <color> | invert
rule decl:sym<outline-color> { :i ("outline-color") ":" <val(/<expr=.expr-outline-color> /, &?ROUTINE.WHY)>}
rule expr-outline-color { :i <color> || invert & <keyw>   }
#| outline-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<outline-style> { :i ("outline-style") ":" <val(/<expr=.expr-outline-style> /, &?ROUTINE.WHY)>}
rule expr-outline-style { :i [[none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| outline-width: thin | medium | thick | <length>
rule decl:sym<outline-width> { :i ("outline-width") ":" <val(/<expr=.expr-outline-width> /, &?ROUTINE.WHY)>}
rule expr-outline-width { :i [thin | medium | thick ]& <keyw>  || <length>  }
#| outline: [ 'outline-color' || 'outline-style' || 'outline-width' ]
rule decl:sym<outline> { :i (outline) ":" <val(/<expr=.expr-outline> /, &?ROUTINE.WHY)>}
rule expr-outline { :i [[:my @S; <expr-outline-color><!{
    @S[0]++
}>| <expr-outline-style><!{
    @S[1]++
}>| <expr-outline-width><!{
    @S[2]++
}>]+] }
#| overflow: visible | hidden | scroll | auto
rule decl:sym<overflow> { :i (overflow) ":" <val(/<expr=.expr-overflow> /, &?ROUTINE.WHY)>}
rule expr-overflow { :i [visible | hidden | scroll | auto ]& <keyw>  }
#| padding-top: <padding-width>
rule decl:sym<padding-top> { :i ("padding-top") ":" <val(/<expr=.expr-padding-top> /, &?ROUTINE.WHY)>}
rule expr-padding-top { :i <padding-width> }
#| padding-top: <padding-width>
rule decl:sym<padding-right> { :i ("padding-right") ":" <val(/<expr=.expr-padding-right> /, &?ROUTINE.WHY)>}
rule expr-padding-right { :i <padding-width> }
#| padding-top: <padding-width>
rule decl:sym<padding-bottom> { :i ("padding-bottom") ":" <val(/<expr=.expr-padding-bottom> /, &?ROUTINE.WHY)>}
rule expr-padding-bottom { :i <padding-width> }
#| padding-top: <padding-width>
rule decl:sym<padding-left> { :i ("padding-left") ":" <val(/<expr=.expr-padding-left> /, &?ROUTINE.WHY)>}
rule expr-padding-left { :i <padding-width> }
#| padding: <padding-width>{1,4}
rule decl:sym<padding> { :i (padding) ":" <val(/<expr=.expr-padding>** 1..4 /, &?ROUTINE.WHY)>}
rule expr-padding { :i <padding-width> }
#| <length> | <percentage>
rule padding-width { :i <length> || <percentage>  }
#| page-break-after: auto | always | avoid | left | right
rule decl:sym<page-break-after> { :i ("page-break-after") ":" <val(/<expr=.expr-page-break-after> /, &?ROUTINE.WHY)>}
rule expr-page-break-after { :i [auto | always | avoid | left | right ]& <keyw>  }
#| page-break-before: auto | always | avoid | left | right
rule decl:sym<page-break-before> { :i ("page-break-before") ":" <val(/<expr=.expr-page-break-before> /, &?ROUTINE.WHY)>}
rule expr-page-break-before { :i [auto | always | avoid | left | right ]& <keyw>  }
#| page-break-inside: avoid | auto
rule decl:sym<page-break-inside> { :i ("page-break-inside") ":" <val(/<expr=.expr-page-break-inside> /, &?ROUTINE.WHY)>}
rule expr-page-break-inside { :i [avoid | auto ]& <keyw>  }
#| pause-after: <time> | <percentage>
rule decl:sym<pause-after> { :i ("pause-after") ":" <val(/<expr=.expr-pause-after> /, &?ROUTINE.WHY)>}
rule expr-pause-after { :i <time> || <percentage>  }
#| pause-before: <time> | <percentage>
rule decl:sym<pause-before> { :i ("pause-before") ":" <val(/<expr=.expr-pause-before> /, &?ROUTINE.WHY)>}
rule expr-pause-before { :i <time> || <percentage>  }
#| pause: [ [<time> | <percentage>]{1,2} ]
rule decl:sym<pause> { :i (pause) ":" <val(/<expr=.expr-pause> /, &?ROUTINE.WHY)>}
rule expr-pause { :i [[<time> || <percentage> ] ** 1..2] }
#| pitch-range: <number>
rule decl:sym<pitch-range> { :i ("pitch-range") ":" <val(/<expr=.expr-pitch-range> /, &?ROUTINE.WHY)>}
rule expr-pitch-range { :i <number> }
#| pitch: <frequency> | x-low | low | medium | high | x-high
rule decl:sym<pitch> { :i (pitch) ":" <val(/<expr=.expr-pitch> /, &?ROUTINE.WHY)>}
rule expr-pitch { :i <frequency> || ["x-low" | low | medium | high | "x-high" ]& <keyw>   }
#| play-during: <uri> [ mix || repeat ]? | auto | none
rule decl:sym<play-during> { :i ("play-during") ":" <val(/<expr=.expr-play-during> /, &?ROUTINE.WHY)>}
rule expr-play-during { :i <uri> [[:my @S; mix & <keyw> <!{
    @S[0]++
}>| repeat & <keyw> <!{
    @S[1]++
}>]+] ?  || [auto | none ]& <keyw>   }
#| position: static | relative | absolute | fixed
rule decl:sym<position> { :i (position) ":" <val(/<expr=.expr-position> /, &?ROUTINE.WHY)>}
rule expr-position { :i [static | relative | absolute | fixed ]& <keyw>  }
#| quotes: [<string> <string>]+ | none
rule decl:sym<quotes> { :i (quotes) ":" <val(/<expr=.expr-quotes> /, &?ROUTINE.WHY)>}
rule expr-quotes { :i [<string> <string> ] + || none & <keyw>   }
#| richness: <number>
rule decl:sym<richness> { :i (richness) ":" <val(/<expr=.expr-richness> /, &?ROUTINE.WHY)>}
rule expr-richness { :i <number> }
#| right: <length> | <percentage> | auto
rule decl:sym<right> { :i (right) ":" <val(/<expr=.expr-right> /, &?ROUTINE.WHY)>}
rule expr-right { :i <length> || <percentage> || auto & <keyw>   }
#| size: <length>{1,2} | auto | portrait | landscape
rule decl:sym<size> { :i (size) ":" <val(/<expr=.expr-size> /, &?ROUTINE.WHY)>}
rule expr-size { :i <length> ** 1..2 || [auto | portrait | landscape ]& <keyw>   }
#| speak-header: once | always
rule decl:sym<speak-header> { :i ("speak-header") ":" <val(/<expr=.expr-speak-header> /, &?ROUTINE.WHY)>}
rule expr-speak-header { :i [once | always ]& <keyw>  }
#| speak-numeral: digits | continuous
rule decl:sym<speak-numeral> { :i ("speak-numeral") ":" <val(/<expr=.expr-speak-numeral> /, &?ROUTINE.WHY)>}
rule expr-speak-numeral { :i [digits | continuous ]& <keyw>  }
#| speak-punctuation: code | none
rule decl:sym<speak-punctuation> { :i ("speak-punctuation") ":" <val(/<expr=.expr-speak-punctuation> /, &?ROUTINE.WHY)>}
rule expr-speak-punctuation { :i [code | none ]& <keyw>  }
#| speak: normal | none | spell-out
rule decl:sym<speak> { :i (speak) ":" <val(/<expr=.expr-speak> /, &?ROUTINE.WHY)>}
rule expr-speak { :i [normal | none | "spell-out" ]& <keyw>  }
#| speech-rate: <number> | x-slow | slow | medium | fast | x-fast | faster | slower
rule decl:sym<speech-rate> { :i ("speech-rate") ":" <val(/<expr=.expr-speech-rate> /, &?ROUTINE.WHY)>}
rule expr-speech-rate { :i <number> || ["x-slow" | slow | medium | fast | "x-fast" | faster | slower ]& <keyw>   }
#| stress: <number>
rule decl:sym<stress> { :i (stress) ":" <val(/<expr=.expr-stress> /, &?ROUTINE.WHY)>}
rule expr-stress { :i <number> }
#| table-layout: auto | fixed
rule decl:sym<table-layout> { :i ("table-layout") ":" <val(/<expr=.expr-table-layout> /, &?ROUTINE.WHY)>}
rule expr-table-layout { :i [auto | fixed ]& <keyw>  }
#| text-align: <align> | justify
rule decl:sym<text-align> { :i ("text-align") ":" <val(/<expr=.expr-text-align> /, &?ROUTINE.WHY)>}
rule expr-text-align { :i <align> || justify & <keyw>   }
#| text-decoration: none | [ underline || overline || line-through || blink ]
rule decl:sym<text-decoration> { :i ("text-decoration") ":" <val(/<expr=.expr-text-decoration> /, &?ROUTINE.WHY)>}
rule expr-text-decoration { :i none & <keyw>  || [[:my @S; underline & <keyw> <!{
    @S[0]++
}>| overline & <keyw> <!{
    @S[1]++
}>| "line-through" & <keyw> <!{
    @S[2]++
}>| blink & <keyw> <!{
    @S[3]++
}>]+]  }
#| text-indent: <length> | <percentage>
rule decl:sym<text-indent> { :i ("text-indent") ":" <val(/<expr=.expr-text-indent> /, &?ROUTINE.WHY)>}
rule expr-text-indent { :i <length> || <percentage>  }
#| text-transform: capitalize | uppercase | lowercase | none
rule decl:sym<text-transform> { :i ("text-transform") ":" <val(/<expr=.expr-text-transform> /, &?ROUTINE.WHY)>}
rule expr-text-transform { :i [capitalize | uppercase | lowercase | none ]& <keyw>  }
#| top: <length> | <percentage> | auto
rule decl:sym<top> { :i (top) ":" <val(/<expr=.expr-top> /, &?ROUTINE.WHY)>}
rule expr-top { :i <length> || <percentage> || auto & <keyw>   }
#| unicode-bidi: normal | embed | bidi-override
rule decl:sym<unicode-bidi> { :i ("unicode-bidi") ":" <val(/<expr=.expr-unicode-bidi> /, &?ROUTINE.WHY)>}
rule expr-unicode-bidi { :i [normal | embed | "bidi-override" ]& <keyw>  }
#| vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length>
rule decl:sym<vertical-align> { :i ("vertical-align") ":" <val(/<expr=.expr-vertical-align> /, &?ROUTINE.WHY)>}
rule expr-vertical-align { :i [baseline | sub | super | top | "text-top" | middle | bottom | "text-bottom" ]& <keyw>  || <percentage> || <length>  }
#| visibility: visible | hidden | collapse
rule decl:sym<visibility> { :i (visibility) ":" <val(/<expr=.expr-visibility> /, &?ROUTINE.WHY)>}
rule expr-visibility { :i [visible | hidden | collapse ]& <keyw>  }
#| voice-family: [<generic-voice> | <specific-voice> ]#
rule decl:sym<voice-family> { :i ("voice-family") ":" <val(/<expr=.expr-voice-family> /, &?ROUTINE.WHY)>}
rule expr-voice-family { :i [<generic-voice> || <specific-voice> ] +% <op(",")> }
#| male | female | child
rule generic-voice { :i [male | female | child ]& <keyw>  }
#| <identifier> | <string>
rule specific-voice { :i <identifier> || <string>  }
#| volume: <number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud
rule decl:sym<volume> { :i (volume) ":" <val(/<expr=.expr-volume> /, &?ROUTINE.WHY)>}
rule expr-volume { :i <number> || <percentage> || [silent | "x-soft" | soft | medium | loud | "x-loud" ]& <keyw>   }
#| white-space: normal | pre | nowrap | pre-wrap | pre-line
rule decl:sym<white-space> { :i ("white-space") ":" <val(/<expr=.expr-white-space> /, &?ROUTINE.WHY)>}
rule expr-white-space { :i [normal | pre | nowrap | "pre-wrap" | "pre-line" ]& <keyw>  }
#| widows: <integer>
rule decl:sym<widows> { :i (widows) ":" <val(/<expr=.expr-widows> /, &?ROUTINE.WHY)>}
rule expr-widows { :i <integer> }
#| width: <length> | <percentage> | auto
rule decl:sym<width> { :i (width) ":" <val(/<expr=.expr-width> /, &?ROUTINE.WHY)>}
rule expr-width { :i <length> || <percentage> || auto & <keyw>   }
#| word-spacing: normal | <length>
rule decl:sym<word-spacing> { :i ("word-spacing") ":" <val(/<expr=.expr-word-spacing> /, &?ROUTINE.WHY)>}
rule expr-word-spacing { :i normal & <keyw>  || <length>  }
#| z-index: auto | <integer>
rule decl:sym<z-index> { :i ("z-index") ":" <val(/<expr=.expr-z-index> /, &?ROUTINE.WHY)>}
rule expr-z-index { :i auto & <keyw>  || <integer>  }