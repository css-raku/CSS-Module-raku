#!/usr/bin/env perl6

use Test;

use CSS::Module::CSS1::Actions;
use CSS::Module::CSS1;

use CSS::Module::CSS21::Actions;
use CSS::Module::CSS21;

use CSS::Module::CSS3;

use CSS::Grammar::Test;

for ("012AF", "012AFc") {
    # css21+ unicode is up to 6 digits
    nok($_ ~~ /^<CSS::Module::CSS1::unicode>$/, "not css1 unicode: $_");
    ok($_ ~~ /^<CSS::Module::CSS21::unicode>$/, "css21 unicode: $_");
    ok($_ ~~ /^<CSS::Module::CSS3::unicode>$/, "css3 unicode: $_");
}

# css1 and css21 only recognise latin chars as non-ascii (\o240-\o377)
for ('') {
    nok($_ ~~ /^<CSS::Module::CSS1::nonascii>$/, "not non-ascii css1: $_");
    nok($_ ~~ /^<CSS::Module::CSS21::nonascii>$/, "not non-ascii css21: $_");
    ok($_ ~~ /^<CSS::Module::CSS3::nonascii>$/, "non-ascii css3: $_");
}

my $css1-actions  = CSS::Module::CSS1::Actions.new;
my $css21-actions = CSS::Module::CSS21::Actions.new;
my $css3-actions  = CSS::Module::CSS3::Actions.new;

for (
    declaration-list => {input => 'bad-prop: badval',
			 warnings => 'dropping declaration: bad-prop',
			 ast => [],
    },
    declaration-list => {input => 'background-attachment: crud',
			 warnings => rx{^'usage background-attachment: scroll | fixed'},
			 ast => [],
    },
    declaration-list => {input => 'background-attachment: FiXed',
                         ast => [{property => 'background-attachment', expr => [{keyw => 'fixed'}]}],
    },
    declaration-list => {input => 'font-family: "unclosed-string',
			 ast => [],
			 warnings => rx{^usage},
    },
    # recheck comments and whitespace
    declaration-list => {input => '/*aa*/COLoR/*bb*/:<!--cc-->BLUE /*dd*/;',
			 ast => [{property => "color", "expr" => [{"rgb" => {"r" => 0, "g" => 0, "b" => 255}}]}],
    },
    # boxed properties should be expanded
    declaration-list => {input => 'margin: 2em 3em',
                         ast => [{property => "margin",
                                 "expr" => [{"em" => 2}, {"em" => 3}]}],
    },
    # check override rules
    declaration-list => {input => 'background-attachment: fixed !Important;',
                         ast => [ { property => "background-attachment",
                                    expr => [ { keyw => "fixed" } ],
                                    prio => "important" } ],
    },
  ) {
    my $rule = .key;
    my %expected = %( .value );
    my $input = %expected<input>;

    for css1  => (CSS::Module::CSS1, $css1-actions),
       	css21 => (CSS::Module::CSS21, $css21-actions),	
       	css3  => (CSS::Module::CSS3, $css3-actions) {

	    my ($level, $class, $actions) = (.key, @(.value));

	    CSS::Grammar::Test::parse-tests($class, $input,
					    :$rule,
					    :suite($level),
					    :$actions,
					    :%expected );
	}

}

done;
