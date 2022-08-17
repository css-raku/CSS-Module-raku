#!/usr/bin/env perl6

use Test;
use JSON::Fast;

use CSS::Module::SVG;
use CSS::Grammar::Test;
use CSS::Writer;

my CSS::Module $svg = CSS::Module::SVG.module;

my %seen;

for 't/svg-properties.json'.IO.lines {

    next if .substr(0,2) eq '//';

    my %expected = %( from-json($_) );
    my $prop = %expected<prop>.lc;
    my $expr = %expected<expr>;

    %expected<ast> = $expr ?? { :declarations[{ :property{ :ident($prop), :$expr } }] } !! Any;

    my $input = sprintf '{%s: %s}', $prop, %expected<decl>;
    my $writer = CSS::Writer.new;

    for ({ :module($svg), :proforma<inherit initial>, :$writer}, )
    -> % ( :$module!, :$proforma!, :$writer=Any) {

        my $level = $module.name;
	my $grammar = $module.grammar;
        my $actions = $module.actions.new;

	CSS::Grammar::Test::parse-tests($grammar, $input,
					:rule<declarations>,
					:$actions,
					:suite($level),
                                        :$writer,
					:%expected );

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
						:expected({ :$ast }) );

            }
        }
    }
}

done-testing;
