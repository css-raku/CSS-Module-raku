#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS1;
use CSS::Language::CSS1::Actions;
use lib '.';
use t::AST;

my $css1_actions = CSS::Language::CSS1::Actions.new;

for (
    declaration => {input => 'bad-prop: badval',
                    warnings => 'unknown property: bad-prop - declaration dropped',
                    ast => Mu,
    },
    declaration => {input => 'background-attachment: crud',
                    warnings => 'usage background-attachment: scroll | fixed | inherit',
    },
    declaration => {input => 'background-attachment: FiXed',   ast => {property => 'background-attachment', expr => [ident => 'fixed']},
    },
  ) {

    my $rule = $_.key;
    my %test = $_.value;
    my $input = %test<input>;

    $css1_actions.reset;
         my $p = CSS::Language::CSS1.parse( $input, :rule($rule), :actions($css1_actions));
    t::AST::parse_tests($input, $p, :rule($rule), :suite('css1'),
                         :warnings($css1_actions.warnings),
                         :expected(%test) );
}

done;