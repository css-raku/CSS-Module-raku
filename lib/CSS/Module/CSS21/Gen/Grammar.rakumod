unit grammar CSS::Module::CSS21::Gen::Grammar;
#| azimuth: <angle> | [ <direction> || <behind> ] | <delta>
rule decl:sym<azimuth> { :i (azimuth) ":" <val(/<css-val-azimuth> /, &?ROUTINE.WHY)>}
rule css-val-azimuth { :i <angle> || [[<direction> :my $*A; <!{
    $*A++
}>|| <behind> :my $*B; <!{
    $*B++
}>]+] || <delta>  }
#| <delta> = leftwards | rightwards
rule delta { :i [leftwards | rightwards ]& <keyw>  }
#| <direction> = left-side | far-left | left | center-left | center | center-right | right | far-right | right-side
rule direction { :i ["left-side" | "far-left" | left | "center-left" | center | "center-right" | right | "far-right" | "right-side" ]& <keyw>  }
#| <behind> = behind
rule behind { :i behind & <keyw> }
#| background-attachment: scroll | fixed
rule decl:sym<background-attachment> { :i ("background-attachment") ":" <val(/<css-val-background-attachment> /, &?ROUTINE.WHY)>}
rule css-val-background-attachment { :i [scroll | fixed ]& <keyw>  }
#| background-color: <color> | transparent
rule decl:sym<background-color> { :i ("background-color") ":" <val(/<css-val-background-color> /, &?ROUTINE.WHY)>}
rule css-val-background-color { :i <color> || transparent & <keyw>  }
#| background-image: <uri> | none
rule decl:sym<background-image> { :i ("background-image") ":" <val(/<css-val-background-image> /, &?ROUTINE.WHY)>}
rule css-val-background-image { :i <uri> || none & <keyw>  }
#| background-position: [ [ <percentage> | <length> | <align> ] [ <percentage> | <length> | <valign> ]? ] | [ <align> || <valign> ]
rule decl:sym<background-position> { :i ("background-position") ":" <val(/<css-val-background-position> /, &?ROUTINE.WHY)>}
rule css-val-background-position { :i [[<percentage> || <length> || <align> ] [<percentage> || <length> || <valign> ] ? ] || [[<align> :my $*A; <!{
    $*A++
}>|| <valign> :my $*B; <!{
    $*B++
}>]+]  }
#| <align> = left | center | right
rule align { :i [left | center | right ]& <keyw>  }
#| <valign> = top | center | bottom
rule valign { :i [top | center | bottom ]& <keyw>  }
#| background-repeat: repeat | repeat-x | repeat-y | no-repeat
rule decl:sym<background-repeat> { :i ("background-repeat") ":" <val(/<css-val-background-repeat> /, &?ROUTINE.WHY)>}
rule css-val-background-repeat { :i [repeat | "repeat-x" | "repeat-y" | "no-repeat" ]& <keyw>  }
#| background: ['background-color' || 'background-image' || 'background-repeat' || 'background-attachment' || 'background-position']
rule decl:sym<background> { :i (background) ":" <val(/<css-val-background> /, &?ROUTINE.WHY)>}
rule css-val-background { :i [[<css-val-background-color> :my $*A; <!{
    $*A++
}>|| <css-val-background-image> :my $*B; <!{
    $*B++
}>|| <css-val-background-repeat> :my $*C; <!{
    $*C++
}>|| <css-val-background-attachment> :my $*D; <!{
    $*D++
}>|| <css-val-background-position> :my $*E; <!{
    $*E++
}>]+] }
#| border-collapse: collapse | separate
rule decl:sym<border-collapse> { :i ("border-collapse") ":" <val(/<css-val-border-collapse> /, &?ROUTINE.WHY)>}
rule css-val-border-collapse { :i [collapse | separate ]& <keyw>  }
#| border-color: [ <color> | transparent ]{1,4}
rule decl:sym<border-color> { :i ("border-color") ":" <val(/<css-val-border-color>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-border-color { :i [<color> || transparent & <keyw> ] }
#| border-spacing: <length> <length>?
rule decl:sym<border-spacing> { :i ("border-spacing") ":" <val(/<css-val-border-spacing> /, &?ROUTINE.WHY)>}
rule css-val-border-spacing { :i <length> <length> ?  }
#| border-style: <border-style>{1,4}
rule decl:sym<border-style> { :i ("border-style") ":" <val(/<css-val-border-style>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-border-style { :i <border-style> }
#| <border-style> = none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset
rule border-style { :i [none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw>  }
#| border-top: [ 'border-top-width' || 'border-top-style' || 'border-top-color' ]
rule decl:sym<border-top> { :i ("border-top") ":" <val(/<css-val-border-top> /, &?ROUTINE.WHY)>}
rule css-val-border-top { :i [[<css-val-border-top-width> :my $*A; <!{
    $*A++
}>|| <css-val-border-top-style> :my $*B; <!{
    $*B++
}>|| <css-val-border-top-color> :my $*C; <!{
    $*C++
}>]+] }
#| border-right: [ 'border-right-width' || 'border-right-style' || 'border-right-color' ]
rule decl:sym<border-right> { :i ("border-right") ":" <val(/<css-val-border-right> /, &?ROUTINE.WHY)>}
rule css-val-border-right { :i [[<css-val-border-right-width> :my $*A; <!{
    $*A++
}>|| <css-val-border-right-style> :my $*B; <!{
    $*B++
}>|| <css-val-border-right-color> :my $*C; <!{
    $*C++
}>]+] }
#| border-bottom: [ 'border-bottom-width' || 'border-bottom-style' || 'border-bottom-color' ]
rule decl:sym<border-bottom> { :i ("border-bottom") ":" <val(/<css-val-border-bottom> /, &?ROUTINE.WHY)>}
rule css-val-border-bottom { :i [[<css-val-border-bottom-width> :my $*A; <!{
    $*A++
}>|| <css-val-border-bottom-style> :my $*B; <!{
    $*B++
}>|| <css-val-border-bottom-color> :my $*C; <!{
    $*C++
}>]+] }
#| border-left: [ 'border-left-width' || 'border-left-style' || 'border-left-color' ]
rule decl:sym<border-left> { :i ("border-left") ":" <val(/<css-val-border-left> /, &?ROUTINE.WHY)>}
rule css-val-border-left { :i [[<css-val-border-left-width> :my $*A; <!{
    $*A++
}>|| <css-val-border-left-style> :my $*B; <!{
    $*B++
}>|| <css-val-border-left-color> :my $*C; <!{
    $*C++
}>]+] }
#| border-top-color: <color> | transparent
rule decl:sym<border-top-color> { :i ("border-top-color") ":" <val(/<css-val-border-top-color> /, &?ROUTINE.WHY)>}
rule css-val-border-top-color { :i <color> || transparent & <keyw>  }
#| border-top-color: <color> | transparent
rule decl:sym<border-right-color> { :i ("border-right-color") ":" <val(/<css-val-border-right-color> /, &?ROUTINE.WHY)>}
rule css-val-border-right-color { :i <color> || transparent & <keyw>  }
#| border-top-color: <color> | transparent
rule decl:sym<border-bottom-color> { :i ("border-bottom-color") ":" <val(/<css-val-border-bottom-color> /, &?ROUTINE.WHY)>}
rule css-val-border-bottom-color { :i <color> || transparent & <keyw>  }
#| border-top-color: <color> | transparent
rule decl:sym<border-left-color> { :i ("border-left-color") ":" <val(/<css-val-border-left-color> /, &?ROUTINE.WHY)>}
rule css-val-border-left-color { :i <color> || transparent & <keyw>  }
#| border-top-style: <border-style>
rule decl:sym<border-top-style> { :i ("border-top-style") ":" <val(/<css-val-border-top-style> /, &?ROUTINE.WHY)>}
rule css-val-border-top-style { :i <border-style> }
#| border-top-style: <border-style>
rule decl:sym<border-right-style> { :i ("border-right-style") ":" <val(/<css-val-border-right-style> /, &?ROUTINE.WHY)>}
rule css-val-border-right-style { :i <border-style> }
#| border-top-style: <border-style>
rule decl:sym<border-bottom-style> { :i ("border-bottom-style") ":" <val(/<css-val-border-bottom-style> /, &?ROUTINE.WHY)>}
rule css-val-border-bottom-style { :i <border-style> }
#| border-top-style: <border-style>
rule decl:sym<border-left-style> { :i ("border-left-style") ":" <val(/<css-val-border-left-style> /, &?ROUTINE.WHY)>}
rule css-val-border-left-style { :i <border-style> }
#| border-top-width: <border-width>
rule decl:sym<border-top-width> { :i ("border-top-width") ":" <val(/<css-val-border-top-width> /, &?ROUTINE.WHY)>}
rule css-val-border-top-width { :i <border-width> }
#| border-top-width: <border-width>
rule decl:sym<border-right-width> { :i ("border-right-width") ":" <val(/<css-val-border-right-width> /, &?ROUTINE.WHY)>}
rule css-val-border-right-width { :i <border-width> }
#| border-top-width: <border-width>
rule decl:sym<border-bottom-width> { :i ("border-bottom-width") ":" <val(/<css-val-border-bottom-width> /, &?ROUTINE.WHY)>}
rule css-val-border-bottom-width { :i <border-width> }
#| border-top-width: <border-width>
rule decl:sym<border-left-width> { :i ("border-left-width") ":" <val(/<css-val-border-left-width> /, &?ROUTINE.WHY)>}
rule css-val-border-left-width { :i <border-width> }
#| border-width: <border-width>{1,4}
rule decl:sym<border-width> { :i ("border-width") ":" <val(/<css-val-border-width>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-border-width { :i <border-width> }
#| <border-width> = thin | medium | thick | <length>
rule border-width { :i [thin | medium | thick ]& <keyw>  || <length>  }
#| border: [ 'border-width' || 'border-style' || 'border-color' ]
rule decl:sym<border> { :i (border) ":" <val(/<css-val-border> /, &?ROUTINE.WHY)>}
rule css-val-border { :i [[<css-val-border-width> :my $*A; <!{
    $*A++
}>|| <css-val-border-style> :my $*B; <!{
    $*B++
}>|| <css-val-border-color> :my $*C; <!{
    $*C++
}>]+] }
#| bottom: <length> | <percentage> | auto
rule decl:sym<bottom> { :i (bottom) ":" <val(/<css-val-bottom> /, &?ROUTINE.WHY)>}
rule css-val-bottom { :i <length> || <percentage> || auto & <keyw>  }
#| caption-side: top | bottom
rule decl:sym<caption-side> { :i ("caption-side") ":" <val(/<css-val-caption-side> /, &?ROUTINE.WHY)>}
rule css-val-caption-side { :i [top | bottom ]& <keyw>  }
#| clear: none | left | right | both
rule decl:sym<clear> { :i (clear) ":" <val(/<css-val-clear> /, &?ROUTINE.WHY)>}
rule css-val-clear { :i [none | left | right | both ]& <keyw>  }
#| clip: <shape> | auto
rule decl:sym<clip> { :i (clip) ":" <val(/<css-val-clip> /, &?ROUTINE.WHY)>}
rule css-val-clip { :i <shape> || auto & <keyw>  }
#| <shape> = <rect()>
rule shape { :i <rect> }
#| rect([<length> | auto]#{4,4})
rule rect { :i "rect(" [[<length> || auto & <keyw> ] ** 4% "," || <usage(&?ROUTINE.WHY)> ] ")" }
#| color: <color>
rule decl:sym<color> { :i (color) ":" <val(/<css-val-color> /, &?ROUTINE.WHY)>}
rule css-val-color { :i <color> }
#| content: normal | none | [ <string> | <uri> | <counter()> | <counters()> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+
rule decl:sym<content> { :i (content) ":" <val(/<css-val-content> /, &?ROUTINE.WHY)>}
rule css-val-content { :i [normal | none ]& <keyw>  || [<string> || <uri> || <counter> || <counters> || <attr> || ["open-quote" | "close-quote" | "no-open-quote" | "no-close-quote" ]& <keyw>  ] +  }
#| attr(<identifier>)
rule attr { :i "attr(" [<identifier> || <usage(&?ROUTINE.WHY)> ] ")" }
#| counter(<identifier>[, <'list-style-type'>]?)
rule counter { :i "counter(" [<identifier> ["," <css-val-list-style-type> ] ?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| counters(<identifier> [, <string>]?)
rule counters { :i "counters(" [<identifier> ["," <string> ] ?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| counter-increment: none | [ <identifier> <integer>? ]+
rule decl:sym<counter-increment> { :i ("counter-increment") ":" <val(/<css-val-counter-increment> /, &?ROUTINE.WHY)>}
rule css-val-counter-increment { :i none & <keyw> || [<identifier> <integer> ? ] +  }
#| counter-reset: none | [ <identifier> <integer>? ]+
rule decl:sym<counter-reset> { :i ("counter-reset") ":" <val(/<css-val-counter-reset> /, &?ROUTINE.WHY)>}
rule css-val-counter-reset { :i none & <keyw> || [<identifier> <integer> ? ] +  }
#| cue-after: <uri> | none
rule decl:sym<cue-after> { :i ("cue-after") ":" <val(/<css-val-cue-after> /, &?ROUTINE.WHY)>}
rule css-val-cue-after { :i <uri> || none & <keyw>  }
#| cue-before: <uri> | none
rule decl:sym<cue-before> { :i ("cue-before") ":" <val(/<css-val-cue-before> /, &?ROUTINE.WHY)>}
rule css-val-cue-before { :i <uri> || none & <keyw>  }
#| cue: [ 'cue-before' || 'cue-after' ]
rule decl:sym<cue> { :i (cue) ":" <val(/<css-val-cue> /, &?ROUTINE.WHY)>}
rule css-val-cue { :i [[<css-val-cue-before> :my $*A; <!{
    $*A++
}>|| <css-val-cue-after> :my $*B; <!{
    $*B++
}>]+] }
#| cursor: [ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ]
rule decl:sym<cursor> { :i (cursor) ":" <val(/<css-val-cursor> /, &?ROUTINE.WHY)>}
rule css-val-cursor { :i [[<uri> <op(",")> ] * [[auto | crosshair | default | pointer | move | "e-resize" | "ne-resize" | "nw-resize" | "n-resize" | "se-resize" | "sw-resize" | "s-resize" | "w-resize" | text | wait | help | progress ]& <keyw> ] ] }
#| direction: ltr | rtl
rule decl:sym<direction> { :i (direction) ":" <val(/<css-val-direction> /, &?ROUTINE.WHY)>}
rule css-val-direction { :i [ltr | rtl ]& <keyw>  }
#| display: inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none
rule decl:sym<display> { :i (display) ":" <val(/<css-val-display> /, &?ROUTINE.WHY)>}
rule css-val-display { :i [inline | block | "list-item" | "inline-block" | table | "inline-table" | "table-row-group" | "table-header-group" | "table-footer-group" | "table-row" | "table-column-group" | "table-column" | "table-cell" | "table-caption" | none ]& <keyw>  }
#| elevation: <angle> | <tilt>
rule decl:sym<elevation> { :i (elevation) ":" <val(/<css-val-elevation> /, &?ROUTINE.WHY)>}
rule css-val-elevation { :i <angle> || <tilt>  }
#| <tilt> = below | level | above | higher | lower
rule tilt { :i [below | level | above | higher | lower ]& <keyw>  }
#| empty-cells: show | hide
rule decl:sym<empty-cells> { :i ("empty-cells") ":" <val(/<css-val-empty-cells> /, &?ROUTINE.WHY)>}
rule css-val-empty-cells { :i [show | hide ]& <keyw>  }
#| float: left | right | none
rule decl:sym<float> { :i (float) ":" <val(/<css-val-float> /, &?ROUTINE.WHY)>}
rule css-val-float { :i [left | right | none ]& <keyw>  }
#| font-family: [ <generic-family> | <family-name> ]#
rule decl:sym<font-family> { :i ("font-family") ":" <val(/<css-val-font-family> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-font-family { :i [<generic-family> || <family-name> ] }
#| <generic-family> = serif | sans-serif | cursive | fantasy | monospace
rule generic-family { :i [serif | "sans-serif" | cursive | fantasy | monospace ]& <keyw>  }
#| <family-name> = <identifiers> | <string>
rule family-name { :i <identifiers> || <string>  }
#| font-size: <absolute-size> | <relative-size> | <length>
rule decl:sym<font-size> { :i ("font-size") ":" <val(/<css-val-font-size> /, &?ROUTINE.WHY)>}
rule css-val-font-size { :i <absolute-size> || <relative-size> || <length>  }
#| <absolute-size> = xx-small | x-small | small | medium | large | x-large | xx-large
rule absolute-size { :i ["xx-small" | "x-small" | small | medium | large | "x-large" | "xx-large" ]& <keyw>  }
#| <relative-size> = larger | smaller | <percentage>
rule relative-size { :i [larger | smaller ]& <keyw>  || <percentage>  }
#| font-style: normal | italic | oblique
rule decl:sym<font-style> { :i ("font-style") ":" <val(/<css-val-font-style> /, &?ROUTINE.WHY)>}
rule css-val-font-style { :i [normal | italic | oblique ]& <keyw>  }
#| font-variant: normal | small-caps
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<css-val-font-variant> /, &?ROUTINE.WHY)>}
rule css-val-font-variant { :i [normal | "small-caps" ]& <keyw>  }
#| font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
rule decl:sym<font-weight> { :i ("font-weight") ":" <val(/<css-val-font-weight> /, &?ROUTINE.WHY)>}
rule css-val-font-weight { :i [normal | bold | bolder | lighter ]& <keyw>  || [100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ]& <number>  }
#| font: [ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family'# ] | caption | icon | menu | message-box | small-caption | status-bar
rule decl:sym<font> { :i (font) ":" <val(/<css-val-font> /, &?ROUTINE.WHY)>}
rule css-val-font { :i [[[<css-val-font-style> :my $*A; <!{
    $*A++
}>|| <css-val-font-variant> :my $*B; <!{
    $*B++
}>|| <css-val-font-weight> :my $*C; <!{
    $*C++
}>]+] ? <css-val-font-size> [<op("/")> <css-val-line-height> ] ? <css-val-font-family> +% <op(",")> ] || [caption | icon | menu | "message-box" | "small-caption" | "status-bar" ]& <keyw>   }
#| height: <length> | <percentage> | auto
rule decl:sym<height> { :i (height) ":" <val(/<css-val-height> /, &?ROUTINE.WHY)>}
rule css-val-height { :i <length> || <percentage> || auto & <keyw>  }
#| left: <length> | <percentage> | auto
rule decl:sym<left> { :i (left) ":" <val(/<css-val-left> /, &?ROUTINE.WHY)>}
rule css-val-left { :i <length> || <percentage> || auto & <keyw>  }
#| letter-spacing: normal | <length>
rule decl:sym<letter-spacing> { :i ("letter-spacing") ":" <val(/<css-val-letter-spacing> /, &?ROUTINE.WHY)>}
rule css-val-letter-spacing { :i normal & <keyw> || <length>  }
#| line-height: normal | <number> | <length> | <percentage>
rule decl:sym<line-height> { :i ("line-height") ":" <val(/<css-val-line-height> /, &?ROUTINE.WHY)>}
rule css-val-line-height { :i normal & <keyw> || <number> || <length> || <percentage>  }
#| list-style-image: <uri> | none
rule decl:sym<list-style-image> { :i ("list-style-image") ":" <val(/<css-val-list-style-image> /, &?ROUTINE.WHY)>}
rule css-val-list-style-image { :i <uri> || none & <keyw>  }
#| list-style-position: inside | outside
rule decl:sym<list-style-position> { :i ("list-style-position") ":" <val(/<css-val-list-style-position> /, &?ROUTINE.WHY)>}
rule css-val-list-style-position { :i [inside | outside ]& <keyw>  }
#| list-style-type: disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none
rule decl:sym<list-style-type> { :i ("list-style-type") ":" <val(/<css-val-list-style-type> /, &?ROUTINE.WHY)>}
rule css-val-list-style-type { :i [disc | circle | square | decimal | "decimal-leading-zero" | "lower-roman" | "upper-roman" | "lower-greek" | "lower-latin" | "upper-latin" | armenian | georgian | "lower-alpha" | "upper-alpha" | none ]& <keyw>  }
#| list-style: [ 'list-style-type' || 'list-style-position' || 'list-style-image' ]
rule decl:sym<list-style> { :i ("list-style") ":" <val(/<css-val-list-style> /, &?ROUTINE.WHY)>}
rule css-val-list-style { :i [[<css-val-list-style-type> :my $*A; <!{
    $*A++
}>|| <css-val-list-style-position> :my $*B; <!{
    $*B++
}>|| <css-val-list-style-image> :my $*C; <!{
    $*C++
}>]+] }
#| margin-right: <margin-width>
rule decl:sym<margin-right> { :i ("margin-right") ":" <val(/<css-val-margin-right> /, &?ROUTINE.WHY)>}
rule css-val-margin-right { :i <margin-width> }
#| margin-right: <margin-width>
rule decl:sym<margin-left> { :i ("margin-left") ":" <val(/<css-val-margin-left> /, &?ROUTINE.WHY)>}
rule css-val-margin-left { :i <margin-width> }
#| margin-top: <margin-width>
rule decl:sym<margin-top> { :i ("margin-top") ":" <val(/<css-val-margin-top> /, &?ROUTINE.WHY)>}
rule css-val-margin-top { :i <margin-width> }
#| margin-top: <margin-width>
rule decl:sym<margin-bottom> { :i ("margin-bottom") ":" <val(/<css-val-margin-bottom> /, &?ROUTINE.WHY)>}
rule css-val-margin-bottom { :i <margin-width> }
#| margin: <margin-width>{1,4}
rule decl:sym<margin> { :i (margin) ":" <val(/<css-val-margin>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-margin { :i <margin-width> }
#| <margin-width> = <length> | <percentage> | auto
rule margin-width { :i <length> || <percentage> || auto & <keyw>  }
#| max-height: <length> | <percentage> | none
rule decl:sym<max-height> { :i ("max-height") ":" <val(/<css-val-max-height> /, &?ROUTINE.WHY)>}
rule css-val-max-height { :i <length> || <percentage> || none & <keyw>  }
#| max-width: <length> | <percentage> | none
rule decl:sym<max-width> { :i ("max-width") ":" <val(/<css-val-max-width> /, &?ROUTINE.WHY)>}
rule css-val-max-width { :i <length> || <percentage> || none & <keyw>  }
#| min-height: <length> | <percentage>
rule decl:sym<min-height> { :i ("min-height") ":" <val(/<css-val-min-height> /, &?ROUTINE.WHY)>}
rule css-val-min-height { :i <length> || <percentage>  }
#| min-width: <length> | <percentage>
rule decl:sym<min-width> { :i ("min-width") ":" <val(/<css-val-min-width> /, &?ROUTINE.WHY)>}
rule css-val-min-width { :i <length> || <percentage>  }
#| opacity: <number>
rule decl:sym<opacity> { :i (opacity) ":" <val(/<css-val-opacity> /, &?ROUTINE.WHY)>}
rule css-val-opacity { :i <number> }
#| orphans: <integer>
rule decl:sym<orphans> { :i (orphans) ":" <val(/<css-val-orphans> /, &?ROUTINE.WHY)>}
rule css-val-orphans { :i <integer> }
#| outline-color: <color> | invert
rule decl:sym<outline-color> { :i ("outline-color") ":" <val(/<css-val-outline-color> /, &?ROUTINE.WHY)>}
rule css-val-outline-color { :i <color> || invert & <keyw>  }
#| outline-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<outline-style> { :i ("outline-style") ":" <val(/<css-val-outline-style> /, &?ROUTINE.WHY)>}
rule css-val-outline-style { :i [[none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| outline-width: thin | medium | thick | <length>
rule decl:sym<outline-width> { :i ("outline-width") ":" <val(/<css-val-outline-width> /, &?ROUTINE.WHY)>}
rule css-val-outline-width { :i [thin | medium | thick ]& <keyw>  || <length>  }
#| outline: [ 'outline-color' || 'outline-style' || 'outline-width' ]
rule decl:sym<outline> { :i (outline) ":" <val(/<css-val-outline> /, &?ROUTINE.WHY)>}
rule css-val-outline { :i [[<css-val-outline-color> :my $*A; <!{
    $*A++
}>|| <css-val-outline-style> :my $*B; <!{
    $*B++
}>|| <css-val-outline-width> :my $*C; <!{
    $*C++
}>]+] }
#| overflow: visible | hidden | scroll | auto
rule decl:sym<overflow> { :i (overflow) ":" <val(/<css-val-overflow> /, &?ROUTINE.WHY)>}
rule css-val-overflow { :i [visible | hidden | scroll | auto ]& <keyw>  }
#| padding-top: <padding-width>
rule decl:sym<padding-top> { :i ("padding-top") ":" <val(/<css-val-padding-top> /, &?ROUTINE.WHY)>}
rule css-val-padding-top { :i <padding-width> }
#| padding-top: <padding-width>
rule decl:sym<padding-right> { :i ("padding-right") ":" <val(/<css-val-padding-right> /, &?ROUTINE.WHY)>}
rule css-val-padding-right { :i <padding-width> }
#| padding-top: <padding-width>
rule decl:sym<padding-bottom> { :i ("padding-bottom") ":" <val(/<css-val-padding-bottom> /, &?ROUTINE.WHY)>}
rule css-val-padding-bottom { :i <padding-width> }
#| padding-top: <padding-width>
rule decl:sym<padding-left> { :i ("padding-left") ":" <val(/<css-val-padding-left> /, &?ROUTINE.WHY)>}
rule css-val-padding-left { :i <padding-width> }
#| padding: <padding-width>{1,4}
rule decl:sym<padding> { :i (padding) ":" <val(/<css-val-padding>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-padding { :i <padding-width> }
#| <padding-width> = <length> | <percentage>
rule padding-width { :i <length> || <percentage>  }
#| page-break-after: auto | always | avoid | left | right
rule decl:sym<page-break-after> { :i ("page-break-after") ":" <val(/<css-val-page-break-after> /, &?ROUTINE.WHY)>}
rule css-val-page-break-after { :i [auto | always | avoid | left | right ]& <keyw>  }
#| page-break-before: auto | always | avoid | left | right
rule decl:sym<page-break-before> { :i ("page-break-before") ":" <val(/<css-val-page-break-before> /, &?ROUTINE.WHY)>}
rule css-val-page-break-before { :i [auto | always | avoid | left | right ]& <keyw>  }
#| page-break-inside: avoid | auto
rule decl:sym<page-break-inside> { :i ("page-break-inside") ":" <val(/<css-val-page-break-inside> /, &?ROUTINE.WHY)>}
rule css-val-page-break-inside { :i [avoid | auto ]& <keyw>  }
#| pause-after: <time> | <percentage>
rule decl:sym<pause-after> { :i ("pause-after") ":" <val(/<css-val-pause-after> /, &?ROUTINE.WHY)>}
rule css-val-pause-after { :i <time> || <percentage>  }
#| pause-before: <time> | <percentage>
rule decl:sym<pause-before> { :i ("pause-before") ":" <val(/<css-val-pause-before> /, &?ROUTINE.WHY)>}
rule css-val-pause-before { :i <time> || <percentage>  }
#| pause: [ [<time> | <percentage>]{1,2} ]
rule decl:sym<pause> { :i (pause) ":" <val(/<css-val-pause> /, &?ROUTINE.WHY)>}
rule css-val-pause { :i [[<time> || <percentage> ] ** 1..2] }
#| pitch-range: <number>
rule decl:sym<pitch-range> { :i ("pitch-range") ":" <val(/<css-val-pitch-range> /, &?ROUTINE.WHY)>}
rule css-val-pitch-range { :i <number> }
#| pitch: <frequency> | x-low | low | medium | high | x-high
rule decl:sym<pitch> { :i (pitch) ":" <val(/<css-val-pitch> /, &?ROUTINE.WHY)>}
rule css-val-pitch { :i <frequency> || ["x-low" | low | medium | high | "x-high" ]& <keyw>   }
#| play-during: <uri> [ mix || repeat ]? | auto | none
rule decl:sym<play-during> { :i ("play-during") ":" <val(/<css-val-play-during> /, &?ROUTINE.WHY)>}
rule css-val-play-during { :i <uri> [[mix & <keyw> :my $*A; <!{
    $*A++
}>|| repeat & <keyw> :my $*B; <!{
    $*B++
}>]+] ?  || [auto | none ]& <keyw>   }
#| position: static | relative | absolute | fixed
rule decl:sym<position> { :i (position) ":" <val(/<css-val-position> /, &?ROUTINE.WHY)>}
rule css-val-position { :i [static | relative | absolute | fixed ]& <keyw>  }
#| quotes: [<string> <string>]+ | none
rule decl:sym<quotes> { :i (quotes) ":" <val(/<css-val-quotes> /, &?ROUTINE.WHY)>}
rule css-val-quotes { :i [<string> <string> ] + || none & <keyw>  }
#| richness: <number>
rule decl:sym<richness> { :i (richness) ":" <val(/<css-val-richness> /, &?ROUTINE.WHY)>}
rule css-val-richness { :i <number> }
#| right: <length> | <percentage> | auto
rule decl:sym<right> { :i (right) ":" <val(/<css-val-right> /, &?ROUTINE.WHY)>}
rule css-val-right { :i <length> || <percentage> || auto & <keyw>  }
#| size: <length>{1,2} | auto | portrait | landscape
rule decl:sym<size> { :i (size) ":" <val(/<css-val-size> /, &?ROUTINE.WHY)>}
rule css-val-size { :i <length> ** 1..2 || [auto | portrait | landscape ]& <keyw>   }
#| speak-header: once | always
rule decl:sym<speak-header> { :i ("speak-header") ":" <val(/<css-val-speak-header> /, &?ROUTINE.WHY)>}
rule css-val-speak-header { :i [once | always ]& <keyw>  }
#| speak-numeral: digits | continuous
rule decl:sym<speak-numeral> { :i ("speak-numeral") ":" <val(/<css-val-speak-numeral> /, &?ROUTINE.WHY)>}
rule css-val-speak-numeral { :i [digits | continuous ]& <keyw>  }
#| speak-punctuation: code | none
rule decl:sym<speak-punctuation> { :i ("speak-punctuation") ":" <val(/<css-val-speak-punctuation> /, &?ROUTINE.WHY)>}
rule css-val-speak-punctuation { :i [code | none ]& <keyw>  }
#| speak: normal | none | spell-out
rule decl:sym<speak> { :i (speak) ":" <val(/<css-val-speak> /, &?ROUTINE.WHY)>}
rule css-val-speak { :i [normal | none | "spell-out" ]& <keyw>  }
#| speech-rate: <number> | x-slow | slow | medium | fast | x-fast | faster | slower
rule decl:sym<speech-rate> { :i ("speech-rate") ":" <val(/<css-val-speech-rate> /, &?ROUTINE.WHY)>}
rule css-val-speech-rate { :i <number> || ["x-slow" | slow | medium | fast | "x-fast" | faster | slower ]& <keyw>   }
#| stress: <number>
rule decl:sym<stress> { :i (stress) ":" <val(/<css-val-stress> /, &?ROUTINE.WHY)>}
rule css-val-stress { :i <number> }
#| table-layout: auto | fixed
rule decl:sym<table-layout> { :i ("table-layout") ":" <val(/<css-val-table-layout> /, &?ROUTINE.WHY)>}
rule css-val-table-layout { :i [auto | fixed ]& <keyw>  }
#| text-align: <align> | justify
rule decl:sym<text-align> { :i ("text-align") ":" <val(/<css-val-text-align> /, &?ROUTINE.WHY)>}
rule css-val-text-align { :i <align> || justify & <keyw>  }
#| text-decoration: none | [ underline || overline || line-through || blink ]
rule decl:sym<text-decoration> { :i ("text-decoration") ":" <val(/<css-val-text-decoration> /, &?ROUTINE.WHY)>}
rule css-val-text-decoration { :i none & <keyw> || [[underline & <keyw> :my $*A; <!{
    $*A++
}>|| overline & <keyw> :my $*B; <!{
    $*B++
}>|| "line-through" & <keyw> :my $*C; <!{
    $*C++
}>|| blink & <keyw> :my $*D; <!{
    $*D++
}>]+]  }
#| text-indent: <length> | <percentage>
rule decl:sym<text-indent> { :i ("text-indent") ":" <val(/<css-val-text-indent> /, &?ROUTINE.WHY)>}
rule css-val-text-indent { :i <length> || <percentage>  }
#| text-transform: capitalize | uppercase | lowercase | none
rule decl:sym<text-transform> { :i ("text-transform") ":" <val(/<css-val-text-transform> /, &?ROUTINE.WHY)>}
rule css-val-text-transform { :i [capitalize | uppercase | lowercase | none ]& <keyw>  }
#| top: <length> | <percentage> | auto
rule decl:sym<top> { :i (top) ":" <val(/<css-val-top> /, &?ROUTINE.WHY)>}
rule css-val-top { :i <length> || <percentage> || auto & <keyw>  }
#| unicode-bidi: normal | embed | bidi-override
rule decl:sym<unicode-bidi> { :i ("unicode-bidi") ":" <val(/<css-val-unicode-bidi> /, &?ROUTINE.WHY)>}
rule css-val-unicode-bidi { :i [normal | embed | "bidi-override" ]& <keyw>  }
#| vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length>
rule decl:sym<vertical-align> { :i ("vertical-align") ":" <val(/<css-val-vertical-align> /, &?ROUTINE.WHY)>}
rule css-val-vertical-align { :i [baseline | sub | super | top | "text-top" | middle | bottom | "text-bottom" ]& <keyw>  || <percentage> || <length>  }
#| visibility: visible | hidden | collapse
rule decl:sym<visibility> { :i (visibility) ":" <val(/<css-val-visibility> /, &?ROUTINE.WHY)>}
rule css-val-visibility { :i [visible | hidden | collapse ]& <keyw>  }
#| voice-family: [<generic-voice> | <specific-voice> ]#
rule decl:sym<voice-family> { :i ("voice-family") ":" <val(/<css-val-voice-family> +% <op(",")> /, &?ROUTINE.WHY)>}
rule css-val-voice-family { :i [<generic-voice> || <specific-voice> ] }
#| <generic-voice> = male | female | child
rule generic-voice { :i [male | female | child ]& <keyw>  }
#| <specific-voice> = <identifier> | <string>
rule specific-voice { :i <identifier> || <string>  }
#| volume: <number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud
rule decl:sym<volume> { :i (volume) ":" <val(/<css-val-volume> /, &?ROUTINE.WHY)>}
rule css-val-volume { :i <number> || <percentage> || [silent | "x-soft" | soft | medium | loud | "x-loud" ]& <keyw>   }
#| white-space: normal | pre | nowrap | pre-wrap | pre-line
rule decl:sym<white-space> { :i ("white-space") ":" <val(/<css-val-white-space> /, &?ROUTINE.WHY)>}
rule css-val-white-space { :i [normal | pre | nowrap | "pre-wrap" | "pre-line" ]& <keyw>  }
#| widows: <integer>
rule decl:sym<widows> { :i (widows) ":" <val(/<css-val-widows> /, &?ROUTINE.WHY)>}
rule css-val-widows { :i <integer> }
#| width: <length> | <percentage> | auto
rule decl:sym<width> { :i (width) ":" <val(/<css-val-width> /, &?ROUTINE.WHY)>}
rule css-val-width { :i <length> || <percentage> || auto & <keyw>  }
#| word-spacing: normal | <length>
rule decl:sym<word-spacing> { :i ("word-spacing") ":" <val(/<css-val-word-spacing> /, &?ROUTINE.WHY)>}
rule css-val-word-spacing { :i normal & <keyw> || <length>  }
#| z-index: auto | <integer>
rule decl:sym<z-index> { :i ("z-index") ":" <val(/<css-val-z-index> /, &?ROUTINE.WHY)>}
rule css-val-z-index { :i auto & <keyw> || <integer>  }