use v6;

# specification: http://www.w3.org/TR/2011/REC-CSS2-20110607/propidx.html

use CSS::Grammar::CSS21;

grammar CSS::Extensions::CSS21 {...}

grammar CSS::Language::CSS21:ver<20110607.000>
    is CSS::Extensions::CSS21 
    is CSS::Grammar::CSS21 {};

grammar CSS::Extensions::CSS21 {

    rule declaration:sym<validated> { <decl> <prio>**0..1 <any-arg>* <end-decl> }

    # For handling undimensioned quantities
    token length:sym<num>       {<number>}
    token angle:sym<num>        {<number>}
    token frequency:sym<num>    {<number>}
    proto token proforma        { <...> }
    token proforma:sym<inherit> {:i inherit}
    rule misc                   {<proforma>**0..1 <any-arg>*}

    # allow color names and define our vocabulary
    rule color:sym<named> {:i [ aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | orange | purple | red | silver | teal | white | yellow ] & <keyw> }

    # system colors are a css2 anachronism
    rule color:sym<system> {:i [ ActiveBorder | ActiveCaption | AppWorkspace | Background | ButtonFace | ButtonHighlight | ButtonShadow | ButtonText | CaptionText | GrayText | Highlight | HighlightText | InactiveBorder | InactiveCaption | InactiveCaptionText | InfoBackground | InfoText | Menu | MenuText | Scrollbar | ThreeDDarkShadow | ThreeDFace | ThreeDHighlight | ThreeDLightShadow | ThreeDShadow | Window | WindowFrame | WindowText ] & <system=.keyw> }
 
    # nomenclature
    token integer     {[\+|\-]?\d+ <!before ['%'|\w|'.']>}
    token number      {<num> <!before ['%'|\w]>}
    token uri         {<url>}
    token keyw        {<ident>}           # keywords (case insensitive)
    token identifier  {<name>}            # identifiers (case sensitive)
    rule identifiers  {[ <identifier> ]+} # sequence of identifiers
    # property - rule for processing right hand side of property declarations
    # experimental
    rule val($expr)   { $<expr>=$expr:i:s || <misc> }

    # --- Functions --- #

    rule attr     {:i'attr(' [ <attribute_name=.identifier> || <any-args>] ')'}
    rule counter  {:i'counter(' [ <identifier> [ ',' <list-style-type> ]* || <any-args> ] ')'}
    rule counters {:i'counters(' [ <identifier> [ ',' <string> ]? || <any-args> ] ')' }
    rule shape-arg {:i <length> | auto & <keyw> }
    rule shape    {:i'rect(' [ <top=.shape-arg> ',' <right=.shape-arg> ',' <bottom=.shape-arg> ',' <left=.shape-arg> || <any-args> ] ')' }

    # --- Properties --- #

    # - azimuth: <angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards | inherit
     rule decl:sym<azimuth> {:i (azimuth) ':' [ <angle>
                                                | [ leftwards | rightwards]  & <delta=.keyw>
                                                | [ [ left[\-side]? | far\-[left|right] | center[\-[left|right]]? | right[\-side]? ] & <keyw>
                                                    | behind & <behind=.keyw> ]**1..2
                                                || <misc> ] }

    # - background-attachment: scroll | fixed | inherit
    # Note: using the experimental <val(..)> rule
    token background-attachment {:i [ scroll | fixed ] & <keyw> }
    rule decl:sym<background-attachment> {:i (background\-attachment) ':' <val(rx[<background-attachment>])> }

    # - background-color: <color> | transparent | inherit
    token background-color {:i <color> | transparent & <keyw> }
    rule decl:sym<background-color> {:i (background\-color) ':' [
                                          <background-color>
                                          || <misc> ]}

    # - background-image: <url> | none | inherit
    token background-image {:i <url> | none & <keyw> }
    rule decl:sym<background-image> {:i (background\-image) ':' [
                                          <background-image>
                                          || <misc> ]}

    # - background-position: [ [ <percentage> | <length> | left | center | right ] [ <percentage> | <length> | top | center | bottom ]? ] | [ [ left | center | right ] || [ top | center | bottom ] ] | inherit
    # simplification of http://www.w3.org/TR/2012/CR-css3-background-20120724/#ltpositiongt
    rule position {:i [ <percentage> | <length> | [ [ left | center | right | top | bottom ] & <keyw> ] [ <percentage> | <length> ] ? ] ** 1..2 }
    rule decl:sym<background-position> {:i (background\-position) ':' [ <position> || <misc> ]}

    # - background-repeat: repeat | repeat-x | repeat-y | no-repeat
    token background-repeat {:i [ repeat[\-[x|y]]? | no\-repeat ] & <keyw> }
    rule decl:sym<background-repeat> {:i (background\-repeat) ':' [ <background-repeat>
                                                                    || <misc> ]}

    # - background: <background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position> | inherit
    rule decl:sym<background> {:i (background) ':' [ [ <background-color> | <background-image> | <background-repeat> | <background-attachment> | <background-position=.position> ]**1..5
                                                     || <misc> ]}

    # - border-collapse: collapse | separate | inherit
    rule decl:sym<border-collapse> {:i (border\-collapse) ':' [ [ collapse | separate ] & <keyw> || <misc> ] }

    # - border-color: [ <color> | transparent ]{1,4} | inherit
    rule border-color { <color> | transparent & <keyw>  }
    rule decl:sym<border-color> {:i (border\-color) ':' [ <border-color>**1..4
                                                          || <misc> ]}

    # - border-spacing: <length> <length>? | inherit
    rule decl:sym<border-spacing> {:i (border\-spacing) ':' [ <length> <length>? || <misc> ] }

    # - border-style: none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset
    token border-style {:i [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ] & <keyw> }
    rule decl:sym<border-style> {:i (border\-style) ':' [ <border-style> ** 1..4
                                                          || <misc> ]}

    # - border-top|border-right|border-bottom|border-left: [ <border-width> || <border-style> || 'border-top-color' ] | inherit
    rule decl:sym<border-*> {:i (border\-[top|right|bottom|left]) ':' [ [ <border-width> | <border-style> | <border-color> ]**1..3 || <misc> ] }

   # - border-top-color|border-right-color|border-bottom-color|border-left-color: <color> | transparent | inherit
    rule decl:sym<border-*-color> {:i (border\-[top|right|bottom|left]\-color) ':' [ <border-color> || <misc> ] }

    # - border-top-style|border-right-style|border-bottom-style|border-left-style: <border-style> | inherit
    rule decl:sym<border-*-style> {:i (border\-[top|right|bottom|left]\-style) ':' [ <border-style> || <misc> ] }

    # - border-top-width|border-right-width|border-bottom-width|border-left-width: <border-width> | inherit
    rule border-width {:i [ thin | medium | thick ] & <keyw> | <length> }
    rule decl:sym<border-*-width> {:i (border\-[top|right|bottom|left]\-width) ':' [ <border-width> || <misc> ] }

    # - border-width: <border-width>{1,4} | inherit
    rule decl:sym<border-width> {:i (border\-width) ':' [ <border-width>**1..4 || <misc> ] }

    # - border: [ <border-width> || <border-style> || 'border-top-color' ] | inherit
    # - refactored: border: [ <border-width> || <border-style> || <border-color> ] | inherit
    rule decl:sym<border> {:i (border) ':' [ [ <border-width> | <border-style> | <border-color> ]**1..3 || <misc> ] }

    # - bottom: <length> | <percentage> | auto | inherit
    rule decl:sym<bottom> {:i (bottom) ':' [ <length> | <percentage> | auto & <keyw> || <misc> ] }

    # - caption-side: top | bottom | inherit
    rule decl:sym<caption-side> {:i (caption\-side) ':' [ [ top | bottom ] & <keyw> || <misc> ] }

    # - clear: none | left | right | both | inherit
    rule decl:sym<clear> {:i (clear) ':' [ [ none | left | right | both ] & <keyw> || <misc> ] }

    # - clip: <shape> | auto
    rule decl:sym<clip> {:i (clip) ':' [ <shape> | auto  & <keyw>
                                         || <misc> ]}


    # - color: <color> | inherit
    rule decl:sym<color> {:i (color) ':' [ <color> || <misc> ] }

    # - content: normal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+ | inherit
    rule decl:sym<content> {:i (content) ':' [ <proforma> | [ normal | none ] & <keyw> | [ [ <string> | <uri> | <counter> | <counters> | <attr> | [ open\-quote | close\-quote | no\-open\-quote | no\-close\-quote ] & <keyw>  ] || <any-arg>+ ]+
                                               || <misc> ] }

    # - counter-increment: [ <identifier> <integer>? ]+ | none | inherit
    # - counter-reset: [ <identifier> <integer>? ]+ | none | inherit
    rule decl:sym<counter-[increment|reset]> {:i (counter\-[increment|reset]) ':' [ 
                                           <proforma>
                                           | none & <keyw>
                                           | [ <identifier> <integer>? <any>*? ]+ 
                                           || <misc> ] }

    # - cue-before: <uri> | none | inherit
    # - cue-after: <uri> | none | inherit
    token cue {:i <uri> | none & <keyw> }
    rule decl:sym<cue-[before|after]> {:i (cue\-[before|after]) ':'  [ <cue-after=.cue> || <misc> ] }

    # - cue: [ 'cue-before' || 'cue-after' ] | inherit
    rule decl:sym<cue> {:i (cue) ':' [ <cue-before=.cue> <cue-after=.cue>? || <misc> ] }

    # - cursor: [ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ] | inherit
    rule decl:sym<cursor> {:i (cursor) ':' [ [ [ <uri> ',' ]*
                                               [ [ auto | crosshair | default | pointer | move | e\-resize | ne\-resize | nw\-resize | n\-resize | se\-resize | sw\-resize | 's-resize' | w\-resize | text | wait | help | progress ] & <keyw>  ] ]
                                             || <misc> ] }

    # - direction: ltr | rtl | inherit
    rule decl:sym<direction> {:i (direction) ':' [ [ ltr | rtl ] & <keyw> || <misc> ] }

    # - display: inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none | inherit
    rule decl:sym<display> {:i (display) ':' [ [ block | inline[\-[block|table]]? | list\-item | table[\-[cell|caption|[header|footer]\-group|[row|column][\-group]?]]? | none ] & <keyw>
                                               || <misc> ] }

    # - elavation: <angle> | below | level | above | higher | lower | inherit
    rule decl:sym<elevation> {:i (elevation) ':' [ <angle>
                                                   | [below | level | above ] & <keyw>
                                                   | [ higher | lower ] & <tilt=.keyw>
                                                   || <misc> ]}

    # - empty-cells: show | hide | inherit
    rule decl:sym<empty-cells> {:i (empty\-cells) ':' [ [ show | hide ] & <keyw> || <misc> ] }

    # - float: left | right | none | inherit
    rule decl:sym<float> {:i (float) ':' [ [ left | right | none ] & <keyw> || <misc> ] }

    # - font-family: [[ <family-name> | <generic-family> ] [, <family-name> | <generic-family> ]* ] | inherit
    rule font-family {:i [ serif | sans\-serif | cursive | fantasy | monospace ] & <generic-family=.keyw> || <family-name=.identifiers> | <family-name=.string> }
    rule decl:sym<font-family> {:i (font\-family) ':' [ <proforma>
                                                        | <font-family> +% ',' <any>*
                                                        || <misc> ] }

    # - font-size: <absolute-size> | <relative-size> | <length> | <percentage> | inherit
    token absolute-size {:i [ [[xx|x]\-]?small | medium | [[xx|x]\-]?large ] & <keyw> }
    token relative-size {:i [ larger | smaller ] & <keyw> }
    token font-size {:i <absolute-size> | <relative-size> | <length> | <percentage> }
    rule decl:sym<font-size> {:i (font\-size) ':' [ <font-size>
                                                    || <misc> ] }

    # - font-style: normal | italic | oblique | inherit
    token font-style {:i [ normal | italic | oblique ] & <keyw> }
    rule decl:sym<font-style> {:i (font\-style) ':' <val(rx[<font-style>])> }

    # - font-variant: normal | small-caps | inherit
    token font-variant {:i [ normal | small\-caps ] & <keyw>}
    rule decl:sym<font-variant> {:i (font\-variant) ':' [ <font-variant> || <misc> ] }

    # - font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 | inherit
    token font-weight {:i [ normal | bold | bolder | lighter ] & <keyw>
                           | [ 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ] & <number> }
    rule decl:sym<font-weight> {:i (font\-weight) ':' [ <font-weight>
                                                        || <misc> ] }

    # - font: [ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family' ] | caption | icon | menu | message-box | small-caption | status-bar | inherit
    rule decl:sym<font> {:i (font) ':' [
                              [ <font-style> | <font-variant> | <font-weight> ]**0..3 <font-size> [ '/' <line-height> ]? [ <font-family> +% ',' ]
                              | [ caption | icon | menu | message\-box | small\-caption | status\-bar ] & <keyw>
                              || <misc> ] }

    # - width: <length> | <percentage> | auto | inherit
    # - height: <length> | <percentage> | auto | inherit
    # - left: <length> | <percentage> | auto | inherit
    # - right: <length> | <percentage> | auto | inherit
    rule decl:sym<width|height|left|top> {:i (width|height|left|top) ':' <val(rx[<length> | <percentage> | auto & <keyw> ])> }

    # - letter-spacing: normal | <length> | inherit
    # - word-spacing: normal | <length> | inherit
    rule decl:sym<*-spacing> {:i ([letter|word]\-spacing) ':' [ normal & <keyw> | <length> || <misc> ] }

    # - line-height: normal | <number> | <length> | <percentage> | inherit
    token line-height {:i normal & <keyw> | <number> | <length> | <percentage> }
    rule decl:sym<line-height> {:i (line\-height) ':' [ <line-height>
                                                        || <misc> ]}

    # - list-style-image: <uri> | none | inherit
    token list-style-image {:i  <uri> | none & <keyw> }
    rule decl:sym<list-style-image> {:i (list\-style\-image) ':' [ <list-style-image>
                                                                   || <misc> ]}

    # - list-style-position: inside | outside | inherit
    token list-style-position {:i  [ inside | outside ] & <keyw> }
    rule decl:sym<list-style-position> {:i (list\-style\-position) ':' [ <list-style-position>
                                                                         || <misc> ]}

    # - list-style-type: disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none | inherit
    token list-style-type {:i [ disc | circle | square | decimal | decimal\-leading\-zero | lower\-roman | upper\-roman | lower\-greek | lower\-latin | upper\-latin | armenian | georgian | lower\-alpha | upper\-alpha | none ] & <keyw> }
    rule decl:sym<list-style-type> {:i (list\-style\-type) ':' <val(rx[<list-style-type>])> }

    # - list-style: [ 'list-style-type' || 'list-style-position' || 'list-style-image' ] | inherit
    rule decl:sym<list-style> {:i (list\-style) ':' [ [ <list-style-type> | <list-style-position> | <list-style-image> ]**1..3  || <misc> ] }

    # - margin-right|margin-left: <margin-width> | inherit
    # - margin-top|margin-bottom: <margin-width> | inherit
    rule margin-width {:i <length> | <percentage> | auto & <keyw> }
    rule decl:sym<margin-*> {:i (margin\-[right|left|bottom|top]) ':' [ <margin-width> || <misc> ] }

    # - margin: <margin-width>{1,4} | inherit
    rule decl:sym<margin> {:i (margin) ':' [ <margin-width>**1..4 || <misc> ] }

    # - max-height: <length> | <percentage> | none | inherit
    # - max-width: <length> | <percentage> | none | inherit
    rule decl:sym<max-[width|height]> {:i (max\-[width|height]) ':' [ <length> | <percentage> | none & <keyw> || <misc> ] }

    # - min-height: <length> | <percentage> | inherit
    # - min-width: <length> | <percentage> | inherit
    rule decl:sym<min-[width|height]> {:i (min\-[width|height]) ':' [ <length> | <percentage> || <misc> ] }

    # - orphans: <integer> | inherit
    rule decl:sym<orphans> {:i (orphans) ':' [ <integer> || <misc> ] }

    # - outline-color: <color> | invert | inherit
    token outline-color {:i <color> | invert & <keyw> }
    rule decl:sym<outline-color> {:i (outline\-color) ':'  [ <outline-color> || <misc> ] }

    # - outline-style: <border-style> | inherit
    rule decl:sym<outline-style> {:i (outline\-style) ':'  [ <outline-style=.border-style> || <misc> ] }

    # - outline-width: <border-width> | inherit
    rule decl:sym<outline-width> {:i (outline\-width) ':'  [ <outline-width=.border-width> || <misc> ] }

   # - outline: [ 'outline-color' || 'outline-style' || 'outline-width' ] | inherit
    rule decl:sym<outline> {:i (outline) ':' [ [ <outline-color> | <outline-style=.border-style> | <outline-width=.border-width> ]**1..3 || <misc> ] }

    # - overflow: visible | hidden | scroll | auto | inherit
    rule decl:sym<overflow> {:i (overflow) ':' [ [ visible | hidden | scroll | auto ] & <keyw> || <misc> ] }

    # - padding-top|padding-right|padding-bottom|padding-left: <padding-width> | inherit
    rule decl:sym<padding-*> {:i (padding\-[top|right|bottom|left]) ':' [ <padding-width> || <misc> ] }

    # - padding: <padding-width>{1,4} | inherit
    token padding-width {:i <length> | <percentage> }
    rule decl:sym<padding> {:i (padding) ':' [ <padding-width>**1..4 || <misc> ] }

    # - page-break-after: auto | always | avoid | left | right | inherit
    # - page-break-before: auto | always | avoid | left | right | inherit
    rule decl:sym<page-break-[before|after]> {:i (page\-break\-[before|after]) ':' [ [ auto | always | avoid | left | right ] & <keyw> || <misc> ] }

    # - page-break-inside: avoid | auto | inherit
    rule decl:sym<page-break-inside> {:i (page\-break\-inside) ':' [ [ avoid | auto ] & <keyw> || <misc> ] }

    # - pause-after: <time> | <percentage> | inherit
    # - pause-before: <time> | <percentage> | inherit
    token pause {:i <time> | <percentage> }
    rule decl:sym<pause-[before|after]> {:i (pause\-[before|after]) ':' [ <pause> || <misc> ] }

    # - pause: [ [<time> | <percentage>]{1,2} ] | inherit
    rule decl:sym<pause> {:i (pause) ':' [ <pause-before=.pause> <pause-after=.pause>? || <misc> ] }

    # - pitch-range: <number> | inherit
    rule decl:sym<pitch-range> {:i (pitch\-range) ':' [ <number> || <misc> ] }

    # - pitch: <frequency> | x-low | low | medium | high | x-high | inherit
    rule decl:sym<pitch> {:i (pitch) ':' [ <frequency> | [ x\-low | low | medium | high | x\-high ] & <keyw> || <misc> ] }

    # - play-during: <uri> [ mix || repeat ]? | auto | none | inherit
    rule decl:sym<play-during> {:i (play\-during) ':' [ <uri> [ [ mix | repeat ] & <keyw> ]**0..2 | [ auto | none ] & <keyw> || <misc> ] }

    # - position: static | relative | absolute | fixed | inherit
    rule decl:sym<position> {:i (position) ':' [ [ static | relative | absolute | fixed ] & <keyw> || <misc> ] }

    # - quotes: [<string> <string>]+ | none | inherit
    rule decl:sym<quotes> {:i (quotes) ':' [ [ <string> <string> ]+ | none & <keyw> || <misc> ] }

    # - richness: <number> | inherit
    rule decl:sym<richness> {:i (richness) ':' [ <number> || <misc> ] }

    # - right: <length> | <percentage> | auto | inherit
    rule decl:sym<right> {:i (right) ':'  [ <length> | <percentage> | auto & <keyw>  || <misc> ] }

    # - size: <length>{1,2} | auto | portrait | landscape | inherit
    rule decl:sym<size> {:i (size) ':' [ <length> ** 1..2 | [ auto | portrait | landscape ] & <keyw>
                                         || <misc> ]}

    # - speak-header: once | always | inherit
    rule decl:sym<speak-header> {:i (speak\-header) ':' [ [ once | always ] & <keyw> || <misc> ] }

    # - speak-numeral: digits | continuous | inherit
    rule decl:sym<speak-numeral> {:i (speak\-numeral) ':' [ [ digits | continuous ] & <keyw> || <misc> ] }

    # - speak-punctuation: code | none | inherit
    rule decl:sym<speak-punctuation> {:i (speak\-punctuation) ':' [ [ code | none ] & <keyw> || <misc> ] }

    # - speak: normal | none | spell-out | inherit
    rule decl:sym<speak> {:i (speak) ':' [ [ normal | none | spell\-out ] & <keyw> || <misc> ] }

    # - speech-rate: <number> | x-slow | slow | medium | fast | x-fast | faster | slower | inherit
    rule decl:sym<speech-rate> {:i (speech\-rate) ':' [ <number> | [ x\-slow | slow | medium | fast | x\-fast | faster | slower ] & <keyw> || <misc> ] }

    # - stress: <number> | inherit
    rule decl:sym<stress> {:i (stress) ':' [ <number> || <misc> ] }

    # - table-layout: auto | fixed | inherit
    rule decl:sym<table-layout> {:i (table\-layout) ':' [ [ auto | fixed ] & <keyw> || <misc> ] }

    # - text-align: left | right | center | justify | inherit
    rule decl:sym<text-align> {:i (text\-align) ':' [ [ left | right | center | justify ] & <keyw> || <misc> ] }

    # - text-decoration: none | [ underline || overline || line-through || blink ] | inherit
    rule decl:sym<text-decoration> {:i (text\-decoration) ':' [ none | [ [ underline | overline | line\-through | blink ] & <keyw> ]**1..4 || <misc> ] }

    # - text-indent: <length> | <percentage> | inherit
    rule decl:sym<text-indent> {:i (text\-indent) ':' [ <length> | <percentage> || <misc> ] }

    # - text-transform: capitalize | uppercase | lowercase | none | inherit
    rule decl:sym<text-transform> {:i (text\-transform) ':' [ [ capitalize | uppercase | lowercase | none ] & <keyw> || <misc> ] }

    # - top: <length> | <percentage> | auto | inherit
    rule decl:sym<top> {:i (top) ':' [ <length> | <percentage> | auto & <keyw> || <misc> ] }

    # - unicode-bidi: normal | embed | bidi-override | inherit
    rule decl:sym<unicode-bidi> {:i (unicode\-bidi) ':' [ [ normal | embed | bidi\-override ] & <keyw> || <misc> ] }

    # - vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length> | inherit
    rule decl:sym<vertical-align> {:i (vertical\-align) ':' [ [ baseline | sub | super | top | text\-top | middle | bottom | text\-bottom ] & <keyw> | <percentage> | <length> || <misc> ] }

    # - visibility: visible | hidden | collapse | inherit
    rule decl:sym<visibility> {:i (visibility) ':' [ [ visible | hidden | collapse ] & <keyw> || <misc> ] }

    # - voice-family: [[<specific-voice> | <generic-voice> ],]* [<specific-voice> | <generic-voice> ] | inherit
    token generic-voice {:i [ male | female | child ] & <keyw> }
    token specific-voice {:i <identifier> | <string> }
    rule decl:sym<voice-family> {:i (voice\-family) ':' [  <proforma> || [ <generic-voice> || <specific-voice> ] +% ',' || <misc> ] }

    # - volume: <number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud | inherit
    rule decl:sym<volume> {:i (volume) ':' [ <number> | <percentage> | [ silent | x\-soft | soft | medium | loud | x\-loud ] & <keyw> || <misc> ] }

    # - white-space: normal | pre | nowrap | pre-wrap | pre-line | inherit
    rule decl:sym<white-space> {:i (white\-space) ':' [ [ normal | pre[\-[wrap|line]]? | nowrap ] & <keyw> || <misc> ] }

    # - widows: <integer> | inherit
    rule decl:sym<widows> {:i (widows) ':' [ <integer> || <misc> ] }

    # - z-index: auto | <integer> | inherit
    rule decl:sym<z-index> {:i (z\-index) ':' [ auto & <keyw> | <integer> || <misc> ] }

}

