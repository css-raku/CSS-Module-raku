use v6;
#  -- DO NOT EDIT --
# generated by css-gen-properties.pl --class=CSS::Module::CSS21::Spec::Actions etc/css21-properties.txt

class CSS::Module::CSS21::Spec::Actions {

    #= azimuth: <angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards
    method decl:sym<azimuth>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= background-attachment: scroll | fixed
    method decl:sym<background-attachment>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-background-attachment($/) { make $.list($/) }

    #= background-color: <color> | transparent
    method decl:sym<background-color>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-background-color($/) { make $.list($/) }

    #= background-image: <uri> | none
    method decl:sym<background-image>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-background-image($/) { make $.list($/) }

    #= background-position: [ [ <percentage> | <length> | left | center | right ] [ <percentage> | <length> | top | center | bottom ]? ] | [ [ left | center | right ] || [ top | center | bottom ] ]
    method decl:sym<background-position>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-background-position($/) { make $.list($/) }

    #= background-repeat: repeat | repeat-x | repeat-y | no-repeat
    method decl:sym<background-repeat>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-background-repeat($/) { make $.list($/) }

    #= background: ['background-color' || 'background-image' || 'background-repeat' || 'background-attachment' || 'background-position']
    method decl:sym<background>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-collapse: collapse | separate
    method decl:sym<border-collapse>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-color: [ <color> | transparent ]{1,4}
    method decl:sym<border-color>($/) { make $.decl($/, &?ROUTINE.WHY, :boxed) }
    method expr-border-color($/) { make $.list($/) }

