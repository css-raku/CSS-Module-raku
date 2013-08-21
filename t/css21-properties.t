#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use CSS::Language::CSS21::Actions;
use CSS::Language::CSS21;

use CSS::Language::CSS3;

use CSS::Grammar::Test;

my $css21-actions = CSS::Language::CSS21::Actions.new;
my $css3x-actions = CSS::Language::CSS3::Actions.new;

my %seen;

my $fh = open 't/css21-properties.json', :r;

for ( $fh.lines ) {

    if .substr(0,2) eq '//' {
##        note '[' ~ .substr(2) ~ ']';
        next;
    }

    my %test = %( from-json($_) );
    my $prop = %test<prop>;

    my %declarations;

    if %test<box> {
        for @(%test<box>) {
            my ($edge, $val) = .kv;
            %declarations{$prop.lc ~ '-' ~ $edge} = {expr => $val}
        }
    }
    else {
        %declarations{ $prop.lc } = {expr => %test<expr>};
    }

    %test<ast> = %declarations;

    my $input = $prop ~ ':' ~ %test<decl>;

    for css21 => (CSS::Language::CSS21, $css21-actions, qw<inherit>),	
       	css3  => (CSS::Language::CSS3, $css3x-actions, qw<inherit initial>) {

	my ($level, $class, $actions, @proforma) = (.key, @(.value));

	CSS::Grammar::Test::parse-tests($class, $input,
					:rule<declaration-list>,
					:actions($actions),
					:suite($level),
					:expected(%test) );

	unless %seen{$prop.lc}{$level}++ {
	    # usage and inheritence  tests
	    my $junk = $prop ~ ': junk +-42';

	    $actions.reset;
	    my $p = $class.parse( $junk, :rule('declaration-list'), :actions($actions));
	    is($p.Str, $junk, "$level $prop: able to parse unexpected input");

	    ok($actions.warnings, "$level $prop : unexpected input produces warning")
		or diag $actions.warnings;

	    for @proforma -> $misc {
		my $decl = $prop ~ ': ' ~ $misc;

		my @_expr = ($misc => True);
		my %ast = %test<box>
		    ?? <top right bottom left>.map({($prop.lc ~ '-' ~ $_) => {expr => @_expr}})
		    !! ($prop.lc => {expr => @_expr});

                CSS::Grammar::Test::parse-tests($class, $decl,
						:rule('declaration-list'),
						:actions($actions),
						:suite($level),
						:expected({ast => %ast}) );

            }
        }
    }
}

done;
