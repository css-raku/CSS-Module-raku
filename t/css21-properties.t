#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use CSS::Module::CSS21::Actions;
use CSS::Module::CSS21;

use CSS::Module::CSS3;

use CSS::Grammar::Test;

my $css21-actions = CSS::Module::CSS21::Actions.new;
my $css3x-actions = CSS::Module::CSS3::Actions.new;

my %seen;

for 't/css21-properties.json'.IO.lines {

    if .substr(0,2) eq '//' {
##        note '[' ~ .substr(2) ~ ']';
        next;
    }

    my %expected = %( from-json($_) );
    my $prop = %expected<prop>.lc;

    my %declarations;

    if %expected<box> {
        for @(%expected<box>) {
            my ($edge, $val) = .kv;
            %declarations{$prop ~ '-' ~ $edge} = {expr => $val}
        }
    }
    else {
        %declarations{ $prop } = {expr => %expected<expr>};
    }

    %expected<ast> = %declarations;

    my $input = $prop ~ ':' ~ %expected<decl>;

    for css21 => (CSS::Module::CSS21, $css21-actions, qw<inherit>),
       	css3x => (CSS::Module::CSS3,  $css3x-actions, qw<inherit initial>) {

	my $level = .key;
	my ($class, $actions, @proforma) = @(.value);

	CSS::Grammar::Test::parse-tests($class, $input,
					:rule<declaration-list>,
					:$actions,
					:suite($level),
					:%expected );

	unless %seen{$prop}{$level}++ {
	    # usage and inheritence  tests
	    my $junk = $prop ~ ': junk +-42';

	    $actions.reset;
	    my $p = $class.parse( $junk, :rule<declaration-list>, :$actions);
	    ok($p.defined && ~$p eq $junk, "$level $prop: able to parse unexpected input")
	        or note "unable to parse declaration list: $junk";

	    ok($actions.warnings, "$level $prop: unexpected input produces warning")
		or diag $actions.warnings;

	    for @proforma -> $misc {
		my $decl = $prop ~ ': ' ~ $misc;

		my @_expr = ({$misc => True});
		my %ast = %expected<box>
		    ?? <top right bottom left>.map({($prop ~ '-' ~ $_) => {expr => @_expr}})
		    !! ($prop => {expr => @_expr});

                CSS::Grammar::Test::parse-tests($class, $decl,
						:rule<declaration-list>,
						:$actions,
						:suite($level),
						:expected({ast => %ast}) );

            }
        }
    }
}

done;
