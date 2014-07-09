#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use CSS::Module::CSS3;
use CSS::Grammar::Test;

my $c = CSS::Module::CSS3; # moar bug work-around
my $actions = CSS::Module::CSS3::Actions.new;

my $fh = open 't/css3x-paged-media.json', :r;

for ( $fh.lines ) {

    if .substr(0,2) eq '//' {
##        note '[' ~ .substr(2) ~ ']';
        next;
    }
    my ($rule, $t) = @( from-json($_) );
    my %test = %$t;
    my $input = %test<input>;

    CSS::Grammar::Test::parse-tests(CSS::Module::CSS3, $input,
				    :rule($rule),
				    :actions($actions),
				    :suite<css3 @page>,
				    :expected(%test) );
}

done;
