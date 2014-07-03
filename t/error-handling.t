#!/usr/bin/env perl6

# these tests check for conformance with error handling as outline in
# http://www.w3.org/TR/2011/REC-CSS2-20110607/syndata.html#parsing-errors

use Test;
use JSON::Tiny;

use CSS::Grammar::Test;
use CSS::Language::CSS3;

my $actions = CSS::Language::CSS3::Actions.new;

my $fh = open 't/error-handling.json', :r;

for ( $fh.lines ) {
    if .substr(0,2) eq '//' {
##        note '[' ~ .substr(2) ~ ']';
        next;
    }

    my ($rule, $t) = @( from-json($_) );
    my %test = @$t;
    my $input = %test<input>;

    CSS::Grammar::Test::parse-tests(CSS::Language::CSS3, $input,
				    :rule($rule),
				    :actions($actions),
				    :suite<css3>,
				    :expected(%test) );
}

done;
