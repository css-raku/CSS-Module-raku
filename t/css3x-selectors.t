#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use CSS::Module::CSS3::Selectors;
use CSS::Grammar::Test;

my $actions = CSS::Module::CSS3::Selectors::Actions.new;

my $fh = open 't/css3x-selectors.json', :r;

for ( $fh.lines ) {
    if .substr(0,2) eq '//' {
##        note '[' ~ .substr(2) ~ ']';
        next;
    }
    my ($rule, $t) = @( from-json($_) );
    my %test = %$t;
    my $input = %test<input>;

    CSS::Grammar::Test::parse-tests(CSS::Module::CSS3::Selectors, $input,
				    :rule($rule),
				    :actions($actions),
				    :suite<css3x-selectors>,
				    :expected(%test) );
}

done;
