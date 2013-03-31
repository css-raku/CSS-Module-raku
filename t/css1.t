#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS1;
use CSS::Language::CSS1::Actions;
use lib '.';
use t::AST;

my $css_actions = CSS::Language::CSS1::Actions.new;

for (
    decl => {input => 'font-family: Gill, "Helvetica", sans-serif',   ast => {"property" => "font-family", "expr" => [{"family_name" => "gill"}, {"family_name" => "Helvetica"}, {"generic_family" => "sans-serif"}]},
    },
    decl => {input => 'font-style: bold', ast => {"property" => "font-style", expr => [ident => 'bold']},
    },
    decl => {input => 'font-variant: small-caps', ast => {"property" => "font-variant", expr => [ident => 'small-caps']},
    },
    decl => {input => 'font-weight: bolder', ast => {"property" => "font-weight", expr => [ident => 'bolder']},
    },
    decl => {input => 'font-weight: 800', ast => {"property" => "font-weight", expr => [num => '800']},
    },
    decl => {input => 'background-attachment: FiXed',   ast => {property => 'background-attachment', expr => [ident => 'fixed']},
    },
    decl => {input => 'background-color : #37a', ast => {property => 'background-color', expr => [color => { rgb => {r => 0x33, g => 0x77, b => 0xAA}}]},
    },
    decl => {input => 'background-image : url(images/ok.png)', ast => {property => 'background-image', expr => [url => 'images/ok.png']},
    },
    decl => {input => 'background-repeat : Repeat-x', ast => {property => 'background-repeat', expr => [ident => 'repeat-x']},
    },
    decl => {input => 'background-position : 100% 90%', ast => {"property" => "background-position", "expr" => [["percentage" => 100e0, "percentage" => 90e0]]},
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
