#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use CSS::Module::CSS3::Fonts;
use CSS::Module::CSS21::Actions;
use CSS::Module::CSS21;
use CSS::Grammar::Test;

my $css3x-actions = CSS::Module::CSS3::Fonts::Actions.new;
my $css21-actions = CSS::Module::CSS21::Actions.new;

my $fh = open 't/css3x-fonts.json', :r;

for ( $fh.lines ) {

    if .substr(0,2) eq '//' {
##        note '[' ~ .substr(2) ~ ']';
        next;
    }
    my ($rule, $t) = @( from-json($_) );
    my %test = %$t;

    my $input = %test<input>;

    CSS::Grammar::Test::parse-tests( CSS::Module::CSS3::Fonts, $input,
				     :rule($rule),
				     :actions($css3x-actions),
				     :suite<css3x-fonts>,
				     :expected(%test) );

    my $css21 = %test<css21> // {};
    CSS::Grammar::Test::parse-tests(CSS::Module::CSS21, $input,
				    :rule($rule),
				    :actions($css21-actions),
				    :suite<css21>,
				    :expected(%(%test, @$css21)) );
}

done;
