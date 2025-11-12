unit grammar CSS::Module::CSS1::Gen::Grammar;
#| font-family: [ <generic-family> | <family-name> ]#
rule decl:sym<font-family> { :i ("font-family") ":" <val(/<expr=.prop-val-font-family> /, &?ROUTINE.WHY)>}
rule prop-val-font-family { :i [<generic-family> || <family-name> ] +% <op(",")> }
#| <generic-family> = serif | sans-serif | cursive | fantasy | monospace
rule generic-family { :i [serif | "sans-serif" | cursive | fantasy | monospace ]& <keyw>  }
#| <family-name> = <identifiers> | <string>
rule family-name { :i <identifiers> || <string>  }
#| font-style: normal | italic | oblique
rule decl:sym<font-style> { :i ("font-style") ":" <val(/<expr=.prop-val-font-style> /, &?ROUTINE.WHY)>}
rule prop-val-font-style { :i [normal | italic | oblique ]& <keyw>  }
#| font-variant: normal | small-caps
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<expr=.prop-val-font-variant> /, &?ROUTINE.WHY)>}
rule prop-val-font-variant { :i [normal | "small-caps" ]& <keyw>  }
#| font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
rule decl:sym<font-weight> { :i ("font-weight") ":" <val(/<expr=.prop-val-font-weight> /, &?ROUTINE.WHY)>}
rule prop-val-font-weight { :i [normal | bold | bolder | lighter ]& <keyw>  || [100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ]& <number>  }
#| font-size: <absolute-size> | <relative-size> | <length> | <percentage>
rule decl:sym<font-size> { :i ("font-size") ":" <val(/<expr=.prop-val-font-size> /, &?ROUTINE.WHY)>}
rule prop-val-font-size { :i <absolute-size> || <relative-size> || <length> || <percentage>  }
#| <absolute-size> = xx-small | x-small | small | medium | large | x-large | xx-large
rule absolute-size { :i ["xx-small" | "x-small" | small | medium | large | "x-large" | "xx-large" ]& <keyw>  }
#| <relative-size> = larger | smaller
rule relative-size { :i [larger | smaller ]& <keyw>  }
#| font: [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family'
rule decl:sym<font> { :i (font) ":" <val(/<expr=.prop-val-font> /, &?ROUTINE.WHY)>}
rule prop-val-font { :i [[<prop-val-font-style> :my $*A; <!{
    $*A++
}>| <prop-val-font-variant> :my $*B; <!{
    $*B++
}>| <prop-val-font-weight> :my $*C; <!{
    $*C++
}>]+] ? <prop-val-font-size> [<op("/")> <prop-val-line-height> ] ? <prop-val-font-family>  }
#| color: <color>
rule decl:sym<color> { :i (color) ":" <val(/<expr=.prop-val-color> /, &?ROUTINE.WHY)>}
rule prop-val-color { :i <color> }
#| background-color: <color> | transparent
rule decl:sym<background-color> { :i ("background-color") ":" <val(/<expr=.prop-val-background-color> /, &?ROUTINE.WHY)>}
rule prop-val-background-color { :i <color> || transparent & <keyw>   }
#| background-image: <uri> | none
rule decl:sym<background-image> { :i ("background-image") ":" <val(/<expr=.prop-val-background-image> /, &?ROUTINE.WHY)>}
rule prop-val-background-image { :i <uri> || none & <keyw>   }
#| background-repeat: repeat | repeat-x | repeat-y | no-repeat
rule decl:sym<background-repeat> { :i ("background-repeat") ":" <val(/<expr=.prop-val-background-repeat> /, &?ROUTINE.WHY)>}
rule prop-val-background-repeat { :i [repeat | "repeat-x" | "repeat-y" | "no-repeat" ]& <keyw>  }
#| background-attachment: scroll | fixed
rule decl:sym<background-attachment> { :i ("background-attachment") ":" <val(/<expr=.prop-val-background-attachment> /, &?ROUTINE.WHY)>}
rule prop-val-background-attachment { :i [scroll | fixed ]& <keyw>  }
#| background-position: [<percentage> | <length> | <align> ] [ <percentage> | <length> | <valign> ]? | [ <valign> || <align> ]
rule decl:sym<background-position> { :i ("background-position") ":" <val(/<expr=.prop-val-background-position> /, &?ROUTINE.WHY)>}
rule prop-val-background-position { :i [<percentage> || <length> || <align> ] [<percentage> || <length> || <valign> ] ?  || [[<valign> :my $*A; <!{
    $*A++
}>| <align> :my $*B; <!{
    $*B++
}>]+]  }
#| <align> = left | center | right
rule align { :i [left | center | right ]& <keyw>  }
#| <valign> = top | center | bottom
rule valign { :i [top | center | bottom ]& <keyw>  }
#| background: 'background-color' || 'background-image' || 'background-repeat' || 'background-attachment' || 'background-position'
rule decl:sym<background> { :i (background) ":" <val(/<expr=.prop-val-background> /, &?ROUTINE.WHY)>}
rule prop-val-background { :i [<prop-val-background-color> :my $*A; <!{
    $*A++
}>| <prop-val-background-image> :my $*B; <!{
    $*B++
}>| <prop-val-background-repeat> :my $*C; <!{
    $*C++
}>| <prop-val-background-attachment> :my $*D; <!{
    $*D++
}>| <prop-val-background-position> :my $*E; <!{
    $*E++
}>]+ }
#| word-spacing: normal | <length>
rule decl:sym<word-spacing> { :i ("word-spacing") ":" <val(/<expr=.prop-val-word-spacing> /, &?ROUTINE.WHY)>}
rule prop-val-word-spacing { :i normal & <keyw>  || <length>  }
#| letter-spacing: normal | <length>
rule decl:sym<letter-spacing> { :i ("letter-spacing") ":" <val(/<expr=.prop-val-letter-spacing> /, &?ROUTINE.WHY)>}
rule prop-val-letter-spacing { :i normal & <keyw>  || <length>  }
#| text-decoration: none | [ underline || overline || line-through || blink ]
rule decl:sym<text-decoration> { :i ("text-decoration") ":" <val(/<expr=.prop-val-text-decoration> /, &?ROUTINE.WHY)>}
rule prop-val-text-decoration { :i none & <keyw>  || [[underline & <keyw>  :my $*A; <!{
    $*A++
}>| overline & <keyw>  :my $*B; <!{
    $*B++
}>| "line-through" & <keyw>  :my $*C; <!{
    $*C++
}>| blink & <keyw>  :my $*D; <!{
    $*D++
}>]+]  }
#| vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage>
rule decl:sym<vertical-align> { :i ("vertical-align") ":" <val(/<expr=.prop-val-vertical-align> /, &?ROUTINE.WHY)>}
rule prop-val-vertical-align { :i [baseline | sub | super | top | "text-top" | middle | bottom | "text-bottom" ]& <keyw>  || <percentage>  }
#| text-transform: capitalize | uppercase | lowercase | none
rule decl:sym<text-transform> { :i ("text-transform") ":" <val(/<expr=.prop-val-text-transform> /, &?ROUTINE.WHY)>}
rule prop-val-text-transform { :i [capitalize | uppercase | lowercase | none ]& <keyw>  }
#| text-align: <align> | justify
rule decl:sym<text-align> { :i ("text-align") ":" <val(/<expr=.prop-val-text-align> /, &?ROUTINE.WHY)>}
rule prop-val-text-align { :i <align> || justify & <keyw>   }
#| text-indent: <length> | <percentage>
rule decl:sym<text-indent> { :i ("text-indent") ":" <val(/<expr=.prop-val-text-indent> /, &?ROUTINE.WHY)>}
rule prop-val-text-indent { :i <length> || <percentage>  }
#| line-height: normal | <number> | <length> | <percentage>
rule decl:sym<line-height> { :i ("line-height") ":" <val(/<expr=.prop-val-line-height> /, &?ROUTINE.WHY)>}
rule prop-val-line-height { :i normal & <keyw>  || <number> || <length> || <percentage>  }
#| margin-top: <length> | <percentage> | auto
rule decl:sym<margin-top> { :i ("margin-top") ":" <val(/<expr=.prop-val-margin-top> /, &?ROUTINE.WHY)>}
rule prop-val-margin-top { :i <length> || <percentage> || auto & <keyw>   }
#| margin-right: <length> | <percentage> | auto
rule decl:sym<margin-right> { :i ("margin-right") ":" <val(/<expr=.prop-val-margin-right> /, &?ROUTINE.WHY)>}
rule prop-val-margin-right { :i <length> || <percentage> || auto & <keyw>   }
#| margin-bottom: <length> | <percentage> | auto
rule decl:sym<margin-bottom> { :i ("margin-bottom") ":" <val(/<expr=.prop-val-margin-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-margin-bottom { :i <length> || <percentage> || auto & <keyw>   }
#| margin-left: <length> | <percentage> | auto
rule decl:sym<margin-left> { :i ("margin-left") ":" <val(/<expr=.prop-val-margin-left> /, &?ROUTINE.WHY)>}
rule prop-val-margin-left { :i <length> || <percentage> || auto & <keyw>   }
#| margin: [ <length> | <percentage> | auto ]{1,4}
rule decl:sym<margin> { :i (margin) ":" <val(/<expr=.prop-val-margin>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-margin { :i [<length> || <percentage> || auto & <keyw>  ] }
#| padding-top: <length> | <percentage>
rule decl:sym<padding-top> { :i ("padding-top") ":" <val(/<expr=.prop-val-padding-top> /, &?ROUTINE.WHY)>}
rule prop-val-padding-top { :i <length> || <percentage>  }
#| padding-right: <length> | <percentage>
rule decl:sym<padding-right> { :i ("padding-right") ":" <val(/<expr=.prop-val-padding-right> /, &?ROUTINE.WHY)>}
rule prop-val-padding-right { :i <length> || <percentage>  }
#| padding-bottom: <length> | <percentage>
rule decl:sym<padding-bottom> { :i ("padding-bottom") ":" <val(/<expr=.prop-val-padding-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-padding-bottom { :i <length> || <percentage>  }
#| padding-left: <length> | <percentage>
rule decl:sym<padding-left> { :i ("padding-left") ":" <val(/<expr=.prop-val-padding-left> /, &?ROUTINE.WHY)>}
rule prop-val-padding-left { :i <length> || <percentage>  }
#| padding: [ <length> | <percentage> ]{1,4}
rule decl:sym<padding> { :i (padding) ":" <val(/<expr=.prop-val-padding>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-padding { :i [<length> || <percentage> ] }
#| border-top-width: thin | medium | thick | <length>
rule decl:sym<border-top-width> { :i ("border-top-width") ":" <val(/<expr=.prop-val-border-top-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-width { :i [thin | medium | thick ]& <keyw>  || <length>  }
#| border-right-width: thin | medium | thick | <length>
rule decl:sym<border-right-width> { :i ("border-right-width") ":" <val(/<expr=.prop-val-border-right-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-right-width { :i [thin | medium | thick ]& <keyw>  || <length>  }
#| border-bottom-width: thin | medium | thick | <length>
rule decl:sym<border-bottom-width> { :i ("border-bottom-width") ":" <val(/<expr=.prop-val-border-bottom-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-width { :i [thin | medium | thick ]& <keyw>  || <length>  }
#| border-left-width: thin | medium | thick | <length>
rule decl:sym<border-left-width> { :i ("border-left-width") ":" <val(/<expr=.prop-val-border-left-width> /, &?ROUTINE.WHY)>}
rule prop-val-border-left-width { :i [thin | medium | thick ]& <keyw>  || <length>  }
#| border-width: [thin | medium | thick | <length>]{1,4}
rule decl:sym<border-width> { :i ("border-width") ":" <val(/<expr=.prop-val-border-width>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-width { :i [[thin | medium | thick ]& <keyw>  || <length> ] }
#| border-color: <color>{1,4}
rule decl:sym<border-color> { :i ("border-color") ":" <val(/<expr=.prop-val-border-color>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-color { :i <color> }
#| border-style: [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]{1,4}
rule decl:sym<border-style> { :i ("border-style") ":" <val(/<expr=.prop-val-border-style>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-border-style { :i [[none | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-top: 'border-top-width' || 'border-top-style' || <color>
rule decl:sym<border-top> { :i ("border-top") ":" <val(/<expr=.prop-val-border-top> /, &?ROUTINE.WHY)>}
rule prop-val-border-top { :i [<prop-val-border-top-width> :my $*A; <!{
    $*A++
}>| <prop-val-border-top-style> :my $*B; <!{
    $*B++
}>| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border-top-color: <color> | transparent
rule decl:sym<border-top-color> { :i ("border-top-color") ":" <val(/<expr=.prop-val-border-top-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-color { :i <color> || transparent & <keyw>   }
#| border-top-color: <color> | transparent
rule decl:sym<border-right-color> { :i ("border-right-color") ":" <val(/<expr=.prop-val-border-right-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-right-color { :i <color> || transparent & <keyw>   }
#| border-top-color: <color> | transparent
rule decl:sym<border-bottom-color> { :i ("border-bottom-color") ":" <val(/<expr=.prop-val-border-bottom-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-color { :i <color> || transparent & <keyw>   }
#| border-top-color: <color> | transparent
rule decl:sym<border-left-color> { :i ("border-left-color") ":" <val(/<expr=.prop-val-border-left-color> /, &?ROUTINE.WHY)>}
rule prop-val-border-left-color { :i <color> || transparent & <keyw>   }
#| border-top-style: [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<border-top-style> { :i ("border-top-style") ":" <val(/<expr=.prop-val-border-top-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-top-style { :i [[none | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-top-style: [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<border-right-style> { :i ("border-right-style") ":" <val(/<expr=.prop-val-border-right-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-right-style { :i [[none | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-top-style: [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<border-bottom-style> { :i ("border-bottom-style") ":" <val(/<expr=.prop-val-border-bottom-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom-style { :i [[none | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-top-style: [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]
rule decl:sym<border-left-style> { :i ("border-left-style") ":" <val(/<expr=.prop-val-border-left-style> /, &?ROUTINE.WHY)>}
rule prop-val-border-left-style { :i [[none | dotted | dashed | solid | double | groove | ridge | inset | outset ]& <keyw> ] }
#| border-right: 'border-right-width' || 'border-right-style' || <color>
rule decl:sym<border-right> { :i ("border-right") ":" <val(/<expr=.prop-val-border-right> /, &?ROUTINE.WHY)>}
rule prop-val-border-right { :i [<prop-val-border-right-width> :my $*A; <!{
    $*A++
}>| <prop-val-border-right-style> :my $*B; <!{
    $*B++
}>| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border-bottom: 'border-bottom-width' || 'border-bottom-style' || <color>
rule decl:sym<border-bottom> { :i ("border-bottom") ":" <val(/<expr=.prop-val-border-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-border-bottom { :i [<prop-val-border-bottom-width> :my $*A; <!{
    $*A++
}>| <prop-val-border-bottom-style> :my $*B; <!{
    $*B++
}>| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border-left: 'border-left-width' || 'border-left-style' || <color>
rule decl:sym<border-left> { :i ("border-left") ":" <val(/<expr=.prop-val-border-left> /, &?ROUTINE.WHY)>}
rule prop-val-border-left { :i [<prop-val-border-left-width> :my $*A; <!{
    $*A++
}>| <prop-val-border-left-style> :my $*B; <!{
    $*B++
}>| <color> :my $*C; <!{
    $*C++
}>]+ }
#| border: 'border-width' || 'border-style' || 'border-color'
rule decl:sym<border> { :i (border) ":" <val(/<expr=.prop-val-border> /, &?ROUTINE.WHY)>}
rule prop-val-border { :i [<prop-val-border-width> :my $*A; <!{
    $*A++
}>| <prop-val-border-style> :my $*B; <!{
    $*B++
}>| <prop-val-border-color> :my $*C; <!{
    $*C++
}>]+ }
#| float: left | right | none
rule decl:sym<float> { :i (float) ":" <val(/<expr=.prop-val-float> /, &?ROUTINE.WHY)>}
rule prop-val-float { :i [left | right | none ]& <keyw>  }
#| clear: none | left | right | both
rule decl:sym<clear> { :i (clear) ":" <val(/<expr=.prop-val-clear> /, &?ROUTINE.WHY)>}
rule prop-val-clear { :i [none | left | right | both ]& <keyw>  }
#| display: block | inline | list-item | none
rule decl:sym<display> { :i (display) ":" <val(/<expr=.prop-val-display> /, &?ROUTINE.WHY)>}
rule prop-val-display { :i [block | inline | "list-item" | none ]& <keyw>  }
#| white-space: normal | pre | nowrap
rule decl:sym<white-space> { :i ("white-space") ":" <val(/<expr=.prop-val-white-space> /, &?ROUTINE.WHY)>}
rule prop-val-white-space { :i [normal | pre | nowrap ]& <keyw>  }
#| list-style-type: disc | circle | square | decimal | lower-roman | upper-roman | lower-alpha | upper-alpha | none
rule decl:sym<list-style-type> { :i ("list-style-type") ":" <val(/<expr=.prop-val-list-style-type> /, &?ROUTINE.WHY)>}
rule prop-val-list-style-type { :i [disc | circle | square | decimal | "lower-roman" | "upper-roman" | "lower-alpha" | "upper-alpha" | none ]& <keyw>  }
#| list-style-image: <uri> | none
rule decl:sym<list-style-image> { :i ("list-style-image") ":" <val(/<expr=.prop-val-list-style-image> /, &?ROUTINE.WHY)>}
rule prop-val-list-style-image { :i <uri> || none & <keyw>   }
#| list-style-position: inside | outside
rule decl:sym<list-style-position> { :i ("list-style-position") ":" <val(/<expr=.prop-val-list-style-position> /, &?ROUTINE.WHY)>}
rule prop-val-list-style-position { :i [inside | outside ]& <keyw>  }
#| list-style: 'list-style-type' || 'list-style-image' || 'list-style-position'
rule decl:sym<list-style> { :i ("list-style") ":" <val(/<expr=.prop-val-list-style> /, &?ROUTINE.WHY)>}
rule prop-val-list-style { :i [<prop-val-list-style-type> :my $*A; <!{
    $*A++
}>| <prop-val-list-style-image> :my $*B; <!{
    $*B++
}>| <prop-val-list-style-position> :my $*C; <!{
    $*C++
}>]+ }
#| position: absolute | relative | static
rule decl:sym<position> { :i (position) ":" <val(/<expr=.prop-val-position> /, &?ROUTINE.WHY)>}
rule prop-val-position { :i [absolute | relative | static ]& <keyw>  }
#| left: <length> | <percentage> | auto
rule decl:sym<left> { :i (left) ":" <val(/<expr=.prop-val-left> /, &?ROUTINE.WHY)>}
rule prop-val-left { :i <length> || <percentage> || auto & <keyw>   }
#| top: <length> | <percentage> | auto
rule decl:sym<top> { :i (top) ":" <val(/<expr=.prop-val-top> /, &?ROUTINE.WHY)>}
rule prop-val-top { :i <length> || <percentage> || auto & <keyw>   }
#| width: <length> | <percentage> | auto
rule decl:sym<width> { :i (width) ":" <val(/<expr=.prop-val-width> /, &?ROUTINE.WHY)>}
rule prop-val-width { :i <length> || <percentage> || auto & <keyw>   }
#| height: <length> | <percentage> | auto
rule decl:sym<height> { :i (height) ":" <val(/<expr=.prop-val-height> /, &?ROUTINE.WHY)>}
rule prop-val-height { :i <length> || <percentage> || auto & <keyw>   }
#| overflow: none | clip | scroll
rule decl:sym<overflow> { :i (overflow) ":" <val(/<expr=.prop-val-overflow> /, &?ROUTINE.WHY)>}
rule prop-val-overflow { :i [none | clip | scroll ]& <keyw>  }
#| z-index: auto | <integer>
rule decl:sym<z-index> { :i ("z-index") ":" <val(/<expr=.prop-val-z-index> /, &?ROUTINE.WHY)>}
rule prop-val-z-index { :i auto & <keyw>  || <integer>  }
#| visibility: inherit | visible | hidden
rule decl:sym<visibility> { :i (visibility) ":" <val(/<expr=.prop-val-visibility> /, &?ROUTINE.WHY)>}
rule prop-val-visibility { :i [inherit | visible | hidden ]& <keyw>  }
#| page-break-before: auto | allways | left | right
rule decl:sym<page-break-before> { :i ("page-break-before") ":" <val(/<expr=.prop-val-page-break-before> /, &?ROUTINE.WHY)>}
rule prop-val-page-break-before { :i [auto | allways | left | right ]& <keyw>  }
#| page-break-after: auto | allways | left | right
rule decl:sym<page-break-after> { :i ("page-break-after") ":" <val(/<expr=.prop-val-page-break-after> /, &?ROUTINE.WHY)>}
rule prop-val-page-break-after { :i [auto | allways | left | right ]& <keyw>  }
#| size: <length>{1,2} | auto | portrait | landscape
rule decl:sym<size> { :i (size) ":" <val(/<expr=.prop-val-size> /, &?ROUTINE.WHY)>}
rule prop-val-size { :i <length> ** 1..2 || [auto | portrait | landscape ]& <keyw>   }