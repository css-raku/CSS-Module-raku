use v6;

# specification: http://www.w3.org/TR/2011/REC-CSS2-20110607/propidx.html

use CSS::Language::_Base;
use CSS::Grammar::CSS21;

grammar  CSS::Language::CSS21:ver<20110607.000> {...}

grammar CSS::Extensions::CSS21 {

    proto token proforma        {*}
    token proforma:sym<inherit> {:i inherit}

    # allow color names and define our vocabulary
    rule color:sym<named> {:i [ aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | orange | purple | red | silver | teal | white | yellow ] & <keyw> }

    # system colors are a css2 anachronism
    rule color:sym<system> {:i [ ActiveBorder | ActiveCaption | AppWorkspace | Background | ButtonFace | ButtonHighlight | ButtonShadow | ButtonText | CaptionText | GrayText | Highlight | HighlightText | InactiveBorder | InactiveCaption | InactiveCaptionText | InfoBackground | InfoText | Menu | MenuText | Scrollbar | ThreeDDarkShadow | ThreeDFace | ThreeDHighlight | ThreeDLightShadow | ThreeDShadow | Window | WindowFrame | WindowText ] & <system=.keyw> }
 
    # <val(..)> - rule for processing right hand side of property declarations
    rule val($expr)   { <proforma> | $<expr>=$expr || <any-args> }

    # --- Functions --- #

    rule attr     {:i'attr(' [ <attribute_name=.qname> || <any-args>] ')'}
    rule counter  {:i'counter(' [ <identifier> [ ',' <list-style-type> ]* || <any-args> ] ')'}
    rule counters {:i'counters(' [ <identifier> [ ',' <string> ]? || <any-args> ] ')' }
    rule shape-arg {:i <length> | auto & <keyw> }
    rule shape    {:i'rect(' [ <top=.shape-arg> ',' <right=.shape-arg> ',' <bottom=.shape-arg> ',' <left=.shape-arg> || <any-args> ] ')' }

    # --- Properties --- #

    # - azimuth: <angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards
    rule azimuth {:i <angle>
                       | [ leftwards | rightwards]  & <delta=.keyw>
                       | [ [ [left|right][\-side]? | far\-[left|right] | center[\-[left|right]]? ] & <direction=.keyw>
                           | behind & <behind=.keyw> ]**1..2 }
    rule decl:sym<azimuth> {:i (azimuth) ':' <val(rx:s:i{ <ref=.azimuth> })> }

    # - background-attachment: scroll | fixed
    rule background-attachment {:i [ scroll | fixed ] & <keyw> }
    rule decl:sym<background-attachment> {:i (background\-attachment) ':' <val(rx[<ref=.background-attachment>])> }

    # - background-color: <color> | transparent
    rule background-color {:i <color> | transparent & <keyw> }
    rule decl:sym<background-color> {:i (background\-color) ':' <val(rx[ <ref=.background-color> ])> }

    # - background-image: <url> | none
    rule background-image {:i <url> | none & <keyw> }
    rule decl:sym<background-image> {:i (background\-image) ':' <val(rx[ <ref=.background-image> ])> }

    # - background-position: [ [ <percentage> | <length> | left | center | right ] [ <percentage> | <length> | top | center | bottom ]? ] | [ [ left | center | right ] || [ top | center | bottom ] ]
    # simplification of http://www.w3.org/TR/2012/CR-css3-background-20120724/#ltpositiongt
    rule position {:i [ <percentage> | <length> | [ [ left | center | right | top | bottom ] & <keyw> ] [ <percentage> | <length> ] ? ] ** 1..2 }
    rule decl:sym<background-position> {:i (background\-position) ':' <val(rx[ <ref=.position> ])> }

    # - background-repeat: repeat | repeat-x | repeat-y | no-repeat
    rule background-repeat {:i [ repeat[\-[x|y]]? | no\-repeat ] & <keyw> }
    rule decl:sym<background-repeat> {:i (background\-repeat) ':' <val(rx[ <ref=.background-repeat> ])> }

    # - background: <background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position>
    rule decl:sym<background> {:i (background) ':' <val(rx:s[ [ <background-color> | <background-image> | <background-repeat> | <background-attachment> | <background-position=.position> ]**1..5 ])> }

    # - border-collapse: collapse | separate
    rule decl:sym<border-collapse> {:i (border\-collapse) ':' <val(rx:s:i[ [ collapse | separate ] & <keyw> ])> }

    # - border-color: [ <color> | transparent ]{1,4}
    rule border-color { <color> | transparent & <keyw>  }
    rule decl:sym<border-color> {:i (border\-color) ':' <val(rx:s[ <ref=.border-color>**1..4 ])> }

    # - border-spacing: <length> <length>?
    rule decl:sym<border-spacing> {:i (border\-spacing) ':' <val(rx:s[ <length> <length>? ])> }

    # - border-style: none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset
    rule border-style {:i [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ] & <keyw> }
    rule decl:sym<border-style> {:i (border\-style) ':' <val(rx:s[ <ref=.border-style> ** 1..4 ])> }

    # - border-top|border-right|border-bottom|border-left: [ <border-width> || <border-style> || 'border-top-color' ]
    rule decl:sym<border-*> {:i (border\-[top|right|bottom|left]) ':' <val(rx:s[ [ <border-width> | <border-style> | <border-color> ]**1..3 ])> }

   # - border-top-color|border-right-color|border-bottom-color|border-left-color: <color> | transparent
    rule decl:sym<border-*-color> {:i (border\-[top|right|bottom|left]\-color) ':' <val(rx:s[ <ref=.border-color> ])> }

    # - border-top-style|border-right-style|border-bottom-style|border-left-style: <border-style>
    rule decl:sym<border-*-style> {:i (border\-[top|right|bottom|left]\-style) ':' <val(rx:s[ <ref=.border-style> ])> }

    # - border-top-width|border-right-width|border-bottom-width|border-left-width: <border-width>
    rule border-width {:i [ thin | medium | thick ] & <keyw> | <length> }
    rule decl:sym<border-*-width> {:i (border\-[top|right|bottom|left]\-width) ':' <val(rx:s[ <ref=.border-width> ])> }

    # - border-width: <border-width>{1,4}
    rule decl:sym<border-width> {:i (border\-width) ':' <val(rx:s[ <ref=.border-width>**1..4 ] )> }

    # - border: [ <border-width> || <border-style> || 'border-top-color' ]
    # - refactored: border: [ <border-width> || <border-style> || <border-color> ]
    rule decl:sym<border> {:i (border) ':' <val(rx:s[ [ <border-width> | <border-style> | <ref=.border-color> ]**1..3 ])> }

    # - bottom: <length> | <percentage> | auto
    rule decl:sym<bottom> {:i (bottom) ':' <val(rx:s:i[ <length> | <percentage> | auto & <keyw> ])> }

    # - caption-side: top | bottom
    rule decl:sym<caption-side> {:i (caption\-side) ':'  <val(rx:s:i[ [ top | bottom ] & <keyw> ])> }

    # - clear: none | left | right | both
    rule decl:sym<clear> {:i (clear) ':'  <val(rx:s:i[ [ none | left | right | both ] & <keyw> ])> }

    # - clip: <shape> | auto
    rule decl:sym<clip> {:i (clip) ':'  <val(rx:s:i[ <shape> | auto  & <keyw> ])> }

    # - color: <color>
    rule decl:sym<color> {:i (color) ':'  <val(rx:s:i[ <color> ])> }

    # - content: normal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+
    rule decl:sym<content> {:i (content) ':'  <val(rx:s:i[ [ normal | none ] & <keyw> | [ <string> | <uri> | <counter> | <counters> | <attr> | [ open\-quote | close\-quote | no\-open\-quote | no\-close\-quote ] & <keyw> ]+ ])> }

    # - counter-increment: [ <identifier> <integer>? ]+ | none
    # - counter-reset: [ <identifier> <integer>? ]+ | none
    rule decl:sym<counter-[increment|reset]> {:i (counter\-[increment|reset]) ':' <val(rx:s:i[ none & <keyw> || [ <identifier> <integer>? ]+ ])> }

    # - cue-before: <uri> | none
    # - cue-after: <uri> | none
    rule cue {:i <uri> | none & <keyw> }
    rule decl:sym<cue-[before|after]> {:i (cue\-[before|after]) ':'  <val(rx:s:i[ <ref=.cue> ])> }

    # - cue: [ 'cue-before' || 'cue-after' ]
    rule decl:sym<cue> {:i (cue) ':' <val(rx:s:i[ <cue-before=.cue> <cue-after=.cue>? ])> }

    # - cursor: [ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ]
    rule decl:sym<cursor> {:i (cursor) ':' <val(rx:s:i[ [ [ <uri> ',' ]*
                                               [ [ auto | crosshair | default | pointer | move | e\-resize | ne\-resize | nw\-resize | n\-resize | se\-resize | sw\-resize | 's-resize' | w\-resize | text | wait | help | progress ] & <keyw>  ] ]
                                             ])> }

    # - direction: ltr | rtl
    rule decl:sym<direction> {:i (direction) ':' <val(rx:s:i[ [ ltr | rtl ] & <keyw> ])> }

    # - display: inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none
    rule decl:sym<display> {:i (display) ':' <val(rx:s:i[ [ block | inline[\-[block|table]]? | list\-item | table[\-[cell|caption|[header|footer]\-group|[row|column][\-group]?]]? | none ] & <keyw> ])> }

    # - elavation: <angle> | below | level | above | higher | lower
    rule elevation {:i <angle>
                   | [below | level | above ] & <direction=.keyw>
                   | [ higher | lower ] & <tilt=.keyw> }
    rule decl:sym<elevation> {:i (elevation) ':' <val(rx:s:i{ <ref=.elevation> })> }

    # - empty-cells: show | hide
    rule decl:sym<empty-cells> {:i (empty\-cells) ':' <val(rx:s:i[ [ show | hide ] & <keyw> ])> }

    # - float: left | right | none
    rule decl:sym<float> {:i (float) ':' <val(rx:s:i[ [ left | right | none ] & <keyw> ])> }

    # - font-family: [[ <family-name> | <generic-family> ] [, <family-name> | <generic-family> ]* ]
    rule font-family {:i [ serif | sans\-serif | cursive | fantasy | monospace ] & <generic-family=.keyw> || <family-name=.identifiers> | <family-name=.string> }
    rule decl:sym<font-family> {:i (font\-family) ':' <val(rx:s:i[ <ref=.font-family> +% [ ',' ] ])> }

    # - font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    rule absolute-size {:i [ [[xx|x]\-]?[small|large] | medium ] & <keyw> }
    rule relative-size {:i [ larger | smaller ] & <keyw> }
    rule font-size {:i <absolute-size> | <relative-size> | <length> | <percentage> }
    rule decl:sym<font-size> {:i (font\-size) ':' <val(rx:s:i[ <ref=.font-size> ])> }

    # - font-style: normal | italic | oblique
    rule font-style {:i [ normal | italic | oblique ] & <keyw> }
    rule decl:sym<font-style> {:i (font\-style) ':' <val(rx[ <ref=.font-style> ])> }

    # - font-variant: normal | small-caps
    rule font-variant {:i [ normal | small\-caps ] & <keyw> }
    rule decl:sym<font-variant> {:i (font\-variant) ':' <val(rx:s:i[ <ref=.font-variant> ])> }

    # - font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    rule font-weight {:i [ normal | bold | bolder | lighter ] & <keyw> | <[1..9]>00 & <number> }
    rule decl:sym<font-weight> {:i (font\-weight) ':' <val(rx:s:i[ <ref=.font-weight> ])> }

    # - font: [ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family' ] | caption | icon | menu | message-box | small-caption | status-bar
    rule decl:sym<font> {:i (font) ':' <val(rx:s:i[
                              [ <font-style> | <font-variant> | <font-weight> ]**0..3 <font-size> [ '/' <line-height> ]? [ <font-family> +% [ ',' ] ]
                              | [ caption | icon | menu | message\-box | small\-caption | status\-bar ] & <keyw>
                              ])> }

    # - width: <length> | <percentage> | auto
    # - height: <length> | <percentage> | auto
    # - left: <length> | <percentage> | auto
    # - right: <length> | <percentage> | auto
    rule decl:sym<width|height|left|top> {:i (width|height|left|top) ':' <val(rx:s:i[ <length> | <percentage> | auto & <keyw> ])> }

    # - letter-spacing: normal | <length>
    # - word-spacing: normal | <length>
    rule decl:sym<*-spacing> {:i ([letter|word]\-spacing) ':' <val(rx:s:i[ normal & <keyw> | <length> ])> }

    # - line-height: normal | <number> | <length> | <percentage>
    rule line-height {:i normal & <keyw> | <number> | <length> | <percentage> }
    rule decl:sym<line-height> {:i (line\-height) ':' <val(rx:s:i[ <ref=.line-height> ])>}

    # - list-style-image: <uri> | none
    rule list-style-image {:i  <uri> | none & <keyw> }
    rule decl:sym<list-style-image> {:i (list\-style\-image) ':' <val(rx:s:i[ <ref=.list-style-image> ])> }

    # - list-style-position: inside | outside
    rule list-style-position {:i  [ inside | outside ] & <keyw> }
    rule decl:sym<list-style-position> {:i (list\-style\-position) ':' <val(rx:s:i[ <ref=.list-style-position> ])> }

    # - list-style-type: disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none
    rule list-style-type {:i [ disc | circle | square | decimal | decimal\-leading\-zero | lower\-roman | upper\-roman | lower\-greek | lower\-latin | upper\-latin | armenian | georgian | lower\-alpha | upper\-alpha | none ] & <keyw> }
    rule decl:sym<list-style-type> {:i (list\-style\-type) ':' <val(rx:s:i[ <ref=.list-style-type> ])> }

    # - list-style: [ 'list-style-type' || 'list-style-position' || 'list-style-image' ]
    rule decl:sym<list-style> {:i (list\-style) ':' <val(rx:s:i[ [ <list-style-type> | <list-style-position> | <list-style-image> ]**1..3 ])> }

    # - margin-right|margin-left: <margin-width>
    # - margin-top|margin-bottom: <margin-width>
    rule margin-width {:i <length> | <percentage> | auto & <keyw> }
    rule decl:sym<margin-*> {:i (margin\-[right|left|bottom|top]) ':' <val(rx:s:i[ <ref=.margin-width> ])> }

    # - margin: <margin-width>{1,4}
    rule decl:sym<margin> {:i (margin) ':' <val(rx:s:i[ <ref=.margin-width>**1..4 ])> }

    # - max-height: <length> | <percentage> | none
    # - max-width: <length> | <percentage> | none
    rule decl:sym<max-[width|height]> {:i (max\-[width|height]) ':' <val(rx:s:i[ <length> | <percentage> | none & <keyw> ])> }

    # - min-height: <length> | <percentage>
    # - min-width: <length> | <percentage>
    rule decl:sym<min-[width|height]> {:i (min\-[width|height]) ':' <val(rx:s:i[ <length> | <percentage> ])> }

    # - opacity: <number>
    rule decl:sym<opacity> {:i (opacity) ':' <val(rx:s:i[ <number> ])> }

    # - orphans: <integer>
    rule decl:sym<orphans> {:i (orphans) ':' <val(rx:s:i[ <integer> ])> }

    # - outline-color: <color> | invert
    rule outline-color {:i <color> | invert & <keyw> }
    rule decl:sym<outline-color> {:i (outline\-color) ':'  <val(rx:s:i[ <ref=.outline-color> ])> }

    # - outline-style: <border-style>
    rule decl:sym<outline-style> {:i (outline\-style) ':'  <val(rx:s:i[ <ref=.border-style> ])> }

    # - outline-width: <border-width>
    rule decl:sym<outline-width> {:i (outline\-width) ':'  <val(rx:s:i[ <ref=.border-width> ])> }

   # - outline: [ 'outline-color' || 'outline-style' || 'outline-width' ]
    rule decl:sym<outline> {:i (outline) ':' <val(rx:s:i[ [ <outline-color> | <outline-style=.border-style> | <outline-width=.border-width> ]**1..3 ])> }

    # - overflow: visible | hidden | scroll | auto
    rule decl:sym<overflow> {:i (overflow) ':' <val(rx:s:i[ [ visible | hidden | scroll | auto ] & <keyw> ])> }

    # - padding-top|padding-right|padding-bottom|padding-left: <padding-width>
    rule decl:sym<padding-*> {:i (padding\-[top|right|bottom|left]) ':' <val(rx:s:i[ <ref=.padding-width> ])> }

    # - padding: <padding-width>{1,4}
    rule padding-width {:i <length> | <percentage> }
    rule decl:sym<padding> {:i (padding) ':' <val(rx:s:i[ <ref=.padding-width>**1..4 ])> }

    # - page-break-after: auto | always | avoid | left | right
    # - page-break-before: auto | always | avoid | left | right
    rule decl:sym<page-break-[before|after]> {:i (page\-break\-[before|after]) ':' <val(rx:s:i[ [ auto | always | avoid | left | right ] & <keyw> ])> }

    # - page-break-inside: avoid | auto
    rule decl:sym<page-break-inside> {:i (page\-break\-inside) ':' <val(rx:s:i[ [ avoid | auto ] & <keyw> ])> }

    # - pause-after: <time> | <percentage>
    # - pause-before: <time> | <percentage>
    rule pause {:i <time> | <percentage> }
    rule decl:sym<pause-[before|after]> {:i (pause\-[before|after]) ':' <val(rx:s:i[ <ref=.pause> ])> }

    # - pause: [ [<time> | <percentage>]{1,2} ]
    rule decl:sym<pause> {:i (pause) ':' <val(rx:s:i[ <pause-before=.pause> <pause-after=.pause>? ])> }

    # - pitch-range: <number>
    rule decl:sym<pitch-range> {:i (pitch\-range) ':' <val(rx:s:i[ <number> ])> }

    # - pitch: <frequency> | x-low | low | medium | high | x-high
    rule decl:sym<pitch> {:i (pitch) ':' <val(rx:s:i[ <frequency> | [ x\-low | low | medium | high | x\-high ] & <keyw> ])> }

    # - play-during: <uri> [ mix || repeat ]? | auto | none
    rule decl:sym<play-during> {:i (play\-during) ':' <val(rx:s:i[ <uri> [ [ mix | repeat ] & <keyw> ]**0..2 | [ auto | none ] & <keyw> ])> }

    # - position: static | relative | absolute | fixed
    rule decl:sym<position> {:i (position) ':' <val(rx:s:i[ [ static | relative | absolute | fixed ] & <keyw> ])> }

    # - quotes: [<string> <string>]+ | none
    rule decl:sym<quotes> {:i (quotes) ':' <val(rx:s:i[ [ <string> <string> ]+ | none & <keyw> ])> }

    # - richness: <number>
    rule decl:sym<richness> {:i (richness) ':' <val(rx:s:i[ <number> ])> }

    # - right: <length> | <percentage> | auto
    rule decl:sym<right> {:i (right) ':'  <val(rx:s:i[ <length> | <percentage> | auto & <keyw>  ])> }

    # - size: <length>{1,2} | auto | portrait | landscape
    rule decl:sym<size> {:i (size) ':' <val(rx:s:i[ <length> ** 1..2 | [ auto | portrait | landscape ] & <keyw> ])>}

    # - speak-header: once | always
    rule decl:sym<speak-header> {:i (speak\-header) ':' <val(rx:s:i[ [ once | always ] & <keyw> ])> }

    # - speak-numeral: digits | continuous
    rule decl:sym<speak-numeral> {:i (speak\-numeral) ':' <val(rx:s:i[ [ digits | continuous ] & <keyw> ])> }

    # - speak-punctuation: code | none
    rule decl:sym<speak-punctuation> {:i (speak\-punctuation) ':' <val(rx:s:i[ [ code | none ] & <keyw> ])> }

    # - speak: normal | none | spell-out
    rule decl:sym<speak> {:i (speak) ':' <val(rx:s:i[ [ normal | none | spell\-out ] & <keyw> ])> }

    # - speech-rate: <number> | x-slow | slow | medium | fast | x-fast | faster | slower
    rule decl:sym<speech-rate> {:i (speech\-rate) ':' <val(rx:s:i[ <number> | [ x\-slow | slow | medium | fast | x\-fast | faster | slower ] & <keyw> ])> }

    # - stress: <number>
    rule decl:sym<stress> {:i (stress) ':' <val(rx:s:i[ <number> ])> }

    # - table-layout: auto | fixed
    rule decl:sym<table-layout> {:i (table\-layout) ':' <val(rx:s:i[ [ auto | fixed ] & <keyw> ])> }

    # - text-align: left | right | center | justify
    rule decl:sym<text-align> {:i (text\-align) ':' <val(rx:s:i[ [ left | right | center | justify ] & <keyw> ])> }

    # - text-decoration: none | [ underline || overline || line-through || blink ]
    rule decl:sym<text-decoration> {:i (text\-decoration) ':' <val(rx:s:i[ none | [ [ underline | overline | line\-through | blink ] & <keyw> ]**1..4 ])> }

    # - text-indent: <length> | <percentage>
    rule decl:sym<text-indent> {:i (text\-indent) ':' <val(rx:s:i[ <length> | <percentage> ])> }

    # - text-transform: capitalize | uppercase | lowercase | none
    rule decl:sym<text-transform> {:i (text\-transform) ':' <val(rx:s:i[ [ capitalize | uppercase | lowercase | none ] & <keyw> ])> }

    # - top: <length> | <percentage> | auto
    rule decl:sym<top> {:i (top) ':' <val(rx:s:i[ <length> | <percentage> | auto & <keyw> ])> }

    # - unicode-bidi: normal | embed | bidi-override
    rule decl:sym<unicode-bidi> {:i (unicode\-bidi) ':' <val(rx:s:i[ [ normal | embed | bidi\-override ] & <keyw> ])> }

    # - vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length>
    rule decl:sym<vertical-align> {:i (vertical\-align) ':' <val(rx:s:i[ [ baseline | sub | super | top | text\-top | middle | bottom | text\-bottom ] & <keyw> | <percentage> | <length> ])> }

    # - visibility: visible | hidden | collapse
    rule decl:sym<visibility> {:i (visibility) ':' <val(rx:s:i[ [ visible | hidden | collapse ] & <keyw> ])> }

    # - voice-family: [[<specific-voice> | <generic-voice> ],]* [<specific-voice> | <generic-voice> ]
    rule generic-voice {:i [ male | female | child ] & <keyw> }
    rule specific-voice {:i <identifier> | <string> }
    rule decl:sym<voice-family> {:i (voice\-family) ':' <val(rx:s:i[ [ <generic-voice> || <specific-voice> ] +% [ ',' ] ])> }

    # - volume: <number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud
    rule decl:sym<volume> {:i (volume) ':' <val(rx:s:i[ <number> | <percentage> | [ silent | x\-soft | soft | medium | loud | x\-loud ] & <keyw> ])> }

    # - white-space: normal | pre | nowrap | pre-wrap | pre-line
    rule decl:sym<white-space> {:i (white\-space) ':' <val(rx:s:i[ [ normal | pre[\-[wrap|line]]? | nowrap ] & <keyw> ])> }

    # - widows: <integer>
    rule decl:sym<widows> {:i (widows) ':' <val(rx:s:i[ <integer> ])> }

    # - z-index: auto | <integer>
    rule decl:sym<z-index> {:i (z\-index) ':' <val(rx:s:i[ auto & <keyw> | <integer> ])> }

}

grammar CSS::Language::CSS21:ver<20110607.000>
    is CSS::Language::_Base
    is CSS::Extensions::CSS21 
    is CSS::Grammar::CSS21 {};

