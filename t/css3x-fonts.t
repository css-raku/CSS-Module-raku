#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS3::Fonts;

# prepare our own composite class with font extensions

use lib '.';
use t::AST;

my $css_actions = CSS::Language::CSS3::Fonts::Actions.new;

for (
    at-rule   => {input => q:to 'END_INPUT',
                           font-face {
                                  font-family: MainText;
                                  src: url(gentium.eot); /* for use with older non-conformant user agents */
                                  src: local("Gentium"), url(gentium.ttf) format("truetype");  /* Overrides src definition */
                                }
                           END_INPUT
                  ast => {"font-description" => {"font-family" => {"expr" => ["family-name" => "MainText"]},
                                                 "src" => {"expr" => ["src" => {"local" => "Gentium"},
                                                                      "src" => {"uri" => "gentium.ttf", "format" => "truetype"}]}},
                          "\@" => "font-face"},
    },
    ) {
    my $rule = $_.key;
    my %test = $_.value;
    my $input = %test<input>;

    $css_actions.reset;
    my $p3 = CSS::Language::CSS3::Fonts.parse( $input, :rule($rule), :actions($css_actions));
    t::AST::parse_tests($input, $p3, :rule($rule), :suite('css3-font-composite'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;
