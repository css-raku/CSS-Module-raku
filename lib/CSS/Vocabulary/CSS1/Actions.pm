use v6;

use CSS::Vocabulary::Actions;

class CSS::Vocabulary::CSS1::Actions
    is CSS::Vocabulary::Actions {

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

    method font-family($/) { make $.node($/) }
    method decl:sym<font-family>($/) {
        if $<font-family> {
            return make {property => 'font-family',
                         expr => [ $<font-family>.map({$_.ast}) ]
            }
        }
        $._make_decl($/, '[[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]');
    }

    method font-style($/) { make $.token($<ident>.ast) }
    method decl:sym<font-style>($/) {
        $._make_decl($/, 'normal | italic | oblique');
    }

    method font-variant($/) { make $.token($<ident>.ast) }
    method decl:sym<font-variant>($/) {
        $._make_decl($/, 'normal | small-caps');
    }

    method font-weight($/) { make $.token( ($<ident> || $<num>).ast ) }
    method decl:sym<font-weight>($/) {
        $._make_decl($/, 'normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900');
    }

    method absolute-size($/) { make $.token($<ident>.ast) }
    method relative-size($/) { make $.token($<ident>.ast) }
    method font-size($/)     { make $.node($/) }
    method decl:sym<font-size>($/) {
        $._make_decl($/, '[x?x-]small | medium | [x?x\-]large | larger | smaller | <length> | <percentage>',
            :body($<font-size>));
    }

    method decl:sym<font>($/) {
        $._make_decl($/, '[ <font-style> || <font-variant> || <font-weight> ]? <font-size> [ / <line-height> ]? <font-family>');
    }
    method decl:sym<color>($/) { warn "color - tba" }

    method background-color($/) { make $.node($/) }
    method decl:sym<background-color>($/) {
        $._make_decl($/, '<color> | transparent | inherit', :body($<background-color>))
    };

    method background-image($/) { make $.node($/) }
    method decl:sym<background-image>($/) {
        $._make_decl($/, '<uri> | none | inherit', :body($<background-image>))
    };

    method background-repeat($/) { make $.node($/) }
    method decl:sym<background-repeat>($/) {
        $._make_decl($/, 'repeat | repeat-x | repeat-y | no-repeat', :body($<background-repeat>))
    };

    method background-attachment($/) { make $.node($/) }
    method decl:sym<background-attachment>($/) {
        $._make_decl($/, 'scroll | fixed | inherit', :body($<background-attachment>));
    };

    method background-position($/) { make $.list($/) }
    method decl:sym<background-position>($/) {
        $._make_decl($/, '[<percentage> | <length>]{1,2} | [top | center | bottom] || [left | center | right]',
            :body($<background-position>))
    };

    method decl:sym<background>($/) {
        $._make_decl($/, '<background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position>');
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

    method line-height($/) { make $.node($/); }
    method decl:sym<line-height>($/) {
        $._make_decl($/, 'normal | <number> | <length> | <percentage>');
    }

    method margin($/) { make $.node($/); }
    method decl:sym<margin-*>($/) {
        $._make_decl($/, '<length> | <percentage> | auto');
    }

    method decl:sym<margin>($/) {
        $._make_decl($/, '[ <length> | <percentage> | auto ]{1,4}',
            :top_right_bottom_left(True));
    }

    method decl:sym<padding-*>($/) {
        $._make_decl($/, '<length> | <percentage>');
    }

    method decl:sym<padding>($/) {
        $._make_decl($/, '[ <length> | <percentage> ]{1,4}',
                     :top_right_bottom_left(True));

    }

    method decl:sym<border-*-width>($/) {
        $._make_decl($/, 'thin | medium | thick | <length>');
    }

    method decl:sym<border-width>($/) {
        $._make_decl($/, '[thin | medium | thick | <length>]{1,4}',
                     :top_right_bottom_left(True));

    }

    method decl:sym<border-color>($/) {
        $._make_decl($/, '<color>{1,4}',
                     :top_right_bottom_left(True));
    }

    method border-style($/) { make $.list($/) }
    method decl:sym<border-style>($/) {
        $._make_decl($/, 'none | dotted | dashed | solid | double | groove | ridge | inset | outset',
            :body($<border-style>));
    }

    method decl:sym<border-*>($/) {
        $._make_decl($/, '<border-width> || <border-style> || <color>');
    }

    method decl:sym<width>($/) {  warn "width - tba" }
    method decl:sym<height>($/) {  warn "height - tba" }
    method decl:sym<float>($/) { warn "float - tba" }
    method decl:sym<clear>($/) { warn "clear - tba" }
    method decl:sym<display>($/) { warn "display - tba" }
    method decl:sym<white-space>($/) { warn "white-space - tba" }
    method decl:sym<list-style-type>($/) { warn "list-style-type - tba" }
    method decl:sym<list-style-image>($/) { warn "list-style-image - tba" }
    method decl:sym<list-style-position>($/) { warn "list-style-position - tba" }
    method decl:sym<list-style>($/) { warn "list-style - tba" }
    method decl:sym<position>($/) { warn "position - tba" }
    method decl:sym<left>($/) { warn "left - tba" }
    method decl:sym<top>($/) { warn "top - tba" }
    method decl:sym<clip>($/) { warn "clip - tba" }
    method decl:sym<overflow>($/) { warn "overflow - tba" }
    method decl:sym<z-index>($/) { warn "z-index - tba" }
    method decl:sym<visibility>($/) { warn "visibility - tba" }
    method decl:sym<page-break-before>($/) { warn "page-break-before - tba" }
    method decl:sym<page-break-after>($/) { warn "page-break-after - tba" }
    method decl:sym<size>($/) { warn "size - tba" }
    method decl:sym<marks>($/) { warn "marks - tba" }


}
