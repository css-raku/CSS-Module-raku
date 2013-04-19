#!/usr/bin/env perl6

use Test;

use CSS::Grammar::CSS3;
use CSS::Grammar::Actions;
use CSS::Language::CSS21;
use CSS::Language::CSS21::Actions;
use CSS::Extensions::CSS3::Fonts;

# prepare our own composite class with font extensions

grammar t::CSS3::FontGrammar
    is CSS::Extensions::CSS3::Fonts
    is CSS::Extensions::CSS21
    is CSS::Grammar::CSS3
      {};

class t::CSS3::FontActions
    is CSS::Extensions::CSS3::Fonts::Actions
    is CSS::Language::CSS21::Actions {};

use lib '.';
use t::AST;

my $css_actions = t::CSS3::FontActions.new;

for (
    at-rule   => {input => q:to 'END_INPUT',
                           font-face {
                                  font-family: MainText;
                                  src: url(gentium.eot); /* for use with older non-conformant user agents */
                                  src: local("Gentium"), url(gentium.ttf) format("truetype");  /* Overrides src definition */
                                }
                           END_INPUT
                  ast => {"declarations" => {"font-family" => {"expr" => ["family-name" => "MainText"]},
                                             "src" => {"expr" => ["src" => {"local" => "Gentium"},
                                                                  "src" => {"uri" => "gentium.ttf", "format" => "truetype"}]}},
                          "\@" => "font-face"},
    },
    ) {
    my $rule = $_.key;
    my %test = $_.value;
    my $input = %test<input>;

    $css_actions.reset;
    my $p3 = t::CSS3::FontGrammar.parse( $input, :rule($rule), :actions($css_actions));
    t::AST::parse_tests($input, $p3, :rule($rule), :suite('css3-font-composite'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;
