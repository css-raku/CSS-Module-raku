unit grammar CSS::Snapshot2026::CSS21::Gen::Grammar;
#| background: [<'background-color'> || <'background-image'> || <'background-repeat'> || <'background-attachment'> || <'background-position'>]
rule decl:sym<background> { :i (background) ":" <val(/<prop-val-background> /, &?ROUTINE.WHY)>}
rule prop-val-background { :i [[<prop-val-background-color> :my $*A;<!{
    $*A++
}>|| <prop-val-background-image> :my $*B;<!{
    $*B++
}>|| <prop-val-background-repeat> :my $*C;<!{
    $*C++
}>|| <prop-val-background-attachment> :my $*D;<!{
    $*D++
}>|| <prop-val-background-position> :my $*E;<!{
    $*E++
}>]+] }
#| background-attachment: scroll | fixed
rule decl:sym<background-attachment> { :i ("background-attachment") ":" <val(/<prop-val-background-attachment> /, &?ROUTINE.WHY)>}
rule prop-val-background-attachment { :i [scroll | fixed ]& <keyw>  }
#| background-color: <color> | transparent
rule decl:sym<background-color> { :i ("background-color") ":" <val(/<prop-val-background-color> /, &?ROUTINE.WHY)>}
rule prop-val-background-color { :i <color> || transparent & <keyw>  }
#| background-image: <uri> | none
rule decl:sym<background-image> { :i ("background-image") ":" <val(/<prop-val-background-image> /, &?ROUTINE.WHY)>}
rule prop-val-background-image { :i <uri> || none & <keyw>  }
#| background-position: [ [ <percentage> | <length> | left | center | right ] [ <percentage> | <length> | top | center | bottom ]? ] | [ [ left | center | right ] || [ top | center | bottom ] ]
rule decl:sym<background-position> { :i ("background-position") ":" <val(/<prop-val-background-position> /, &?ROUTINE.WHY)>}
rule prop-val-background-position { :i [[<percentage> || <length> || [left | center | right ]& <keyw>  ] [<percentage> || <length> || [top | center | bottom ]& <keyw>  ] ? ] || [[[[left | center | right ]& <keyw> ] :my $*A;<!{
    $*A++
}>|| [[top | center | bottom ]& <keyw> ] :my $*B;<!{
    $*B++
}>]+]  }
#| background-repeat: repeat | repeat-x | repeat-y | no-repeat
rule decl:sym<background-repeat> { :i ("background-repeat") ":" <val(/<prop-val-background-repeat> /, &?ROUTINE.WHY)>}
rule prop-val-background-repeat { :i [repeat | "repeat-x" | "repeat-y" | "no-repeat" ]& <keyw>  }
#| border: [ <'border-width'> || <'border-style'> || <'border-color'> ]
rule decl:sym<border> { :i (border) ":" <val(/<prop-val-border> /, &?ROUTINE.WHY)>}
rule prop-val-border { :i [[<prop-val-border-width> :my $*A;<!{
    $*A++
}>|| <prop-val-border-style> :my $*B;<!{
    $*B++
}>|| <prop-val-border-color> :my $*C;<!{
    $*C++
}>]+] }
#| border-bottom: [ <'border-bottom-width'> || <'border-bottom-style'> || <'border-bottom-color'> ]
rule decl:sym<border-bottom> { :i ("border-bottom") ":" <val(/<prop-val-border-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom { :i [[<prop-val-border-bottom-width> :my $*A;<!{
    $*A++
}>|| <prop-val-border-bottom-style> :my $*B;<!{
    $*B++
}>|| <prop-val-border-bottom-color> :my $*C;<!{
    $*C++
}>]+] }
#| border-bottom-color: <border-color>
rule decl:sym<border-bottom-color> { :i ("border-bottom-color") ":" <val(/<prop-val-border-bottom-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-color { :i <border-color> }
#| <border-color> = <color> | transparent
rule border-color { :i <color> || transparent & <keyw>  }
#| border-bottom-style: <border-style>
rule decl:sym<border-bottom-style> { :i ("border-bottom-style") ":" <val(/<prop-val-border-bottom-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-style { :i <border-style> }
#| border-bottom-width: <border-width>
rule decl:sym<border-bottom-width> { :i ("border-bottom-width") ":" <val(/<prop-val-border-bottom-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-width { :i <border-width> }
#| border-collapse: collapse | separate
rule decl:sym<border-collapse> { :i ("border-collapse") ":" <val(/<prop-val-border-collapse> /, &?ROUTINE.WHY)>}
rule prop-val-border-collapse { :i [collapse | separate ]& <keyw>  }
#| border-color: <border-color>{1,4}
rule decl:sym<border-color> { :i ("border-color") ":" <val(/<prop-val-border-color>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-color { :i <border-color> }
#| border-left: [ <'border-left-width'> || <'border-left-style'> || <'border-left-color'> ]
rule decl:sym<border-left> { :i ("border-left") ":" <val(/<prop-val-border-left> /, &?ROUTINE.WHY)>}
rule prop-val-border-left { :i [[<prop-val-border-left-width> :my $*A;<!{
    $*A++
}>|| <prop-val-border-left-style> :my $*B;<!{
    $*B++
}>|| <prop-val-border-left-color> :my $*C;<!{
    $*C++
}>]+] }
#| border-left-color: <border-color>
rule decl:sym<border-left-color> { :i ("border-left-color") ":" <val(/<prop-val-border-left-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-left-color { :i <border-color> }
#| border-left-style: <border-style>
rule decl:sym<border-left-style> { :i ("border-left-style") ":" <val(/<prop-val-border-left-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-left-style { :i <border-style> }
#| border-left-width: <border-width>
rule decl:sym<border-left-width> { :i ("border-left-width") ":" <val(/<prop-val-border-left-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-left-width { :i <border-width> }
#| border-right: [ <'border-right-width'> || <'border-right-style'> || <'border-right-color'> ]
rule decl:sym<border-right> { :i ("border-right") ":" <val(/<prop-val-border-right> /, &?ROUTINE.WHY)>}
rule prop-val-border-right { :i [[<prop-val-border-right-width> :my $*A;<!{
    $*A++
}>|| <prop-val-border-right-style> :my $*B;<!{
    $*B++
}>|| <prop-val-border-right-color> :my $*C;<!{
    $*C++
}>]+] }
#| border-right-color: <border-color>
rule decl:sym<border-right-color> { :i ("border-right-color") ":" <val(/<prop-val-border-right-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-right-color { :i <border-color> }
#| border-right-style: <border-style>
rule decl:sym<border-right-style> { :i ("border-right-style") ":" <val(/<prop-val-border-right-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-right-style { :i <border-style> }
#| border-right-width: <border-width>
rule decl:sym<border-right-width> { :i ("border-right-width") ":" <val(/<prop-val-border-right-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-right-width { :i <border-width> }
#| border-spacing: <length> <length>?
rule decl:sym<border-spacing> { :i ("border-spacing") ":" <val(/<prop-val-border-spacing> /, &?ROUTINE.WHY)>}
rule prop-val-border-spacing { :i <length> <length> ?  }
#| border-style: <border-style>{1,4}
rule decl:sym<border-style> { :i ("border-style") ":" <val(/<prop-val-border-style>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-style { :i <border-style> }
#| <border-style> = none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset
rule border-style { :i [none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw>  }
#| border-top: [ <'border-top-width'> || <'border-top-style'> || <'border-top-color'> ]
rule decl:sym<border-top> { :i ("border-top") ":" <val(/<prop-val-border-top> /, &?ROUTINE.WHY)>}
rule prop-val-border-top { :i [[<prop-val-border-top-width> :my $*A;<!{
    $*A++
}>|| <prop-val-border-top-style> :my $*B;<!{
    $*B++
}>|| <prop-val-border-top-color> :my $*C;<!{
    $*C++
}>]+] }
#| border-top-color: <border-color>
rule decl:sym<border-top-color> { :i ("border-top-color") ":" <val(/<prop-val-border-top-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-color { :i <border-color> }
#| border-top-style: <border-style>
rule decl:sym<border-top-style> { :i ("border-top-style") ":" <val(/<prop-val-border-top-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-style { :i <border-style> }
#| border-top-width: <border-width>
rule decl:sym<border-top-width> { :i ("border-top-width") ":" <val(/<prop-val-border-top-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-width { :i <border-width> }
#| border-width: <border-width>{1,4}
rule decl:sym<border-width> { :i ("border-width") ":" <val(/<prop-val-border-width>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-width { :i <border-width> }
#| <border-width> = thin | medium | thick | <length>
rule border-width { :i [thin | medium | thick ]& <keyw>  || <length>  }
#| bottom: <length> | <percentage> | auto
rule decl:sym<bottom> { :i (bottom) ":" <val(/<prop-val-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-bottom { :i <length> || <percentage> || auto & <keyw>  }
#| caption-side: top | bottom
rule decl:sym<caption-side> { :i ("caption-side") ":" <val(/<prop-val-caption-side> /, &?ROUTINE.WHY)>}
rule prop-val-caption-side { :i [top | bottom ]& <keyw>  }
#| clear: none | left | right | both
rule decl:sym<clear> { :i (clear) ":" <val(/<prop-val-clear> /, &?ROUTINE.WHY)>}
rule prop-val-clear { :i [none | left | right | both ]& <keyw>  }
#| clip: <shape> | auto
rule decl:sym<clip> { :i (clip) ":" <val(/<prop-val-clip> /, &?ROUTINE.WHY)>}
rule prop-val-clip { :i <shape> || auto & <keyw>  }
#| color: <color>
rule decl:sym<color> { :i (color) ":" <val(/<prop-val-color> /, &?ROUTINE.WHY)>}
rule prop-val-color { :i <color> }
#| content: normal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+
rule decl:sym<content> { :i (content) ":" <val(/<prop-val-content> /, &?ROUTINE.WHY)>}
rule prop-val-content { :i [normal | none ]& <keyw>  || [<string> || <uri> || <counter> || <attr> || ["open-quote" | "close-quote" | "no-open-quote" | "no-close-quote" ]& <keyw>  ] +  }
#| counter(<identifier>, <list-style-type>?)
rule counter { :i "counter(" [<identifier> ["," <list-style-type> ]?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| <list-style-type> = disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none
rule list-style-type { :i [disc | circle | square | decimal | "decimal-leading-zero" | "lower-roman" | "upper-roman" | "lower-greek" | "lower-latin" | "upper-latin" | armenian | georgian | "lower-alpha" | "upper-alpha" | none ]& <keyw>  }
#| attr(<identifier>)
rule attr { :i "attr(" [<identifier> || <usage(&?ROUTINE.WHY)> ] ")" }
#| counter-increment: [ <identifier> <integer>? ]+ | none
rule decl:sym<counter-increment> { :i ("counter-increment") ":" <val(/<prop-val-counter-increment> /, &?ROUTINE.WHY)>}
rule prop-val-counter-increment { :i [<identifier> <integer> ? ] + || none & <keyw>  }
#| counter-reset: [ <identifier> <integer>? ]+ | none
rule decl:sym<counter-reset> { :i ("counter-reset") ":" <val(/<prop-val-counter-reset> /, &?ROUTINE.WHY)>}
rule prop-val-counter-reset { :i [<identifier> <integer> ? ] + || none & <keyw>  }
#| cursor: [ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ]
rule decl:sym<cursor> { :i (cursor) ":" <val(/<prop-val-cursor> /, &?ROUTINE.WHY)>}
rule prop-val-cursor { :i [[<uri> <op(",")> ] * [[auto | crosshair | default | pointer | move | "e-resize" | "ne-resize" | "nw-resize" | "n-resize" | "se-resize" | "sw-resize" | "s-resize" | "w-resize" | text | wait | help | progress ]& <keyw> ] ] }
#| direction: ltr | rtl
rule decl:sym<direction> { :i (direction) ":" <val(/<prop-val-direction> /, &?ROUTINE.WHY)>}
rule prop-val-direction { :i [ltr | rtl ]& <keyw>  }
#| display: inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none
rule decl:sym<display> { :i (display) ":" <val(/<prop-val-display> /, &?ROUTINE.WHY)>}
rule prop-val-display { :i [inline | block | "list-item" | "inline-block" | table | "inline-table" | "table-row-group" | "table-header-group" | "table-footer-group" | "table-row" | "table-column-group" | "table-column" | "table-cell" | "table-caption" | none ]& <keyw>  }
#| empty-cells: show | hide
rule decl:sym<empty-cells> { :i ("empty-cells") ":" <val(/<prop-val-empty-cells> /, &?ROUTINE.WHY)>}
rule prop-val-empty-cells { :i [show | hide ]& <keyw>  }
#| float: left | right | none
rule decl:sym<float> { :i (float) ":" <val(/<prop-val-float> /, &?ROUTINE.WHY)>}
rule prop-val-float { :i [left | right | none ]& <keyw>  }
#| font: [ [ <'font-style'> || <'font-variant'> || <'font-weight'> ]? <'font-size'> [ / <'line-height'> ]? <'font-family'> ] | caption | icon | menu | message-box | small-caption | status-bar
rule decl:sym<font> { :i (font) ":" <val(/<prop-val-font> /, &?ROUTINE.WHY)>}
rule prop-val-font { :i [[[<prop-val-font-style> :my $*A;<!{
    $*A++
}>|| <prop-val-font-variant> :my $*B;<!{
    $*B++
}>|| <prop-val-font-weight> :my $*C;<!{
    $*C++
}>]+] ? <prop-val-font-size> [<op("/")> <prop-val-line-height> ] ? <prop-val-font-family> ] || [caption | icon | menu | "message-box" | "small-caption" | "status-bar" ]& <keyw>   }
#| font-family: [ [ <family-name> | <generic-family> ] [, <family-name> | <generic-family>]* ]
rule decl:sym<font-family> { :i ("font-family") ":" <val(/<prop-val-font-family> /, &?ROUTINE.WHY)>}
rule prop-val-font-family { :i [[<family-name> || <generic-family> ] [<op(",")> <family-name>  || <generic-family> ] * ] }
#| <generic-family> = serif | sans-serif | cursive | fantasy | monospace
rule generic-family { :i [serif | "sans-serif" | cursive | fantasy | monospace ]& <keyw>  }
#| <family-name> = <identifiers> | <string>
rule family-name { :i <identifiers> || <string>  }
#| font-size: <absolute-size> | <relative-size> | <length> | <percentage>
rule decl:sym<font-size> { :i ("font-size") ":" <val(/<prop-val-font-size> /, &?ROUTINE.WHY)>}
rule prop-val-font-size { :i <absolute-size> || <relative-size> || <length> || <percentage>  }
#| font-style: normal | italic | oblique
rule decl:sym<font-style> { :i ("font-style") ":" <val(/<prop-val-font-style> /, &?ROUTINE.WHY)>}
rule prop-val-font-style { :i [normal | italic | oblique ]& <keyw>  }
#| font-variant: normal | small-caps
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<prop-val-font-variant> /, &?ROUTINE.WHY)>}
rule prop-val-font-variant { :i [normal | "small-caps" ]& <keyw>  }
#| font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
rule decl:sym<font-weight> { :i ("font-weight") ":" <val(/<prop-val-font-weight> /, &?ROUTINE.WHY)>}
rule prop-val-font-weight { :i [normal | bold | bolder | lighter ]& <keyw>  || [100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ]& <number>  }
#| height: <width-or-height>
rule decl:sym<height> { :i (height) ":" <val(/<prop-val-height> /, &?ROUTINE.WHY)>}
rule prop-val-height { :i <width-or-height> }
#| <width-or-height> = <length> | <percentage> | auto
rule width-or-height { :i <length> || <percentage> || auto & <keyw>  }
#| left: <length> | <percentage> | auto
rule decl:sym<left> { :i (left) ":" <val(/<prop-val-left> /, &?ROUTINE.WHY)>}
rule prop-val-left { :i <length> || <percentage> || auto & <keyw>  }
#| letter-spacing: normal | <length>
rule decl:sym<letter-spacing> { :i ("letter-spacing") ":" <val(/<prop-val-letter-spacing> /, &?ROUTINE.WHY)>}
rule prop-val-letter-spacing { :i normal & <keyw> || <length>  }
#| line-height: normal | <number> | <length> | <percentage>
rule decl:sym<line-height> { :i ("line-height") ":" <val(/<prop-val-line-height> /, &?ROUTINE.WHY)>}
rule prop-val-line-height { :i normal & <keyw> || <number> || <length> || <percentage>  }
#| list-style: [ <'list-style-type'> || <'list-style-position'> || <'list-style-image'> ]
rule decl:sym<list-style> { :i ("list-style") ":" <val(/<prop-val-list-style> /, &?ROUTINE.WHY)>}
rule prop-val-list-style { :i [[<prop-val-list-style-type> :my $*A;<!{
    $*A++
}>|| <prop-val-list-style-position> :my $*B;<!{
    $*B++
}>|| <prop-val-list-style-image> :my $*C;<!{
    $*C++
}>]+] }
#| list-style-image: <uri> | none
rule decl:sym<list-style-image> { :i ("list-style-image") ":" <val(/<prop-val-list-style-image> /, &?ROUTINE.WHY)>}
rule prop-val-list-style-image { :i <uri> || none & <keyw>  }
#| list-style-position: inside | outside
rule decl:sym<list-style-position> { :i ("list-style-position") ":" <val(/<prop-val-list-style-position> /, &?ROUTINE.WHY)>}
rule prop-val-list-style-position { :i [inside | outside ]& <keyw>  }
#| list-style-type: disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none
rule decl:sym<list-style-type> { :i ("list-style-type") ":" <val(/<prop-val-list-style-type> /, &?ROUTINE.WHY)>}
rule prop-val-list-style-type { :i [disc | circle | square | decimal | "decimal-leading-zero" | "lower-roman" | "upper-roman" | "lower-greek" | "lower-latin" | "upper-latin" | armenian | georgian | "lower-alpha" | "upper-alpha" | none ]& <keyw>  }
#| margin: <margin-width>{1,4}
rule decl:sym<margin> { :i (margin) ":" <val(/<prop-val-margin>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-margin { :i <margin-width> }
#| margin-bottom: <margin-width>
rule decl:sym<margin-bottom> { :i ("margin-bottom") ":" <val(/<prop-val-margin-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-margin-bottom { :i <margin-width> }
#| margin-left: <margin-width>
rule decl:sym<margin-left> { :i ("margin-left") ":" <val(/<prop-val-margin-left> /, &?ROUTINE.WHY)>}
rule prop-val-margin-left { :i <margin-width> }
#| margin-right: <margin-width>
rule decl:sym<margin-right> { :i ("margin-right") ":" <val(/<prop-val-margin-right> /, &?ROUTINE.WHY)>}
rule prop-val-margin-right { :i <margin-width> }
#| margin-top: <margin-width>
rule decl:sym<margin-top> { :i ("margin-top") ":" <val(/<prop-val-margin-top> /, &?ROUTINE.WHY)>}
rule prop-val-margin-top { :i <margin-width> }
#| max-height: <length> | <percentage> | none
rule decl:sym<max-height> { :i ("max-height") ":" <val(/<prop-val-max-height> /, &?ROUTINE.WHY)>}
rule prop-val-max-height { :i <length> || <percentage> || none & <keyw>  }
#| max-width: <length> | <percentage> | none
rule decl:sym<max-width> { :i ("max-width") ":" <val(/<prop-val-max-width> /, &?ROUTINE.WHY)>}
rule prop-val-max-width { :i <length> || <percentage> || none & <keyw>  }
#| min-height: <length> | <percentage>
rule decl:sym<min-height> { :i ("min-height") ":" <val(/<prop-val-min-height> /, &?ROUTINE.WHY)>}
rule prop-val-min-height { :i <length> || <percentage>  }
#| min-width: <length> | <percentage>
rule decl:sym<min-width> { :i ("min-width") ":" <val(/<prop-val-min-width> /, &?ROUTINE.WHY)>}
rule prop-val-min-width { :i <length> || <percentage>  }
#| orphans: <integer>
rule decl:sym<orphans> { :i (orphans) ":" <val(/<prop-val-orphans> /, &?ROUTINE.WHY)>}
rule prop-val-orphans { :i <integer> }
#| outline: [ <'outline-color'> || <'outline-style'> || <'outline-width'> ]
rule decl:sym<outline> { :i (outline) ":" <val(/<prop-val-outline> /, &?ROUTINE.WHY)>}
rule prop-val-outline { :i [[<prop-val-outline-color> :my $*A;<!{
    $*A++
}>|| <prop-val-outline-style> :my $*B;<!{
    $*B++
}>|| <prop-val-outline-width> :my $*C;<!{
    $*C++
}>]+] }
#| outline-color: <color> | invert
rule decl:sym<outline-color> { :i ("outline-color") ":" <val(/<prop-val-outline-color> /, &?ROUTINE.WHY)>}
rule prop-val-outline-color { :i <color> || invert & <keyw>  }
#| outline-style: <border-style>
rule decl:sym<outline-style> { :i ("outline-style") ":" <val(/<prop-val-outline-style> /, &?ROUTINE.WHY)>}
rule prop-val-outline-style { :i <border-style> }
#| outline-width: <border-width>
rule decl:sym<outline-width> { :i ("outline-width") ":" <val(/<prop-val-outline-width> /, &?ROUTINE.WHY)>}
rule prop-val-outline-width { :i <border-width> }
#| overflow: visible | hidden | scroll | auto
rule decl:sym<overflow> { :i (overflow) ":" <val(/<prop-val-overflow> /, &?ROUTINE.WHY)>}
rule prop-val-overflow { :i [visible | hidden | scroll | auto ]& <keyw>  }
#| padding: <padding-width>{1,4}
rule decl:sym<padding> { :i (padding) ":" <val(/<prop-val-padding>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-padding { :i <padding-width> }
#| <padding-width> = <length-percentage>
rule padding-width { :i <length-percentage> }
#| padding-bottom: <padding-width>
rule decl:sym<padding-bottom> { :i ("padding-bottom") ":" <val(/<prop-val-padding-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-padding-bottom { :i <padding-width> }
#| padding-left: <padding-width>
rule decl:sym<padding-left> { :i ("padding-left") ":" <val(/<prop-val-padding-left> /, &?ROUTINE.WHY)>}
rule prop-val-padding-left { :i <padding-width> }
#| padding-right: <padding-width>
rule decl:sym<padding-right> { :i ("padding-right") ":" <val(/<prop-val-padding-right> /, &?ROUTINE.WHY)>}
rule prop-val-padding-right { :i <padding-width> }
#| padding-top: <padding-width>
rule decl:sym<padding-top> { :i ("padding-top") ":" <val(/<prop-val-padding-top> /, &?ROUTINE.WHY)>}
rule prop-val-padding-top { :i <padding-width> }
#| page-break-after: auto | always | avoid | left | right
rule decl:sym<page-break-after> { :i ("page-break-after") ":" <val(/<prop-val-page-break-after> /, &?ROUTINE.WHY)>}
rule prop-val-page-break-after { :i [auto | always | avoid | left | right ]& <keyw>  }
#| page-break-before: auto | always | avoid | left | right
rule decl:sym<page-break-before> { :i ("page-break-before") ":" <val(/<prop-val-page-break-before> /, &?ROUTINE.WHY)>}
rule prop-val-page-break-before { :i [auto | always | avoid | left | right ]& <keyw>  }
#| page-break-inside: avoid | auto
rule decl:sym<page-break-inside> { :i ("page-break-inside") ":" <val(/<prop-val-page-break-inside> /, &?ROUTINE.WHY)>}
rule prop-val-page-break-inside { :i [avoid | auto ]& <keyw>  }
#| position: static | relative | absolute | fixed
rule decl:sym<position> { :i (position) ":" <val(/<prop-val-position> /, &?ROUTINE.WHY)>}
rule prop-val-position { :i [static | relative | absolute | fixed ]& <keyw>  }
#| quotes: [<string> <string>]+ | none
rule decl:sym<quotes> { :i (quotes) ":" <val(/<prop-val-quotes> /, &?ROUTINE.WHY)>}
rule prop-val-quotes { :i [<string> <string> ] + || none & <keyw>  }
#| right: <length> | <percentage> | auto
rule decl:sym<right> { :i (right) ":" <val(/<prop-val-right> /, &?ROUTINE.WHY)>}
rule prop-val-right { :i <length> || <percentage> || auto & <keyw>  }
#| table-layout: auto | fixed
rule decl:sym<table-layout> { :i ("table-layout") ":" <val(/<prop-val-table-layout> /, &?ROUTINE.WHY)>}
rule prop-val-table-layout { :i [auto | fixed ]& <keyw>  }
#| text-align: left | right | center | justify
rule decl:sym<text-align> { :i ("text-align") ":" <val(/<prop-val-text-align> /, &?ROUTINE.WHY)>}
rule prop-val-text-align { :i [left | right | center | justify ]& <keyw>  }
#| text-decoration: none | [ underline || overline || line-through || blink ]
rule decl:sym<text-decoration> { :i ("text-decoration") ":" <val(/<prop-val-text-decoration> /, &?ROUTINE.WHY)>}
rule prop-val-text-decoration { :i none & <keyw> || [[underline & <keyw> :my $*A;<!{
    $*A++
}>|| overline & <keyw> :my $*B;<!{
    $*B++
}>|| "line-through" & <keyw> :my $*C;<!{
    $*C++
}>|| blink & <keyw> :my $*D;<!{
    $*D++
}>]+]  }
#| text-indent: <length> | <percentage>
rule decl:sym<text-indent> { :i ("text-indent") ":" <val(/<prop-val-text-indent> /, &?ROUTINE.WHY)>}
rule prop-val-text-indent { :i <length> || <percentage>  }
#| text-transform: capitalize | uppercase | lowercase | none
rule decl:sym<text-transform> { :i ("text-transform") ":" <val(/<prop-val-text-transform> /, &?ROUTINE.WHY)>}
rule prop-val-text-transform { :i [capitalize | uppercase | lowercase | none ]& <keyw>  }
#| top: <top-offset>
rule decl:sym<top> { :i (top) ":" <val(/<prop-val-top> /, &?ROUTINE.WHY)>}
rule prop-val-top { :i <top-offset> }
#| <top-offset> = <length> | <percentage> | auto
rule top-offset { :i <length> || <percentage> || auto & <keyw>  }
#| unicode-bidi: normal | embed | bidi-override
rule decl:sym<unicode-bidi> { :i ("unicode-bidi") ":" <val(/<prop-val-unicode-bidi> /, &?ROUTINE.WHY)>}
rule prop-val-unicode-bidi { :i [normal | embed | "bidi-override" ]& <keyw>  }
#| vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length>
rule decl:sym<vertical-align> { :i ("vertical-align") ":" <val(/<prop-val-vertical-align> /, &?ROUTINE.WHY)>}
rule prop-val-vertical-align { :i [baseline | sub | super | top | "text-top" | middle | bottom | "text-bottom" ]& <keyw>  || <percentage> || <length>  }
#| visibility: visible | hidden | collapse
rule decl:sym<visibility> { :i (visibility) ":" <val(/<prop-val-visibility> /, &?ROUTINE.WHY)>}
rule prop-val-visibility { :i [visible | hidden | collapse ]& <keyw>  }
#| white-space: normal | pre | nowrap | pre-wrap | pre-line
rule decl:sym<white-space> { :i ("white-space") ":" <val(/<prop-val-white-space> /, &?ROUTINE.WHY)>}
rule prop-val-white-space { :i [normal | pre | nowrap | "pre-wrap" | "pre-line" ]& <keyw>  }
#| widows: <integer>
rule decl:sym<widows> { :i (widows) ":" <val(/<prop-val-widows> /, &?ROUTINE.WHY)>}
rule prop-val-widows { :i <integer> }
#| width: <width-or-height>
rule decl:sym<width> { :i (width) ":" <val(/<prop-val-width> /, &?ROUTINE.WHY)>}
rule prop-val-width { :i <width-or-height> }
#| word-spacing: normal | <length>
rule decl:sym<word-spacing> { :i ("word-spacing") ":" <val(/<prop-val-word-spacing> /, &?ROUTINE.WHY)>}
rule prop-val-word-spacing { :i normal & <keyw> || <length>  }
#| z-index: auto | <integer>
rule decl:sym<z-index> { :i ("z-index") ":" <val(/<prop-val-z-index> /, &?ROUTINE.WHY)>}
rule prop-val-z-index { :i auto & <keyw> || <integer>  }
#| azimuth: <angle> | [ <direction> || <behind> ] | <delta>
rule decl:sym<azimuth> { :i (azimuth) ":" <val(/<prop-val-azimuth> /, &?ROUTINE.WHY)>}
rule prop-val-azimuth { :i <angle> || [[<direction> :my $*A;<!{
    $*A++
}>|| <behind> :my $*B;<!{
    $*B++
}>]+] || <delta>  }
#| elevation: <angle> | <tilt>
rule decl:sym<elevation> { :i (elevation) ":" <val(/<prop-val-elevation> /, &?ROUTINE.WHY)>}
rule prop-val-elevation { :i <angle> || <tilt>  }
#| <tilt> = below | level | above | higher | lower
rule tilt { :i [below | level | above | higher | lower ]& <keyw>  }
#| <delta> = leftwards | rightwards
rule delta { :i [leftwards | rightwards ]& <keyw>  }
#| <direction> = left-side | far-left | left | center-left | center | center-right | right | far-right | right-side
rule direction { :i ["left-side" | "far-left" | left | "center-left" | center | "center-right" | right | "far-right" | "right-side" ]& <keyw>  }
#| <behind> = behind
rule behind { :i behind & <keyw> }
#| pitch-range: <number>
rule decl:sym<pitch-range> { :i ("pitch-range") ":" <val(/<prop-val-pitch-range> /, &?ROUTINE.WHY)>}
rule prop-val-pitch-range { :i <number> }
#| pitch: <frequency> | x-low | low | medium | high | x-high
rule decl:sym<pitch> { :i (pitch) ":" <val(/<prop-val-pitch> /, &?ROUTINE.WHY)>}
rule prop-val-pitch { :i <frequency> || ["x-low" | low | medium | high | "x-high" ]& <keyw>   }
#| play-during: <uri> [ mix || repeat ]? | auto | none
rule decl:sym<play-during> { :i ("play-during") ":" <val(/<prop-val-play-during> /, &?ROUTINE.WHY)>}
rule prop-val-play-during { :i <uri> [[mix & <keyw> :my $*A;<!{
    $*A++
}>|| repeat & <keyw> :my $*B;<!{
    $*B++
}>]+] ?  || [auto | none ]& <keyw>   }
#| richness: <number>
rule decl:sym<richness> { :i (richness) ":" <val(/<prop-val-richness> /, &?ROUTINE.WHY)>}
rule prop-val-richness { :i <number> }
#| speak-header: once | always
rule decl:sym<speak-header> { :i ("speak-header") ":" <val(/<prop-val-speak-header> /, &?ROUTINE.WHY)>}
rule prop-val-speak-header { :i [once | always ]& <keyw>  }
#| speak-numeral: digits | continuous
rule decl:sym<speak-numeral> { :i ("speak-numeral") ":" <val(/<prop-val-speak-numeral> /, &?ROUTINE.WHY)>}
rule prop-val-speak-numeral { :i [digits | continuous ]& <keyw>  }
#| speak-punctuation: code | none
rule decl:sym<speak-punctuation> { :i ("speak-punctuation") ":" <val(/<prop-val-speak-punctuation> /, &?ROUTINE.WHY)>}
rule prop-val-speak-punctuation { :i [code | none ]& <keyw>  }
#| speech-rate: <number> | x-slow | slow | medium | fast | x-fast | faster | slower
rule decl:sym<speech-rate> { :i ("speech-rate") ":" <val(/<prop-val-speech-rate> /, &?ROUTINE.WHY)>}
rule prop-val-speech-rate { :i <number> || ["x-slow" | slow | medium | fast | "x-fast" | faster | slower ]& <keyw>   }
#| speak: normal | none | spell-out
rule decl:sym<speak> { :i (speak) ":" <val(/<prop-val-speak> /, &?ROUTINE.WHY)>}
rule prop-val-speak { :i [normal | none | "spell-out" ]& <keyw>  }
#| stress: <number>
rule decl:sym<stress> { :i (stress) ":" <val(/<prop-val-stress> /, &?ROUTINE.WHY)>}
rule prop-val-stress { :i <number> }
#| volume: <number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud
rule decl:sym<volume> { :i (volume) ":" <val(/<prop-val-volume> /, &?ROUTINE.WHY)>}
rule prop-val-volume { :i <number> || <percentage> || [silent | "x-soft" | soft | medium | loud | "x-loud" ]& <keyw>   }