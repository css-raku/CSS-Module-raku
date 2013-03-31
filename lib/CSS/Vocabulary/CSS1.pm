use v6;

grammar CSS::Vocabulary::CSS1 {

    # Fonts
    # - font-family: [[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]
    token font-family {:i [ serif | sans\-serif | cursive | fantasy | monospace] & <generic-family=.ident> || <family-name=.ident> | <family-name=.string> }
    rule decl:sym<font-family> {:i (font\-family) ':' [ <font-family> [ ',' <font-family> ]*
                                                        | <inherit> || <bad_args> ] }

    # - font-style: normal | italic | oblique
    token font-style {:i [ normal | bold | oblique ] & <ident> }
    rule decl:sym<font-style> {:i (font\-style) ':' [ <font-style> | <inherit> || <bad_args> ] }

    # - font-variant: normal | small-caps
    token font-variant {:i [ normal | small\-caps ] & <ident>}
    rule decl:sym<font-variant> {:i (font\-variant) ':' [ <font-variant>
                                                          | <inherit> || <bad_args> ] }
   # - font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    token font-weight {:i [ normal | bold | bolder | lighter ] & <ident>
                           | [ 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ] & <num> }
    rule decl:sym<font-weight> {:i (font\-weight) ':' [ <font-weight>
                                                        | <inherit> || <bad_args> ] }

    # - font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    token absolute-size {i: [x?x\-]?small | medium | [x?x\-]?large & <ident> }
    token relative-size {:i [ larger | smaller ] & <ident> }
    token font-size {:i <absolute-size> | <relative-size> | <length> | <percentage> }
    rule decl:sym<font-size> {:i (font\-size) ':' [ <font-size>
                                                    | <inherit> || <bad_args> ] }
    # - font: [ <font-style> || <font-variant> || <font-weight> ]? <font-size> [ / <line-height> ]? <font-family>
    rule decl:sym<font> {:i (font) ':' [
                              [  <font-style> | <font-variant> | <font-weight> ]* <font-size> [ '/' <line-height> ]? <font-family>
                              | <inherit> || <bad_args> ] }
                             
    # - color: <color>
    # Backgrounds
    # - background-color: <color> | transparent
    rule decl:sym<background-color> {:i (background\-color) ':' [
                                          <color>
                                          | [ fixed & <ident> ]
                                          | <inherit> || <bad_args> ]}

    # - background-image: <url> | none
    rule decl:sym<background-image> {:i (background\-image) ':' [
                                          <url>
                                          | [ fixed & <ident> ]
                                          | <inherit> || <bad_args> ]}

    # - background-repeat: repeat | repeat-x | repeat-y | no-repeat
    rule decl:sym<background-repeat> {:i (background\-repeat) ':' [
                                          [ repeat[\-[x|y]]? | no\-repeat ] & <ident>
                                          | <inherit> || <bad_args> ]}


    # - background-attachment: scroll | fixed
    rule decl:sym<background-attachment> {:i (background\-attachment) ':' [
                                               [ scroll | fixed ] & <ident>
                                               | <inherit> || <bad_args> ]}

    # - background-position: [<percentage> | <length>]{1,2} | [top | center | bottom] || [left | center | right]
    rule decl:sym<background-position> {:i (background\-position) ':' [
                                          [ <percentage> | <length> ]**1..2 | [ top | center | bottom ] & <ident>
                                          [[ left | center | right ] & <ident> ]?
                                          | <inherit> || <bad_args> ]}

    # - background: <background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position>
    # Text
    # - word-spacing: normal | <length>
    # - letter-spacing: normal | <length>
    # - text-decoration: none | [ underline || overline || line-through || blink ]
    # - vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage>
    # - text-transform: capitalize | uppercase | lowercase | none
    # - text-align: left | right | center | justify
    # - text-indent: <length> | <percentage>
    # - line-height: normal | <number> | <length> | <percentage>
    token line-height {:i normal & <ident> | <num> | <length> | <percentage>}
    # - margin-top: <length> | <percentage> | auto
    # - margin-right: <length> | <percentage> | auto
    # - margin-bottom: <length> | <percentage> | auto
    # - margin-left: <length> | <percentage> | auto
    # - margin: [ <length> | <percentage> | auto ]{1,4}
    # - padding-top: <length> | <percentage>
    # - padding-right: <length> | <percentage>
    # - padding-bottom: <length> | <percentage>
    # - padding-left: <length> | <percentage>
    # - padding: [ <length> | <percentage> ]{1,4}
    # - border-top-width: thin | medium | thick | <length>
    # - border-right-width: thin | medium | thick | <length>
    # - border-bottom-width: thin | medium | thick | <length>
    # - border-left-width: thin | medium | thick | <length>
    # - border-width: [thin | medium | thick | <length>]{1,4}
    # - border-color: <color>{1,4}
    # - border-style: none | dotted | dashed | solid | double | groove | ridge | inset | outset
    # - border-top: <border-top-width> || <border-style> || <color>
    # - border-right: <border-right-width> || <border-style> || <color>
    # - border-bottom: <border-bottom-width> || <border-style> || <color>
    # - border-left: <border-left-width> || <border-style> || <color>
    # - border: <border-width> || <border-style> || <color>
    # Positioning etc
    # - width: <length> | <percentage> | auto
    # - height: <length> | <percentage> | auto
    # - float: left | right | none
    # - clear: none | left | right | both
    # - display: block | inline | list-item | none
    # - white-space: normal | pre | nowrap
    # - list-style-type: disc | circle | square | decimal | lower-roman | upper-roman | lower-alpha | upper-alpha | none
    # - list-style-image: <url> | none
    # - list-style-position: inside | outside
    # - list-style: <keyword> || <position> || <url>
    # - position: absolute | relative | static
    # - left: <length> | <percentage> | auto
    # - top: <length> | <percentage> | auto
    # - clip: <shape> | auto
    # - overflow: none | clip | scroll
    # - z-index: auto | <integer>
    # - visibility: inherit | visible | hidden
    # - page-break-before: auto | allways | left | right
    # - page-break-after: auto | allways | left | right
    # - size: <length>{1,2} | auto | portrait | landscape
    # - marks: crop || cross | none

}
