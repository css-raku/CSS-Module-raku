use v6;

use CSS::Language::_Base::Actions;

class CSS::Language::CSS1::Actions
    is CSS::Language::_Base::Actions {

    # - font-family: [[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]
    method font-family($/) { make $.list($/) }
    method decl:sym<font-family>($/) {
        make $._decl($0, $1, '[[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]');
    }

    # - font-style: normal | italic | oblique
    method font-style($/) { make $.node($/) }
    method decl:sym<font-style>($/) {
        make $._decl($0, $1, 'normal | italic | oblique');
    }

    # - font-variant: normal | small-caps
    method font-variant($/)  { make $.node($/) }
    method decl:sym<font-variant>($/) {
        make $._decl($0, $1, 'normal | small-caps');
    }

    # - font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    method font-weight($/) { make $.node($/) }
    method decl:sym<font-weight>($/) {
        make $._decl($0, $1, 'normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900'); 
    }

    # - font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    method absolute-size($/) { make $.token($<keyw>.ast) }
    method relative-size($/) { make $.token($<keyw>.ast) }
    method font-size($/)     { make $.list($/) }
    method decl:sym<font-size>($/) {
        make $._decl($0, $1, '[[x]x-]small | medium | [[x]x\-]large | larger | smaller | <length> | <percentage>');
    }

    method decl:sym<font>($/) {
        make $._decl($0, $1, '[ <font-style> || <font-variant> || <font-weight> ]? <font-size> [ / <line-height> ]? <font-family>');
    }

    # - color: <color>
    method decl:sym<color>($/) {
        make $._decl($0, $1, '<color>');
    }

    # - background-color: <color> | transparent
    method background-color($/) { make $.list($/) }
    method decl:sym<background-color>($/) {
        make $._decl($0, $1, '<color> | transparent')
    };

    # - background-image: <url> | none
    method background-image($/) { make $.list($/) }
    method decl:sym<background-image>($/) {
        make $._decl($0, $1, '<uri> | none')
    };

    # - background-repeat: repeat | repeat-x | repeat-y | no-repeat
    method background-repeat($/) { make $.list($/) }
    method decl:sym<background-repeat>($/) {
        make $._decl($0, $1, 'repeat | repeat-x | repeat-y | no-repeat')
    };

    # - background-attachment: scroll | fixed
    method background-attachment($/) { make $.list($/) }
    method decl:sym<background-attachment>($/) {
        make $._decl($0, $1, 'scroll | fixed');
    };

    # - background-position: [<percentage> | <length>]{1,2} | [top | center | bottom] || [left | center | right]
    method background-position($/) { make $.list($/) }
    method decl:sym<background-position>($/) {
        make $._decl($0, $1, '[<percentage> | <length> ]{1,2} | [top | center | bottom] || [left | center | right]')
    };

    # - background: <background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position>
    method decl:sym<background>($/) {
        make $._decl($0, $1, '<background-color> || <background-image> || <background-repeat> || <background-attachment>');
    }

    # - letter-spacing: normal | <length>
    # - word-spacing: normal | <length>
    method decl:sym<*-spacing>($/) {
        make $._decl($0, $1, 'normal | <length>');
    }

    # - text-decoration: none | [ underline || overline || line-through || blink ]
    method decl:sym<text-decoration>($/) {
        make $._decl($0, $1, 'none | [ underline || overline || line-through || blink ]');
    }

    # - vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage>
     method decl:sym<vertical-align>($/) {
        make $._decl($0, $1, 'baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage>');
    }

    # - text-transform: capitalize | uppercase | lowercase | none
    method decl:sym<text-transform>($/) {
        make $._decl($0, $1, 'capitalize | uppercase | lowercase | none');
    }

    # - text-align: left | right | center | justify
    method decl:sym<text-align>($/) {
        make $._decl($0, $1, 'left | right | center | justify');
    }

    # - text-indent: <length> | <percentage>
    method decl:sym<text-indent>($/) {
        make $._decl($0, $1, '<length> | <percentage>');
    }

    # - line-height: normal | <number> | <length> | <percentage>
    method line-height($/) { make $.list($/); }
    method decl:sym<line-height>($/) {
        make $._decl($0, $1, 'normal | <number> | <length> | <percentage>');
    }

    # - margin-top: <length> | <percentage> | auto
    # - margin-right: <length> | <percentage> | auto
    # - margin-bottom: <length> | <percentage> | auto
    # - margin-left: <length> | <percentage> | auto
    method margin($/) { make $.list($/); }
    method decl:sym<margin-*>($/) {
        make $._decl($0, $1, '<length> | <percentage> | auto');
    }

    # - margin: [ <length> | <percentage> | auto ]{1,4}
    method decl:sym<margin>($/) {
        make $._decl($0, $1, '[ <length> | <percentage> | auto ]{1,4}',
            :expand<box>);
    }

    # - padding-top: <length> | <percentage>
    # - padding-right: <length> | <percentage>
    # - padding-bottom: <length> | <percentage>
    # - padding-left: <length> | <percentage>
    method decl:sym<padding-*>($/) {
        make $._decl($0, $1, '<length> | <percentage>');
    }

    # - padding: [ <length> | <percentage> ]{1,4}
    method decl:sym<padding>($/) {
        make $._decl($0, $1, '[ <length> | <percentage> ]{1,4}',
                     :expand<box>);

    }

    # - border-top-width: thin | medium | thick | <length>
    # - border-right-width: thin | medium | thick | <length>
    # - border-bottom-width: thin | medium | thick | <length>
    # - border-left-width: thin | medium | thick | <length>
    method decl:sym<border-*-width>($/) {
        make $._decl($0, $1, 'thin | medium | thick | <length>');
    }

    # - border-width: [thin | medium | thick | <length>]{1,4}
    method border-width($/) { make $.list($/) }
    method decl:sym<border-width>($/) {
        make $._decl($0, $1, '[thin | medium | thick | <length>]{1,4}',
                     :expand<box>);

    }

    # - border-color: <color>{1,4}
    method decl:sym<border-color>($/) {
        make $._decl($0, $1, '<color>{1,4}', :expand<box>);
    }

    # - border-style: [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]{1,4}
    method border-style($/) { make $.list($/) }
    method decl:sym<border-style>($/) {
        make $._decl($0, $1, '[ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]{1,4}', :expand<box>);
    }

    # - border-top: <border-width> || <border-style> || <color>
    # - border-right: <border-width> || <border-style> || <color>
    # - border-bottom: <border-width> || <border-style> || <color>
    # - border-left: <border-width> || <border-style> || <color>   
    # - border: <border-width> || <border-style> || <color>
    method decl:sym<border-*>($/) {
        make $._decl($0, $1, '<border-width> || <border-style> || <color>');
    }

    # border: <border-width> || <border-style> || <color>
    method decl:sym<border>($/) {
        make $._decl($0, $1, q{[ <border-width> || <border-style> || <color> ]});
    }

    # - width: <length> | <percentage> | auto
    # - height: <length> | <percentage> | auto
    # - left: <length> | <percentage> | auto
    # - top: <length> | <percentage> | auto
    method decl:sym<width|height|left|top>($/) {
        make $._decl($0, $1, '<length> | <percentage> | auto');
    }

    # - float: left | right | none
    method decl:sym<float>($/) {
        make $._decl($0, $1, 'left | right | none');
    }

    # - clear: none | left | right | both
    method decl:sym<clear>($/) {
        make $._decl($0, $1, 'none | left | right | none');
    }

    # - display: block | inline | list-item | none
    method decl:sym<display>($/) {
        make $._decl($0, $1, 'block | inline | list-item | none');
    }

    # - white-space: normal | pre | nowrap    
    method decl:sym<white-space>($/) {
        make $._decl($0, $1, 'normal | pre | nowrap');
    }

    # - list-style-type: disc | circle | square | decimal | lower-roman | upper-roman | lower-alpha | upper-alpha | none
    method list-style-type($/) { make $.list($/) }
    method decl:sym<list-style-type>($/) {
        make $._decl($0, $1, 'disc | circle | square | decimal | lower-roman | upper-roman | lower-alpha | upper-alpha | none')
    }

    # - list-style-image: <url> | none
    method list-style-image($/) { make $.list($/) }
    method decl:sym<list-style-image>($/) {
        make $._decl($0, $1, '<url> | none');
    }

    # - list-style-position: inside | outside
    method list-style-position($/) { make $.list($/) }
    method decl:sym<list-style-position>($/) {
        make $._decl($0, $1, 'inside | outside');
    }

    # - list-style: <keyword> || <position> || <url>
    method decl:sym<list-style>($/) {
        make $._decl($0, $1, '<keyword> || <position> || <url>');
    }

    # - position: absolute | relative | static
    method decl:sym<position>($/) {
        make $._decl($0, $1, 'absolute | relative | static');
    }

    # - overflow: none | clip | scroll
    method decl:sym<overflow>($/) {
        make $._decl($0, $1, 'none | clip | scroll');
    }

    # - z-index: auto | <integer>
    method decl:sym<z-index>($/) {
        make $._decl($0, $1, 'auto | <integer>');
    }
}
