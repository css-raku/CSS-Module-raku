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
    decl     => {input => 'font-family: 21st Century, fantasy',
                 ast => {"property" => "font-family",
                         "expr" => ["family-name" => "21st Century",
                                    "generic-family" => "fantasy"]},
    },
    decl     => {input => 'font-weight: lighter',
                 ast => {"property" => "font-weight",
                         "expr" => ["keyw" => "lighter"]},
    },
    decl     => {input => 'font-weight: initial',
                 ast => {"property" => "font-weight",
                         "expr" => [initial => True]},
    },
    decl     => {input => 'font-weight: inherit',
                 ast => {"property" => "font-weight",
                         "expr" => [inherit => True]},
    },
    decl     => {input => 'font-stretch: extra-expanded',
                 ast => {"property" => "font-stretch",
                         "expr" => ["keyw" => "extra-expanded"]},
    },
    decl     => {input => 'font-style: oblique',
                 ast => {"property" => "font-style", 
                         "expr" => ["keyw" => "oblique"]}
    },
    decl     => {input => 'font-size-adjust: .7',
                 ast => {"property" => "font-size-adjust",
                         "expr" => ["number" => 0.7]}

    },
    decl     => {input => 'font: x-large/110% "new century schoolbook", serif',
                 ast => {"property" => "font",
                         "expr" => ["font-size" => ["absolute-size" => "x-large"],
                                    "line-height" => ["percentage" => 110],
                                    "font-family" => ["family-name" => "new century schoolbook"], 
                                    "font-family" => ["generic-family" => "serif"]]},
    },
    decl     => {input => 'font-variant: small-caps',
                 ast => {"property" => "font-variant",
                         "expr" => ["keyw" => "small-caps"]},
    },
    decl     => {input => 'font-variant: annotation(circled)',
                 ast => {"property" => "font-variant",
                         "expr" => ["annotation" => {"feature-value-name" => "circled"}]},
    },
    decl     => {input => 'font-variant: discretionary-ligatures, character-variant(leo-B, leo-M, leo-N, leo-T, leo-U)',
                 ast => {"property" => "font-variant",
                         "expr" => ["discretionary-lig-values" => "discretionary-ligatures",
                                    "character-variant" => {
                                        "feature-value-list" => ["feature-value-name" => "leo-B",
                                                                 "feature-value-name" => "leo-M",
                                                                 "feature-value-name" => "leo-N",
                                                                 "feature-value-name" => "leo-T",
                                                                 "feature-value-name" => "leo-U"]}]
                 },
    decl     => {input => 'line-height: 1.2em',
                 ast => {"property" => "line-height",
                         "expr" => ["length" => 1.2]},
    },
     },
    ) {
    my $rule = $_.key;
    my %test = $_.value;
    my $input = %test<input>;

    $css_actions.reset;
    my $p3 = CSS::Language::CSS3::Fonts.parse( $input, :rule($rule), :actions($css_actions));
    t::AST::parse_tests($input, $p3, :rule($rule), :suite('css3-fonts'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;