    #= border-spacing: <length> <length>?
    method decl:sym<border-spacing>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]{1,4}
    method decl:sym<border-style>($/) { make $.decl($/, &?ROUTINE.WHY, :boxed) }
    method expr-border-style($/) { make $.list($/) }

    #= border-top: [ 'border-width' || 'border-style' || 'border-color' ]
    method decl:sym<border-top>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-right: [ 'border-width' || 'border-style' || 'border-color' ]
    method decl:sym<border-right>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-bottom: [ 'border-width' || 'border-style' || 'border-color' ]
    method decl:sym<border-bottom>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-left: [ 'border-width' || 'border-style' || 'border-color' ]
    method decl:sym<border-left>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-top-color: <color> | transparent
    method decl:sym<border-top-color>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-right-color: <color> | transparent
    method decl:sym<border-right-color>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-bottom-color: <color> | transparent
    method decl:sym<border-bottom-color>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-left-color: <color> | transparent
    method decl:sym<border-left-color>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-top-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]
    method decl:sym<border-top-style>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-right-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]
    method decl:sym<border-right-style>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-bottom-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]
    method decl:sym<border-bottom-style>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-left-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]
    method decl:sym<border-left-style>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-top-width: thin | medium | thick | <length>
    method decl:sym<border-top-width>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-right-width: thin | medium | thick | <length>
    method decl:sym<border-right-width>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-bottom-width: thin | medium | thick | <length>
    method decl:sym<border-bottom-width>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-left-width: thin | medium | thick | <length>
    method decl:sym<border-left-width>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= border-width: thin | medium | thick | <length>{1,4}
    method decl:sym<border-width>($/) { make $.decl($/, &?ROUTINE.WHY, :boxed) }
    method expr-border-width($/) { make $.list($/) }

    #= border: [ 'border-width' || 'border-style' || 'border-color' ]
    method decl:sym<border>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= bottom: <length> | <percentage> | auto
    method decl:sym<bottom>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= caption-side: top | bottom
    method decl:sym<caption-side>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= clear: none | left | right | both
    method decl:sym<clear>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= clip: <shape> | auto
    method decl:sym<clip>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= color: <color>
    method decl:sym<color>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= content: normal | none | [ <string> | <uri> | <counter> | <counters> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+
    method decl:sym<content>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= counter-increment: [ <identifier> <integer>? ]+ | none
    method decl:sym<counter-increment>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= counter-reset: [ <identifier> <integer>? ]+ | none
    method decl:sym<counter-reset>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= cue-after: <uri> | none
    method decl:sym<cue-after>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-cue-after($/) { make $.list($/) }

    #= cue-before: <uri> | none
    method decl:sym<cue-before>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-cue-before($/) { make $.list($/) }

    #= cue: [ 'cue-before' || 'cue-after' ]
    method decl:sym<cue>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= cursor: [ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ]
    method decl:sym<cursor>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= direction: ltr | rtl
    method decl:sym<direction>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= display: inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none
    method decl:sym<display>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= elevation: <angle> | below | level | above | higher | lower
    method decl:sym<elevation>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= empty-cells: show | hide
    method decl:sym<empty-cells>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= float: left | right | none
    method decl:sym<float>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= font-family: [[ <family-name> | <generic-family> ] [, <family-name> | <generic-family> ]* ]
    method decl:sym<font-family>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-font-family($/) { make $.list($/) }

    #= font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    method decl:sym<font-size>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-font-size($/) { make $.list($/) }

    #= font-style: normal | italic | oblique
    method decl:sym<font-style>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-font-style($/) { make $.list($/) }

    #= font-variant: normal | small-caps
    method decl:sym<font-variant>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-font-variant($/) { make $.list($/) }

    #= font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    method decl:sym<font-weight>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-font-weight($/) { make $.list($/) }

    #= font: [ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family' ] | caption | icon | menu | message-box | small-caption | status-bar
    method decl:sym<font>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= height: <length> | <percentage> | auto
    method decl:sym<height>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= left: <length> | <percentage> | auto
    method decl:sym<left>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= letter-spacing: normal | <length>
    method decl:sym<letter-spacing>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= line-height: normal | <number> | <length> | <percentage>
    method decl:sym<line-height>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-line-height($/) { make $.list($/) }

    #= list-style-image: <uri> | none
    method decl:sym<list-style-image>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-list-style-image($/) { make $.list($/) }

    #= list-style-position: inside | outside
    method decl:sym<list-style-position>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-list-style-position($/) { make $.list($/) }

    #= list-style-type: disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none
    method decl:sym<list-style-type>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-list-style-type($/) { make $.list($/) }

    #= list-style: [ 'list-style-type' || 'list-style-position' || 'list-style-image' ]
    method decl:sym<list-style>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= margin-right: <length> | <percentage>
    method decl:sym<margin-right>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= margin-left: <length> | <percentage>
    method decl:sym<margin-left>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= margin-top: <length> | <percentage>
    method decl:sym<margin-top>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= margin-bottom: <length> | <percentage>
    method decl:sym<margin-bottom>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= margin: [<length> | <percentage>]{1,4}
    method decl:sym<margin>($/) { make $.decl($/, &?ROUTINE.WHY, :boxed) }

    #= max-height: <length> | <percentage> | none
    method decl:sym<max-height>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= max-width: <length> | <percentage> | none
    method decl:sym<max-width>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= min-height: <length> | <percentage>
    method decl:sym<min-height>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= min-width: <length> | <percentage>
    method decl:sym<min-width>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= opacity: <number>
    method decl:sym<opacity>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= orphans: <integer>
    method decl:sym<orphans>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= outline-color: <color> | invert
    method decl:sym<outline-color>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-outline-color($/) { make $.list($/) }

    #= outline-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]
    method decl:sym<outline-style>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-outline-style($/) { make $.list($/) }

    #= outline-width: thin | medium | thick | <length>
    method decl:sym<outline-width>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-outline-width($/) { make $.list($/) }

    #= outline: [ 'outline-color' || 'outline-style' || 'outline-width' ]
    method decl:sym<outline>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= overflow: visible | hidden | scroll | auto
    method decl:sym<overflow>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= padding-top: <length> | <percentage>
    method decl:sym<padding-top>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= padding-right: <length> | <percentage>
    method decl:sym<padding-right>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= padding-bottom: <length> | <percentage>
    method decl:sym<padding-bottom>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= padding-left: <length> | <percentage>
    method decl:sym<padding-left>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= padding: [<length> | <percentage>]{1,4}
    method decl:sym<padding>($/) { make $.decl($/, &?ROUTINE.WHY, :boxed) }

    #= page-break-after: auto | always | avoid | left | right
    method decl:sym<page-break-after>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= page-break-before: auto | always | avoid | left | right
    method decl:sym<page-break-before>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= page-break-inside: avoid | auto
    method decl:sym<page-break-inside>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= pause-after: <time> | <percentage>
    method decl:sym<pause-after>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= pause-before: <time> | <percentage>
    method decl:sym<pause-before>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= pause: [ [<time> | <percentage>]{1,2} ]
    method decl:sym<pause>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= pitch-range: <number>
    method decl:sym<pitch-range>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= pitch: <frequency> | x-low | low | medium | high | x-high
    method decl:sym<pitch>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= play-during: <uri> [ mix || repeat ]? | auto | none
    method decl:sym<play-during>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= position: static | relative | absolute | fixed
    method decl:sym<position>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= quotes: [<string> <string>]+ | none
    method decl:sym<quotes>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= richness: <number>
    method decl:sym<richness>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= right: <length> | <percentage> | auto
    method decl:sym<right>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= size: <length>{1,2} | auto | portrait | landscape
    method decl:sym<size>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= speak-header: once | always
    method decl:sym<speak-header>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= speak-numeral: digits | continuous
    method decl:sym<speak-numeral>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= speak-punctuation: code | none
    method decl:sym<speak-punctuation>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= speak: normal | none | spell-out
    method decl:sym<speak>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= speech-rate: <number> | x-slow | slow | medium | fast | x-fast | faster | slower
    method decl:sym<speech-rate>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= stress: <number>
    method decl:sym<stress>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= table-layout: auto | fixed
    method decl:sym<table-layout>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= text-align: left | right | center | justify
    method decl:sym<text-align>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= text-decoration: none | [ underline || overline || line-through || blink ]
    method decl:sym<text-decoration>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= text-indent: <length> | <percentage>
    method decl:sym<text-indent>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= text-transform: capitalize | uppercase | lowercase | none
    method decl:sym<text-transform>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= top: <length> | <percentage> | auto
    method decl:sym<top>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= unicode-bidi: normal | embed | bidi-override
    method decl:sym<unicode-bidi>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length>
    method decl:sym<vertical-align>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= visibility: visible | hidden | collapse
    method decl:sym<visibility>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= voice-family: [[<specific-voice> | <generic-voice> ],]* [<specific-voice> | <generic-voice> ]
    method decl:sym<voice-family>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= volume: <number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud
    method decl:sym<volume>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= white-space: normal | pre | nowrap | pre-wrap | pre-line
    method decl:sym<white-space>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= widows: <integer>
    method decl:sym<widows>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= width: <length> | <percentage> | auto
    method decl:sym<width>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= word-spacing: normal | <length>
    method decl:sym<word-spacing>($/) { make $.decl($/, &?ROUTINE.WHY) }

    #= z-index: auto | <integer>
    method decl:sym<z-index>($/) { make $.decl($/, &?ROUTINE.WHY) }
}