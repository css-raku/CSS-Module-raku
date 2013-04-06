use v6;

use CSS::Vocabulary::Actions;

class CSS::Vocabulary::CSS1::Actions
    is CSS::Vocabulary::Actions {

    method length:sym<num>($/) {
        my $num = $<num>.ast;

        return $.warning('number not followed by a length unit', $<num>.Str)
            if $num && $.strict;

        make $.token($num, :type<length>, :units<px>)
    }

    method named-color($/) {
        state %colors = (
            black   => [   0,   0,   0 ],
            silver  => [ 192, 192, 192 ],
            gray    => [ 128, 128, 128 ],
            white   => [ 255, 255, 255 ],
            maroon  => [ 128,   0,   0 ],
            red     => [ 255,   0,   0 ],
            purple  => [ 128,   0, 128 ],
            fuchsia => [ 255,   0, 255 ],
            green   => [   0, 128,   0 ],
            lime    => [   0, 255,   0 ],
            olive   => [ 128, 128,   0 ],
            yellow  => [ 255, 255,   0 ],
            navy    => [   0,   0, 128 ],
            blue    => [   0,   0, 255 ],
            teal    => [   0, 128, 128 ],
            aqua    => [   0, 255, 255 ],
            );

        my $color_name = $<ident>.ast;
        my $color = %colors{$color_name}
        or die  "unknown color: " ~ $color_name;

        my %rgb; %rgb<r g b> = @$color;
        make $.token(%rgb, :type<color>, :units<rgb>);
    }

    method color:sym<named>($/) { make $<named-color>.ast }

    method font-family($/) { make $.list($/) }
    method decl:sym<font-family>($/) {
        $._make_decl($/, '[[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]', :body($<font-family>));
    }

    method font-style($/) { make $.token($<ident>.ast) }
    method decl:sym<font-style>($/) {
        $._make_decl($/, 'normal | italic | oblique',
            :body($<font-style>));
    }

    method font-variant($/) { make $.token($<ident>.ast) }
    method decl:sym<font-variant>($/) {
        $._make_decl($/, 'normal | small-caps',
            :body($<font-variant>));
    }

    method font-weight($/) { make $.token( ($<ident> || $<num>).ast ) }
    method decl:sym<font-weight>($/) {
        $._make_decl($/, 'normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900',
                    :body($<font-weight>)); 
    }

    method absolute-size($/) { make $.token($<ident>.ast) }
    method relative-size($/) { make $.token($<ident>.ast) }
    method font-size($/)     { make $.list($/) }
    method decl:sym<font-size>($/) {
        $._make_decl($/, '[[x]x-]small | medium | [[x]x\-]large | larger | smaller | <length> | <percentage>',
            :body($<font-size>));
    }

    method decl:sym<font>($/) {
        $._make_decl($/, '[ <font-style> || <font-variant> || <font-weight> ]? <font-size> [ / <line-height> ]? <font-family>',
                     :expand<family>);
    }
    method decl:sym<color>($/) {
        $._make_decl($/, '<color>');
    }

    method background-color($/) { make $.list($/) }
    method decl:sym<background-color>($/) {
        $._make_decl($/, '<color> | transparent | inherit', :body($<background-color>))
    };

    method background-image($/) { make $.list($/) }
    method decl:sym<background-image>($/) {
        $._make_decl($/, '<uri> | none | inherit', :body($<background-image>))
    };

    method background-repeat($/) { make $.list($/) }
    method decl:sym<background-repeat>($/) {
        $._make_decl($/, 'repeat | repeat-x | repeat-y | no-repeat', :body($<background-repeat>))
    };

    method background-attachment($/) { make $.list($/) }
    method decl:sym<background-attachment>($/) {
        $._make_decl($/, 'scroll | fixed | inherit', :body($<background-attachment>));
    };

    method background-position($/) { make $.list($/) }
    method decl:sym<background-position>($/) {
        $._make_decl($/, '[<percentage> | <length>]{1,2} | [top | center | bottom] || [left | center | right]',
            :body($<background-position>))
    };

    method decl:sym<background>($/) {
        $._make_decl($/, '<background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position>',
                     :expand<family>);
    }

    method decl:sym<*-spacing>($/) {
        $._make_decl($/, 'normal | <length>');
    }

    method decl:sym<text-decoration>($/) {
        $._make_decl($/, 'none | [ underline || overline || line-through || blink ]');
    }

    method decl:sym<vertical-align>($/) {
        $._make_decl($/, 'baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage>');
    }

    method decl:sym<text-transform>($/) {
        $._make_decl($/, 'capitalize | uppercase | lowercase | none');
    }

    method decl:sym<text-align>($/) {
        $._make_decl($/, 'left | right | center | justify');
    }

    method decl:sym<text-indent>($/) {
        $._make_decl($/, '<length> | <percentage>');
    }

    method line-height($/) { make $.list($/); }
    method decl:sym<line-height>($/) {
        $._make_decl($/, 'normal | <number> | <length> | <percentage>');
    }

    method margin($/) { make $.list($/); }
    method decl:sym<margin-*>($/) {
        $._make_decl($/, '<length> | <percentage> | auto');
    }

    method decl:sym<margin>($/) {
        $._make_decl($/, '[ <length> | <percentage> | auto ]{1,4}',
            :expand<box>);
    }

    method decl:sym<padding-*>($/) {
        $._make_decl($/, '<length> | <percentage>');
    }

    method decl:sym<padding>($/) {
        $._make_decl($/, '[ <length> | <percentage> ]{1,4}',
                     :expand<box>);

    }

    method decl:sym<border-*-width>($/) {
        $._make_decl($/, 'thin | medium | thick | <length>');
    }

    method border-width($/) { make $.list($/) }
    method decl:sym<border-width>($/) {
        $._make_decl($/, '[thin | medium | thick | <length>]{1,4}',
                     :body($<border-width>), :expand<box>);

    }

    method decl:sym<border-color>($/) {
        $._make_decl($/, '<color>{1,4}',
                     :expand<box>);
    }

    method border-style($/) { make $.list($/) }
    method decl:sym<border-style>($/) {
        $._make_decl($/, 'none | dotted | dashed | solid | double | groove | ridge | inset | outset',
            :body($<border-style>));
    }

    method decl:sym<border-*>($/) {
        $._make_decl($/, '<border-width> || <border-style> || <color>');
    }

    method decl:sym<width|height|left|top>($/) {
        $._make_decl($/, '<length> | <percentage> | auto');
    }

    method decl:sym<float>($/) {
        $._make_decl($/, 'left | right | none');
    }

    method decl:sym<clear>($/) {
        $._make_decl($/, 'none | left | right | none');
    }

    method decl:sym<display>($/) {
        $._make_decl($/, 'block | inline | list-item | none');
    }

    method decl:sym<white-space>($/) {
        $._make_decl($/, 'normal | pre | nowrap');
    }

    method list-style-type($/) { make $.list($/) }
    method decl:sym<list-style-type>($/) {
        $._make_decl($/, 'disc | circle | square | decimal | lower-roman | upper-roman | lower-alpha | upper-alpha | none',
                     :body($<list-style-type>) )         
    }

    method list-style-image($/) { make $.list($/) }
    method decl:sym<list-style-image>($/) {
        $._make_decl($/, '<url> | none', :body($<list-style-image>) );
    }

    method list-style-position($/) { make $.list($/) }
    method decl:sym<list-style-position>($/) {
        $._make_decl($/, 'inside | outside',  :body($<list-style-position>));
    }

    method decl:sym<list-style>($/) {
        $._make_decl($/, '<keyword> || <position> || <url>', :expand<family> );
    }

    method decl:sym<position>($/) {
        $._make_decl($/, 'absolute | relative | static');
    }

    method decl:sym<overflow>($/) {
        $._make_decl($/, 'none | clip | scroll');
    }

    # only occurence of an integer token so far
    method integer($/) { make $/.Int }
    method decl:sym<z-index>($/) {
        $._make_decl($/, 'auto | <integer>');
    }

    method decl:sym<visibility>($/) {
        $._make_decl($/, 'inherit | visible | hidden');
    }

    method decl:sym<page-break-*>($/) {
        $._make_decl($/, 'auto | allways | left | right');
    }

    method decl:sym<size>($/) {
        $._make_decl($/, '<length>{1,2} | auto | portrait | landscape');
    }

    method decl:sym<marks>($/) {
        $._make_decl($/, 'crop || cross | none');
    }
}
