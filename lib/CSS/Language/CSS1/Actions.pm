use v6;

use CSS::Language::Actions;

class CSS::Language::CSS1::Actions
    is CSS::Language::Actions {

    # - font-family: [[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]
    method font-family($/) { make $.list($/) }
    method decl:sym<font-family>($/) {
        $._make_decl($/, '[[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]', :body($<font-family>));
    }

    # - font-style: normal | italic | oblique
    method font-style($/) { make $.token($<keyw>.ast) }
    method decl:sym<font-style>($/) {
        $._make_decl($/, 'normal | italic | oblique',
            :body($<font-style>));
    }

    # - font-variant: normal | small-caps
    method font-variant($/)  { make $.token($<keyw>.ast) }
    method decl:sym<font-variant>($/) {
        $._make_decl($/, 'normal | small-caps',
            :body($<font-variant>));
    }

    # - font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    method font-weight($/) { make $.token( ($<keyw> || $<number>).ast ) }
    method decl:sym<font-weight>($/) {
        $._make_decl($/, 'normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900',
                    :body($<font-weight>)); 
    }

    # - font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    method absolute-size($/) { make $.token($<keyw>.ast) }
    method relative-size($/) { make $.token($<keyw>.ast) }
    method font-size($/)     { make $.list($/) }
    method decl:sym<font-size>($/) {
        $._make_decl($/, '[[x]x-]small | medium | [[x]x\-]large | larger | smaller | <length> | <percentage>',
            :body($<font-size>));
    }

    method decl:sym<font>($/) {
        $._make_decl($/, '[ <font-style> || <font-variant> || <font-weight> ]? <font-size> [ / <line-height> ]? <font-family>');
    }

    # - color: <color>
    method decl:sym<color>($/) {
        $._make_decl($/, '<color>');
    }

    # - background-color: <color> | transparent
    method background-color($/) { make $.list($/) }
    method decl:sym<background-color>($/) {
        $._make_decl($/, '<color> | transparent', :body($<background-color>))
    };

    # - background-image: <url> | none
    method background-image($/) { make $.list($/) }
    method decl:sym<background-image>($/) {
        $._make_decl($/, '<uri> | none', :body($<background-image>))
    };

    # - background-repeat: repeat | repeat-x | repeat-y | no-repeat
    method background-repeat($/) { make $.list($/) }
    method decl:sym<background-repeat>($/) {
        $._make_decl($/, 'repeat | repeat-x | repeat-y | no-repeat', :body($<background-repeat>))
    };

    # - background-attachment: scroll | fixed
    method background-attachment($/) { make $.list($/) }
    method decl:sym<background-attachment>($/) {
        $._make_decl($/, 'scroll | fixed', :body($<background-attachment>));
    };

    # - background-position: [<percentage> | <length>]{1,2} | [top | center | bottom] || [left | center | right]
    method background-position($/) { make $.list($/) }
    method decl:sym<background-position>($/) {
        $._make_decl($/, '[<percentage> | <length> ]{1,2} | [top | center | bottom] || [left | center | right]',
            :body($<background-position>))
    };

    # - background: <background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position>
    method decl:sym<background>($/) {
        $._make_decl($/, '<background-color> || <background-image> || <background-repeat> || <background-attachment>');
    }

    # - letter-spacing: normal | <length>
    # - word-spacing: normal | <length>
    method decl:sym<*-spacing>($/) {
        $._make_decl($/, 'normal | <length>');
    }

    # - text-decoration: none | [ underline || overline || line-through || blink ]
    method decl:sym<text-decoration>($/) {
        $._make_decl($/, 'none | [ underline || overline || line-through || blink ]');
    }

    # - vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage>
     method decl:sym<vertical-align>($/) {
        $._make_decl($/, 'baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage>');
    }

    # - text-transform: capitalize | uppercase | lowercase | none
    method decl:sym<text-transform>($/) {
        $._make_decl($/, 'capitalize | uppercase | lowercase | none');
    }

    # - text-align: left | right | center | justify
    method decl:sym<text-align>($/) {
        $._make_decl($/, 'left | right | center | justify');
    }

    # - text-indent: <length> | <percentage>
    method decl:sym<text-indent>($/) {
        $._make_decl($/, '<length> | <percentage>');
    }

    # - line-height: normal | <number> | <length> | <percentage>
    method line-height($/) { make $.list($/); }
    method decl:sym<line-height>($/) {
        $._make_decl($/, 'normal | <number> | <length> | <percentage>', :body($<line-height>));
    }

    # - margin-top: <length> | <percentage> | auto
    # - margin-right: <length> | <percentage> | auto
    # - margin-bottom: <length> | <percentage> | auto
    # - margin-left: <length> | <percentage> | auto
    method margin($/) { make $.list($/); }
    method decl:sym<margin-*>($/) {
        $._make_decl($/, '<length> | <percentage> | auto');
    }

    # - margin: [ <length> | <percentage> | auto ]{1,4}
    method decl:sym<margin>($/) {
        $._make_decl($/, '[ <length> | <percentage> | auto ]{1,4}',
            :expand<box>);
    }

    # - padding-top: <length> | <percentage>
    # - padding-right: <length> | <percentage>
    # - padding-bottom: <length> | <percentage>
    # - padding-left: <length> | <percentage>
    method decl:sym<padding-*>($/) {
        $._make_decl($/, '<length> | <percentage>');
    }

    # - padding: [ <length> | <percentage> ]{1,4}
    method decl:sym<padding>($/) {
        $._make_decl($/, '[ <length> | <percentage> ]{1,4}',
                     :expand<box>);

    }

    # - border-top-width: thin | medium | thick | <length>
    # - border-right-width: thin | medium | thick | <length>
    # - border-bottom-width: thin | medium | thick | <length>
    # - border-left-width: thin | medium | thick | <length>
    method decl:sym<border-*-width>($/) {
        $._make_decl($/, 'thin | medium | thick | <length>');
    }

    # - border-width: [thin | medium | thick | <length>]{1,4}
    method border-width($/) { make $.list($/) }
    method decl:sym<border-width>($/) {
        $._make_decl($/, '[thin | medium | thick | <length>]{1,4}',
                     :body($<border-width>), :expand<box>);

    }

    # - border-color: <color>{1,4}
    method decl:sym<border-color>($/) {
        $._make_decl($/, '<color>{1,4}',
                     :expand<box>);
    }

    # - border-style: none | dotted | dashed | solid | double | groove | ridge | inset | outset
    method border-style($/) { make $.list($/) }
    method decl:sym<border-style>($/) {
        $._make_decl($/, 'none | dotted | dashed | solid | double | groove | ridge | inset | outset',
            :body($<border-style>));
    }

    # - border-top: <border-width> || <border-style> || <color>
    # - border-right: <border-width> || <border-style> || <color>
    # - border-bottom: <border-width> || <border-style> || <color>
    # - border-left: <border-width> || <border-style> || <color>   
    # - border: <border-width> || <border-style> || <color>
    method decl:sym<border-*>($/) {
        $._make_decl($/, '<border-width> || <border-style> || <color>');
    }

    # - width: <length> | <percentage> | auto
    # - height: <length> | <percentage> | auto
    # - left: <length> | <percentage> | auto
    # - top: <length> | <percentage> | auto
    method decl:sym<width|height|left|top>($/) {
        $._make_decl($/, '<length> | <percentage> | auto');
    }

    # - float: left | right | none
    method decl:sym<float>($/) {
        $._make_decl($/, 'left | right | none');
    }

    # - clear: none | left | right | both
    method decl:sym<clear>($/) {
        $._make_decl($/, 'none | left | right | none');
    }

    # - display: block | inline | list-item | none
    method decl:sym<display>($/) {
        $._make_decl($/, 'block | inline | list-item | none');
    }

    # - white-space: normal | pre | nowrap    
    method decl:sym<white-space>($/) {
        $._make_decl($/, 'normal | pre | nowrap');
    }

    # - list-style-type: disc | circle | square | decimal | lower-roman | upper-roman | lower-alpha | upper-alpha | none
    method list-style-type($/) { make $.list($/) }
    method decl:sym<list-style-type>($/) {
        $._make_decl($/, 'disc | circle | square | decimal | lower-roman | upper-roman | lower-alpha | upper-alpha | none',
                     :body($<list-style-type>) )         
    }

    # - list-style-image: <url> | none
    method list-style-image($/) { make $.list($/) }
    method decl:sym<list-style-image>($/) {
        $._make_decl($/, '<url> | none', :body($<list-style-image>) );
    }

    # - list-style-position: inside | outside
    method list-style-position($/) { make $.list($/) }
    method decl:sym<list-style-position>($/) {
        $._make_decl($/, 'inside | outside',  :body($<list-style-position>));
    }

    # - list-style: <keyword> || <position> || <url>
    method decl:sym<list-style>($/) {
        $._make_decl($/, '<keyword> || <position> || <url>');
    }

    # - position: absolute | relative | static
    method decl:sym<position>($/) {
        $._make_decl($/, 'absolute | relative | static');
    }

    # - overflow: none | clip | scroll
    method decl:sym<overflow>($/) {
        $._make_decl($/, 'none | clip | scroll');
    }

    # - z-index: auto | <integer>
    method decl:sym<z-index>($/) {
        $._make_decl($/, 'auto | <integer>');
    }
}
