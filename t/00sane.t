#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS1::Actions;
use CSS::Language::CSS1;

use CSS::Language::CSS21::Actions;
use CSS::Language::CSS21;

use CSS::Language::CSS3;

use lib '.';
use t::AST;

my $css1_actions  = CSS::Language::CSS1::Actions.new;
my $css21_actions = CSS::Language::CSS21::Actions.new;
my $css3_actions  = CSS::Language::CSS3::Actions.new;

for (
    declaration => {input => 'bad-prop: badval',
                    warnings => 'unknown property: bad-prop - declaration dropped',
                    ast => Mu,
    },
    declaration => {input => 'background-attachment: crud',
                    warnings => rx{^usage\ background\-attachment\:\ scroll\ \|\ fixed},
    },
    declaration => {input => 'background-attachment: FiXed',   ast => {property => 'background-attachment', expr => [keyw => 'fixed']},
    },
    # boxed properties should be expanded
    declaration-list => {input => 'margin: 2em 3em',  
                         ast => {"margin-top" => {expr => ["length" => 2]},
                                 "margin-right" => {expr => ["length" => 3]},
                                 "margin-bottom" => {expr => ["length" => 2]},
                                 "margin-left" => {expr => ["length" => 3]}
                                 },
    },
    # check override rules
    declaration-list => {input => 'margin-right: 5em; margin-top: 10em !IMPORTANT; margin: 2em 3em; margin-bottom: 1em',  
                         ast => {"margin-right" => {expr => ["length" => 3]},
                                 "margin-top" => {expr => ["length" => 10], prio => "important"},
                                 "margin-bottom" => {expr => ["length" => 1]},
                                 "margin-left" => {expr => ["length" => 3]}
                                 },
    },
    # also check !important
    declaration-list => {input => 'margin: em -ex !IMPORTANT',
             ast => {"margin-top" => {expr => ["length" => 1], "prio" => "important"},
                     "margin-right" => {expr => ["length" => -1], "prio" => "important"},
                     "margin-bottom" => {expr => ["length" => 1], "prio" => "important"},
                     "margin-left" => {expr => ["length" => -1], "prio" => "important"},
                     },
    },
  ) {

    my $rule = .key;
    my %test = .value;
    my $input = %test<input>;

    $css1_actions.reset;
    my $p1 = CSS::Language::CSS1.parse( $input, :rule($rule), :actions($css1_actions));
    t::AST::parse_tests($input, $p1, :rule($rule), :suite('css1'),
                         :warnings($css1_actions.warnings),
                         :expected(%test) );

    $css21_actions.reset;
    my $p21 = CSS::Language::CSS21.parse( $input, :rule($rule), :actions($css21_actions));
    t::AST::parse_tests($input, $p21, :rule($rule), :suite('css21'),
                         :warnings($css21_actions.warnings),
                         :expected(%test) );
    $css3_actions.reset;
    my $p3 = CSS::Language::CSS3.parse( $input, :rule($rule), :actions($css3_actions));
    t::AST::parse_tests($input, $p3, :rule($rule), :suite('css3'),
                         :warnings($css3_actions.warnings),
                         :expected(%test) );

}

done;
