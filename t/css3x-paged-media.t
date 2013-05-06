#!/usr/bin/env perl6

use Test;

use CSS::Grammar::CSS3;
use CSS::Grammar::Actions;
use CSS::Language::CSS3;

# prepare our own composite class with paged media extensions

use lib '.';
use t::AST;

my $css_actions = CSS::Language::CSS3::Actions.new;

my $top_center = 'page { color: red;
        @top-center {
           content: "Page " counters(page,".");
       }
}';

my $top_center_ast = {"declarations" => {"color" => {"expr" => ["color" => {"r" => 255, "g" => 0, "b" => 0}]},
                                         "\@top-center" => {"margin-box" => {"box-vpos" => "top", "box-center" => "center"},
                                                            "declarations" => {"content" => {"expr" => ["string" => "Page ", "counters" => {"identifier" => "page", "string" => "."}]}}}},
                      "\@" => "page"};

for (
    at-rule   => {input => 'page :left { margin-left: 4cm; size: a4 }',
                  ast => {"page" => "left",
                          "declarations" => {"margin-left" => {"expr" => ["length" => 4]},
                                             "size" => {"expr" => ["page-size" => "a4"]},
                          },
                          "\@" => "page"},
    },
    at-rule   => {input => 'page :junk { margin-right: 2cm }',
                  ast => {"declarations" => {"margin-right" => {"expr" => ["length" => 2]}}, "\@" => "page"},
                  warnings => 'ignoring page pseudo: junk',
    },
    at-rule   => {input => 'page : { margin-right: 2cm }',
                  ast => Mu,
                  warnings => "':' should be followed by one of: left right first",
    },
    'page-declarations' => {input => '{@bottom-right-CorNeR {color:blue}}',
                 ast => {"\@bottom-right-corner" => {"margin-box" => {"box-vpos" => "bottom",
                                                                      "box-hpos" => "right"},
                                                     "declarations" => {"color" => {"expr" => ["color" => {"r" => 0, "g" => 0, "b" => 255}]}}}},
    },
    'page-declarations' => {input => '{ @Top-CENTER {content: "Page " counters(page);} }',
                            ast => {"\@top-center" => {"margin-box" => {"box-vpos" => "top", "box-center" => "center"},
                                           "declarations" => {"content" => {"expr" => ["string" => "Page ", "counters" => {"identifier" => "page"}]}}}},
    },
    at-rule => {input => $top_center, ast => $top_center_ast},
    ) {
    my $rule = $_.key;
    my %test = $_.value;
    my $input = %test<input>;
note $input;
    $css_actions.reset;
    my $p3 = CSS::Language::CSS3.parse( $input, :rule($rule), :actions($css_actions));
    t::AST::parse_tests($input, $p3, :rule($rule), :suite('css3 @page'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;
