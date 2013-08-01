#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use CSS::Language::CSS3;
use CSS::Grammar::Test;

my $css_actions = CSS::Language::CSS3::Actions.new;

my $fh = open 't/css3x-media-queries.json', :r;

for ( $fh.lines ) {

    if .substr(0,2) eq '//' {
##        note '[' ~ .substr(2) ~ ']';
        next;
    }
    my ($rule, %test) = @( from-json($_) );
    my $input = %test<input>;

    $css_actions.reset;
    my $p3 = CSS::Language::CSS3.parse( $input, :rule($rule), :actions($css_actions));
    CSS::Grammar::Test::parse_tests($input, $p3, :rule($rule), :suite('css3 @media'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;
