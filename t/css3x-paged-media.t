#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use CSS::Language::CSS3;
use CSS::Grammar::Test;

my $actions = CSS::Language::CSS3::Actions.new;

my $fh = open 't/css3x-paged-media.json', :r;

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
				    :suite<css3 @page>,
				    :expected(%test) );
}

done;
