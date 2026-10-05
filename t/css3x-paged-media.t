#!/usr/bin/env perl6

use Test;
use JSON::Fast;

use CSS::Module::CSS3;
use CSS::Grammar::Test;
use CSS::Writer;

my $module = CSS::Module::CSS3.module;
my CSS::Writer $writer .= new;

for ( 't/css3x-paged-media.json'.IO.lines ) {
    next
        if .substr(0,2) eq '//';

    my :($rule, $expected) := @( from-json($_) );

    my %expected = %$expected;
    %expected ,= .Hash with %expected{$module.name}:delete;
    my $input = %expected<input>:delete;
    &CSS::Grammar::Test::parse-tests($input, :$module,
                                     :$rule,
                                     :$writer,
                                     :%expected );
}

done-testing;
