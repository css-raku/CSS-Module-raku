#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use CSS::Language::CSS3::Fonts;
use CSS::Language::CSS3::CSS21_Imported;
use CSS::Grammar::Test;

my $css3x_actions = CSS::Language::CSS3::Fonts::Actions.new;
my $css21_actions = CSS::Language::CSS3::CSS21_Imported::Actions.new;

my $fh = open 't/css3x-fonts.json', :r;

for ( $fh.lines ) {

    if .substr(0,2) eq '//' {
##        note '[' ~ .substr(2) ~ ']';
        next;
    }
    my ($rule, %test) = @( from-json($_) );

    my $input = %test<input>;

    $css3x_actions.reset;
    my $p-font = CSS::Language::CSS3::Fonts.parse( $input, :rule($rule), :actions($css3x_actions));
    CSS::Grammar::Test::parse_tests($input, $p-font, :rule($rule), :suite('css3x-fonts'),
                         :warnings($css3x_actions.warnings),
                         :expected(%test) );

    $css21_actions.reset;
    my $css21 = %test<css21> // {};
    my $p-css21 = CSS::Language::CSS3::CSS21_Imported.parse( $input, :rule($rule), :actions($css21_actions));
    CSS::Grammar::Test::parse_tests($input, $p-css21, :rule($rule), :suite('css21'),
                         :warnings($css21_actions.warnings),
                         :expected(%(%test, %$css21)) );
}

done;
