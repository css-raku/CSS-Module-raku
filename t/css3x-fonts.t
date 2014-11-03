#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use CSS::Module::CSS3::Fonts;
use CSS::Module::CSS21::Actions;
use CSS::Module::CSS21;
use CSS::Grammar::Test;

my $css3x-actions = CSS::Module::CSS3::Fonts::Actions.new;
my $css21-actions = CSS::Module::CSS21::Actions.new;

for 't/css3x-fonts.json'.IO.lines {

    if .substr(0,2) eq '//' {
##        note '[' ~ .substr(2) ~ ']';
        next;
    }
    my ($rule, $expected) = @( from-json($_) );

    my $input = $expected<input>;

    CSS::Grammar::Test::parse-tests( CSS::Module::CSS3::Fonts, $input,
				     :$rule,
				     :actions($css3x-actions),
				     :suite<css3x-fonts>,
				     :$expected );

    my $css21 = $expected<css21> // {};
    CSS::Grammar::Test::parse-tests(CSS::Module::CSS21, $input,
				    :$rule,
				    :actions($css21-actions),
				    :suite<css21>,
				    :expected(%(%$expected, %$css21)) );
}

done;
