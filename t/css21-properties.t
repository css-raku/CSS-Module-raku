#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS21;
use CSS::Language::CSS21::Actions;

use CSS::Language::CSS3;

use lib '.';
use t::AST;

my $css21_actions = CSS::Language::CSS21::Actions.new;
my $css3_actions = CSS::Language::CSS3::Actions.new;

my %seen;

for (
    {prop => 'azimuth', decl => '30deg', expr => ["angle" => 30],
    },
    {prop => 'Azimuth', decl => 'far-right',
     expr => ["direction" => "far-right", "_implied" => "angle" => 60],
    },
    {prop => 'azimuth', decl => 'center-left behind',  
     expr => ["direction" => "center-left", "behind" => "behind",
     "_implied" => "angle" => 200],
    },
    {prop => 'AZIMUTH', decl => 'Rightwards',
     expr => ["delta" => "rightwards",
     "_implied" => "delta" => 20],
    },
    {prop => 'azimuth', decl => 'inherit', expr => [inherit => True],
    },
    {prop => 'background-attachment', decl => 'FiXed', expr => [keyw => 'fixed'],
    },
    {prop => 'Background-Attachment', decl => 'inherit', expr => [inherit => True],
    },
    {prop => 'background-color', decl => '#37a', expr => [color => {r => 0x33, g => 0x77, b => 0xAA}],
    },
    {prop => 'background-image', decl => 'url(images/ok.png)', expr => [url => 'images/ok.png'],
    },
    {prop => 'background-repeat', decl => 'Repeat-x', expr => [keyw => 'repeat-x'],
    },
    {prop => 'background-position', decl => '100% 90%', expr => [["percentage" => 100, "percentage" => 90]],
    },
    {prop => 'border-collapse', decl => 'separate', expr => [keyw => 'separate'],
    },
    {prop => 'border-spacing', decl => '3em', expr => [length => 3],
    },
    {prop => 'border-bottom', decl => 'thick dotted red',
     expr => ["border-width" => ["keyw" => "thick"],
              "border-style" => ["keyw" => "dotted"],
              "border-color" => ["color" => {"r" => 255, "g" => 0, "b" => 0}]],
    },
    {prop => 'border-collapse', decl => 'collapse', expr => [keyw => 'collapse'],
    },
    {prop => 'border-spacing', decl => '2px .1cm', expr => [length => 2, length => .1],
    },
    {prop => 'border-right-color', decl => 'green', expr => [color => {r => 0, g => 128, b => 0}],
    },
    {prop => 'border-style', decl => 'dotted dashed',
     box => ["top" => ["keyw" => "dotted"],
             "right" => ["keyw" => "dashed"],
             "bottom" => ["keyw" => "dotted"],
             "left" => ["keyw" => "dashed"]],
    },
    {prop => 'border-bottom-style', decl => 'outset',  expr => [keyw => 'outset'],
    },
    {prop => 'bottom', decl => '5%', expr => [percentage => 5],
    },
    {prop => 'caption-side', decl => 'top', expr => [keyw => 'top'],
    },
    {prop => 'clip', decl => 'rect(5px, 40px, auto, 5px)',
     expr => ["shape" => {"top" => {"length" => 5},
                          "right" => {"length" => 40},
                          "bottom" => {"keyw" => "auto"},
                          "left" => {"length" => 5}}],
    },
    {prop => 'content', decl => '"Section " counter(Section) ". "',  
     expr => ["string" => "Section ",
                "counter" => ["identifier" => "Section"],
                "string" => ". "],
    },
    {prop => 'content', decl => '"Section " counters(Section)',  
     expr => ["string" => "Section ",
                "counters" => ["identifier" => "Section"],
                         ],
    },
    {prop => 'counter-increment', decl => 'section 5',
     expr => [identifier => "section", integer => 5],
    },
    {prop => 'counter-increment', decl => 'None', expr => [keyw => 'none'],
    },
    {prop => 'counter-reset', decl => 'section 10',
     expr => [identifier => "section", integer => 10],
    },
    {prop => 'cue-before', decl => 'url("quack.wav")', expr => ["uri" => "quack.wav"],
    },   
    {prop => 'cue-after', decl => 'url("woof.wav")', expr => ["uri" => "woof.wav"],
    },   
    {prop => 'cue', decl => 'none url("woof.wav")',
     expr => ["cue-before" => ["keyw" => "none"],
                "cue-after" => ["uri" => "woof.wav"]],
    },  
    {prop => 'cursor', decl => 'e-resize', expr => [keyw => "e-resize"],
    },
    {prop => 'direction', decl => 'LTR', expr => [keyw => "ltr"],
    },
    {prop => 'display', decl => 'inline-table', expr => [keyw => "inline-table"],
    },
    {prop => 'elevation', decl => '65DEG',
     expr => ["angle" => 65],
    },
    {prop => 'elevation', decl => 'above',
     expr => ["direction" => "above", _implied => angle => 90],
    },
    {prop => 'elevation', decl => 'LOWER',
     expr => ["tilt" => "lower", _implied => delta => -10],
    },
    {prop => 'empty-cells', decl => 'show',
     expr => [keyw => "show"],
    },
    {prop => 'margin', decl => 'inherit',
     box => ["top" => ["inherit" => Bool::True],
             "right" => ["inherit" => Bool::True],
             "bottom" => ["inherit" => Bool::True],
             "left" => ["inherit" => Bool::True]],
    },
    {prop => 'max-width', decl => '30%', expr => [percentage => "30"],
    },
    {prop => 'orphans', decl => '3', expr => [integer => 3],
    },
    {prop => 'outline-color', decl => 'olive',
     expr => ["color" => {"r" => 128, "g" => 128, "b" => 0}],
    },
    {prop => 'outline-style', decl => 'groove', expr => [keyw => "groove"],
    },
    {prop => 'outline-width', decl => '2em', expr => [length => 2],
    },
    {prop => 'outline', decl => '#00FF00 dotted thick',
     expr => ["outline-color" => ["color" => {"r" => 0, "g" => 255, "b" => 0}],
                "outline-style" => ["keyw" => "dotted"],
                "outline-width" => ["keyw" => "thick"]],
    },
    {prop => 'page-break-after', decl => 'auto', expr => ["keyw" => "auto"],
    },
    {prop => 'page-break-inside', decl => 'avoid', expr => ["keyw" => "avoid"],
    },
    {prop => 'pause-before', decl => '10s', expr => ["time" => "10"],
    },
    {prop => 'pause', decl => '2s 5s',
     expr => ["pause-before" => ["time" => 2],
                "pause-after" => ["time" => 5]],
    },
    {prop => 'pitch-range', decl => '10', expr => ["number" => "10"],
    },
    {prop => 'play-during', decl => 'url(test.wav) mix', expr => ["uri" => "test.wav", keyw => "mix"],
    },
    {prop => 'quotes', decl => '"<" ">"', expr => [string => "<", string => ">"],
    },
    {prop => 'richness', decl => '10', expr => ["number" => "10"],
    },
    {prop => 'right', decl => '15%', expr => ["percentage" => "15"],
    },
    {prop => 'size', decl => '3ex', expr => ["length" => 3],
    },
    {prop => 'speak-header', decl => 'always', expr => ["keyw" => "always"],
    },
    {prop => 'speak-punctuation', decl => 'code', expr => ["keyw" => "code"],
    },
    {prop => 'speak', decl => 'normal', expr => ["keyw" => "normal"],
    },
    {prop => 'speech-rate', decl => 'fast', expr => ["keyw" => "fast"],
    },
    {prop => 'stress', decl => '42', expr => ["number" => 42],
    },
    {prop => 'table-layout', decl => 'fixed', expr => ["keyw" => "fixed"],
    },
    {prop => 'unicode-bidi', decl => 'embed', expr => ["keyw" => "embed"],
    },
    {prop => 'visibility', decl => 'hidden', expr => ["keyw" => "hidden"],
    },
    {prop => 'voice-family', decl => 'juliet, female',
     expr => ["specific-voice" => ["identifier" => "juliet"],
                "generic-voice" => ["keyw" => "female"]],
    },
    {prop => 'VOLUME', decl => 'LOUD', expr => ["keyw" => "loud"],
    },
    {prop => 'widows', decl => '3', expr => ["integer" => 3],
    },
   ) {

    my %test = %$_;
    my $prop = %test<prop>;

    my %declarations;

    if %test<box> {
        for @(%test<box>) {
            my ($edge, $val) = $_.kv;
            %declarations{$prop.lc ~ '-' ~ $edge} = {expr => $val}
        }
    }
    else {
        %declarations{ $prop.lc } = {expr => %test<expr>};
    }

    %declarations<_implied> = %test<_implied> if %test<_implied>;
    %test<ast> = %declarations;

    my $input = $prop ~ ':' ~ %test<decl>;

    $css21_actions.reset;
    my $p21 = CSS::Language::CSS21.parse( $input, :rule('declaration-list'), :actions($css21_actions));
    t::AST::parse_tests($input, $p21, :rule('decl'), :suite('css21'),
                         :warnings($css21_actions.warnings),
                         :expected(%test) );

    $css3_actions.reset;
    my $p3 = CSS::Language::CSS3.parse( $input, :rule('declaration-list'), :actions($css3_actions));
    t::AST::parse_tests($input, $p3, :rule('decl'), :suite('css3'),
                         :warnings($css3_actions.warnings),
                         :expected(%test) );

   unless %seen{$prop.lc}++ {
        # usage and inheritence  tests
        my $junk = $prop ~ ': junk "x" 42';

        $css21_actions.reset;
        $p21 = CSS::Language::CSS21.parse( $junk, :rule('declaration-list'), :actions($css21_actions));
        is($p21.Str, $junk, "$prop: able to parse unexpected input");

        ok($css21_actions.warnings, "$prop : unexpected input produces warning")
            or diag $css21_actions.warnings;

        for <inherit initial> -> $misc {
            my $decl = $prop ~ ': ' ~ $misc;

            my @_expr = ($misc => True);

            my %ast = %test<box>
                ?? <top right bottom left>.map({($prop.lc ~ '-' ~ $_) => [expr => @_expr]})
                !! ($prop.lc => [expr => @_expr]);

            unless $misc eq 'initial' { # applicable to css3 only
                $css21_actions.reset;
                $p21 = CSS::Language::CSS21.parse( $decl, :rule('declaration-list'), :actions($css21_actions));

                t::AST::parse_tests($decl, $p21, :rule('decl'), :suite('css21'),
                                    :warnings($css21_actions.warnings),
                                    :expected({ast => %ast}) );
            }

            $css3_actions.reset;
            $p3 = CSS::Language::CSS3.parse( $decl, :rule('declaration-list'), :actions($css3_actions));

            t::AST::parse_tests($decl, $p3, :rule('decl'), :suite('css3'),
                                :warnings($css3_actions.warnings),
                                :expected({ast => %ast}) );
        }
   }
}

done;
