#!/usr/bin/env perl6

use Test;
use JSON::Fast;
use CSS::Grammar::Test;
use CSS::Module::CSS3;
use CSS::Writer;

my $actions = CSS::Module::CSS3::Actions;
my $writer = CSS::Writer.new;

my $tests = @*ARGS.head // 't/css3x-values-and-units.json';

for $tests.IO.lines {

    next
        if .substr(0,2) eq '//';

    my :($rule, $expected) := from-json($_);
    my $input = $expected<input>;
    subtest $input, {
        $actions .= new;
        &CSS::Grammar::Test::parse-tests(
            CSS::Module::CSS3, $input, :$rule, :$actions,
            :suite<css3x-units>,
            :$writer,
            :$expected );
    }
}

done-testing;
