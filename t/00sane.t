#!/usr/bin/env perl6

use Test;

use CSS::Module::CSS1::Actions;
use CSS::Module::CSS1;
use CSS::Module::CSS21::Actions;
use CSS::Module::CSS21;
use CSS::Module::CSS3;
use CSS::Grammar::Test;
use CSS::Writer;

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
my $css-writer = CSS::Writer.new;

for (
    declarations => {input => '{bad-prop: badval}',
                     warnings => 'dropping unknown property: bad-prop',
                     ast => [],
    },
    declarations => {input => '{ @guff {color:red} }',
                     warnings => 'dropping unknown property: @guff',
                     css1 => {warnings => 'dropping term: @guff {color:red}'},
                     ast => [],
    },
    declarations => {input => '{background-attachment: crud}',
                     warnings => rx{^'usage background-attachment: scroll | fixed'},
                     ast => [],
    },
    declarations => {input => '{background-attachment: FiXed}',
                     ast => [{ident => 'background-attachment', expr => [{keyw => 'fixed'}]}],
    },
    declarations => {input => '{font-family: "unclosed-string}',
                     ast => [],
                     warnings => rx{^usage},
    },
    # recheck comments and whitespace
    declarations => {input => '{/*aa*/COLoR/*bb*/:<!--cc-->BLUE /*dd*/;}',
                     ast => [{ident => "color", "expr" => [{"rgb" => [ {num => 0}, {num => 0}, {num => 255} ]}]}],
    },
    # boxed properties should be expanded
    declarations => {input => '{margin: 2em 3em}',
                     ast => [{ident => "margin",
                              "expr" => [{"em" => 2}, {"em" => 3}]}],
    },
    # check override rules
    declarations => {input => '{background-attachment: fixed !Important;}',
                     ast => [ { ident => "background-attachment",
                                expr => [ { keyw => "fixed" } ],
                                prio => "important" } ],
    },
  ) {
    my $rule = .key;
    my %expected = %( .value );
    my $input = %expected<input>;

    for css1  => {class => CSS::Module::CSS1,  actions => $css1-actions},
       	css21 => {class => CSS::Module::CSS21, actions => $css21-actions},	
       	css3  => {class => CSS::Module::CSS3,  actions => $css3-actions, writer => $css-writer} {

	    my ($level, $opt) = .kv;
            my $class = $opt<class>;
            my $actions = $opt<actions>;
            my $writer = $opt<writer>;
            my %level-tests = %( %expected{$level} // () );
            my %level-expected = %expected, %level-tests;

	    CSS::Grammar::Test::parse-tests($class, $input,
					    :$rule,
					    :suite($level),
					    :$actions,
                                            :$writer,
					    :expected(%level-expected) );
	}

}

done;
