#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS1::Actions;
use CSS::Language::CSS1;

use CSS::Language::CSS21::Actions;
use CSS::Language::CSS21;

use CSS::Language::CSS3;

use CSS::Grammar::Test;

for ("012AF", "012AFc") {
    # css21+ unicode is up to 6 digits
    nok($_ ~~ /^<CSS::Language::CSS1::unicode>$/, "not css1 unicode: $_");
    ok($_ ~~ /^<CSS::Language::CSS21::unicode>$/, "css21 unicode: $_");
    ok($_ ~~ /^<CSS::Language::CSS3::unicode>$/, "css3 unicode: $_");
}

# css1 and css21 only recognise latin chars as non-ascii (\o240-\o377)
for ('') {
    nok($_ ~~ /^<CSS::Language::CSS1::nonascii>$/, "not non-ascii css1: $_");
    nok($_ ~~ /^<CSS::Language::CSS21::nonascii>$/, "not non-ascii css21: $_");
    ok($_ ~~ /^<CSS::Language::CSS3::nonascii>$/, "non-ascii css3: $_");
}

my $css1-actions  = CSS::Language::CSS1::Actions.new;
my $css21-actions = CSS::Language::CSS21::Actions.new;
my $css3-actions  = CSS::Language::CSS3::Actions.new;

for (
    declaration-list => {input => 'bad-prop: badval',
			 warnings => 'unknown property: bad-prop - declaration dropped',
			 ast => {},
    },
    declaration-list => {input => 'background-attachment: crud',
			 warnings => rx{^'usage background-attachment: scroll | fixed'},
			 ast => {},
    },
    declaration-list => {input => 'background-attachment: FiXed', ast => {'background-attachment' => {expr => [{keyw => 'fixed'}]}},
    },
    declaration-list => {input => 'font-family: "unclosed-string',
			 ast => {},
			 warnings => rx{^usage},
    },
    # recheck comments and whitespace
    declaration-list => {input => '/*aa*/COLoR/*bb*/:<!--cc-->BLUE /*dd*/;',
			 ast => {"color" => {"expr" => [{"color" => {"r" => 0, "g" => 0, "b" => 255}}]}},
    },
    # boxed properties should be expanded
    declaration-list => {input => 'margin: 2em 3em',  
                         ast => {"margin-top" => {expr => [{"length" => 2}]},
                                 "margin-right" => {expr => [{"length" => 3}]},
                                 "margin-bottom" => {expr => [{"length" => 2}]},
                                 "margin-left" => {expr => [{"length" => 3}]}
                                 },
    },
    # check override rules
    declaration-list => {input => 'margin-right: 5em; margin-top: 10em !IMPORTANT; margin: 2em 3em; margin-bottom: 1em',
                         ast => 42,
                         ast => {"margin-right" => {expr => [{"length" => 3}]},
                                 "margin-top" => {expr => [{"length" => 10}], prio => "important"},
                                 "margin-bottom" => {expr => [{"length" => 1}]},
                                 "margin-left" => {expr => [{"length" => 3}]}
                                 },
    },
    # also check !important
    declaration-list => {input => 'margin: em -ex !IMPORTANT',
             ast => {"margin-top"    => {expr => [{"length" => 1}],  "prio" => "important"},
                     "margin-right"  => {expr => [{"length" => -1}], "prio" => "important"},
                     "margin-bottom" => {expr => [{"length" => 1}],  "prio" => "important"},
                     "margin-left"   => {expr => [{"length" => -1}], "prio" => "important"},
                     },
    },
  ) {

    note {t => $_.kv}.perl;
    my $rule = .key;
    my %test = @( .value );
    my $input = %test<input>;

    for css1  => (CSS::Language::CSS1, $css1-actions),
       	css21 => (CSS::Language::CSS21, $css21-actions),	
       	css3  => (CSS::Language::CSS3, $css3-actions) {

	    my ($level, $class, $actions) = (.key, @(.value));

	    CSS::Grammar::Test::parse-tests($class, $input,
					    :rule($rule),
					    :suite($level),
					    :actions($actions),
					    :expected(%test) );
	}

}

done;
