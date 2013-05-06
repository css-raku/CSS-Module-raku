#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS3::Colors;

# prepare our own composite class with color extensions

use lib '.';
use t::AST;

my $css_actions = CSS::Language::CSS3::Colors::Actions.new;

for (
    term   => {input => 'rgb(70%, 50%, 10%)',
               ast => {r => 179, g => 127, b => 26},
               token => {type => 'color', units => 'rgb'},
    },
    term   => {input => 'rgba(100%, 50%, 0%, 0.1)',
               ast => {r => 255, g => 127, b => 0, a=> .1},
               token => {type => 'color', units => 'rgba'},
    },
    term   => {input => 'hsl(120, 100%, 50%)',
               ast => {h => 120, 's' => 1, 'l' => .5},
               token => {type => 'color', units => 'hsl'},
    },
    term   => {input => 'hsla( 50%, 100%, .5, 75% )',
               ast => {h => 180, 's' => 1, 'l' => .5, 'a' => .75},
               token => {type => 'color', units => 'hsla'},
    },
    # a few invalid cases
    term  => {input => 'rgba(10%,20%,30%)',
              ast => Mu,
              warnings => rx{^usage\: \s rgba\(},
    },
    term  => {input => 'hsl(junk)',
              ast => Mu,
              warnings => rx{^usage\: \s hsl\(},
    },
    term  => {input => 'hsla()',
              ast => Mu,
              warnings => rx{^usage\: \s hsla\(},
    },
    color => {input => 'orange', ast => {"r" => 255, "g" => 165, "b" => 0}},
    color => {input => 'hotpink', ast => {"r" => 255, "g" => 105, "b" => 180}},
    color => {input => 'lavenderblush', ast => {"r" => 255, "g" => 240, "b" => 245}},
    color => {input => 'currentcolor', ast => 'currentcolor'},
    decl  => {input => 'opacity: .33',
              ast => {"property" => "opacity",
                      "expr" => ["alphavalue" => 0.33]}},
# http://www.w3.org/TR/2011/REC-css3-color-20110607
# @color-profile is in the process of being dropped
##    at-rule => {input => 'color-profile { name: acmAe_cmyk; src: url(http://printers.example.com/acmecorp/model1234); }',
##                ast => {"declarations" => {"name" => {"expr" => ["term" => "acme_cmyk"]},
##                                           "src" => {"expr" => ["term" => "http://printers.example.com/acmecorp/model1234"]}},
##                        '@' => "color-profile"},
##    },
    ) {
    my $rule = $_.key;
    my %test = $_.value;
    my $input = %test<input>;

    $css_actions.reset;
    my $p3 = CSS::Language::CSS3::Colors.parse( $input, :rule($rule), :actions($css_actions));
    t::AST::parse_tests($input, $p3, :rule($rule), :suite('css3-color'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;
