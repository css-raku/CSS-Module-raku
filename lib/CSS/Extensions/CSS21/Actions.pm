use v6;

use CSS::Extensions::CSS1::Actions;

class CSS::Extensions::CSS21::Actions
    is CSS::Extensions::CSS1::Actions {

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

                my $keyw = $<lr>.Str.trim.lc || 'behind';
                my $bh = $<bh>.Str ?? 1 !! 0;

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

# -- background: <background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position>  -- inherited

# -- background-attachment: scroll | fixed | inherit  -- inherited

# -- background-color: <color> | transparent | inherit  -- inherited

# -- background-image: <uri> | none | inherit  -- inherited

# -- background-position: 
    method decl:sym<background-position>($/) {
        $._make_decl($/, q{[ <percentage> | <length> | left | center | right ] || [ <percentage> | <length> | top | center | bottom ] | inherit}, :body($<background-position>));
    }

# -- background-repeat: repeat | repeat-x | repeat-y | no-repeat | inherit  -- inherited

    method decl:sym<background>($/) {
        $._make_decl($/, q{['background-color' || 'background-image' || 'background-repeat' || 'background-attachment' || 'background-position'] | inherit});
    }

    method decl:sym<border-collapse>($/) {
        $._make_decl($/, q{collapse | separate | inherit});
    }

    method decl:sym<border-color>($/) {
        $._make_decl($/, q{[ <color> | transparent ]{1,4} | inherit},
                     :expand<box>);
    }

    method decl:sym<border-spacing>($/) {
        $._make_decl($/, q{<length> <length>? | inherit});
    }

    method decl:sym<border-style>($/) {
        $._make_decl($/, q{<border-style>{1,4} | inherit},
                     :body($<border-style>), :expand<box>);
    }

    # * = top|right|bottom|left
    method decl:sym<border-*>($/) {
        $._make_decl($/, q{[ <border-width> || <border-style> || 'border-top-color' ] | inherit});
    }

    # * = top|right|bottom|left
    method decl:sym<border-*-color>($/) {
        $._make_decl($/, q{<color> | transparent | inherit});
    }

    # * = top|right|bottom|left
    method decl:sym<border-*-style>($/) {
        $._make_decl($/, q{<border-style> | inherit});
    }

    # * = top|right|bottom|left
    method decl:sym<border-*-width>($/) {
        $._make_decl($/, q{<border-width> | inherit});
    }

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

# -- clear: none | left | right | both | inherit  -- inherited

    method decl:sym<clip>($/) {
        $._make_decl($/, ' <shape> | auto');
    }

# -- color: <color> | inherit  -- inherited

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

# -- float: left | right | none | inherit  -- inherited

# -- font-family: [[ <family-name> | <generic-family> ] [, <family-name> | <generic-family> ]* ] | inherit  -- inherited

# -- font-size: <absolute-size> | <relative-size> | <length> | <percentage> | inherit  -- inherited

# -- font-style: normal | italic | oblique | inherit  -- inherited

# -- font-variant: normal | small-caps | inherit  -- inherited

# -- font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 | inherit  -- inherited

    method decl:sym<font>($/) {
        $._make_decl($/, q{[ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family' ] | caption | icon | menu | message-box | small-caption | status-bar | inherit},
                     :expand<family>);
    }

# -- height: <length> | <percentage> | auto | inherit  -- inherited

# -- left: <length> | <percentage> | auto | inherit  -- inherited

# -- letter-spacing: normal | <length> | inherit  -- inherited

# -- line-height: normal | <number> | <length> | <percentage> | inherit  -- inherited

    method decl:sym<list-style-image>($/) {
        $._make_decl($/, q{<uri> | none | inherit},
                     :body($<list-style-image>) );
    }

# -- list-style-position: inside | outside | inherit  -- inherited

    method decl:sym<list-style-type>($/) {
        $._make_decl($/, q{disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none | inherit},
                     :body($<list-style-type>) );
    }

    method decl:sym<list-style>($/) {
        $._make_decl($/, q{[ 'list-style-type' || 'list-style-position' || 'list-style-image' ] | inherit});
    }

    # * = top|bottom|left|right
    method decl:sym<margin-*>($/) {
        $._make_decl($/, q{<margin-width> | inherit});
    }

    method decl:sym<margin>($/) {
        $._make_decl($/, q{<margin-width>{1,4} | inherit},
                     :expand<box>);
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

    # * = top|bottom|left|right
    method decl:sym<padding-*>($/) {
        $._make_decl($/, q{<padding-width> | inherit});
    }

    method decl:sym<padding>($/) {
        $._make_decl($/, q{<padding-width>{1,4} | inherit},
                     :expand(<box>));
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

# -- text-align: left | right | center | justify | inherit  -- inherited

# -- text-decoration: none | [ underline || overline || line-through || blink ] | inherit  -- inherited

# -- text-indent: <length> | <percentage> | inherit  -- inherited

# -- text-transform: capitalize | uppercase | lowercase | none | inherit  -- inherited

# -- top: <length> | <percentage> | auto | inherit  -- inherited

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

# -- width: <length> | <percentage> | auto | inherit  -- inherited

# -- word-spacing: normal | <length> | inherit  -- inherited

# -- z-index: auto | <integer> | inherit  -- inherited

}
