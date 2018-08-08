#!/usr/bin/env perl6

use Test;
use JSON::Fast;

use CSS::Module::CSS21;
use CSS::Module::CSS3;
use CSS::Module::CSS1;
use CSS::Grammar::Test;
use CSS::Writer;

my CSS::Module $css1  = CSS::Module::CSS1.module;
my CSS::Module $css21 = CSS::Module::CSS21.module;
my CSS::Module $css3x = CSS::Module::CSS3.module;

my CSS::Writer $writer .= new;

my %seen;

for 't/css1-properties.json'.IO.lines {

    next if .substr(0,2) eq '//';

    my %expected = from-json($_);
    my $prop = %expected<prop>.lc;
    my $input = sprintf '{%s: %s}', $prop, %expected<decl>;
    my $expr = %expected<expr>;

    %expected<ast> = $expr ?? { :declarations[{ :property{ :ident($prop), :$expr } }] } !! Any;

    for { :module($css1), :proforma[]},
       	{ :module($css21), :proforma<inherit>},	
       	{ :module($css3x), :proforma<inherit initial>, :$writer}
    ->  % ( :$module!, :$proforma!, |c) {

        my $level = $module.name;
        my $grammar = $module.grammar;
        my $actions = $module.actions.new;

	CSS::Grammar::Test::parse-tests($grammar, $input,
					:rule<declarations>,
					:suite($level),
					:$actions,
					:%expected,
                                        |c,
                                       );

	unless %seen{$prop}{$level}++ {
	    # usage and inheritence  tests
	    my $junk = sprintf '{%s: %s}', $prop, 'junk +-42';

	    $actions.reset;
	    my $p = $grammar.parse( $junk, :rule<declarations>, :$actions);
	    ok($p.defined && ~$p eq $junk, "$level $prop: able to parse unexpected input")
	        or note "unable to parse declaration list: $junk";

	    ok($actions.warnings, "$level $prop: unexpected input produces warning")
		or diag $actions.warnings;

	    for @$proforma -> $misc {
		my $decl = sprintf '{%s: %s}', $prop, $misc;

		my $ast = { :declarations[{ :property{ :ident($prop), :expr[ { :keyw($misc)} ] } }] };

                CSS::Grammar::Test::parse-tests($grammar, $decl,
						:rule<declarations>,
						:$actions,
						:suite($level),
						:expected{ :$ast } );

            }
        }
    }
}

done-testing;
