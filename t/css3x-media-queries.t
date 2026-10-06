#!/usr/bin/env perl6

use Test;
use JSON::Fast;

use CSS::Module::CSS3;
use CSS::Grammar::Test;
use CSS::Writer;

my $module = CSS::Module::CSS3.module;
my CSS::Writer $writer .= new;

for 't/css3x-media-queries.json'.IO.lines {
#for '/tmp/tst.json'.IO.lines {

    next
        if .substr(0,2) eq '//';

    my ($rule, $expected) = @( from-json($_) );
    my $input = $expected<input>;
    subtest "$rule: $input", {

        &CSS::Grammar::Test::parse-tests(
            $input,
            :$module,
            :$rule,
            :suite<css3 @media>,
            :$writer,
            :$expected,
        );
    }
}

done-testing;
