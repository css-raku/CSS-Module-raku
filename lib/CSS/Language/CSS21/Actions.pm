use v6;

use CSS::Language::_Base::Actions;

class CSS::Language::CSS21::Actions
    is CSS::Language::_Base::Actions {

    has $._proforma-usage = ' | inherit';

    method color:sym<system>($/) { make $.node($/) }

    # --- Functions --- #

    #= usage: attr( attribute-name <type-or-unit>? )
    method attr($/)             {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.list($/);
    }

    #= usage: counter(ident [, ident [,...] ])
    method counter($/) {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.list($/);
    }

    #= usage: counters(ident [, "string"])
    method counters($/) {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.list($/);
    }

    #= usage: rect(<top>, <right>, <botom>, <left>)
    method shape($/)     {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.list($/);
    }
    method shape-arg($/) { make $.list($/) }

    method val($/) { make $.list($<expr> // $/) }

   # --- Properties --- #

    #= azimuth: <angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards'
    method decl:sym<azimuth>($/) {
        # see http://www.w3.org/TR/2011/REC-CSS2-20110607/aural.html
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method azimuth($/) {
        my $ast = $.node($/);

        # compute implied angles
        my $angle;

        if my $direction = $ast<direction> || $ast<behind> {

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

            my $bh = $ast<behind> ?? 1 !! 0;

            $angle = {angle => $.token(%angles{$direction}[$bh], :type<angle>, :units<degrees> )};
	}
        elsif $ast<delta> {
            my $delta_angle = $ast<delta> eq 'leftwards' ?? -20 !! 20;
            $angle = {turn => $.token($delta_angle, :type<angle>, :units<degrees> )};
        }
	else {
	    $angle = $ast;
	}

        make [$angle];
    }


    #= background-attachment: scroll | fixed
    method decl:sym<background-attachment>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    };
    method background-attachment($/) { make $.list($/) }

    #= background-color: <color> | transparent
    method decl:sym<background-color>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY)
    };
    method background-color($/) { make $.list($/) }

    #= background-image: <url> | none
    method decl:sym<background-image>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY)
    };
    method background-image($/) { make $.list($/) }

    # - background-position: [ [ <percentage> | <length> | left | center | right ] [ <percentage> | <length> | top | center | bottom ]? ] | [ [ left | center | right ] || [ top | center | bottom ] ]
    # refactored as
    #= background-position:[ <percentage> | <length> | left | center | right ] || [ <percentage> | <length> | top | center | bottom ]
    method decl:sym<background-position>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method position($/) { make $.list($/) }

    #= background-repeat: repeat | repeat-x | repeat-y | no-repeat
    method decl:sym<background-repeat>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY)
    };
    method background-repeat($/) { make $.list($/) }

    #= background: [<background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position>]
    method decl:sym<background>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= border-collapse: collapse | separate
    method decl:sym<border-collapse>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= border-color: [ <color> | transparent ]{1,4}
    method decl:sym<border-color>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY, :expand<box>);
    }
    method border-color($/) { make $.list($/) }
    
    #= border-spacing: <length> <length>?
    method decl:sym<border-spacing>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= border-top|border-right|border-bottom|border-left: [ <border-width> || <border-style> || 'border-top-color' ]
    method decl:sym<border-*>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= border-top-color|border-right-color|border-bottom-color|border-left-color: <color> | transparent
    method decl:sym<border-*-color>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= border-top-style|border-right-style|border-bottom-style|border-left-style: <border-style>
    method decl:sym<border-*-style>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= border-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]{1,4}
    method decl:sym<border-style>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY, :expand<box>);
    }
    method border-style($/) { make $.list($/) }

    #= border-top-width|border-right-width|border-bottom-width|border-left-width: <border-width>
    method decl:sym<border-*-width>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= border-width: <border-width>{1,4}
    method decl:sym<border-width>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY, :expand<box>);
    }
    method border-width($/) { make $.list($/) }

    #= border: <border-width> || <border-style> || 'border-top-color'
    method decl:sym<border>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= bottom: <length> | <percentage> | auto
    method decl:sym<bottom>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= caption-side: top | bottom
    method decl:sym<caption-side>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= clear: none | left | right | both
    method decl:sym<clear>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= clip: <shape> | auto
    method decl:sym<clip>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= color: <color>
    method decl:sym<color>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= content: normal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+
    method decl:sym<content>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= couunter-increment, counter-reset: [ <identifier> <integer>? ]+ | none
    method decl:sym<counter-[increment|reset]>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    method cue($/) { make $.list($/) }
    #= cue-before, cue-after: <uri> | none
    method decl:sym<cue-[before|after]>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= cue: [ 'cue-before' || 'cue-after' ]
    method decl:sym<cue>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= cursor: [ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ]
    method decl:sym<cursor>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= direction: ltr | rtl
    method decl:sym<direction>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= display: inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none
    method decl:sym<display>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= elevation: <angle> | below | level | above | higher | lower
    method decl:sym<elevation>($/) {
        # see http://www.w3.org/TR/2011/REC-CSS2-20110607/aural.html
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method elevation($/) {
        my $ast = $.node($/);

        my $angle;

        if my $direction = $ast<direction> {

            state %angles = (
                'below'    => -90,
                'level'    =>   0,
                'above'    =>  90,
                );

            $angle = {angle => $.token(%angles{$direction}, :type<angle>, :units<degrees> )};
        }
        elsif $ast<tilt> {
            my $delta_angle = $ast<tilt> eq 'lower' ?? -10 !! 10;
            $angle = {tilt => $.token($delta_angle, :type<angle>, :units<degrees> )};
        }
	else {
	    $angle = $ast;
	}

        make [$angle];
    }

    #= empty-cells: show | hide
    method decl:sym<empty-cells>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= float: left | right | none
    method decl:sym<float>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= font-family: [[ <family-name> | <generic-family> ] [, <family-name> | <generic-family> ]* ]
    method decl:sym<font-family>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method font-family($/) { make $.list($/) }

    #= font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    method decl:sym<font-size>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method absolute-size($/) { make $.token($<keyw>.ast) }
    method relative-size($/) { make $.token($<keyw>.ast) }
    method font-size($/)     { make $.list($/) }

    #= font-style: normal | italic | oblique
    method decl:sym<font-style>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method font-style($/) { make $.list($/) }

    #= font-variant: normal | small-caps
    method decl:sym<font-variant>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method font-variant($/) { make $.list($/) }

    #= font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    method decl:sym<font-weight>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY); 
    }
    method font-weight($/) { make $.list($/) }

    #= font: [ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family' ] | caption | icon | menu | message-box | small-caption | status-bar
    method decl:sym<font>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= width, height, left, right: <length> | <percentage> | auto
    method decl:sym<width|height|left|top>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= letter-spacing, word-spacing: normal | <length>
    method decl:sym<*-spacing>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= line-height: normal | <number> | <length> | <percentage>
    method decl:sym<line-height>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method line-height($/) { make $.list($/); }

    #= list-style-image: <uri> | none
    method decl:sym<list-style-image>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method list-style-image($/) { make $.list($/) }

    #= list-style-position: inside | outside
    method decl:sym<list-style-position>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method list-style-position($/) { make $.list($/) }

    #= list-style-type: disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none
    method decl:sym<list-style-type>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method list-style-type($/) { make $.list($/) }

    #= list-style: [ 'list-style-type' || 'list-style-position' || 'list-style-image' ]
    method decl:sym<list-style>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= margin-right, margin-left, margin-top, margin-bottom: <margin-width>
    method decl:sym<margin-*>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method margin-width($/) { make $.list($/) }

    #= margin: <margin-width>{1,4}
    method decl:sym<margin>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY, :expand<box>);
    }

    #= max-height, max-width: <length> | <percentage> | none
    method decl:sym<max-[width|height]>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= min-height, min-width: <length> | <percentage>
    method decl:sym<min-[width|height]>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= opacity: <number>
    method decl:sym<opacity>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= orphans: <integer>
    method decl:sym<orphans>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= outline-color: <color> | invert
    method decl:sym<outline-color>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method outline-color($/) { make $.list($/) }

    #= outline-style: <border-style>
    method decl:sym<outline-style>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= outline-width: <border-width>
    method decl:sym<outline-width>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= outline: [ 'outline-color' || 'outline-style' || 'outline-width' ]
    method decl:sym<outline>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= overflow: visible | hidden | scroll | auto
    method decl:sym<overflow>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= padding-top|padding-right|padding-bottom|padding-left: <padding-width>
    method decl:sym<padding-*>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method padding-width($/) { make $.list($/) }

    #= padding: <padding-width>{1,4}
    method decl:sym<padding>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY, :expand(<box>));
    }

    #= page-break-after, page-break-before: auto | always | avoid | left | right
    method decl:sym<page-break-[before|after]>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= page-break-inside: avoid | auto
    method decl:sym<page-break-inside>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= pause-after, pause-before: <time> | <percentage>
    method decl:sym<pause-[before|after]>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method pause($/) { make $.list($/) }

    #= pause: [ [<time> | <percentage>]{1,2} ]
    method decl:sym<pause>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= pitch-range: <number>
    method decl:sym<pitch-range>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= pitch: <frequency> | x-low | low | medium | high | x-high
    method decl:sym<pitch>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= play-during: <uri> [ mix || repeat ]? | auto | none
    method decl:sym<play-during>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= position: static | relative | absolute | fixed
    method decl:sym<position>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= quotes: [<string> <string>]+ | none
    method decl:sym<quotes>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= richness: <number>
    method decl:sym<richness>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= right: <length> | <percentage> | auto
    method decl:sym<right>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= size: <length>{1,2} | auto | portrait | landscape
    method decl:sym<size>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= speak-header: once | always
    method decl:sym<speak-header>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= speak-numeral: digits | continuous
    method decl:sym<speak-numeral>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= speak-punctuation: code | none
     method decl:sym<speak-punctuation>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= speak: normal | none | spell-out
    method decl:sym<speak>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= speech-rate: <number> | x-slow | slow | medium | fast | x-fast | faster | slower
    method decl:sym<speech-rate>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= stress: <number>
    method decl:sym<stress>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= table-layout: auto | fixed
    method decl:sym<table-layout>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= text-align: left | right | center | justify
    method decl:sym<text-align>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= text-decoration: none | [ underline || overline || line-through || blink ]
    method decl:sym<text-decoration>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= text-indent: <length> | <percentage>
    method decl:sym<text-indent>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= text-transform: capitalize | uppercase | lowercase | none
    method decl:sym<text-transform>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= unicode-bidi: normal | embed | bidi-override
    method decl:sym<unicode-bidi>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length>
    method decl:sym<vertical-align>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= visibility: visible | hidden | collapse
    method decl:sym<visibility>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= voice-family: [[<specific-voice> | <generic-voice> ],]* [<specific-voice> | <generic-voice> ]
    method decl:sym<voice-family>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }
    method generic-voice($/) { make $.list($/) }
    method specific-voice($/) { make $.list($/) }

    #= volume: <number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud
    method decl:sym<volume>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= white-space: normal | pre | nowrap | pre-wrap | pre-line
    method decl:sym<white-space>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= widows: <integer>
    method decl:sym<widows>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= z-index: auto | <integer>
    method decl:sym<z-index>($/) {
        make $._decl($0, $<val>, &?ROUTINE.WHY);
    }

}
