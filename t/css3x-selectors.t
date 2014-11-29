#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use CSS::Module::CSS3::Selectors;
use CSS::Grammar::Test;
use CSS::Writer;

my $actions = CSS::Module::CSS3::Selectors::Actions.new;
my $writer = CSS::Writer.new;

for ( 't/css3x-selectors.json'.IO.lines ) {
    next 
        if .substr(0,2) eq '//';

    my ($rule, $expected) = @( from-json($_) );
    my $input = $expected<input>;

    CSS::Grammar::Test::parse-tests(CSS::Module::CSS3::Selectors, $input,
				    :$rule,
				    :$actions,
				    :suite<css3x-selectors>,
                                    :$writer,
				    :$expected );
}

done;
