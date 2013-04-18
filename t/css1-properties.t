#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS1::Actions;
use CSS::Language::CSS1;

use CSS::Language::CSS21::Actions;
use CSS::Language::CSS21;

use lib '.';
use t::AST;

my $css1_actions = CSS::Language::CSS1::Actions.new;
my $css21_actions = CSS::Language::CSS21::Actions.new;

my %seen;

for (
    {prop => 'background-color ', decl => '#37a', ast => {property => 'background-color', expr => [color => {r => 0x33, g => 0x77, b => 0xAA}]},
    },
    {prop => 'background-image ', decl => 'url(images/ok.png)', ast => {property => 'background-image', expr => [url => 'images/ok.png']},
    },
    {prop => 'background-repeat ', decl => 'Repeat-x', ast => {property => 'background-repeat', expr => [keyw => 'repeat-x']},
    },
    {prop => 'background-attachment', decl => 'FiXed',   ast => {property => 'background-attachment', expr => [keyw => 'fixed']},
    },
    {prop => 'background-position ', decl => '100% 90%', ast => {"property" => "background-position", "expr" => ["percentage" => 100, "percentage" => 90]},
    },
    {prop => 'background', decl => 'url(chess.png) gray 50% repeat scroll', 
             ast => {"property" => "background",
                     "expr" => ["background-image" => ["url" => "chess.png"],
                                "background-color" => ["color" => {"r" => 128, "g" => 128, "b" => 128}],
                                "background-position" => ["percentage" => 50],
                                "background-repeat" => ["keyw" => "repeat"],
                                "background-attachment" => ["keyw" => "scroll"]]},
    },
    {prop => 'border-top-width', decl => 'thick',
             ast => {"property" => "border-top-width",
                     "expr" => ["keyw" => "thick"]}
    },
    {prop => 'border-width', decl => '2ex 1.5em 3ex 2em',
             ast => {"property" => "border-width",
                     "expr" => ["border-width-top" => ["length" => 2],
                                "border-width-right" => ["length" => 1.5],
                                "border-width-bottom" => ["length" => 3],
                                "border-width-left" => ["length" => 2]]},
    },
    {prop => 'border-color', decl => '#a7f #aa77ff rgb(100,150,20) aqua',
             ast => {"property" => "border-color", 
                     "expr" => ["border-color-top" => ["color" => {"r" => 170, "g" => 119, "b" => 255}],
                                "border-color-right" => ["color" => {"r" => 170, "g" => 119, "b" => 255}],
                                "border-color-bottom" => ["color" => {"r" => 100, "g" => 150, "b" => 20}],
                                "border-color-left" => ["color" => {"r" => 0, "g" => 255, "b" => 255}]]},
    },
    {prop => 'border-style', decl => 'groove', ast => {"property" => "border-style",
                                                      "expr" => ["keyw" => "groove"]},
    },
    {prop => 'clear', decl => 'both', ast => {"property" => "clear",
                                             "expr" => ["keyw" => "both"]},
    },
    {prop => 'color', decl => '#3377aa', ast => {property => 'color', expr => [color => {r => 0x33, g => 0x77, b => 0xAA}]},
    },
    {prop => 'display', decl => 'list-item',
             ast => {"property" => "display",
                     "expr" => ["keyw" => "list-item"]},
    },
    {prop => 'float ', decl => 'left', ast => {"property" => "float",
                                             "expr" => ["keyw" => "left"]},
    },
    {prop => 'font-family', decl => 'Gill, "Helvetica", sans-serif',   ast => {"property" => "font-family", "expr" => ["family-name" => "Gill",
                                                                                                                      "family-name" => "Helvetica",
                                                                                                                      "generic-family" => "sans-serif"]},
    },
    {prop => 'font-style', decl => 'italic', ast => {"property" => "font-style", expr => ["keyw" => 'italic']},
    },
    {prop => 'font-variant', decl => 'small-caps', ast => {"property" => "font-variant", expr => ["keyw" => 'small-caps']},
    },
    {prop => 'font-weight', decl => 'bolder', ast => {"property" => "font-weight", expr => ["keyw" => 'bolder']},
    },
    {prop => 'font-weight', decl => '800', ast => {"property" => "font-weight", expr => ["number" => '800']},
    },
    {prop => 'font-size', decl => '12pt', ast => {"property" => "font-size", expr => [length => '12']},
    },
    {prop => 'font-size', decl => '150%', ast => {"property" => "font-size", expr => [percentage => '150']},
    },
    {prop => 'font-size', decl => 'Larger', ast => {"property" => "font-size", expr => [relative-size => 'larger']},
    },
    {prop => 'font', decl => '12pt/14pt sans-serif',
             ast => {"property" => "font",
                     "expr" => ["font-size" => ["length" => 12],
                                "line-height" => ["length" => 14],
                                "font-family" => ["generic-family" => "sans-serif"]]},
    },
    {prop => 'font', decl => 'normal small-caps 120%/120% fantasy',
             ast => {"property" => "font",
                     "expr" => ["font-style" => "normal",
                                "font-variant" => "small-caps",
                                "font-size" => ["percentage" => 120],
                                "line-height" => ["percentage" => 120],
                                "font-family" => ["generic-family" => "fantasy"]]},
    },
    {prop => 'letter-spacing', decl => 'normal',
             ast => {"property" => "letter-spacing",
                     "expr" => ["keyw" => "normal"]}
    },
    {prop => 'line-height', decl => '120%',
             ast => {"property" => "line-height",
                     "expr" => ["line-height" => {"percentage" => 120}]}
    },
    {prop => 'list-style-type', decl => 'square',
             ast => {"property" => "list-style-type",
                     "expr" => ["keyw" => "square"]},
    },
    {prop => 'list-style-image', decl => 'url(snoopy.png)',
             ast => {"property" => "list-style-image",
                     "expr" => ["uri" => "snoopy.png"]},
    },
    {prop => 'list-style-position', decl => 'outside',
             ast => {"property" => "list-style-position",
                     "expr" => [keyw => 'outside']},
    },
    {prop => 'list-style', decl => 'url(http://png.com/ellipse.png) disc outside',
             ast => {"property" => "list-style",
                     "expr" => ["list-style-image" => ["uri" => "http://png.com/ellipse.png"],
                                "list-style-type" => ["keyw" => "disc"],
                                "list-style-position" => ["keyw" => "outside"]]},
    },
    {prop => 'overflow', decl => 'scroll', ast => {"property" => "overflow",
                                                 "expr" => ["keyw" => "scroll"]},
    },
    {prop => 'padding-bottom', decl => '2em',
             ast => {"property" => "padding-bottom",
                     "expr" => ["length" => 2]}
    },
    {prop => 'position', decl => 'absolute', ast => {"property" => "position",
                                             "expr" => ["keyw" => "absolute"]},
    },
    {prop => 'margin-top', decl => '1.25ex',
             ast => {"property" => "margin-top",
                     "expr" => ["length" => 1.25]}
    },
    {prop => 'margin', decl => '1.2ex 1.5em 125% 0',
             ast => {"property" => "margin",
                     "expr" => ["margin-top" => ["length" => 1.2],
                                "margin-right" => ["length" => 1.5],
                                "margin-bottom" => ["percentage" => 125],
                                "margin-left" => ["length" => 0]]},
    },
    {prop => 'margin', decl => '1.2ex 1.5em',
             ast => {"property" => "margin",
                     "expr" => ["margin-top" => ["length" => 1.2],
                                "margin-right" => ["length" => 1.5],
                                "margin-bottom" => ["length" => 1.2],
                                "margin-left" => ["length" => 1.5]]}
    },
    {prop => 'text-decoration', decl => 'Underline',
             ast => {"property" => "text-decoration",
                     "expr" => ["keyw" => "underline"]}
    },
    {prop => 'text-transform', decl => 'uppercase',
             ast => {"property" => "text-transform",
                     "expr" => ["keyw" => "uppercase"]}
    },
    {prop => 'text-align', decl => 'justify',
             ast => {"property" => "text-align",
                     "expr" => ["keyw" => "justify"]}
    },
    {prop => 'text-decoration', decl => 'underline',
             ast => {"property" => "text-decoration",
                     "expr" => ["keyw" => "underline"]}
    },
    {prop => 'vertical-align', decl => 'text-top',
             ast => {"property" => "vertical-align",
                     "expr" => ["keyw" => "text-top"]}

    },
    {prop => 'width', decl => '55mm', ast => {"property" => "width",
                                             "expr" => ["length" => 55]},
    },
    {prop => 'word-spacing', decl => '1.5em',
             ast => {"property" => "word-spacing",
                     "expr" => ["length" => 1.5]}
    },
    {prop => 'white-space', decl => 'nowrap', ast => {"property" => "white-space",
                                             "expr" => ["keyw" => "nowrap"]},
    },
    {prop => 'z-index', decl => '3', ast => {"property" => "z-index",
                                             "expr" => ["integer" => 3]},
    },

    ) {

    my %test = %$_;
    my $prop = %test<prop>;
    my $input = $prop ~ ':' ~ %test<decl>;

    $css1_actions.reset;
     my $p1 = CSS::Language::CSS1.parse( $input, :rule('decl'), :actions($css1_actions));
    t::AST::parse_tests($input, $p1, :rule('decl'), :suite('css1'),
                         :warnings($css1_actions.warnings),
                         :expected(%test) );

    $css21_actions.reset;
    my $p21 = CSS::Language::CSS21.parse( $input, :rule('decl'), :actions($css21_actions));
    t::AST::parse_tests($input, $p21, :rule('decl'), :suite('css21'),
                         :warnings($css21_actions.warnings),
                         :expected(%test) );

    unless %seen{$prop}++ {

        my $junk = $prop ~ ': junk 42';

        $css1_actions.reset;
        $p1 = CSS::Language::CSS1.parse( $junk, :rule('decl'), :actions($css1_actions));
        is($p1.Str, $junk, "$prop: able to parse unexpected input");

        ok($css1_actions.warnings.grep({/^usage:/}), "$prop : unexpected input produces warning")
            or diag $css1_actions.warnings;

        $css21_actions.reset;
        $p21 = CSS::Language::CSS21.parse( $junk, :rule('decl'), :actions($css21_actions));
        is($p21.Str, $junk, "$prop: able to parse unexpected input");

        ok($css21_actions.warnings.grep({/^usage:/}), "$prop : unexpected input produces warning")
            or diag $css21_actions.warnings;
    }

}

done;
