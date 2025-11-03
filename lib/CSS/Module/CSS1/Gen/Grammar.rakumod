unit grammar CSS::Module::CSS1::Gen::Grammar;
#| font-family: [ <generic-family> | <family-name> ]#
rule decl:sym<font-family> { :i ("font-family") ":" <val(/<expr=.expr-font-family> /, &?ROUTINE.WHY)>}
rule expr-font-family { :i [<generic-family> || <family-name> ] +% <op(",")> }
#| serif | sans-serif | cursive | fantasy | monospace
rule generic-family { :i [serif | "sans-serif" | cursive | fantasy | monospace ]& <keyw>  }
#| <identifiers> | <string>
rule family-name { :i <identifiers> || <string>  }
#| font-style: normal | italic | oblique
rule decl:sym<font-style> { :i ("font-style") ":" <val(/<expr=.expr-font-style> /, &?ROUTINE.WHY)>}
rule expr-font-style { :i [normal | italic | oblique ]& <keyw>  }
#| font-variant: normal | small-caps
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<expr=.expr-font-variant> /, &?ROUTINE.WHY)>}
rule expr-font-variant { :i [normal | "small-caps" ]& <keyw>  }
#| font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
rule decl:sym<font-weight> { :i ("font-weight") ":" <val(/<expr=.expr-font-weight> /, &?ROUTINE.WHY)>}
rule expr-font-weight { :i [normal | bold | bolder | lighter ]& <keyw>  || [100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ]& <number>  }
#| font-size: <absolute-size> | <relative-size> | <length> | <percentage>
rule decl:sym<font-size> { :i ("font-size") ":" <val(/<expr=.expr-font-size> /, &?ROUTINE.WHY)>}
rule expr-font-size { :i <absolute-size> || <relative-size> || <length> || <percentage>  }
#| xx-small | x-small | small | medium | large | x-large | xx-large
rule absolute-size { :i ["xx-small" | "x-small" | small | medium | large | "x-large" | "xx-large" ]& <keyw>  }
#| larger | smaller
rule relative-size { :i [larger | smaller ]& <keyw>  }
#| font: [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family'
rule decl:sym<font> { :i (font) ":" <val(/<expr=.expr-font> /, &?ROUTINE.WHY)>}
rule expr-font { :i [[<expr-font-style>:my $a; <!{
    $a++
}>| <expr-font-variant>:my $b; <!{
    $b++
}>| <expr-font-weight>:my $c; <!{
    $c++
}>]+] ? <expr-font-size> [<op("/")> <expr-line-height> ] ? <expr-font-family>  }
#| color: <color>
rule decl:sym<color> { :i (color) ":" <val(/<expr=.expr-color> /, &?ROUTINE.WHY)>}
rule expr-color { :i <color> }
#| background-color: <color> | transparent
rule decl:sym<background-color> { :i ("background-color") ":" <val(/<expr=.expr-background-color> /, &?ROUTINE.WHY)>}
rule expr-background-color { :i <color> || transparent & <keyw>   }
#| background-image: <uri> | none
rule decl:sym<background-image> { :i ("background-image") ":" <val(/<expr=.expr-background-image> /, &?ROUTINE.WHY)>}
rule expr-background-image { :i <uri> || none & <keyw>   }
#| background-repeat: repeat | repeat-x | repeat-y | no-repeat
rule decl:sym<background-repeat> { :i ("background-repeat") ":" <val(/<expr=.expr-background-repeat> /, &?ROUTINE.WHY)>}
rule expr-background-repeat { :i [repeat | "repeat-x" | "repeat-y" | "no-repeat" ]& <keyw>  }
#| background-attachment: scroll | fixed
rule decl:sym<background-attachment> { :i ("background-attachment") ":" <val(/<expr=.expr-background-attachment> /, &?ROUTINE.WHY)>}
rule expr-background-attachment { :i [scroll | fixed ]& <keyw>  }
#| background-position: [<percentage> | <length> | <align> ] [ <percentage> | <length> | <valign> ]? | [ <valign> || <align> ]
rule decl:sym<background-position> { :i ("background-position") ":" <val(/<expr=.expr-background-position> /, &?ROUTINE.WHY)>}
rule expr-background-position { :i [<percentage> || <length> || <align> ] [<percentage> || <length> || <valign> ] ?  || [[<valign>:my $a; <!{
    $a++
}>| <align>:my $b; <!{
    $b++
}>]+]  }
#| left | center | right
rule align { :i [left | center | right ]& <keyw>  }
#| top | center | bottom
rule valign { :i [top | center | bottom ]& <keyw>  }
#| background: 'background-color' || 'background-image' || 'background-repeat' || 'background-attachment' || 'background-position'
rule decl:sym<background> { :i (background) ":" <val(/<expr=.expr-background> /, &?ROUTINE.WHY)>}
rule expr-background { :i [<expr-background-color>:my $a; <!{
    $a++
}>| <expr-background-image>:my $b; <!{
    $b++
}>| <expr-background-repeat>:my $c; <!{
    $c++
}>| <expr-background-attachment>:my $d; <!{
    $d++
}>| <expr-background-position>:my $e; <!{
    $e++
}>]+ }
#| word-spacing: normal | <length>
rule decl:sym<word-spacing> { :i ("word-spacing") ":" <val(/<expr=.expr-word-spacing> /, &?ROUTINE.WHY)>}
rule expr-word-spacing { :i normal & <keyw>  || <length>  }
#| letter-spacing: normal | <length>
rule decl:sym<letter-spacing> { :i ("letter-spacing") ":" <val(/<expr=.expr-letter-spacing> /, &?ROUTINE.WHY)>}
rule expr-letter-spacing { :i normal & <keyw>  || <length>  }
#| text-decoration: none | [ underline || overline || line-through || blink ]
rule decl:sym<text-decoration> { :i ("text-decoration") ":" <val(/<expr=.expr-text-decoration> /, &?ROUTINE.WHY)>}
rule expr-text-decoration { :i none & <keyw>  || [[underline & <keyw> :my $a; <!{
    $a++
}>| overline & <keyw> :my $b; <!{
    $b++
}>| "line-through" & <keyw> :my $c; <!{
    $c++
}>| blink & <keyw> :my $d; <!{
    $d++
}>]+]  }
#| vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage>
rule decl:sym<vertical-align> { :i ("vertical-align") ":" <val(/<expr=.expr-vertical-align> /, &?ROUTINE.WHY)>}
rule expr-vertical-align { :i [baseline | sub | super | top | "text-top" | middle | bottom | "text-bottom" ]& <keyw>  || <percentage>  }
#| text-transform: capitalize | uppercase | lowercase | none
rule decl:sym<text-transform> { :i ("text-transform") ":" <val(/<expr=.expr-text-transform> /, &?ROUTINE.WHY)>}
rule expr-text-transform { :i [capitalize | uppercase | lowercase | none ]& <keyw>  }
#| text-align: <align> | justify
rule decl:sym<text-align> { :i ("text-align") ":" <val(/<expr=.expr-text-align> /, &?ROUTINE.WHY)>}
rule expr-text-align { :i <align> || justify & <keyw>   }
#| text-indent: <length> | <percentage>
rule decl:sym<text-indent> { :i ("text-indent") ":" <val(/<expr=.expr-text-indent> /, &?ROUTINE.WHY)>}
rule expr-text-indent { :i <length> || <percentage>  }
#| line-height: normal | <number> | <length> | <percentage>
rule decl:sym<line-height> { :i ("line-height") ":" <val(/<expr=.expr-line-height> /, &?ROUTINE.WHY)>}
rule expr-line-height { :i normal & <keyw>  || <number> || <length> || <percentage>  }
#| margin-top: <length> | <percentage> | auto
rule decl:sym<margin-top> { :i ("margin-top") ":" <val(/<expr=.expr-margin-top> /, &?ROUTINE.WHY)>}
rule expr-margin-top { :i <length> || <percentage> || auto & <keyw>   }
#| margin-right: <length> | <percentage> | auto
rule decl:sym<margin-right> { :i ("margin-right") ":" <val(/<expr=.expr-margin-right> /, &?ROUTINE.WHY)>}
rule expr-margin-right { :i <length> || <percentage> || auto & <keyw>   }
#| margin-bottom: <length> | <percentage> | auto
rule decl:sym<margin-bottom> { :i ("margin-bottom") ":" <val(/<expr=.expr-margin-bottom> /, &?ROUTINE.WHY)>}
rule expr-margin-bottom { :i <length> || <percentage> || auto & <keyw>   }
#| margin-left: <length> | <percentage> | auto
rule decl:sym<margin-left> { :i ("margin-left") ":" <val(/<expr=.expr-margin-left> /, &?ROUTINE.WHY)>}
rule expr-margin-left { :i <length> || <percentage> || auto & <keyw>   }
#| margin: [ <length> | <percentage> | auto ]{1,4}
rule decl:sym<margin> { :i (margin) ":" <val(/<expr=.expr-margin>** 1..4 /, &?ROUTINE.WHY)>}
rule expr-margin { :i [<length> || <percentage> || auto & <keyw>  ] }
#| padding-top: <length> | <percentage>
rule decl:sym<padding-top> { :i ("padding-top") ":" <val(/<expr=.expr-padding-top> /, &?ROUTINE.WHY)>}
rule expr-padding-top { :i <length> || <percentage>  }
#| padding-right: <length> | <percentage>
rule decl:sym<padding-right> { :i ("padding-right") ":" <val(/<expr=.expr-padding-right> /, &?ROUTINE.WHY)>}
rule expr-padding-right { :i <length> || <percentage>  }
#| padding-bottom: <length> | <percentage>
rule decl:sym<padding-bottom> { :i ("padding-bottom") ":" <val(/<expr=.expr-padding-bottom> /, &?ROUTINE.WHY)>}
rule expr-padding-bottom { :i <length> || <percentage>  }
#| padding-left: <length> | <percentage>
rule decl:sym<padding-left> { :i ("padding-left") ":" <val(/<expr=.expr-padding-left> /, &?ROUTINE.WHY)>}
rule expr-padding-left { :i <length> || <percentage>  }
#| padding: [ <length> | <percentage> ]{1,4}
rule decl:sym<padding> { :i (padding) ":" <val(/<expr=.expr-padding>** 1..4 /, &?ROUTINE.WHY)>}
rule expr-padding { :i [<length> || <percentage> ] }
#| border-top-width: thin | medium | thick | <length>
rule decl:sym<border-top-width> { :i ("border-top-width") ":" <val(/<expr=.expr-border-top-width> /, &?ROUTINE.WHY)>}
rule expr-border-top-width { :i [thin | medium | thick ]& <keyw>  || <length>  }
#| border-right-width: thin | medium | thick | <length>
rule decl:sym<border-right-width> { :i ("border-right-width") ":" <val(/<expr=.expr-border-right-width> /, &?ROUTINE.WHY)>}
rule expr-border-right-width { :i [thin | medium | thick ]& <keyw>  || <length>  }
#| border-bottom-width: thin | medium | thick | <length>
rule decl:sym<border-bottom-width> { :i ("border-bottom-width") ":" <val(/<expr=.expr-border-bottom-width> /, &?ROUTINE.WHY)>}
rule expr-border-bottom-width { :i [thin | medium | thick ]& <keyw>  || <length>  }
#| border-left-width: thin | medium | thick | <length>
rule decl:sym<border-left-width> { :i ("border-left-width") ":" <val(/<expr=.expr-border-left-width> /, &?ROUTINE.WHY)>}
rule expr-border-left-width { :i [thin | medium | thick ]& <keyw>  || <length>  }
#| border-width: [thin | medium | thick | <length>]{1,4}
rule decl:sym<border-width> { :i ("border-width") ":" <val(/<expr=.expr-border-width>** 1..4 /, &?ROUTINE.WHY)>}
rule expr-border-width { :i [[thin | medium | thick ]& <keyw>  || <length> ] }
#| border-color: <color>{1,4}
rule decl:sym<border-color> { :i ("border-color") ":" <val(/<expr=.expr-border-color>** 1..4 /, &?ROUTINE.WHY)>}
rule expr-border-color { :i <color> }
#| border-style: [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]{1,4}
rule decl:sym<border-style> { :i ("border-style") ":" <val(/<expr=.expr-border-style>** 1..4 /, &?ROUTINE.WHY)>}
rule expr-border-style { :i [[none | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-top: 'border-top-width' || 'border-top-style' || <color>
rule decl:sym<border-top> { :i ("border-top") ":" <val(/<expr=.expr-border-top> /, &?ROUTINE.WHY)>}
rule expr-border-top { :i [<expr-border-top-width>:my $a; <!{
    $a++
}>| <expr-border-top-style>:my $b; <!{
    $b++
}>| <color>:my $c; <!{
    $c++
}>]+ }
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
#| border-top-style: [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<border-top-style> { :i ("border-top-style") ":" <val(/<expr=.expr-border-top-style> /, &?ROUTINE.WHY)>}
rule expr-border-top-style { :i [[none | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-top-style: [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<border-right-style> { :i ("border-right-style") ":" <val(/<expr=.expr-border-right-style> /, &?ROUTINE.WHY)>}
rule expr-border-right-style { :i [[none | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-top-style: [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<border-bottom-style> { :i ("border-bottom-style") ":" <val(/<expr=.expr-border-bottom-style> /, &?ROUTINE.WHY)>}
rule expr-border-bottom-style { :i [[none | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-top-style: [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<border-left-style> { :i ("border-left-style") ":" <val(/<expr=.expr-border-left-style> /, &?ROUTINE.WHY)>}
rule expr-border-left-style { :i [[none | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-right: 'border-right-width' || 'border-right-style' || <color>
rule decl:sym<border-right> { :i ("border-right") ":" <val(/<expr=.expr-border-right> /, &?ROUTINE.WHY)>}
rule expr-border-right { :i [<expr-border-right-width>:my $a; <!{
    $a++
}>| <expr-border-right-style>:my $b; <!{
    $b++
}>| <color>:my $c; <!{
    $c++
}>]+ }
#| border-bottom: 'border-bottom-width' || 'border-bottom-style' || <color>
rule decl:sym<border-bottom> { :i ("border-bottom") ":" <val(/<expr=.expr-border-bottom> /, &?ROUTINE.WHY)>}
rule expr-border-bottom { :i [<expr-border-bottom-width>:my $a; <!{
    $a++
}>| <expr-border-bottom-style>:my $b; <!{
    $b++
}>| <color>:my $c; <!{
    $c++
}>]+ }
#| border-left: 'border-left-width' || 'border-left-style' || <color>
rule decl:sym<border-left> { :i ("border-left") ":" <val(/<expr=.expr-border-left> /, &?ROUTINE.WHY)>}
rule expr-border-left { :i [<expr-border-left-width>:my $a; <!{
    $a++
}>| <expr-border-left-style>:my $b; <!{
    $b++
}>| <color>:my $c; <!{
    $c++
}>]+ }
#| border: 'border-width' || 'border-style' || 'border-color'
rule decl:sym<border> { :i (border) ":" <val(/<expr=.expr-border> /, &?ROUTINE.WHY)>}
rule expr-border { :i [<expr-border-width>:my $a; <!{
    $a++
}>| <expr-border-style>:my $b; <!{
    $b++
}>| <expr-border-color>:my $c; <!{
    $c++
}>]+ }
#| float: left | right | none
rule decl:sym<float> { :i (float) ":" <val(/<expr=.expr-float> /, &?ROUTINE.WHY)>}
rule expr-float { :i [left | right | none ]& <keyw>  }
#| clear: none | left | right | both
rule decl:sym<clear> { :i (clear) ":" <val(/<expr=.expr-clear> /, &?ROUTINE.WHY)>}
rule expr-clear { :i [none | left | right | both ]& <keyw>  }
#| display: block | inline | list-item | none
rule decl:sym<display> { :i (display) ":" <val(/<expr=.expr-display> /, &?ROUTINE.WHY)>}
rule expr-display { :i [block | inline | "list-item" | none ]& <keyw>  }
#| white-space: normal | pre | nowrap
rule decl:sym<white-space> { :i ("white-space") ":" <val(/<expr=.expr-white-space> /, &?ROUTINE.WHY)>}
rule expr-white-space { :i [normal | pre | nowrap ]& <keyw>  }
#| list-style-type: disc | circle | square | decimal | lower-roman | upper-roman | lower-alpha | upper-alpha | none
rule decl:sym<list-style-type> { :i ("list-style-type") ":" <val(/<expr=.expr-list-style-type> /, &?ROUTINE.WHY)>}
rule expr-list-style-type { :i [disc | circle | square | decimal | "lower-roman" | "upper-roman" | "lower-alpha" | "upper-alpha" | none ]& <keyw>  }
#| list-style-image: <uri> | none
rule decl:sym<list-style-image> { :i ("list-style-image") ":" <val(/<expr=.expr-list-style-image> /, &?ROUTINE.WHY)>}
rule expr-list-style-image { :i <uri> || none & <keyw>   }
#| list-style-position: inside | outside
rule decl:sym<list-style-position> { :i ("list-style-position") ":" <val(/<expr=.expr-list-style-position> /, &?ROUTINE.WHY)>}
rule expr-list-style-position { :i [inside | outside ]& <keyw>  }
#| list-style: 'list-style-type' || 'list-style-image' || 'list-style-position'
rule decl:sym<list-style> { :i ("list-style") ":" <val(/<expr=.expr-list-style> /, &?ROUTINE.WHY)>}
rule expr-list-style { :i [<expr-list-style-type>:my $a; <!{
    $a++
}>| <expr-list-style-image>:my $b; <!{
    $b++
}>| <expr-list-style-position>:my $c; <!{
    $c++
}>]+ }
#| position: absolute | relative | static
rule decl:sym<position> { :i (position) ":" <val(/<expr=.expr-position> /, &?ROUTINE.WHY)>}
rule expr-position { :i [absolute | relative | static ]& <keyw>  }
#| left: <length> | <percentage> | auto
rule decl:sym<left> { :i (left) ":" <val(/<expr=.expr-left> /, &?ROUTINE.WHY)>}
rule expr-left { :i <length> || <percentage> || auto & <keyw>   }
#| top: <length> | <percentage> | auto
rule decl:sym<top> { :i (top) ":" <val(/<expr=.expr-top> /, &?ROUTINE.WHY)>}
rule expr-top { :i <length> || <percentage> || auto & <keyw>   }
#| width: <length> | <percentage> | auto
rule decl:sym<width> { :i (width) ":" <val(/<expr=.expr-width> /, &?ROUTINE.WHY)>}
rule expr-width { :i <length> || <percentage> || auto & <keyw>   }
#| height: <length> | <percentage> | auto
rule decl:sym<height> { :i (height) ":" <val(/<expr=.expr-height> /, &?ROUTINE.WHY)>}
rule expr-height { :i <length> || <percentage> || auto & <keyw>   }
#| overflow: none | clip | scroll
rule decl:sym<overflow> { :i (overflow) ":" <val(/<expr=.expr-overflow> /, &?ROUTINE.WHY)>}
rule expr-overflow { :i [none | clip | scroll ]& <keyw>  }
#| z-index: auto | <integer>
rule decl:sym<z-index> { :i ("z-index") ":" <val(/<expr=.expr-z-index> /, &?ROUTINE.WHY)>}
rule expr-z-index { :i auto & <keyw>  || <integer>  }
#| visibility: inherit | visible | hidden
rule decl:sym<visibility> { :i (visibility) ":" <val(/<expr=.expr-visibility> /, &?ROUTINE.WHY)>}
rule expr-visibility { :i [inherit | visible | hidden ]& <keyw>  }
#| page-break-before: auto | allways | left | right
rule decl:sym<page-break-before> { :i ("page-break-before") ":" <val(/<expr=.expr-page-break-before> /, &?ROUTINE.WHY)>}
rule expr-page-break-before { :i [auto | allways | left | right ]& <keyw>  }
#| page-break-after: auto | allways | left | right
rule decl:sym<page-break-after> { :i ("page-break-after") ":" <val(/<expr=.expr-page-break-after> /, &?ROUTINE.WHY)>}
rule expr-page-break-after { :i [auto | allways | left | right ]& <keyw>  }
#| size: <length>{1,2} | auto | portrait | landscape
rule decl:sym<size> { :i (size) ":" <val(/<expr=.expr-size> /, &?ROUTINE.WHY)>}
rule expr-size { :i <length> ** 1..2 || [auto | portrait | landscape ]& <keyw>   }