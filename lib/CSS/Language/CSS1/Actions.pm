use v6;

use CSS::Language::_Base::Actions;
use CSS::Language::CSS1::_Interface;

class CSS::Language::CSS1::Actions
    is CSS::Language::_Base::Actions
    does CSS::Language::CSS1::_Interface {

    #= font-family: [[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]
    method decl:sym<font-family>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }
    method font-family($/) { make $.list($/) }
    method family-name($/) { make $<family-name>.ast }
    method generic-family($/) { make $<generic-family>.ast }

    #= font-style: normal | italic | oblique
    method decl:sym<font-style>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }
    method font-style($/) { make $.list($/) }

    #= font-variant: normal | small-caps
    method decl:sym<font-variant>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }
    method font-variant($/)  { make $.list($/) }

    #= font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    method decl:sym<font-weight>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY); 
    }
    method font-weight($/) { make $.list($/) }

    #= font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    method decl:sym<font-size>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }
    method absolute-size($/) { make $.token($<keyw>.ast) }
    method relative-size($/) { make $.token($<keyw>.ast) }
    method font-size($/)     { make $.list($/) }

    #= font: [ <font-style> || <font-variant> || <font-weight> ]? <font-size> [ / <line-height> ]? <font-family>
    method decl:sym<font>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= color: <color>
    method decl:sym<color>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= background-color: <color> | transparent
    method decl:sym<background-color>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY)
    };
    method background-color($/) { make $.list($/) }

    #= background-image: <url> | none
    method decl:sym<background-image>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY)
    };
    method background-image($/) { make $.list($/) }

    #= background-repeat: repeat | repeat-x | repeat-y | no-repeat
    method decl:sym<background-repeat>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY)
    };
    method background-repeat($/) { make $.list($/) }

    #= background-attachment: scroll | fixed
    method decl:sym<background-attachment>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    };
    method background-attachment($/) { make $.list($/) }

    #= background-position: [<percentage> | <length>]{1,2} | [top | center | bottom] || [left | center | right]
    method decl:sym<background-position>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY)
    };
    method background-position($/) { make $.list($/) }

    #= background: <background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position>
    method decl:sym<background>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= letter-spacing, word-spacing: normal | <length>
    method decl:sym<*-spacing>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= text-decoration: none | [ underline || overline || line-through || blink ]
    method decl:sym<text-decoration>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage>
     method decl:sym<vertical-align>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= text-transform: capitalize | uppercase | lowercase | none
    method decl:sym<text-transform>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= text-align: left | right | center | justify
    method decl:sym<text-align>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= text-indent: <length> | <percentage>
    method decl:sym<text-indent>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= line-height: normal | <number> | <length> | <percentage>
    method decl:sym<line-height>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }
    method line-height($/) { make $.list($/); }

    #= margin-top, margin-left, margin-bottom, margin-left: <length> | <percentage> | auto
    method decl:sym<margin-*>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }
    method margin($/) { make $.list($/); }

    #= margin: [ <length> | <percentage> | auto ]{1,4}
    method decl:sym<margin>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY, :expand<box>);
    }

    #= padding-top, padding-right, padding-bottom, padding-left: <length> | <percentage>
    method decl:sym<padding-*>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= padding: [ <length> | <percentage> ]{1,4}
    method decl:sym<padding>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY, :expand<box>);

    }

    #= border-top-width, border-right-width, border-bottom-width, border-left-width: thin | medium | thick | <length>
    method decl:sym<border-*-width>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= border-width: [thin | medium | thick | <length>]{1,4}
    method decl:sym<border-width>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY, :expand<box>);

    }
    method border-width($/) { make $.list($/) }

    #= border-color: <color>{1,4}
    method decl:sym<border-color>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY, :expand<box>);
    }

    #= border-style: [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]{1,4}
    method decl:sym<border-style>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY, :expand<box>);
    }
    method border-style($/) { make $.list($/) }

    #= border-top, border-right, border-bottom, border-left: <border-width> || <border-style> || <color>
    method decl:sym<border-*>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= border: <border-width> || <border-style> || <color>
    method decl:sym<border>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= width, height, left, top: <length> | <percentage> | auto
    method decl:sym<width|height|left|top>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= float: left | right | none
    method decl:sym<float>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= clear: none | left | right | both
    method decl:sym<clear>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= display: block | inline | list-item | none
    method decl:sym<display>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= white-space: normal | pre | nowrap    
    method decl:sym<white-space>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= list-style-type: disc | circle | square | decimal | lower-roman | upper-roman | lower-alpha | upper-alpha | none
    method decl:sym<list-style-type>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY)
    }
    method list-style-type($/) { make $.list($/) }

    #= list-style-image: <url> | none
    method decl:sym<list-style-image>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }
    method list-style-image($/) { make $.list($/) }

    #= list-style-position: inside | outside
    method decl:sym<list-style-position>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }
    method list-style-position($/) { make $.list($/) }

    #= list-style: <keyword> || <position> || <url>
    method decl:sym<list-style>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= position: absolute | relative | static
    method decl:sym<position>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= overflow: none | clip | scroll
    method decl:sym<overflow>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }

    #= z-index: auto | <integer>
    method decl:sym<z-index>($/) {
        make $._decl($0, $1, &?ROUTINE.WHY);
    }
}
