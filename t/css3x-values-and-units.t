#!/usr/bin/env perl6

use Test;
use JSON::Fast;
use CSS::Grammar::Test;
use CSS::Module::CSS3;
use CSS::Writer;

my $writer = CSS::Writer.new;
my $module = CSS::Module::CSS3.module;
my $tests = @*ARGS.head // 't/css3x-values-and-units.json';

for $tests.IO.lines {

    next
        if .substr(0,2) eq '//';

    my :($rule, $expected) := from-json($_);
    my Str:D $input = $expected<input>;
    subtest $input, {
        CSS::Grammar::Test::parse-tests(
            $input,
            :$rule,
            :$module,
            :$writer,
            :$expected );
    }
}

done-testing;
