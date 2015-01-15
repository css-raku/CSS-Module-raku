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
my $css3-actions_2  = CSS::Module::CSS3::Actions.new( :pass-unknown );
my $css-writer = CSS::Writer.new( :terse, :color-names );

for (
    :declarations{ :input('{unknown-prop: someval}'),
                   :warnings('dropping unknown property: unknown-prop'),
                   :ast{ :declarations[] },
                   :pass-unknown{
                       :warnings[],
                       :ast{ :declarations[ {"property:unknown" => {:expr[{ :ident<someval> }], :ident<unknown-prop>}} ]},
                   },
    },
    :declarations{ :input('{unknown-prop: unknown-func()}'),
                   :warnings['ignoring function: unknown-func', 'dropping declaration: unknown-prop'],
                   :ast{ :declarations[] },
                   :css1{
                       :warnings['dropping term: unknown-func()', 'dropping declaration: unknown-prop'],
                   },
                   :pass-unknown{
                       :warnings[],
                       :ast{ :declarations[{"property:unknown" => {:expr[{ :func{ :ident<unknown-func> }}], :ident<unknown-prop>}}] },
                   },
    },
    :declarations{ :input('{ @guff {color:red} }'),
                   :warnings('dropping unknown property: @guff'),
                   :css1{ :warnings('dropping term: @guff {color:red}') },
                   :ast{ :declarations[] },
                   :pass-unknown{
                       :warnings[],
                       :ast{ :declarations[ { "margin-rule:unknown" =>  { :declarations[ { :property{ :ident<color>, :expr[ { :rgb[ { :num(255) }, { :num(0) }, { :num(0) } ] } ] } } ],
                                                                           :at-keyw<guff> } } ] }
                   },
    },
    :declarations{ :input('{background-attachment: crud}'),
                   :warnings(rx{^'usage background-attachment: scroll | fixed'}),
                   :ast{ :declarations[] },
    },
    :declarations{ :input('{background-attachment: FiXed}'),
                   :ast{ :declarations[{ :property{ident => 'background-attachment', :expr[{ :keyw<fixed> }]}}]} ,
    },
    :declarations{ :input('{font-family: "unclosed-string}'),
                   :ast{ :declarations[] },
                   :warnings(rx{^usage}),
    },
    # recheck comments and whitespace
    :declarations{ :input('{/*aa*/COLoR/*bb*/:<!--cc-->BLUE /*dd*/;}'),
                   :ast{ :declarations[{ :property{ :ident<color>, :expr[{ :rgb[ { :num(0) }, { :num(0) }, { :num(255) } ]}]}}] },
    },
    :declarations{ :input('{margin: 2em 3em}'),
                   :ast{ :declarations[ { :property{ :ident<margin>,
                                          :expr[ { :em(2) }, { :em(3) } ]} }]
                   },
    },
    # check override rules
    :declarations{ :input('{background-attachment: fixed !Important;}'),
                   :ast{ :declarations[ { :property{ :ident<background-attachment>,
                                         :expr[ { :keyw<fixed> } ],
                                         :prio<important> } } ]},
    },
    # selector sanity
    :simple-selector{ :input('H1:active'),
                      :ast{ :simple-selector[ { :qname{ :element-name<h1> } }, { :pseudo-class<active> } ] },
    },
    :simple-selector{ :input('h1[id$=ess]'),
                      :css1{ :parse<h1>, :ast{ :simple-selector[ :qname{ :element-name<h1> } ] } },
                      :css21{ :parse<h1>, :ast{ :simple-selector[ :qname{ :element-name<h1> } ] } },
                      :ast{ :simple-selector[ { :qname{ :element-name<h1> } }, { :attrib[ { :ident<id> }, { :op<$=> }, { :ident<ess> } ] } ] },
    },
  ) {
    my $rule = .key;
    my %expected = %( .value );
    my $input = %expected<input>;

    for css1  => {class => CSS::Module::CSS1,  actions => $css1-actions, writer => $css-writer},
       	css21 => {class => CSS::Module::CSS21, actions => $css21-actions, writer => $css-writer},	
       	css3  => {class => CSS::Module::CSS3,  actions => $css3-actions, writer => $css-writer},
       	pass-unknown  => {class => CSS::Module::CSS3,  actions => $css3-actions_2, writer => $css-writer} {

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
