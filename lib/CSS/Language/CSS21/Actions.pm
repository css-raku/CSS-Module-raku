use v6;

use CSS::Language::Actions;
use CSS::Grammar::Actions;

class CSS::Language::CSS21::Actions
    is CSS::Language::Actions {

    # --- Functions --- #

    method any_function($/)             {
        $.warning('unknown function', $<ident>.ast.lc);
    }

    method function:sym<attr>($/)             {
        return $.warning('usage: attr( attribute-name <type-or-unit>? [, <fallback> ]? )')
            if $<any_args>;
        make {ident => 'attr', args => $.list($/)}
    }

    method function:sym<counter>($/) {
        return $.warning('usage: counter(ident [, ident [,...] ])')
            if $<any_args>;
        make {ident => 'counter', args => $.list($/)}
    }

    method function:sym<counters>($/) {
        return $.warning('usage: counters(ident [, "string"])')
            if $<any_args>;
        make {ident => 'counters', args => $.list($/)}
    }

    # --- Properties --- #

   method decl:sym<azimuth>($/) {
        # see http://www.w3.org/TR/2011/REC-CSS2-20110607/aural.html

        return $.warning('usage azimuth: <angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards | inherit')
            if $<any_args>;

        my %ast;
        %ast<property> = $0.Str.trim.lc;

        if $<inherit> {
            %ast<inherit> = True;
        }
        else {
            my @expr;
            if $<angle> {
                @expr = (<angle> => $<angle>.ast);
            }
            elsif $<lr> || $<bh> {

                state %angles = (
                    'left-side'    => [270, 270],
                    'far-left'     => [300, 240],
                    'left'         => [320, 220],
                    'center-left'  => [340, 200],
                    'center'       => [0,   180],
                    'center-right' => [20,  160],
                    'right'        => [40,  140],
                    'far-right'    => [60,  120],
                    'right-side'   => [90,  90],
                    'behind'       => [180, 180],
                    );

                my $keyw = $<lr>.ast || 'behind';
                my $bh = $<behind> ?? 1 !! 0;

                @expr = (angle => $.token(%angles{$keyw}[$bh], :type<angle>, :units<degrees> ));
            }
            elsif $<delta> {
                my $delta_angle = $<dl> ?? -20 !! 20;
                @expr = (<delta> => $.token($delta_angle, :type<angle>, :units<degrees> ));
            }

            %ast<expr> = @expr;
        }

        make %ast;
    }

    method background-attachment($/) { make $.list($/) }
    method decl:sym<background-attachment>($/) {
        $._make_decl($/, 'scroll | fixed | inherit', :body($<background-attachment>));
    };

    method background-color($/) { make $.list($/) }
    method decl:sym<background-color>($/) {
        $._make_decl($/, '<color> | transparent | inherit', :body($<background-color>))
    };

    method background-image($/) { make $.list($/) }
    method decl:sym<background-image>($/) {
        $._make_decl($/, '<uri> | none | inherit', :body($<background-image>))
    };

    method background-position($/) { make $.list($/) }
    method decl:sym<background-position>($/) {
        $._make_decl($/, q{[ <percentage> | <length> | left | center | right ] || [ <percentage> | <length> | top | center | bottom ] | inherit}, :body($<background-position>));
    }

    method background-repeat($/) { make $.list($/) }
    method decl:sym<background-repeat>($/) {
        $._make_decl($/, 'repeat | repeat-x | repeat-y | no-repeat | inherit', :body($<background-repeat>))
    };

    method decl:sym<background>($/) {
        $._make_decl($/, q{['background-color' || 'background-image' || 'background-repeat' || 'background-attachment' || 'background-position'] | inherit});
    }

    method decl:sym<border-collapse>($/) {
        $._make_decl($/, q{collapse | separate | inherit});
    }

    method border-color($/) { make $.list($/) }
    method decl:sym<border-color>($/) {
        $._make_decl($/, q{[ <color> | transparent ]{1,4} | inherit},
            :body($<border-color>), :expand<box>);
    }
    
    method decl:sym<border-spacing>($/) {
        $._make_decl($/, q{<length> <length>? | inherit});
    }

    # - border-top|border-right|border-bottom|border-left: [ <border-width> || <border-style> || 'border-top-color' ] | inherit
    method decl:sym<border-*>($/) {
        $._make_decl($/, q{[ <border-width> || <border-style> || 'border-color' ] | inherit});
    }

    # - border-top-color|border-right-color|border-bottom-color|border-left-color: <color> | transparent | inherit
    method decl:sym<border-*-color>($/) {
        $._make_decl($/, q{<color> | transparent | inherit},
            :body($<border-color>));
    }

    # - border-top-style|border-right-style|border-bottom-style|border-left-style: <border-style> | inherit
    method decl:sym<border-*-style>($/) {
        $._make_decl($/, q{<border-style> | inherit},
                     :body($<border-style>));
    }

    method border-style($/) { make $.list($/) }
    method decl:sym<border-style>($/) {
        $._make_decl($/, 'none | dotted | dashed | solid | double | groove | ridge | inset | outset | inherit',
            :body($<border-style>));
    }

    # - border-top-width|border-right-width|border-bottom-width|border-left-width: <border-width> | inherit
    method decl:sym<border-*-width>($/) {
        $._make_decl($/, q{<border-width> | inherit}, :body($<border-width>));
    }

    method border-width($/) { make $.list($/) }
    method decl:sym<border-width>($/) {
        $._make_decl($/, q{<border-width>{1,4} | inherit},
                     :body($<border-width>), :expand<box>);
    }

    # border_width: thin | medium | thick | <length>  -- inherited

    method decl:sym<border>($/) {
        $._make_decl($/, q{[ <border-width> || <border-style> || 'border-top-color' ] | inherit});
    }

    method decl:sym<bottom>($/) {
        $._make_decl($/, q{<length> | <percentage> | auto | inherit});
    }

    method decl:sym<caption-side>($/) {
        $._make_decl($/, q{top | bottom | inherit});
    }

    method decl:sym<clear>($/) {
        $._make_decl($/, 'none | left | right | none');
    }

    method decl:sym<clip>($/) {
        $._make_decl($/, ' <shape> | auto | inehrit');
    }

    method decl:sym<color>($/) {
        $._make_decl($/, '<color> | inherit');
    }

    method decl:sym<content>($/) {
        $._make_decl($/, q{normal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+ | inherit});
    }

    method decl:sym<counter-increment>($/) {
        $._make_decl($/, q{[ <identifier> <integer>? ]+ | none | inherit});
    }

    method decl:sym<counter-reset>($/) {
        $._make_decl($/, q{[ <identifier> <integer>? ]+ | none | inherit});
    }

    method decl:sym<cue-after>($/) {
        $._make_decl($/, q{<uri> | none | inherit});
    }

    method decl:sym<cue-before>($/) {
        $._make_decl($/, q{<uri> | none | inherit});
    }

    method decl:sym<cue>($/) {
        $._make_decl($/, q{[ 'cue-before' || 'cue-after' ] | inherit});
    }

    method decl:sym<cursor>($/) {
        $._make_decl($/, q{[ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ] | inherit});
    }

    method decl:sym<direction>($/) {
        $._make_decl($/, q{ltr | rtl | inherit});
    }

    method decl:sym<display>($/) {
        $._make_decl($/, q{inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none | inherit});
    }

    method decl:sym<elevation>($/) {
        # see http://www.w3.org/TR/2011/REC-CSS2-20110607/aural.html

        return $.warning('usage elevation: <angle> | below | level | above | higher | lower | inherit')
            if $<any_args>;

        my %ast;
        %ast<property> = $0.Str.trim.lc;

        if $<inherit> {
            %ast<inherit> = True;
        }
        else {
            my @expr;

            if $<angle> {
                @expr = (<angle> => $<angle>.ast);
            }
            elsif $<tilt> {

                state %angles = (
                    'below'    => -90,
                    'level'    =>   0,
                    'above'    =>  90,
                    );

                my $keyw = $<tilt>.Str.trim.lc;
                @expr = (angle => $.token(%angles{$keyw}, :type<angle>, :units<degrees> ));
            }
            elsif $<delta> {
                my $delta_angle = $<dl> ?? -10 !! 10;
                @expr = (delta => $.token($delta_angle, :type<angle>, :units<degrees> ));
            }
            %ast<expr> = @expr;
        }

        make %ast;
    }

    method decl:sym<empty-cells>($/) {
        $._make_decl($/, q{show | hide | inherit});
    }

    method decl:sym<float>($/) {
        $._make_decl($/, 'left | right | none');
    }

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

    method font-weight($/) { make $.token( ($<ident> || $<number>).ast ) }
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
        $._make_decl($/, q{[ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family' ] | caption | icon | menu | message-box | small-caption | status-bar | inherit});
    }

    method decl:sym<width|height|left|top>($/) {
        $._make_decl($/, '<length> | <percentage> | auto');
    }

    # - letter-spacing: normal | <length>
    # - word-spacing: normal | <length>
    method decl:sym<*-spacing>($/) {
        $._make_decl($/, 'normal | <length>');
    }

    method line-height($/) { make $.list($/); }
    method decl:sym<line-height>($/) {
        $._make_decl($/, 'normal | <number> | <length> | <percentage>');
    }

    method list-style-image($/) { make $.list($/) }
    method decl:sym<list-style-image>($/) {
        $._make_decl($/, q{<uri> | none | inherit},
                     :body($<list-style-image>) );
    }

    method list-style-position($/) { make $.list($/) }
    method decl:sym<list-style-position>($/) {
        $._make_decl($/, 'inside | outside | inherited',  :body($<list-style-position>));
    }

    method list-style-type($/) { make $.list($/) }
    method decl:sym<list-style-type>($/) {
        $._make_decl($/, q{disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none | inherit},
                     :body($<list-style-type>) );
    }

    method decl:sym<list-style>($/) {
        $._make_decl($/, q{[ 'list-style-type' || 'list-style-position' || 'list-style-image' ] | inherit});
    }

    # - margin-right|margin-left: <margin-width> | inherit
    # - margin-top|margin-bottom: <margin-width> | inherit
    method margin-width($/) { make $.list($/) }
    method decl:sym<margin-*>($/) {
        $._make_decl($/, q{<margin-width> | inherit}, :body($<margin-width>));
    }

    method decl:sym<margin>($/) {
        $._make_decl($/, q{<margin-width>{1,4} | inherit},
                     :body($<margin-width>), :expand<box>);
    }

    method decl:sym<marks>($/) {
        $._make_decl($/, 'crop || cross | none');
    }

    method decl:sym<max-[width|height]>($/) {
        $._make_decl($/, q{<length> | <percentage> | none | inherit});
    }

    method decl:sym<min-[width|height]>($/) {
        $._make_decl($/, q{<length> | <percentage> | inherit});
    }

    method decl:sym<orphans>($/) {
        $._make_decl($/, q{<integer> | inherit});
    }

    method decl:sym<outline-color>($/) {
        $._make_decl($/, q{<color> | invert | inherit});
    }

    method decl:sym<outline-style>($/) {
        $._make_decl($/, q{<border-style> | inherit});
    }

    method decl:sym<outline-width>($/) {
        $._make_decl($/, q{<border-width> | inherit});
    }

    method decl:sym<outline>($/) {
        $._make_decl($/, q{[ 'outline-color' || 'outline-style' || 'outline-width' ] | inherit});
    }

    method decl:sym<overflow>($/) {
        $._make_decl($/, q{visible | hidden | scroll | auto | inherit});
    }

    # - padding-top|padding-right|padding-bottom|padding-left: <padding-width> | inherit
    method decl:sym<padding-*>($/) {
        $._make_decl($/, q{<padding-width> | inherit}, :body($<padding-width>));
    }

    method padding-width($/) { make $.list($/) }
    method decl:sym<padding>($/) {
        $._make_decl($/, q{<padding-width>{1,4} | inherit},
                     :body($<padding-width>), :expand(<box>));
    }

    method decl:sym<page-break-[before|after]>($/) {
        $._make_decl($/, q{auto | always | avoid | left | right | inherit});
    }

    method decl:sym<page-break-inside>($/) {
        $._make_decl($/, q{avoid | auto | inherit});
    }

    method decl:sym<pause-[before|after]>($/) {
        $._make_decl($/, q{<time> | <percentage> | inherit});
    }

    method decl:sym<pause>($/) {
        $._make_decl($/, q{[ [<time> | <percentage>]{1,2} ] | inherit});
    }

    method decl:sym<pitch-range>($/) {
        $._make_decl($/, q{<number> | inherit});
    }

    method decl:sym<pitch>($/) {
        $._make_decl($/, q{<frequency> | x-low | low | medium | high | x-high | inherit});
    }

    method decl:sym<play-during>($/) {
        $._make_decl($/, q{<uri> [ mix || repeat ]? | auto | none | inherit});
    }

    method decl:sym<position>($/) {
        $._make_decl($/, q{static | relative | absolute | fixed | inherit});
    }

    method decl:sym<quotes>($/) {
        $._make_decl($/, q{[<string> <string>]+ | none | inherit});
    }

    method decl:sym<richness>($/) {
        $._make_decl($/, q{<number> | inherit});
    }

    method decl:sym<right>($/) {
        $._make_decl($/, q{<length> | <percentage> | auto | inherit});
    }

    method decl:sym<speak-header>($/) {
        $._make_decl($/, q{once | always | inherit});
    }

    method decl:sym<speak-numeral>($/) {
        $._make_decl($/, q{digits | continuous | inherit});
    }

    method decl:sym<speak-punctuation>($/) {
        $._make_decl($/, q{code | none | inherit});
    }

    method decl:sym<speak>($/) {
        $._make_decl($/, q{normal | none | spell-out | inherit});
    }

    method decl:sym<speech-rate>($/) {
        $._make_decl($/, q{<number> | x-slow | slow | medium | fast | x-fast | faster | slower | inherit});
    }

    method decl:sym<stress>($/) {
        $._make_decl($/, q{<number> | inherit});
    }

    method decl:sym<table-layout>($/) {
        $._make_decl($/, q{auto | fixed | inherit});
    }

    method decl:sym<text-align>($/) {
        $._make_decl($/, 'left | right | center | justify | inherit');
    }

    method decl:sym<text-decoration>($/) {
        $._make_decl($/, 'none | [ underline || overline || line-through || blink ]');
    }

    method decl:sym<text-indent>($/) {
        $._make_decl($/, '<length> | <percentage>');
    }

    method decl:sym<text-transform>($/) {
        $._make_decl($/, 'capitalize | uppercase | lowercase | none');
    }

    method decl:sym<unicode-bidi>($/) {
        $._make_decl($/, q{normal | embed | bidi-override | inherit});
    }

    method decl:sym<vertical-align>($/) {
        $._make_decl($/, q{baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length> | inherit});
    }

    method decl:sym<visibility>($/) {
        $._make_decl($/, q{visible | hidden | collapse | inherit});
    }

    method decl:sym<voice-family>($/) {
        $._make_decl($/, q{[[<specific-voice> | <generic-voice> ],]* [<specific-voice> | <generic-voice> ] | inherit});
    }

    method decl:sym<volume>($/) {
        $._make_decl($/, q{<number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud | inherit});
    }

    method decl:sym<white-space>($/) {
        $._make_decl($/, q{normal | pre | nowrap | pre-wrap | pre-line | inherit});
    }

    method decl:sym<widows>($/) {
        $._make_decl($/, q{<integer> | inherit});
    }

    method decl:sym<size>($/) {
        $._make_decl($/, '<length>{1,2} | auto | portrait | landscape');
    }

    method decl:sym<z-index>($/) {
        $._make_decl($/, 'auto | <integer>');
    }

}
