use v6;

use CSS::Language::_Base::Actions;

class CSS::Language::CSS21::Actions
    is CSS::Language::_Base::Actions {

    has $._proforma-usage = ' | inherit';

    method color:sym<system>($/) { make $.node($/) }

    # --- Functions --- #

    method attr($/)             {
        return $.warning('usage: attr( attribute-name <type-or-unit>? )')
            if $<any-args>;
        make $.node($/);
    }

    method counter($/) {
        return $.warning('usage: counter(ident [, ident [,...] ])')
            if $<any-args>;
        make $.list($/);
    }

    method counters($/) {
        return $.warning('usage: counters(ident [, "string"])')
            if $<any-args>;
        make $.node($/);
    }

    method shape-arg($/) { make $.node($/) }
    method shape($/)     {
        return $.warning('usage: rect(<top>, <right>, <botom>, <left>)')
            if $<any-args>;
        make $.node($/);
    }

    # experimental rule
    method val($/) { make $.list($<expr> // $/) }

   # --- Properties --- #

    # - azimuth: <angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards
    method azimuth($/) {
        my %ast = $.node($/);

        # compute implied angles
        my $angle;

        if my $direction = %ast<direction> || %ast<behind> {

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

            my $bh = %ast<behind> ?? 1 !! 0;

            $angle = (angle => $.token(%angles{$direction}[$bh], :type<angle>, :units<degrees> ));
            }
        elsif %ast<delta> {
            my $delta_angle = %ast<delta> eq 'leftwards' ?? -20 !! 20;
            $angle = (turn => $.token($delta_angle, :type<angle>, :units<degrees> ));
        }

        make $angle // %ast;
    }

    method decl:sym<azimuth>($/) {
        # see http://www.w3.org/TR/2011/REC-CSS2-20110607/aural.html
        make $._decl($0, $<val>, 'usage azimuth: <angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards');
    }

    # - background-attachment: scroll | fixed
    method background-attachment($/) { make $.list($/) }
    method decl:sym<background-attachment>($/) {
        make $._decl($0, $<val>, 'scroll | fixed');
    };

    # - background-color: <color> | transparent
    method background-color($/) { make $.list($/) }
    method decl:sym<background-color>($/) {
        make $._decl($0, $<val>, '<color> | transparent')
    };

    # - background-image: <url> | none
    method background-image($/) { make $.list($/) }
    method decl:sym<background-image>($/) {
        make $._decl($0, $<val>, '<uri> | none')
    };

    # - background-position: [ [ <percentage> | <length> | left | center | right ] [ <percentage> | <length> | top | center | bottom ]? ] | [ [ left | center | right ] || [ top | center | bottom ] ]
    # refactored as [ <percentage> | <length> | left | center | right ] || [ <percentage> | <length> | top | center | bottom ]
    method position($/) { make $.list($/) }
    method decl:sym<background-position>($/) {
        make $._decl($0, $<val>, q{[ <percentage> | <length> | left | center | right ] || [ <percentage> | <length> | top | center | bottom ]});
    }

    # - background-repeat: repeat | repeat-x | repeat-y | no-repeat
    method background-repeat($/) { make $.list($/) }
    method decl:sym<background-repeat>($/) {
        make $._decl($0, $<val>, 'repeat | repeat-x | repeat-y | no-repeat')
    };

    # - background: <background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position>
     method decl:sym<background>($/) {
        make $._decl($0, $<val>, q{['background-color' || 'background-image' || 'background-repeat' || 'background-attachment' || 'background-position']});
    }

    # - border-collapse: collapse | separate
    method decl:sym<border-collapse>($/) {
        make $._decl($0, $<val>, q{collapse | separate});
    }

    # - border-color: [ <color> | transparent ]{1,4}
    method border-color($/) { make $.list($/) }
    method decl:sym<border-color>($/) {
        make $._decl($0, $<val>, q{[ <color> | transparent ]{1,4}},
                     :expand<box>);
    }
    
    # - border-spacing: <length> <length>?
    method decl:sym<border-spacing>($/) {
        make $._decl($0, $<val>, q{<length> <length>?});
    }

    # - border-top|border-right|border-bottom|border-left: [ <border-width> || <border-style> || 'border-top-color' ]
    method decl:sym<border-*>($/) {
        make $._decl($0, $<val>, q{[ <border-width> || <border-style> || 'border-color' ]});
    }

    # - border-top-color|border-right-color|border-bottom-color|border-left-color: <color> | transparent
    method decl:sym<border-*-color>($/) {
        make $._decl($0, $<val>, q{<color> | transparent});
    }

    # - border-top-style|border-right-style|border-bottom-style|border-left-style: <border-style>
    method decl:sym<border-*-style>($/) {
        make $._decl($0, $<val>, q{<border-style>});
    }

    # - border-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]{1,4}
    method border-style($/) { make $.list($/) }
    method decl:sym<border-style>($/) {
        make $._decl($0, $<val>, '[ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]{1,4}', :expand<box>);
    }

    # - border-top-width|border-right-width|border-bottom-width|border-left-width: <border-width>
    method decl:sym<border-*-width>($/) {
        make $._decl($0, $<val>, q{<border-width>});
    }

    # - border-width: <border-width>{1,4}
    method border-width($/) { make $.list($/) }
    method decl:sym<border-width>($/) {
        make $._decl($0, $<val>, q{<border-width>{1,4}},
                     :expand<box>);
    }

    # border: <border-width> || <border-style> || 'border-top-color'
    method decl:sym<border>($/) {
        make $._decl($0, $<val>, q{[ <border-width> || <border-style> || 'border-top-color' ]});
    }

    # - bottom: <length> | <percentage> | auto
    method decl:sym<bottom>($/) {
        make $._decl($0, $<val>, q{<length> | <percentage> | auto});
    }

    # - caption-side: top | bottom
    method decl:sym<caption-side>($/) {
        make $._decl($0, $<val>, q{top | bottom});
    }

    # - clear: none | left | right | both
    method decl:sym<clear>($/) {
        make $._decl($0, $<val>, 'none | left | right | none');
    }

    # - clip: <shape> | auto
    method decl:sym<clip>($/) {
        make $._decl($0, $<val>, ' <shape> | auto | inehrit');
    }

    # - color: <color>
    method decl:sym<color>($/) {
        make $._decl($0, $<val>, '<color>');
    }

    # - content: normal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+
    method decl:sym<content>($/) {
        make $._decl($0, $<val>, q{normal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+});
    }

    # - counter-increment: [ <identifier> <integer>? ]+ | none
    # - counter-reset: [ <identifier> <integer>? ]+ | none
    method decl:sym<counter-[increment|reset]>($/) {
        make $._decl($0, $<val>, q{[ <identifier> <integer>? ]+ | none});
    }

    method cue($/) { make $.list($/) }
    # - cue-before: <uri> | none
    # - cue-after: <uri> | none
    method decl:sym<cue-[before|after]>($/) {
        make $._decl($0, $<val>, q{<uri> | none});
    }

    # - cue: [ 'cue-before' || 'cue-after' ]
    method decl:sym<cue>($/) {
        make $._decl($0, $<val>, q{[ 'cue-before' || 'cue-after' ]});
    }

    # - cursor: [ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ]
    method decl:sym<cursor>($/) {
        make $._decl($0, $<val>, q{[ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ]});
    }

    # - direction: ltr | rtl
    method decl:sym<direction>($/) {
        make $._decl($0, $<val>, q{ltr | rtl});
    }

    # - display: inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none
    method decl:sym<display>($/) {
        make $._decl($0, $<val>, q{inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none});
    }

    method elevation($/) {
        my %ast = $.node($/);

        my $angle;

        if my $direction = %ast<direction> {

            state %angles = (
                'below'    => -90,
                'level'    =>   0,
                'above'    =>  90,
                );

            $angle = (angle => $.token(%angles{$direction}, :type<angle>, :units<degrees> ));
        }
        elsif %ast<tilt> {
            my $delta_angle = %ast<tilt> eq 'lower' ?? -10 !! 10;
            $angle = (tilt => $.token($delta_angle, :type<angle>, :units<degrees> ));
        }

        make $angle // %ast;
    }

    # - elevation: <angle> | below | level | above | higher | lower
    method decl:sym<elevation>($/) {
        # see http://www.w3.org/TR/2011/REC-CSS2-20110607/aural.html
        make $._decl($0, $<val>, '<angle> | below | level | above | higher | lower');

    }

    # - empty-cells: show | hide
    method decl:sym<empty-cells>($/) {
        make $._decl($0, $<val>, q{show | hide});
    }

    # - float: left | right | none
    method decl:sym<float>($/) {
        make $._decl($0, $<val>, 'left | right | none');
    }

    # - font-family: [[ <family-name> | <generic-family> ] [, <family-name> | <generic-family> ]* ]
    method font-family($/) { make $.list($/) }
    method decl:sym<font-family>($/) {
        make $._decl($0, $<val>, '[[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]');
    }

    # - font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    method absolute-size($/) { make $.token($<keyw>.ast) }
    method relative-size($/) { make $.token($<keyw>.ast) }
    method font-size($/)     { make $.list($/) }
    method decl:sym<font-size>($/) {
        make $._decl($0, $<val>, '[[x]x-]small | medium | [[x]x\-]large | larger | smaller | <length> | <percentage>');
    }

    # - font-style: normal | italic | oblique
    method font-style($/) { make $.node($/) }
    method decl:sym<font-style>($/) {
        make $._decl($0, $<val>, 'normal | italic | oblique');
    }

    # - font-variant: normal | small-caps
    method font-variant($/) { make $.node($/) }
    method decl:sym<font-variant>($/) {
        make $._decl($0, $<val>, 'normal | small-caps');
    }

    # - font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    method font-weight($/) { make $.node($/) }
    method decl:sym<font-weight>($/) {
        make $._decl($0, $<val>, 'normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900'); 
    }

    # - font: [ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family' ] | caption | icon | menu | message-box | small-caption | status-bar
    method decl:sym<font>($/) {
        make $._decl($0, $<val>, q{[ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family' ] | caption | icon | menu | message-box | small-caption | status-bar});
    }

    # - width: <length> | <percentage> | auto
    # - height: <length> | <percentage> | auto
    # - left: <length> | <percentage> | auto
    # - right: <length> | <percentage> | auto
    method decl:sym<width|height|left|top>($/) {
        make $._decl($0, $<val>, '<length> | <percentage> | auto');
    }

    # - letter-spacing: normal | <length>
    # - word-spacing: normal | <length>
    method decl:sym<*-spacing>($/) {
        make $._decl($0, $<val>, 'normal | <length>');
    }

    # - line-height: normal | <number> | <length> | <percentage>
    method line-height($/) { make $.list($/); }
    method decl:sym<line-height>($/) {
        make $._decl($0, $<val>, 'normal | <number> | <length> | <percentage>');
    }

    # - list-style-image: <uri> | none
    method list-style-image($/) { make $.list($/) }
    method decl:sym<list-style-image>($/) {
        make $._decl($0, $<val>, q{<uri> | none});
    }

    # - list-style-position: inside | outside
    method list-style-position($/) { make $.list($/) }
    method decl:sym<list-style-position>($/) {
        make $._decl($0, $<val>, 'inside | outsideed');
    }

    # - list-style-type: disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none
    method list-style-type($/) { make $.list($/) }
    method decl:sym<list-style-type>($/) {
        make $._decl($0, $<val>, q{disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none});
    }

    # - list-style: [ 'list-style-type' || 'list-style-position' || 'list-style-image' ]
    method decl:sym<list-style>($/) {
        make $._decl($0, $<val>, q{[ 'list-style-type' || 'list-style-position' || 'list-style-image' ]});
    }

    # - margin-right|margin-left: <margin-width>
    # - margin-top|margin-bottom: <margin-width>
    method margin-width($/) { make $.list($/) }
    method decl:sym<margin-*>($/) {
        make $._decl($0, $<val>, q{<margin-width>});
    }

    # - margin: <margin-width>{1,4}
    method decl:sym<margin>($/) {
        make $._decl($0, $<val>, q{<margin-width>{1,4}},
                     :expand<box>);
    }

    # - max-height: <length> | <percentage> | none
    # - max-width: <length> | <percentage> | none
    method decl:sym<max-[width|height]>($/) {
        make $._decl($0, $<val>, q{<length> | <percentage> | none});
    }

    # - min-height: <length> | <percentage>
    # - min-width: <length> | <percentage>
    method decl:sym<min-[width|height]>($/) {
        make $._decl($0, $<val>, q{<length> | <percentage>});
    }

    # - opacity: <number>
    method decl:sym<opacity>($/) {
        make $._decl($0, $<val>, q{<number>});
    }

    # - orphans: <integer>
    method decl:sym<orphans>($/) {
        make $._decl($0, $<val>, q{<integer>});
    }

    # - outline-color: <color> | invert
    method outline-color($/) { make $.list($/) }
    method decl:sym<outline-color>($/) {
        make $._decl($0, $<val>, q{<color> | invert});
    }

    # - outline-style: <border-style>
    method decl:sym<outline-style>($/) {
        make $._decl($0, $<val>, q{<border-style>});
    }

    # - outline-width: <border-width>
    method decl:sym<outline-width>($/) {
        make $._decl($0, $<val>, q{<border-width>});
    }

    # - outline: [ 'outline-color' || 'outline-style' || 'outline-width' ]
    method decl:sym<outline>($/) {
        make $._decl($0, $<val>, q{[ 'outline-color' || 'outline-style' || 'outline-width' ]});
    }

    # - overflow: visible | hidden | scroll | auto
    method decl:sym<overflow>($/) {
        make $._decl($0, $<val>, q{visible | hidden | scroll | auto});
    }

    method padding-width($/) { make $.list($/) }
    # - padding-top|padding-right|padding-bottom|padding-left: <padding-width>
    method decl:sym<padding-*>($/) {
        make $._decl($0, $<val>, q{<padding-width>});
    }

    # - padding: <padding-width>{1,4}
     method decl:sym<padding>($/) {
        make $._decl($0, $<val>, q{<padding-width>{1,4}},
                     :expand(<box>));
    }

    # - page-break-after: auto | always | avoid | left | right
    # - page-break-before: auto | always | avoid | left | right
    method decl:sym<page-break-[before|after]>($/) {
        make $._decl($0, $<val>, q{auto | always | avoid | left | right});
    }

    # - page-break-inside: avoid | auto
    method decl:sym<page-break-inside>($/) {
        make $._decl($0, $<val>, q{avoid | auto});
    }

    method pause($/) { make $.list($/) }
    # - pause-after: <time> | <percentage>
    # - pause-before: <time> | <percentage>
    method decl:sym<pause-[before|after]>($/) {
        make $._decl($0, $<val>, q{<time> | <percentage>});
    }

    # - pause: [ [<time> | <percentage>]{1,2} ]
    method decl:sym<pause>($/) {
        make $._decl($0, $<val>, q{[ [<time> | <percentage>]{1,2} ]});
    }

    # - pitch-range: <number>
    method decl:sym<pitch-range>($/) {
        make $._decl($0, $<val>, q{<number>});
    }

    # - pitch: <frequency> | x-low | low | medium | high | x-high
    method decl:sym<pitch>($/) {
        make $._decl($0, $<val>, q{<frequency> | x-low | low | medium | high | x-high});
    }

    # - play-during: <uri> [ mix || repeat ]? | auto | none
    method decl:sym<play-during>($/) {
        make $._decl($0, $<val>, q{<uri> [ mix || repeat ]? | auto | none});
    }

    # - position: static | relative | absolute | fixed
    method decl:sym<position>($/) {
        make $._decl($0, $<val>, q{static | relative | absolute | fixed});
    }

    # - quotes: [<string> <string>]+ | none
    method decl:sym<quotes>($/) {
        make $._decl($0, $<val>, q{[<string> <string>]+ | none});
    }

    # - richness: <number>
    method decl:sym<richness>($/) {
        make $._decl($0, $<val>, q{<number>});
    }

    # - right: <length> | <percentage> | auto
    method decl:sym<right>($/) {
        make $._decl($0, $<val>, q{<length> | <percentage> | auto});
    }

    # - size: <length>{1,2} | auto | portrait | landscape
    method decl:sym<size>($/) {
        make $._decl($0, $<val>, '<length>{1,2} | auto | portrait | landscape');
    }

    # - speak-header: once | always
    method decl:sym<speak-header>($/) {
        make $._decl($0, $<val>, q{once | always});
    }

    # - speak-numeral: digits | continuous
    method decl:sym<speak-numeral>($/) {
        make $._decl($0, $<val>, q{digits | continuous});
    }

    # - speak-punctuation: code | none
     method decl:sym<speak-punctuation>($/) {
        make $._decl($0, $<val>, q{code | none});
    }

    # - speak: normal | none | spell-out
    method decl:sym<speak>($/) {
        make $._decl($0, $<val>, q{normal | none | spell-out});
    }

    # - speech-rate: <number> | x-slow | slow | medium | fast | x-fast | faster | slower
    method decl:sym<speech-rate>($/) {
        make $._decl($0, $<val>, q{<number> | x-slow | slow | medium | fast | x-fast | faster | slower});
    }

    # - stress: <number>
    method decl:sym<stress>($/) {
        make $._decl($0, $<val>, q{<number>});
    }

    # - table-layout: auto | fixed
    method decl:sym<table-layout>($/) {
        make $._decl($0, $<val>, q{auto | fixed});
    }

    # - text-align: left | right | center | justify
    method decl:sym<text-align>($/) {
        make $._decl($0, $<val>, 'left | right | center | justify');
    }

    # - text-decoration: none | [ underline || overline || line-through || blink ]
    method decl:sym<text-decoration>($/) {
        make $._decl($0, $<val>, 'none | [ underline || overline || line-through || blink ]');
    }

    # - text-indent: <length> | <percentage>
    method decl:sym<text-indent>($/) {
        make $._decl($0, $<val>, '<length> | <percentage>');
    }

    # - text-transform: capitalize | uppercase | lowercase | none
    method decl:sym<text-transform>($/) {
        make $._decl($0, $<val>, 'capitalize | uppercase | lowercase | none');
    }

    # - unicode-bidi: normal | embed | bidi-override
    method decl:sym<unicode-bidi>($/) {
        make $._decl($0, $<val>, q{normal | embed | bidi-override});
    }

    # - vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length>
    method decl:sym<vertical-align>($/) {
        make $._decl($0, $<val>, q{baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length>});
    }

    # - visibility: visible | hidden | collapse
    method decl:sym<visibility>($/) {
        make $._decl($0, $<val>, q{visible | hidden | collapse});
    }

    # - voice-family: [[<specific-voice> | <generic-voice> ],]* [<specific-voice> | <generic-voice> ]
    method generic-voice($/) { make $.list($/) }
    method specific-voice($/) { make $.list($/) }
    method decl:sym<voice-family>($/) {
        make $._decl($0, $<val>, q{[[<specific-voice> | <generic-voice> ],]* [<specific-voice> | <generic-voice> ]});
    }

    # - volume: <number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud
    method decl:sym<volume>($/) {
        make $._decl($0, $<val>, q{<number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud});
    }

    # - white-space: normal | pre | nowrap | pre-wrap | pre-line
    method decl:sym<white-space>($/) {
        make $._decl($0, $<val>, q{normal | pre | nowrap | pre-wrap | pre-line});
    }

    # - widows: <integer>
    method decl:sym<widows>($/) {
        make $._decl($0, $<val>, q{<integer>});
    }

    # - z-index: auto | <integer>
    method decl:sym<z-index>($/) {
        make $._decl($0, $<val>, 'auto | <integer>');
    }

}
