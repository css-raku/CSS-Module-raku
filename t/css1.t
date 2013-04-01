#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS1;
use CSS::Language::CSS1::Actions;
use lib '.';
use t::AST;

my $css_actions = CSS::Language::CSS1::Actions.new;

for (
    decl => {input => 'font-family: Gill, "Helvetica", sans-serif',   ast => {"property" => "font-family", "expr" => [{"family-name" => "gill"}, {"family-name" => "Helvetica"}, {"generic-family" => "sans-serif"}]},
    },
    decl => {input => 'font-style: bold', ast => {"property" => "font-style", expr => ["font-style" => 'bold']},
    },
    decl => {input => 'font-variant: small-caps', ast => {"property" => "font-variant", expr => ["font-variant" => 'small-caps']},
    },
    decl => {input => 'font-weight: bolder', ast => {"property" => "font-weight", expr => ["font-weight" => 'bolder']},
    },
    decl => {input => 'font-weight: 800', ast => {"property" => "font-weight", expr => ["font-weight" => '800']},
    },
    decl => {input => 'font-size: 12pt', ast => {"property" => "font-size", expr => [length => '12']},
    },
    decl => {input => 'font-size: 150%', ast => {"property" => "font-size", expr => [percentage => '150']},
    },
    decl => {input => 'font-size:Larger', ast => {"property" => "font-size", expr => [relative-size => 'larger']},
    },
    decl => {input => 'font: 12pt/14pt sans-serif',
             ast => {"property" => "font",
                     "expr" => [["font-size" => {"length" => 12},
                                 "line-height" => {"length" => 14},
                                 "font-family" => {"generic-family" => "sans-serif"}]]}
    },
    decl => {input => 'font: normal small-caps 120%/120% fantasy',
             ast => {"property" => "font",
                     "expr" => [["font-style" => "normal",
                                 "font-variant" => "small-caps",
                                 "font-size" => {"percentage" => 120},
                                 "line-height" => {"percentage" => 120},
                                 "font-family" => {"generic-family" => "fantasy"}]]}
    },
    decl => {input => 'background-attachment: FiXed',   ast => {property => 'background-attachment', expr => [ident => 'fixed']},
    },
    decl => {input => 'background-color : #37a', ast => {property => 'background-color', expr => [color => { rgb => {r => 0x33, g => 0x77, b => 0xAA}}]},
    },
    decl => {input => 'background-image : url(images/ok.png)', ast => {property => 'background-image', expr => [url => 'images/ok.png']},
    },
    decl => {input => 'background-repeat : Repeat-x', ast => {property => 'background-repeat', expr => [ident => 'repeat-x']},
    },
    decl => {input => 'background-position : 100% 90%', ast => {"property" => "background-position", "expr" => [["percentage" => 100, "percentage" => 90]]},
    },
    decl => {input => 'background: url(chess.png) gray 50% repeat scroll', 
             ast => {"property" => "background",
                     "expr" => [["background-image" => {"url" => "chess.png"},
                                 "background-color" => {"color" => {"r" => 128, "g" => 128, "b" => 128}},
                                 "background-position" => ["percentage" => 50],
                                 "background-repeat" => {"ident" => "repeat"},
                                 "background-attachment" => {"ident" => "scroll"}]]},
    },
    ) {

    my $rule = $_.key;
    my %test = $_.value;
    my $input = %test<input>;

    $css_actions.reset;
     my $p = CSS::Language::CSS1.parse( $input, :rule($rule), :actions($css_actions));
    t::AST::parse_tests($input, $p, :rule($rule), :suite('css1'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;
