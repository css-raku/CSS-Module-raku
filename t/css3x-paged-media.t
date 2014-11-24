#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use CSS::Module::CSS3;
use CSS::Grammar::Test;
use CSS::Writer;

my $c = CSS::Module::CSS3; # moar bug work-around
my $actions = CSS::Module::CSS3::Actions.new;

for ( 't/css3x-paged-media.json'.IO.lines ) {

    if .substr(0,2) eq '//' {
##        note '[' ~ .substr(2) ~ ']';
        next;
    }
    my ($rule, $expected) = @( from-json($_) );
    my $input = $expected<input>;

    CSS::Grammar::Test::parse-tests(CSS::Module::CSS3, $input,
				    :$rule,
				    :$actions,
				    :suite<css3 @page>,
                                    :writer(CSS::Writer),
				    :$expected );
}

done;
