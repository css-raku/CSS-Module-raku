use v6;

# specification: http://www.w3.org/TR/2011/REC-CSS2-20110607/propidx.html

use CSS::Grammar::CSS21;

grammar CSS::Language::CSS21:ver<20110607.000> 
    is CSS::Grammar::CSS21 {

    # For handling undimensioned quantities
    token length:sym<num>    {<number>}
    token angle:sym<num>     {<number>}
    token frequency:sym<num> {<number>}

    # allow color names and define our vocabulary
    rule color:sym<named> {:i [ aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | orange | purple | red | silver | teal | white | yellow ] & <ident> }
    rule color:sym<system> {:i [ ActiveBorder | ActiveCaption | AppWorkspace | Background | ButtonFace | ButtonHighlight | ButtonShadow | ButtonText | CaptionText | GrayText | Highlight | HighlightText | InactiveBorder | InactiveCaption | InactiveCaptionText | InfoBackground | InfoText | Menu | MenuText | Scrollbar | ThreeDDarkShadow | ThreeDFace | ThreeDHighlight | ThreeDLightShadow | ThreeDShadow | Window | WindowFrame | WindowText ] & <system=.ident> }
 
    # nomenclature
    token integer    {[\+|\-]?\d+ <!before ['%'|\w|'.']>}
    token number     {<num> <!before ['%'|\w]>}
    token uri        {<url>}
    token identifier {<ident-cs>}  # identifiers (case sensitive)

    # --- Functions --- #

    rule attr     {:i'attr(' [ <attribute_name=.identifier> <type-or-unit=.ident>? [ ',' <fallback=.ident> ]? || <any-args>] ')'}
    rule counter  {:i'counter(' [ <identifier> [ ',' <list-style-type=.ident> ]* || <any-args> ] ')'}
    rule counters {:i'counters(' [ <identifier> [ ',' <string> ]? || <any-args> ] ')' }
    rule shape-arg {:i <length> | auto & <ident> }
    rule shape    {:i'rect(' [ <top=.shape-arg> ',' <right=.shape-arg> ',' <bottom=.shape-arg> ',' <left=.shape-arg> || <any-args> ] ')' }

    # --- Properties --- #

    # - azimuth: <angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards | inherit
     rule decl:sym<azimuth> {:i (azimuth) ':' [
                                  <angle>
                                  | leftwards & <leftwards=.ident>| rightwards & <rightwards=.ident>
                                  | [
                                       [ [ [ left[\-side]? | far\-[left|right] | center[\-[left|right]]? | right[\-side]? ] & <ident>  ]
                                        | behind & <behind=.ident>  ]**1..2
                                  ]
                                  | <inherit> || <any-args> ] }

    # - background-attachment: scroll | fixed | inherit
    token background-attachment {:i [ scroll | fixed ] & <ident> }
    rule decl:sym<background-attachment> {:i (background\-attachment) ':' [
                                               <background-attachment>
                                               | <inherit> || <any-args> ]}

    # - background-color: <color> | transparent | inherit
    token background-color {:i <color> | transparent & <ident> }
    rule decl:sym<background-color> {:i (background\-color) ':' [
                                          <background-color>
                                          | <inherit> || <any-args> ]}

    # - background-image: <url> | none | inherit
    token background-image {:i <url> | none & <ident> }
    rule decl:sym<background-image> {:i (background\-image) ':' [
                                          <background-image>
                                          | <inherit> || <any-args> ]}

    # - background-position: [ [ <percentage> | <length> | left | center | right ] [ <percentage> | <length> | top | center | bottom ]? ] | [ [ left | center | right ] || [ top | center | bottom ] ] | inherit
    # refactored as [ <percentage> | <length> | left | center | right ] || [ <percentage> | <length> | top | center | bottom ] | inherit
    rule background-position {:i  [ 
                                   [ <percentage> | <length> | [ left | center | right ] & <ident>  ] 
                                   | [ <percentage> | <length> | [ top | center | bottom ] & <ident>  ]
                                  ]**1..2 }
    rule decl:sym<background-position> {:i (background\-position) ':' [
                                             <background-position>
                                             | <inherit> || <any-args> ]}

    # - background-repeat: repeat | repeat-x | repeat-y | no-repeat
    token background-repeat {:i [ repeat[\-[x|y]]? | no\-repeat ] & <ident> }
    rule decl:sym<background-repeat> {:i (background\-repeat) ':' [
                                          <background-repeat>
                                          | <inherit> || <any-args> ]}


    # - background: <background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position> | inherit
    rule decl:sym<background> {:i (background) ':' [
                                    [ <background-color> | <background-image> | <background-repeat> | <background-attachment> | <background-position> ]**1..5
                                    | <inherit> || <any-args> ]}

    # - border-collapse: collapse | separate | inherit
    rule decl:sym<border-collapse> {:i (border\-collapse) ':' [ [ collapse | separate ] & <ident> | <inherit> || <any-args> ] }

    # - border-color: [ <color> | transparent ]{1,4} | inherit
    rule border-color { <color> | transparent & <ident>  }
    rule decl:sym<border-color> {:i (border\-color) ':' [
                                      [ <border-color> ] ** 1..4
                                      | <inherit> || <any-args> ]}

    # - border-spacing: <length> <length>? | inherit
    rule decl:sym<border-spacing> {:i (border\-spacing) ':' [ <length> <length>? | <inherit> || <any-args> ] }

    # - border-style: none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset
    token border-style {:i [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ] & <ident> }
    rule decl:sym<border-style> {:i (border\-style) ':' [
                                      <border-style> ** 1..4
                                      | <inherit> || <any-args> ]}

    # - border-top|border-right|border-bottom|border-left: [ <border-width> || <border-style> || 'border-top-color' ] | inherit
    rule decl:sym<border-*> {:i (border\-[top|right|bottom|left]) ':' [ [ [ <border-width> | <border-style> | <border-color> ]**1..3 ] | <inherit> || <any-args> ] }

   # - border-top-color|border-right-color|border-bottom-color|border-left-color: <color> | transparent | inherit
    rule decl:sym<border-*-color> {:i (border\-[top|right|bottom|left]\-color) ':' [ <border-color> | <inherit> || <any-args> ] }

    # - border-top-style|border-right-style|border-bottom-style|border-left-style: <border-style> | inherit
    rule decl:sym<border-*-style> {:i (border\-[top|right|bottom|left]\-style) ':' [ <border-style> | <inherit> || <any-args> ] }

    # - border-top-width|border-right-width|border-bottom-width|border-left-width: <border-width> | inherit
    rule border-width {:i [ thin | medium | thick ] & <ident> | <length> }
    rule decl:sym<border-*-width> {:i (border\-[top|rightbottom|left]\-width) ':' [ <border-width> | <inherit> || <any-args> ] }

    # - border-width: <border-width>{1,4} | inherit
    rule decl:sym<border-width> {:i (border\-width) ':' [ <border-width>**1..4 | <inherit> || <any-args> ] }

    # - border: [ <border-width> || <border-style> || 'border-top-color' ] | inherit
    # - refactored: border: [ <border-width> || <border-style> || <border-color> ] | inherit
    rule decl:sym<border> {:i (border) ':' [ [ [ <border-width> | <border-style> | <border-color> ]**1..3 ] | <inherit> || <any-args> ] }

    # - bottom: <length> | <percentage> | auto | inherit
    rule decl:sym<bottom> {:i (bottom) ':' [ <length> | <percentage> | auto & <ident> | <inherit> || <any-args> ] }

    # - caption-side: top | bottom | inherit
    rule decl:sym<caption-side> {:i (caption\-side) ':' [ [ top | bottom ] & <ident> | <inherit> || <any-args> ] }

    # - clear: none | left | right | both | inherit
    rule decl:sym<clear> {:i (clear) ':' [ [ none | left | right | both ] & <ident> | <inherit> || <any-args> ] }

    # - clip: <shape> | auto
    # interim <shape> token. needs to be properly prototyped, etc
    rule decl:sym<clip> {:i (clip) ':' [
                              <shape>
                              | auto  & <ident>
                              | <inherit> || <any-args> ]}


    # - color: <color> | inherit
    rule decl:sym<color> {:i (color) ':' [ <color> | <inherit> || <any-args> ] }

    # - content: normal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+ | inherit
    rule decl:sym<content> {:i (content) ':' [ [ normal | none ] & <ident> | [ [ <string> | <uri> | <counter> | <attr> | [ open\-quote | close\-quote | no\-open\-quote | no\-close\-quote ] & <ident>  ] ]+ | <inherit> || <any-args> ] }

    # - counter-increment: [ <identifier> <integer>? ]+ | none | inherit
    rule decl:sym<counter-increment> {:i (counter\-increment) ':' [ [ <identifier> <integer>? ]+ | none & <ident> | <inherit> || <any-args> ] }

    # - counter-reset: [ <identifier> <integer>? ]+ | none | inherit
    rule decl:sym<counter-reset> {:i (counter\-reset) ':' [ [ <identifier> <integer>? ]+ | none & <ident> | <inherit> || <any-args> ] }

    # - cue-after: <uri> | none | inherit
    token cue {:i <uri> | none & <ident> }
    rule decl:sym<cue-after> {:i (cue\-after) ':'  [ <cue-after=.cue> | inherit || <any-args> ] }

    # - cue-before: <uri> | none | inherit
    rule decl:sym<cue-before> {:i (cue\-before) ':'  [ <cue-before=.cue> | inherit || <any-args> ] }

    # - cue: [ 'cue-before' || 'cue-after' ] | inherit
    rule decl:sym<cue> {:i (cue) ':' [ <cue-before=.cue> <cue-after=.cue>? | <inherit> || <any-args> ] }

    # - cursor: [ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ] | inherit
    rule decl:sym<cursor> {:i (cursor) ':' [ [ [ <uri> ',' ]* [ [ auto | crosshair | default | pointer | move | e\-resize | ne\-resize | nw\-resize | n\-resize | se\-resize | sw\-resize | 's-resize' | w\-resize | text | wait | help | progress ] & <ident>  ] ] | <inherit> || <any-args> ] }

    # - direction: ltr | rtl | inherit
    rule decl:sym<direction> {:i (direction) ':' [ [ ltr | rtl ] & <ident> | <inherit> || <any-args> ] }

    # - display: inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none | inherit
    rule decl:sym<display> {:i (display) ':' [ [ block | inline[\-[block|table]]? | list\-item | table[\-[cell|caption|[header|footer]\-group|[row|column][\-group]?]]? | none ] & <ident> | <inherit> || <any-args> ] }

    rule decl:sym<elevation> {:i (elevation) ':' [
                                   <angle>
                                   | [below | level | above ] & <ident>
                                   | [ higher | lower ] & <tilt=.ident>
                                   | <inherit> || <any-args> ]}

    # - empty-cells: show | hide | inherit
    rule decl:sym<empty-cells> {:i (empty\-cells) ':' [ [ show | hide ] & <ident> | <inherit> || <any-args> ] }

    # - float: left | right | none | inherit
    rule decl:sym<float> {:i (float) ':' [ [ left | right | none ] & <ident> | <inherit> || <any-args> ] }

    # - font-family: [[ <family-name> | <generic-family> ] [, <family-name> | <generic-family> ]* ] | inherit
    rule font-family {:i [ serif | sans\-serif | cursive | fantasy | monospace ] & <generic-family=.ident-cs> || [ <family-name=.ident-cs> ]+ | <family-name=.string> }
    rule decl:sym<font-family> {:i (font\-family) ':' [ <font-family> [ ',' <font-family> || <any> ]*
                                                        | <inherit> || <any-args> ] }

    # - font-size: <absolute-size> | <relative-size> | <length> | <percentage> | inherit
    token absolute-size {:i [ [[xx|x]\-]?small | medium | [[xx|x]\-]?large ] & <ident> }
    token relative-size {:i [ larger | smaller ] & <ident> }
    token font-size {:i <absolute-size> | <relative-size> | <length> | <percentage> }
    rule decl:sym<font-size> {:i (font\-size) ':' [ <font-size>
                                                    | <inherit> || <any-args> ] }

    # - font-style: normal | italic | oblique | inherit
    token font-style {:i [ normal | italic | oblique ] & <ident> }
    rule decl:sym<font-style> {:i (font\-style) ':' [ [ normal | italic | oblique ] & <ident> | <inherit> || <any-args> ] }

    # - font-variant: normal | small-caps | inherit
    token font-variant {:i [ normal | small\-caps ] & <ident>}
    rule decl:sym<font-variant> {:i (font\-variant) ':' [ [ normal | small\-caps ] & <ident> | <inherit> || <any-args> ] }

    # - font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 | inherit
    token font-weight {:i [ normal | bold | bolder | lighter ] & <ident>
                           | [ 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ] & <number> }
    rule decl:sym<font-weight> {:i (font\-weight) ':' [ <font-weight>
                                                        | <inherit> || <any-args> ] }

    # - font: [ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family' ] | caption | icon | menu | message-box | small-caption | status-bar | inherit
    rule decl:sym<font> {:i (font) ':' [
                              [  <font-style> | <font-variant> | <font-weight> ]* <font-size> [ '/' <line-height> ]? <font-family> [ ',' <font-family> ]*
                              | [ caption | icon | menu | message\-box | small\-caption | status\-bar ] & <ident>
                              | <inherit> || <any-args> ] }

    # - width: <length> | <percentage> | auto | inherit
    # - height: <length> | <percentage> | auto | inherit
    # - left: <length> | <percentage> | auto | inherit
    # - right: <length> | <percentage> | auto | inherit
    rule decl:sym<width|height|left|top> {:i (width|height|left|top) ':' [ <length> | <percentage> | auto & <ident> | <inherit> || <any-args> ] }

    # - letter-spacing: normal | <length> | inherit
    # - word-spacing: normal | <length> | inherit
    rule decl:sym<*-spacing> {:i ([letter|word]\-spacing) ':' [ normal & <ident> | <length> | <inherit> || <any-args> ] }

    # - line-height: normal | <number> | <length> | <percentage> | inherit
    token line-height {:i normal & <ident> | <number> | <length> | <percentage> }
    rule decl:sym<line-height> {:i (line\-height) ':' [ <line-height>
                                                        | <inherit> || <any-args> ]}

    # - list-style-image: <uri> | none | inherit
    token list-style-image {:i  <uri> | none & <ident> }
    rule decl:sym<list-style-image> {:i (list\-style\-image) ':' [
                                          <list-style-image>
                                          | <inherit> || <any-args> ]}

    # - list-style-position: inside | outside | inherit
    token list-style-position {:i  [ inside | outside ] & <ident> }
    rule decl:sym<list-style-position> {:i (list\-style\-position) ':' [
                                             <list-style-position>
                                             | <inherit> || <any-args> ]}

    # - list-style-type: disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none | inherit
    token list-style-type {:i [ disc | circle | square | decimal | decimal\-leading\-zero | lower\-roman | upper\-roman | lower\-greek | lower\-latin | upper\-latin | armenian | georgian | lower\-alpha | upper\-alpha | none ] & <ident> }
    rule decl:sym<list-style-type> {:i (list\-style\-type) ':' [ <list-style-type> | <inherit> || <any-args> ] }

    # - list-style: [ 'list-style-type' || 'list-style-position' || 'list-style-image' ] | inherit
    rule decl:sym<list-style> {:i (list\-style) ':' [ [ [ <list-style-type> | <list-style-position> | <list-style-image> ]**1..3 ] | <inherit> || <any-args> ] }

    # - margin-right|margin-left: <margin-width> | inherit
    # - margin-top|margin-bottom: <margin-width> | inherit
    rule margin-width {:i <length> | <percentage> | auto & <ident> }
    rule decl:sym<margin-*> {:i (margin\-[right|left|bottom|top]) ':' [ <margin-width> | <inherit> || <any-args> ] }

    # - margin: <margin-width>{1,4} | inherit
    rule decl:sym<margin> {:i (margin) ':' [ <margin-width>**1..4 | <inherit> || <any-args> ] }

    # - max-height: <length> | <percentage> | none | inherit
    # - max-width: <length> | <percentage> | none | inherit
    rule decl:sym<max-[width|height]> {:i (max\-[width|height]) ':' [ <length> | <percentage> | none & <ident> | <inherit> || <any-args> ] }

    # - min-height: <length> | <percentage> | inherit
    # - min-width: <length> | <percentage> | inherit
    rule decl:sym<min-[width|height]> {:i (min\-[width|height]) ':' [ <length> | <percentage> | <inherit> || <any-args> ] }

    # - orphans: <integer> | inherit
    rule decl:sym<orphans> {:i (orphans) ':' [ <integer> | <inherit> || <any-args> ] }

     # - outline-color: <color> | invert | inherit
    token outline-color {:i <color> | invert & <ident> }
    rule decl:sym<outline-color> {:i (outline\-color) ':'  [ <outline-color> | inherit || <any-args> ] }

    # - outline-style: <border-style> | inherit
    rule decl:sym<outline-style> {:i (outline\-style) ':'  [ <outline-style=.border-style> | inherit || <any-args> ] }

    # - outline-width: <border-width> | inherit
    rule decl:sym<outline-width> {:i (outline\-width) ':'  [ <outline-width=.border-width> | inherit || <any-args> ] }

   # - outline: [ 'outline-color' || 'outline-style' || 'outline-width' ] | inherit
    rule decl:sym<outline> {:i (outline) ':' [ [ [ <outline-color> | <outline-style=.border-style> | <outline-width=.border-width> ]**1..3 ] | <inherit> || <any-args> ] }

    # - overflow: visible | hidden | scroll | auto | inherit
    rule decl:sym<overflow> {:i (overflow) ':' [ [ visible | hidden | scroll | auto ] & <ident> | <inherit> || <any-args> ] }

    # - padding-top|padding-right|padding-bottom|padding-left: <padding-width> | inherit
    rule decl:sym<padding-*> {:i (padding\-[top|right|bottom|left]) ':' [ <padding-width> | <inherit> || <any-args> ] }

    # - padding: <padding-width>{1,4} | inherit
    token padding-width {:i <length> | <percentage> }
    rule decl:sym<padding> {:i (padding) ':' [ <padding-width>**1..4 | <inherit> || <any-args> ] }

    # - page-break-after: auto | always | avoid | left | right | inherit
    # - page-break-before: auto | always | avoid | left | right | inherit
    rule decl:sym<page-break-[before|after]> {:i (page\-break\-[before|after]) ':' [ [ auto | always | avoid | left | right ] & <ident> | <inherit> || <any-args> ] }

    # - page-break-inside: avoid | auto | inherit
    rule decl:sym<page-break-inside> {:i (page\-break\-inside) ':' [ [ avoid | auto ] & <ident> | <inherit> || <any-args> ] }

    # - pause-after: <time> | <percentage> | inherit
    # - pause-before: <time> | <percentage> | inherit
    token pause {:i <time> | <percentage> }
    rule decl:sym<pause-[before|after]> {:i (pause\-[before|after]) ':' [ <pause> | <inherit> || <any-args> ] }

    # - pause: [ [<time> | <percentage>]{1,2} ] | inherit
    rule decl:sym<pause> {:i (pause) ':' [ <pause-before=.pause> <pause-after=.pause>? | <inherit> || <any-args> ] }

    # - pitch-range: <number> | inherit
    rule decl:sym<pitch-range> {:i (pitch\-range) ':' [ <number> | <inherit> || <any-args> ] }

    # - pitch: <frequency> | x-low | low | medium | high | x-high | inherit
    rule decl:sym<pitch> {:i (pitch) ':' [ <frequency> | [ x\-low | low | medium | high | x\-high ] & <ident> | <inherit> || <any-args> ] }

    # - play-during: <uri> [ mix || repeat ]? | auto | none | inherit
    rule decl:sym<play-during> {:i (play\-during) ':' [ <uri> [ [ mix & <ident> | repeat & <ident>  ]**1..2 ]? | [ auto | none ] & <ident> | <inherit> || <any-args> ] }

    # - position: static | relative | absolute | fixed | inherit
    rule decl:sym<position> {:i (position) ':' [ [ static | relative | absolute | fixed ] & <ident> | <inherit> || <any-args> ] }

    # - quotes: [<string> <string>]+ | none | inherit
    rule decl:sym<quotes> {:i (quotes) ':' [ [ <string> <string> ]+ | none & <ident> | <inherit> || <any-args> ] }

    # - richness: <number> | inherit
    rule decl:sym<richness> {:i (richness) ':' [ <number> | <inherit> || <any-args> ] }

    # - right: <length> | <percentage> | auto | inherit
    rule decl:sym<right> {:i (right) ':'  [ <length> | <percentage> | auto & <ident>  | <inherit> || <any-args> ] }

    # - size: <length>{1,2} | auto | portrait | landscape | inherit
    rule decl:sym<size> {:i (size) ':' [
                              <length> ** 1..2
                              | [ auto | portrait | landscape ] & <ident>
                              | <inherit> || <any-args> ]}

    # - speak-header: once | always | inherit
    rule decl:sym<speak-header> {:i (speak\-header) ':' [ [ once | always ] & <ident> | <inherit> || <any-args> ] }

    # - speak-numeral: digits | continuous | inherit
    rule decl:sym<speak-numeral> {:i (speak\-numeral) ':' [ [ digits | continuous ] & <ident> | <inherit> || <any-args> ] }

    # - speak-punctuation: code | none | inherit
    rule decl:sym<speak-punctuation> {:i (speak\-punctuation) ':' [ [ code | none ] & <ident> | <inherit> || <any-args> ] }

    # - speak: normal | none | spell-out | inherit
    rule decl:sym<speak> {:i (speak) ':' [ [ normal | none | spell\-out ] & <ident> | <inherit> || <any-args> ] }

    # - speech-rate: <number> | x-slow | slow | medium | fast | x-fast | faster | slower | inherit
    rule decl:sym<speech-rate> {:i (speech\-rate) ':' [ <number> | [ x\-slow | slow | medium | fast | x\-fast | faster | slower ] & <ident> | <inherit> || <any-args> ] }

    # - stress: <number> | inherit
    rule decl:sym<stress> {:i (stress) ':' [ <number> | <inherit> || <any-args> ] }

    # - table-layout: auto | fixed | inherit
    rule decl:sym<table-layout> {:i (table\-layout) ':' [ [ auto | fixed ] & <ident> | <inherit> || <any-args> ] }

    # - text-align: left | right | center | justify | inherit
    rule decl:sym<text-align> {:i (text\-align) ':' [ [ left | right | center | justify ] & <ident> | <inherit> || <any-args> ] }

    # - text-decoration: none | [ underline || overline || line-through || blink ] | inherit
    rule decl:sym<text-decoration> {:i (text\-decoration) ':' [ none & <ident> | [ [ underline & <ident> | overline & <ident> | line\-through & <ident> | blink & <ident>  ]**1..4 ] | <inherit> || <any-args> ] }

    # - text-indent: <length> | <percentage> | inherit
    rule decl:sym<text-indent> {:i (text\-indent) ':' [ <length> | <percentage> | <inherit> || <any-args> ] }

    # - text-transform: capitalize | uppercase | lowercase | none | inherit
    rule decl:sym<text-transform> {:i (text\-transform) ':' [ [ capitalize | uppercase | lowercase | none ] & <ident> | <inherit> || <any-args> ] }

    # - top: <length> | <percentage> | auto | inherit
    rule decl:sym<top> {:i (top) ':' [ <length> | <percentage> | auto & <ident> | <inherit> || <any-args> ] }

    # - unicode-bidi: normal | embed | bidi-override | inherit
    rule decl:sym<unicode-bidi> {:i (unicode\-bidi) ':' [ [ normal | embed | bidi\-override ] & <ident> | <inherit> || <any-args> ] }

    # - vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length> | inherit
    rule decl:sym<vertical-align> {:i (vertical\-align) ':' [ [ baseline | sub | super | top | text\-top | middle | bottom | text\-bottom ] & <ident> | <percentage> | <length> | <inherit> || <any-args> ] }

    # - visibility: visible | hidden | collapse | inherit
    rule decl:sym<visibility> {:i (visibility) ':' [ [ visible | hidden | collapse ] & <ident> | <inherit> || <any-args> ] }

    # - voice-family: [[<specific-voice> | <generic-voice> ],]* [<specific-voice> | <generic-voice> ] | inherit
    token generic-voice {:i [ male | female | child ] & <ident> }
    token specific-voice {:i <identifier> | <string> }
    rule decl:sym<voice-family> {:i (voice\-family) ':' [  [ <generic-voice> || <specific-voice> ]  [ ',' [ <generic-voice> || <specific-voice> ] ]* | <inherit> || <any-args> ] }

    # - volume: <number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud | inherit
    rule decl:sym<volume> {:i (volume) ':' [ <number> | <percentage> | [ silent | x\-soft | soft | medium | loud | x\-loud ] & <ident> | <inherit> || <any-args> ] }

    # - white-space: normal | pre | nowrap | pre-wrap | pre-line | inherit
    rule decl:sym<white-space> {:i (white\-space) ':' [ [ normal | pre[\-[wrap|line]]? | nowrap ] & <ident> | <inherit> || <any-args> ] }

    # - widows: <integer> | inherit
    rule decl:sym<widows> {:i (widows) ':' [ <integer> | <inherit> || <any-args> ] }

    # - z-index: auto | <integer> | inherit
    rule decl:sym<z-index> {:i (z\-index) ':' [ auto & <ident> | <integer> | <inherit> || <any-args> ] }

}

