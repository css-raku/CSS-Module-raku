use v6;

# reference: http://www.w3.org/TR/2008/REC-CSS1-20080411/#css1-properties

grammar CSS::Extensions::CSS1::Syntax {

    # For handling undimensioned numbers
    token length:sym<num> {<num><!before ['%'|\w]>}

    # allow color names and define our vocabulary
    token named-color {:i [aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | purple | red | silver | teal | white | yellow] & <ident> }
    rule color:sym<named> {<named-color>}
}

grammar CSS::Extensions::CSS1:ver<20080411>
 is CSS::Extensions::CSS1::Syntax {

    # 5.2 Font Properties
    # -------------------
    # - font-family: [[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]
    rule font-family {:i [ serif | sans\-serif | cursive | fantasy | monospace ] & <generic-family=.ident> | [ <family-name=.ident> ]+ | <family-name=.string> }
    rule decl:sym<font-family> {:i (font\-family) ':' [ <inherit> || <font-family> [ ',' <font-family> || <any> ]*
                                                        || <any_args> ] }

    # - font-style: normal | italic | oblique
    token font-style {:i [ normal | italic | oblique ] & <ident> }
    rule decl:sym<font-style> {:i (font\-style) ':' [ <font-style> | <inherit> || <any_args> ] }

    # - font-variant: normal | small-caps
    token font-variant {:i [ normal | small\-caps ] & <ident>}
    rule decl:sym<font-variant> {:i (font\-variant) ':' [ <font-variant>
                                                          | <inherit> || <any_args> ] }
   # - font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    token font-weight {:i [ normal | bold | bolder | lighter ] & <ident>
                           | [ 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ] & <num> }
    rule decl:sym<font-weight> {:i (font\-weight) ':' [ <font-weight>
                                                        | <inherit> || <any_args> ] }

    # - font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    token absolute-size {:i [ [[xx|x]\-]?small | medium | [[xx|x]\-]?large ] & <ident> }
    token relative-size {:i [ larger | smaller ] & <ident> }
    token font-size {:i <absolute-size> | <relative-size> | <length> | <percentage> }
    rule decl:sym<font-size> {:i (font\-size) ':' [ <font-size>
                                                    | <inherit> || <any_args> ] }
    # - font: [ <font-style> || <font-variant> || <font-weight> ]? <font-size> [ / <line-height> ]? <font-family>
    rule decl:sym<font> {:i (font) ':' [
                              [  <font-style> | <font-variant> | <font-weight> ]* <font-size> [ '/' <line-height> ]? <font-family> [ ',' <font-family> ]*
                              | <inherit> || <any_args> ] }


    # 5.3 Color and background properties
    # -----------------------------------
    # - color: <color>
    rule decl:sym<color> {:i (color) ':' [
                               <color>
                               | <inherit> || <any_args> ]}

    # - background-color: <color> | transparent
    token background-color {:i <color> | transparent & <ident> }
    rule decl:sym<background-color> {:i (background\-color) ':' [
                                          <background-color>
                                          | <inherit> || <any_args> ]}

    # - background-image: <url> | none
    token background-image {:i <url> | none & <ident> }
    rule decl:sym<background-image> {:i (background\-image) ':' [
                                          <background-image>
                                          | <inherit> || <any_args> ]}

    # - background-repeat: repeat | repeat-x | repeat-y | no-repeat
    token background-repeat {:i [ repeat[\-[x|y]]? | no\-repeat ] & <ident> }
    rule decl:sym<background-repeat> {:i (background\-repeat) ':' [
                                          <background-repeat>
                                          | <inherit> || <any_args> ]}


    # - background-attachment: scroll | fixed
    token background-attachment {:i [ scroll | fixed ] & <ident> }
    rule decl:sym<background-attachment> {:i (background\-attachment) ':' [
                                               <background-attachment>
                                               | <inherit> || <any_args> ]}

    # - background-position: [<percentage> | <length>]{1,2} | [top | center | bottom] || [left | center | right]
    rule background-position {:i  [ <percentage> | <length> ]**1..2
                                  | [ [ top | center | bottom ] & <ident>  
                                      | [ left | center | right ] & <ident> ]+ }

    rule decl:sym<background-position> {:i (background\-position) ':' [
                                             <background-position>
                                             | <inherit> || <any_args> ]}

    # - background: <background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position>
    rule decl:sym<background> {:i (background) ':' [
                                    [ <background-color> | <background-image> | <background-repeat> | <background-attachment> | <background-position> ]+
                                             | <inherit> || <any_args> ]}


    # 5.4 Text properties
    # -------------------
    # - word-spacing: normal | <length>
    # - letter-spacing: normal | <length>
    rule decl:sym<*-spacing> {:i ([word|letter]\-spacing) ':' [
                                   normal & <ident> | <length>
                                   | <inherit> || <any_args> ]}

    # - text-decoration: none | [ underline || overline || line-through || blink ]
    rule decl:sym<text-decoration> {:i (text\-decoration) ':' [
                                         none & <ident>
                                         | [[ underline | overline | line\-through | blink ] & <ident> ]+

                                 | <inherit> || <any_args> ]}
    # - vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage>
    rule decl:sym<vertical-align> {:i (vertical\-align) ':' [
                                         [ baseline | sub | super | top | text\-top | middle | bottom | text\-bottom ] & <ident>
                                         | <percentage>
                                         | <inherit> || <any_args> ]}
    

    # - text-transform: capitalize | uppercase | lowercase | none
    rule decl:sym<text-transform> {:i (text\-transform) ':' [
                                        [ capitalize | uppercase | lowercase | none ] & <ident>
                                        | <inherit> || <any_args> ]}

    # - text-align: left | right | center | justify
    rule decl:sym<text-align> {:i (text\-align) ':' [
                                    [ left | right | center | justify ] & <ident>
                                    | <inherit> || <any_args> ]}

    # - text-indent: <length> | <percentage>
    rule decl:sym<text-indent> {:i (text\-indent) ':' [
                                     <length> | <percentage>
                                     | <inherit> || <any_args> ]}

    # - line-height: normal | <number> | <length> | <percentage>
    token line-height {:i normal & <ident> | <num> | <length> | <percentage> }
    rule decl:sym<line-height> {:i (line\-height) ':' [
                                     <line-height>
                                     | <inherit> || <any_args> ]}

    # 5.5 Box properties
    # ------------------
    # - margin-top: <length> | <percentage> | auto
    # - margin-right: <length> | <percentage> | auto
    # - margin-bottom: <length> | <percentage> | auto
    # - margin-left: <length> | <percentage> | auto
    rule decl:sym<margin-*> {:i (margin\-[top|right|bottom|left]) ':' [
                                  <length> | <percentage> | auto & <ident> 
                                  | <inherit> || <any_args> ]}

    # - margin: [ <length> | <percentage> | auto ]{1,4}
    rule decl:sym<margin> {:i (margin) ':' [
                                [ <length> | <percentage> | auto & <ident> ] ** 1..4
                                | <inherit> || <any_args> ]}

    # - padding-top: <length> | <percentage>
    # - padding-right: <length> | <percentage>
    # - padding-bottom: <length> | <percentage>
    # - padding-left: <length> | <percentage>
    rule decl:sym<padding-*> {:i (padding\-[top|right|bottom|left]) ':' [
                                   <length> | <percentage>
                                   | <inherit> || <any_args> ]}
 
    # - padding: [ <length> | <percentage> ]{1,4}
    rule decl:sym<padding> {:i (padding) ':' [
                                 [ <length> | <percentage> ] ** 1..4
                                 | <inherit> || <any_args> ]}

    # - border-top-width: thin | medium | thick | <length>
    # - border-right-width: thin | medium | thick | <length>
    # - border-bottom-width: thin | medium | thick | <length>
    # - border-left-width: thin | medium | thick | <length>
    rule decl:sym<border-*-width> {:i (border\-[top|right|bottom|left]\-width) ':' [
                                        [ thin | medium | thick ] & <ident>
                                        | <length>
                                        | <inherit> || <any_args> ]}

    # - border-width: [thin | medium | thick | <length>]{1,4}
    token border-width {:i [ thin | medium | thick ] & <ident>
                            | <length> }
    rule decl:sym<border-width> {:i (border\-width) ':' [
                                      [ <border-width> ] ** 1..4
                                      | <inherit> || <any_args> ]}

    # - border-color: <color>{1,4}
    rule decl:sym<border-color> {:i (border\-color) ':' [
                                      [ <color> ] ** 1..4
                                      | <inherit> || <any_args> ]}

    # - border-style: none | dotted | dashed | solid | double | groove | ridge | inset | outset
    token border-style {:i [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ] & <ident> }
    rule decl:sym<border-style> {:i (border\-style) ':' [
                                      <border-style>
                                      | <inherit> || <any_args> ]}

    # - border-top: <border-width> || <border-style> || <color>
    # - border-right: <border-width> || <border-style> || <color>
    # - border-bottom: <border-width> || <border-style> || <color>
    # - border-left: <border-width> || <border-style> || <color>   
    # - border: <border-width> || <border-style> || <color>
    rule decl:sym<border-*> {:i (border[\-[top|right|bottom|left]]?) ':' [
                                  [ <border-width> | <border-style> | <color> ]+
                                  | <inherit> || <any_args> ]}

    # Positioning etc
    # - width: <length> | <percentage> | auto
    # - height: <length> | <percentage> | auto
    # - left: <length> | <percentage> | auto
    # - top: <length> | <percentage> | auto
    rule decl:sym<width|height|left|top> {:i (width|height|left|top) ':' [
                                  <length> | <percentage> | auto & <ident>
                                  | <inherit> || <any_args> ]}

    # - float: left | right | none
    rule decl:sym<float> {:i (float) ':' [
                                  [ left | right | none ] & <ident>
                                  | <inherit> || <any_args> ]}

    # - clear: none | left | right | both
    rule decl:sym<clear> {:i (clear) ':' [
                               [  none | left | right | both ] & <ident>
                               | <inherit> || <any_args> ]}

    # 5.6 Classification properties
    # -----------------------------
    # - display: block | inline | list-item | none
    rule decl:sym<display> {:i (display) ':' [
                                 [ block | inline | list\-item | none ] & <ident>
                                 | <inherit> || <any_args> ]}

    # - white-space: normal | pre | nowrap    
    rule decl:sym<white-space> {:i (white\-space) ':' [
                                     [ normal | pre | nowrap ] & <ident>
                                     | <inherit> || <any_args> ]}

    # - list-style-type: disc | circle | square | decimal | lower-roman | upper-roman | lower-alpha | upper-alpha | none
    token list-style-type {:i [ disc | circle | square | decimal | lower\-roman | upper\-roman | lower\-alpha | upper\-alpha | none ] & <ident> }
    rule decl:sym<list-style-type> {:i (list\-style\-type) ':' [
                                     <list-style-type>
                                     | <inherit> || <any_args> ]}

    # - list-style-image: <url> | none
    token list-style-image {:i  <url> | none & <ident> }
    rule decl:sym<list-style-image> {:i (list\-style\-image) ':' [
                                     <list-style-image>
                                     | <inherit> || <any_args> ]}

    # - list-style-position: inside | outside
    token list-style-position {:i  [ inside | outside ] & <ident> }
    rule decl:sym<list-style-position> {:i (list\-style\-position) ':' [
                                     <list-style-position>
                                     | <inherit> || <any_args> ]}

    # - list-style: <keyword> || <position> || <url>
    rule decl:sym<list-style> {:i (list\-style) ':' [
                                    [ <list-style-type> | <list-style-image> | <list-style-position> ]+
                                    | <inherit> || <any_args> ]}

    # - position: absolute | relative | static
    rule decl:sym<position> {:i (position) ':' [
                                 [ absolute | relative | static ] & <ident>
                                 | <inherit> || <any_args> ]}

    # - overflow: none | clip | scroll
    rule decl:sym<overflow> {:i (overflow) ':' [
                                 [ none | clip | scroll ] & <ident>
                                 | <inherit> || <any_args> ]}

    # - z-index: auto | <integer>
    token integer {[\+|\-]?\d+}
    rule decl:sym<z-index> {:i (z\-index) ':' [
                                 <integer>
                                 | <inherit> || <any_args> ]}
   
    # - visibility: inherit | visible | hidden
    rule decl:sym<visibility> {:i (visibility) ':' [
                                 [ inherit | visible | hidden ] & <ident>
                                 | <inherit> || <any_args> ]}
    
    # - page-break-before: auto | allways | left | right
    # - page-break-after: auto | allways | left | right
    rule decl:sym<page-break-*> {:i (page\-break\-[before|after]) ':' [
                                 [  auto | allways | left | right ] & <ident>
                                 | <inherit> || <any_args> ]}
    
    # - size: <length>{1,2} | auto | portrait | landscape
    rule decl:sym<size> {:i (size) ':' [
                              <length> ** 1..2
                              |  [ auto | portrait | landscape ] & <ident>
                              | <inherit> || <any_args> ]}

    # - marks: crop || cross | none
    rule decl:sym<marks> {:i (marks) ':' [
                               [ crop & <ident> ]? [ cross | none ] & <ident>
                               | crop & <ident>
                               | <inherit> || <any_args> ]}
    
}
