#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS1::Actions;
use CSS::Language::CSS1;

##use CSS::Language::CSS21::Actions;
##use CSS::Language::CSS21;

use lib '.';
use t::AST;

my $css1_actions = CSS::Language::CSS1::Actions.new;
##my $css21_actions = CSS::Language::CSS21::Actions.new;

my %seen;

for (
    {prop => 'background-color ', decl => '#37a', ast => {property => 'background-color', expr => [color => {r => 0x33, g => 0x77, b => 0xAA}]},
    },
    {prop => 'background-image ', decl => 'url(images/ok.png)', ast => {property => 'background-image', expr => [url => 'images/ok.png']},
    },
    {prop => 'background-repeat ', decl => 'Repeat-x', ast => {property => 'background-repeat', expr => [ident => 'repeat-x']},
    },
    {prop => 'background-attachment', decl => 'FiXed',   ast => {property => 'background-attachment', expr => [ident => 'fixed']},
    },
    {prop => 'background-position ', decl => '100% 90%', ast => {"property" => "background-position", "expr" => ["percentage" => 100, "percentage" => 90]},
    },
    {prop => 'background', decl => 'url(chess.png) gray 50% repeat scroll', 
             ast => {"property_list" => [
                         {"property" => "background"},
                         {"property" => "background-image", "expr" => ["url" => "chess.png"]},
                         {"property" => "background-color", "expr" => ["color" => {"r" => 128, "g" => 128, "b" => 128}]},
                         {"property" => "background-position", "expr" => ["percentage" => 50]},
                         {"property" => "background-repeat", "expr" => ["ident" => "repeat"]},
                         {"property" => "background-attachment", "expr" => ["ident" => "scroll"]}]},
    },
    {prop => 'border-top-width', decl => 'thick',
             ast => {"property" => "border-top-width",
                     "expr" => ["ident" => "thick"]}
    },
    {prop => 'border-width', decl => '2ex 1.5em 3ex 2em',
             ast => {"property_list" => [
                         {"property" => "border-width"},
                         {"property" => "border-width-top", "expr" => "length" => 2},
                         {"property" => "border-width-right", "expr" => "length" => 1.5},
                         {"property" => "border-width-bottom", "expr" => "length" => 3},
                         {"property" => "border-width-left", "expr" => "length" => 2}]},
    },
    {prop => 'border-color', decl => '#a7f #aa77ff rgb(100,150,20) aqua',
             ast => {"property_list" => [
                         {"property" => "border-color"},
                         {"property" => "border-color-top", "expr" => "color" => {"r" => 170, "g" => 119, "b" => 255}},
                         {"property" => "border-color-right", "expr" => "color" => {"r" => 170, "g" => 119, "b" => 255}},
                         {"property" => "border-color-bottom", "expr" => "color" => {"r" => 100, "g" => 150, "b" => 20}},
                         {"property" => "border-color-left", "expr" => "color" => {"r" => 0, "g" => 255, "b" => 255}}]},
    },
    {prop => 'border-style', decl => 'groove', ast => {"property" => "border-style",
                                                      "expr" => ["ident" => "groove"]},
    },
    {prop => 'clear', decl => 'both', ast => {"property" => "clear",
                                             "expr" => ["ident" => "both"]},
    },
    {prop => 'color', decl => '#3377aa', ast => {property => 'color', expr => [color => {r => 0x33, g => 0x77, b => 0xAA}]},
    },
    {prop => 'display', decl => 'list-item',
             ast => {"property" => "display",
                     "expr" => ["ident" => "list-item"]},
    },
    {prop => 'float ', decl => 'left', ast => {"property" => "float",
                                             "expr" => ["ident" => "left"]},
    },
    {prop => 'font-family', decl => 'Gill, "Helvetica", sans-serif',   ast => {"property" => "font-family", "expr" => ["family-name" => "gill",
                                                                                                                      "family-name" => "Helvetica",
                                                                                                                      "generic-family" => "sans-serif"]},
    },
    {prop => 'font-style', decl => 'italic', ast => {"property" => "font-style", expr => ["ident" => 'italic']},
    },
    {prop => 'font-variant', decl => 'small-caps', ast => {"property" => "font-variant", expr => ["ident" => 'small-caps']},
    },
    {prop => 'font-weight', decl => 'bolder', ast => {"property" => "font-weight", expr => ["ident" => 'bolder']},
    },
    {prop => 'font-weight', decl => '800', ast => {"property" => "font-weight", expr => ["num" => '800']},
    },
    {prop => 'font-size', decl => '12pt', ast => {"property" => "font-size", expr => [length => '12']},
    },
    {prop => 'font-size', decl => '150%', ast => {"property" => "font-size", expr => [percentage => '150']},
    },
    {prop => 'font-size', decl => 'Larger', ast => {"property" => "font-size", expr => [relative-size => 'larger']},
    },
    {prop => 'font', decl => '12pt/14pt sans-serif',
             ast => {"property_list" => [
                         {"property" => "font"},
                         {"property" => "font-size", "expr" => ["length" => 12]},
                         {"property" => "line-height", "expr" => ["length" => 14]},
                         {"property" => "font-family", "expr" => ["generic-family" => "sans-serif"]}]},
    },
    {prop => 'font', decl => 'normal small-caps 120%/120% fantasy',
             ast => {"property_list" => [
                         {"property" => "font"},
                         {"property" => "font-style", "expr" => "normal"},
                         {"property" => "font-variant", "expr" => "small-caps"},
                         {"property" => "font-size", "expr" => ["percentage" => 120]},
                         {"property" => "line-height", "expr" => ["percentage" => 120]},
                         {"property" => "font-family", "expr" => ["generic-family" => "fantasy"]}]},
    },
    {prop => 'letter-spacing', decl => 'normal',
             ast => {"property" => "letter-spacing",
                     "expr" => ["ident" => "normal"]}
    },
    {prop => 'line-height', decl => '120%',
             ast => {"property" => "line-height",
                     "expr" => ["line-height" => {"percentage" => 120}]}
    },
    {prop => 'list-style-type', decl => 'square',
             ast => {"property" => "list-style-type",
                     "expr" => ["ident" => "square"]},
    },
    {prop => 'list-style-image', decl => 'url(snoopy.png)',
             ast => {"property" => "list-style-image",
                     "expr" => ["url" => "snoopy.png"]},
    },
    {prop => 'list-style-position', decl => 'outside',
             ast => {"property" => "list-style-position",
                     "expr" => [ident => 'outside']},
    },
    {prop => 'list-style', decl => 'url(http://png.com/ellipse.png) disc outside',
             ast => {"property_list" => [
                         {"property" => "list-style"},
                         {"property" => "list-style-image", "expr" => ["url" => "http://png.com/ellipse.png"]},
                         {"property" => "list-style-type", "expr" => ["ident" => "disc"]},
                         {"property" => "list-style-position", "expr" => ["ident" => "outside"]},
                         ]},
    },
    {prop => 'overflow', decl => 'scroll', ast => {"property" => "overflow",
                                                 "expr" => ["ident" => "scroll"]},
    },
    {prop => 'padding-bottom', decl => '2em',
             ast => {"property" => "padding-bottom",
                     "expr" => ["length" => 2]}
    },
    {prop => 'page-break-after', decl => 'auto', ast => {"property" => "page-break-after",
                                             "expr" => ["ident" => "auto"]},
    },
    {prop => 'position', decl => 'absolute', ast => {"property" => "position",
                                             "expr" => ["ident" => "absolute"]},
    },
    {prop => 'margin-top', decl => '1.25ex',
             ast => {"property" => "margin-top",
                     "expr" => ["length" => 1.25]}
    },
    {prop => 'marks', decl => 'crop', ast => {"property" => "marks",
                                             "expr" => ["ident" => "crop"]},
    },
    {prop => 'margin', decl => '1.2ex 1.5em 125% 0',
             ast => {property_list => [
                         {"property" => "margin"},
                         {"property" => "margin-top", "expr" => "length" => 1.2},
                         {"property" => "margin-right", "expr" => "length" => 1.5},
                         {"property" => "margin-bottom", "expr" => "percentage" => 125},
                         {"property" => "margin-left", "expr" => "length" => 0}],
             }
    },
    {prop => 'margin', decl => '1.2ex 1.5em',
             ast => {"property_list" => [
                         {"property" => "margin"},
                         {"property" => "margin-top", "expr" => "length" => 1.2},
                         {"property" => "margin-right", "expr" => "length" => 1.5},
                         {"property" => "margin-bottom", "expr" => "length" => 1.2},
                         {"property" => "margin-left", "expr" => "length" => 1.5}]}
    },
##    {prop => 'margin', decl => 'inherit',
##             ast => {"property_list" => [
##                         {"property" => "margin", inherit => True},
##                         ]},
##    },
    {prop => 'size', decl => '3ex', ast => {"property" => "size",
                                             "expr" => ["length" => 3]},
    },
    {prop => 'text-decoration', decl => 'Underline',
             ast => {"property" => "text-decoration",
                     "expr" => ["ident" => "underline"]}
    },
    {prop => 'text-transform', decl => 'uppercase',
             ast => {"property" => "text-transform",
                     "expr" => ["ident" => "uppercase"]}
    },
    {prop => 'text-align', decl => 'justify',
             ast => {"property" => "text-align",
                     "expr" => ["ident" => "justify"]}
    },
    {prop => 'text-decoration', decl => 'underline',
             ast => {"property" => "text-decoration",
                     "expr" => ["ident" => "underline"]}
    },
    {prop => 'vertical-align', decl => 'text-top',
             ast => {"property" => "vertical-align",
                     "expr" => ["ident" => "text-top"]}

    },
    {prop => 'width', decl => '55mm', ast => {"property" => "width",
                                             "expr" => ["length" => 55]},
    },
    {prop => 'word-spacing', decl => '1.5em',
             ast => {"property" => "word-spacing",
                     "expr" => ["length" => 1.5]}
    },
    {prop => 'white-space', decl => 'nowrap', ast => {"property" => "white-space",
                                             "expr" => ["ident" => "nowrap"]},
    },
    {prop => 'visibility', decl => 'hidden', ast => {"property" => "visibility",
                                             "expr" => ["ident" => "hidden"]},
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

##    $css21_actions.reset;
##    my $p21 = CSS::Language::CSS21.parse( $input, :rule('decl'), :actions($css21_actions));
##    t::AST::parse_tests($input, $p21, :rule('decl'), :suite('css21'),
##                         :warnings($css21_actions.warnings),
##                         :expected(%test) );

    unless %seen{$prop}++ {

        my $junk = $prop ~ ': junk 42';

        $css1_actions.reset;
        $p1 = CSS::Language::CSS1.parse( $junk, :rule('decl'), :actions($css1_actions));
        is($p1.Str, $junk, "$prop: able to parse unexpected input");

        ok($css1_actions.warnings.grep({/^usage:/}), "$prop : unexpected input produces warning")
            or diag $css1_actions.warnings;

##        $css21_actions.reset;
##        $p21 = CSS::Language::CSS21.parse( $junk, :rule('decl'), :actions($css21_actions));
##        is($p21.Str, $junk, "$prop: able to parse unexpected input");

##        ok($css21_actions.warnings.grep({/^usage:/}), "$prop : unexpected input produces warning")
##            or diag $css21_actions.warnings;
    }

}

done;
