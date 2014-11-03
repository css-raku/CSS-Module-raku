#!/usr/bin/env perl6

# these tests check for conformance with error handling as outline in
# http://www.w3.org/TR/2011/REC-CSS2-20110607/syndata.html#parsing-errors

use Test;
use JSON::Tiny;

use CSS::Module::CSS3;
use CSS::Grammar::Test;

my $c = CSS::Module::CSS3; # moarbug workaround
my $actions = CSS::Module::CSS3::Actions.new;

for ( 't/error-handling.json'.IO.lines ) {
    if .substr(0,2) eq '//' {
##        note '[' ~ .substr(2) ~ ']';
        next;
    }

    my ($rule, $expected) = @( from-json($_) );
    my $input = $expected<input>;

    CSS::Grammar::Test::parse-tests(CSS::Module::CSS3, $input,
				    :$rule,
				    :$actions,
				    :suite<css3>,
				    :$expected );
}

done;
