use v6;

# references:
# -- http://www.w3.org/TR/2008/REC-CSS1-20080411/#css1-properties
# -- http://129.69.59.141/css1pqre.htm

use CSS::Language::_Base;
use CSS::Grammar::CSS1;
use CSS::Language::CSS1::Spec::Interface;

grammar CSS::Language::CSS1:ver<20080411.000>
    is CSS::Language::_Base
    is CSS::Grammar::CSS1
    does CSS::Language::CSS1::Spec::Interface {

    # allow color names and define our vocabulary
    rule color:sym<named>  {:i [aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | purple | red | silver | teal | white | yellow] & <keyw> }

    # 5.2 Font Properties
    # -------------------
    # - font-family: [[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]
    rule decl:sym<font-family> {:i (font\-family) ':' ( <ref=.font-family> +% [ ',' ] <any>* || <any-args> ) }
    rule font-family    {:i  [ <generic-family> || <family-name> ] }
    rule family-name    { <family-name=.identifiers> || <family-name=.string> }
    rule generic-family {:i [ serif | sans\-serif | cursive | fantasy | monospace ] & <generic-family=.identifier> }

    # - font-style: normal | italic | oblique
    rule font-style {:i [ normal | italic | oblique ] & <keyw> }
    rule decl:sym<font-style> {:i (font\-style) ':' ( <ref=.font-style> || <any-args> )}

    # - font-variant: normal | small-caps
    rule font-variant {:i [ normal | small\-caps ] & <keyw> }
    rule decl:sym<font-variant> {:i (font\-variant) ':' ( <ref=.font-variant> || <any-args> )}
    # - font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    rule font-weight {:i [ normal | bold | bolder | lighter ] & <keyw> | <[1..9]>00 & <number> }
    rule decl:sym<font-weight> {:i (font\-weight) ':' ( <ref=.font-weight> || <any-args> )}

    # - font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    rule absolute-size {:i [ [[xx|x]\-]?small | medium | [[xx|x]\-]?large ] & <keyw> }
    rule relative-size {:i [ larger | smaller ] & <keyw> }
    rule font-size {:i <absolute-size> | <relative-size> | <length> | <percentage> }
    rule decl:sym<font-size> {:i (font\-size) ':' ( <ref=.font-size> || <any-args> )}
    # - font: [ <font-style> || <font-variant> || <font-weight> ]? <font-size> [ / <line-height> ]? <font-family>
    rule decl:sym<font> {:i (font) ':' (
                              [:my @*SEEN;[ <font-style> <!seen(0)> | <font-variant> <!seen(1)> | <font-weight> <!seen(2)> ]*] <font-size> [ '/' <line-height> ]? <font-family> +% ','
                              || <any-args> )}

    # 5.3 Color and background properties
    # -----------------------------------
    # - color: <color>
    rule decl:sym<color> {:i (color) ':' ( <color> || <any-args> )}

    # - background-color: <color> | transparent
    rule background-color {:i <color> | transparent & <keyw> }
    rule decl:sym<background-color> {:i (background\-color) ':' ( <ref=.background-color> || <any-args> )}

    # - background-image: <url> | none
    rule background-image {:i <url> | none & <keyw> }
    rule decl:sym<background-image> {:i (background\-image) ':' ( <ref=.background-image> || <any-args> )}

    # - background-repeat: repeat | repeat-x | repeat-y | no-repeat
    rule background-repeat {:i [ repeat[\-[x|y]]? | no\-repeat ] & <keyw> }
    rule decl:sym<background-repeat> {:i (background\-repeat) ':' ( <ref=.background-repeat> || <any-args> )}


    # - background-attachment: scroll | fixed
    rule background-attachment {:i [ scroll | fixed ] & <keyw> }
    rule decl:sym<background-attachment> {:i (background\-attachment) ':' ( <ref=.background-attachment>
                                                                            || <any-args> )}

    # - background-position: [<percentage> | <length>]{1,2} | [top | center | bottom] || [left | center | right]
    rule background-position {:i [ <percentage> | <length> ]**1..2
                                 | [:my @*SEEN;
                                     [ [ top | center | bottom ] & <keyw> <!seen(0)>
                                     | [ left | center | right ] & <keyw> <!seen(1)> ]+ ] }

    rule decl:sym<background-position> {:i (background\-position) ':' ( <ref=.background-position>
                                                                        || <any-args> )}

    # - background: <background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position>
    rule decl:sym<background> {:i (background) ':' (
                                    [:my @*SEEN;
				      [ <background-color> <!seen(0)> | <background-image> <!seen(1)> | <background-repeat> <!seen(2)> | <background-attachment> <!seen(3)> | <background-position> <!seen(4)> ]+
                                    ] || <any-args> )}


    # 5.4 Text properties
    # -------------------
    # - word-spacing: normal | <length>
    # - letter-spacing: normal | <length>
    rule decl:sym<*-spacing> {:i ([word|letter]\-spacing) ':' ( normal & <keyw> | <length>
                                                                || <any-args> )}

    # - text-decoration: none | [ underline || overline || line-through || blink ]
    rule decl:sym<text-decoration> {:i (text\-decoration) ':' ( none & <keyw>
                                                                | :my @*SEEN;[[ underline <!seen(0)> | overline <!seen(1)> | line\-through <!seen(2)> | blink <!seen(3)> ] & <keyw> ]+
                                                                || <any-args> )}
    # - vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage>
    rule decl:sym<vertical-align> {:i (vertical\-align) ':' (
                                        [ baseline | sub | super | top | text\-top | middle | bottom | text\-bottom ] & <keyw>
                                        | <percentage>
                                        || <any-args> )}
    

    # - text-transform: capitalize | uppercase | lowercase | none
    rule decl:sym<text-transform> {:i (text\-transform) ':' ( [ capitalize | uppercase | lowercase | none ] & <keyw>
                                                              || <any-args> )}

    # - text-align: left | right | center | justify
    rule decl:sym<text-align> {:i (text\-align) ':' ( [ left | right | center | justify ] & <keyw>
                                                      || <any-args> )}

    # - text-indent: <length> | <percentage>
    rule decl:sym<text-indent> {:i (text\-indent) ':' ( <length> | <percentage>
                                                        || <any-args> )}

    # - line-height: normal | <number> | <length> | <percentage>
    rule line-height {:i normal & <keyw> | <number> | <length> | <percentage> }
    rule decl:sym<line-height> {:i (line\-height) ':' ( <ref=.line-height> || <any-args> )}

    # 5.5 Box properties
    # ------------------
    # - margin-top: <length> | <percentage> | auto
    # - margin-right: <length> | <percentage> | auto
    # - margin-bottom: <length> | <percentage> | auto
    # - margin-left: <length> | <percentage> | auto
    rule decl:sym<margin-*> {:i (margin\-[top|right|bottom|left]) ':' ( <length> | <percentage> | auto & <keyw> 
                                                                        || <any-args> )}

    # - margin: [ <length> | <percentage> | auto ]{1,4}
    rule decl:sym<margin> {:i (margin) ':' (
                                [ <length> | <percentage> | auto & <keyw> ] ** 1..4
                                || <any-args> )}

    # - padding-top: <length> | <percentage>
    # - padding-right: <length> | <percentage>
    # - padding-bottom: <length> | <percentage>
    # - padding-left: <length> | <percentage>
    rule decl:sym<padding-*> {:i (padding\-[top|right|bottom|left]) ':' ( <length> | <percentage>
                                                                          || <any-args> )}
 
    # - padding: [ <length> | <percentage> ]{1,4}
    rule decl:sym<padding> {:i (padding) ':' ( [ <length> | <percentage> ] ** 1..4
                                               || <any-args> )}

    # - border-top-width: thin | medium | thick | <length>
    # - border-right-width: thin | medium | thick | <length>
    # - border-bottom-width: thin | medium | thick | <length>
    # - border-left-width: thin | medium | thick | <length>
    rule decl:sym<border-*-width> {:i (border\-[top|right|bottom|left]\-width) ':' (
                                        [ thin | medium | thick ] & <keyw>
                                        | <length>
                                        || <any-args> )}

    # - border-width: [thin | medium | thick | <length>]{1,4}
    rule border-width {:i [ thin | medium | thick ] & <keyw> | <length> }
    rule decl:sym<border-width> {:i (border\-width) ':' ( [ <ref=.border-width> ] ** 1..4
                                                          || <any-args> )}

    # - border-color: <color>{1,4}
    rule decl:sym<border-color> {:i (border\-color) ':' ( [ <color> ] ** 1..4
                                                          || <any-args> )}

    # - border-style: none | dotted | dashed | solid | double | groove | ridge | inset | outset
    rule border-style {:i [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ] & <keyw> }
    rule decl:sym<border-style> {:i (border\-style) ':' ( <ref=.border-style> **1..4 || <any-args> )}

    # - border-top: <border-width> || <border-style> || <color>
    # - border-right: <border-width> || <border-style> || <color>
    # - border-bottom: <border-width> || <border-style> || <color>
    # - border-left: <border-width> || <border-style> || <color>   
    # - border: <border-width> || <border-style> || <color>
    rule decl:sym<border-*> {:i (border[\-[top|right|bottom|left]]?) ':' (
                                  :my @*SEEN; [ <border-width> <!seen(0)> | <border-style> <!seen(1)> | <color> <!seen(2)> ]+
                                  || <any-args> )}

    # - border: [ <border-width> || <border-style> || 'color' ]
    rule decl:sym<border> {:i (border) ':' (
                                  :my @*SEEN; [ <border-width> <!seen(0)> | <border-style> <!seen(1)> | <color> <!seen(2)> ]+
                                  || <any-args> )}

    # Positioning etc
    # - width: <length> | <percentage> | auto
    # - height: <length> | <percentage> | auto
    # - left: <length> | <percentage> | auto
    # - top: <length> | <percentage> | auto
    rule decl:sym<width|height|left|top> {:i (width|height|left|top) ':' (
                                               <length> | <percentage> | auto & <keyw>
                                               || <any-args> )}

    # - float: left | right | none
    rule decl:sym<float> {:i (float) ':' ( [ left | right | none ] & <keyw>
                                           || <any-args> )}

    # - clear: none | left | right | both
    rule decl:sym<clear> {:i (clear) ':' ( [ none | left | right | both ] & <keyw>
                                           || <any-args> )}

    # 5.6 Classification properties
    # -----------------------------
    # - display: block | inline | list-item | none
    rule decl:sym<display> {:i (display) ':' (
                                 [ block | inline | list\-item | none ] & <keyw>
                                 || <any-args> )}

    # - white-space: normal | pre | nowrap    
    rule decl:sym<white-space> {:i (white\-space) ':' ( [ normal | pre | nowrap ] & <keyw>
                                                        || <any-args> )}

    # - list-style-type: disc | circle | square | decimal | lower-roman | upper-roman | lower-alpha | upper-alpha | none
    rule list-style-type {:i [ disc | circle | square | decimal | lower\-roman | upper\-roman | lower\-alpha | upper\-alpha | none ] & <keyw> }
    rule decl:sym<list-style-type> {:i (list\-style\-type) ':' ( <ref=.list-style-type> || <any-args> )}

    # - list-style-image: <url> | none
    rule list-style-image {:i <uri> | none & <keyw> }
    rule decl:sym<list-style-image> {:i (list\-style\-image) ':' ( <ref=.list-style-image> || <any-args> )}

    # - list-style-position: inside | outside
    rule list-style-position {:i [ inside | outside ] & <keyw> }
    rule decl:sym<list-style-position> {:i (list\-style\-position) ':' ( <ref=.list-style-position>
                                                                         || <any-args> )}

    # - list-style: <keyword> || <position> || <url>
    rule decl:sym<list-style> {:i (list\-style) ':' (
                                    [ <list-style-type> | <list-style-image> | <list-style-position> ]**1..3
                                    || <any-args> )}

    # - position: absolute | relative | static
    rule decl:sym<position> {:i (position) ':' ( [ absolute | relative | static ] & <keyw>
                                                 || <any-args> )}

    # - overflow: none | clip | scroll
    rule decl:sym<overflow> {:i (overflow) ':' ( [ none | clip | scroll ] & <keyw>
                                                 || <any-args> )}

    # - z-index: auto | <integer>
    rule decl:sym<z-index> {:i (z\-index) ':' ( <integer> || <any-args> )}    
}
