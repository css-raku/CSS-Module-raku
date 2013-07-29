#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS3;
use CSS::Grammar::Test;

my $css_actions = CSS::Language::CSS3::Actions.new;

my $embedded_page = 'media print and (width: 21cm) and (height: 29.7cm) {
      @page { margin-left: 3cm; }
   }';

my $embedded_page_ast = {"media-list" => ["media-query" => ["media" => "print",
                                                            "media-expr" => {"property" => "width",
                                                                             "expr" => ["length" => 21]},
                                                            "media-expr" => {"property" => "height",
                                                                             "expr" => ["length" => 29.7]}]],
                         "media-rules" => ["at-rule" => {"declarations" => {"margin-left" => {expr => ["length" => 3]}},
                                                         "\@" => "page"}],
                         "\@" => "media"};

for (
    resolution      => {input => '300dpi', ast => 300, token => {type => 'resolution', units => 'dpi'}},
    media-expr => {input => 'min-width: 25cm',
                   ast => {"property" => "min-width",
                           "expr" => ["length" => 25]},
    },
    media-expr => {input => 'max-width: foo',
                   warnings => 'usage max-width: <length>',
    },
    media-expr => {input => 'width: -em',
                   warnings => 'width: length cannot be negative',
    },
    at-rule   => {input => 'media all { body { background:lime } }',
                  ast => {"media-list" => ["media-query" => ["media" => "all"]],
                          "media-rules" => ["ruleset" => {"selectors" => ["selector" => ["simple-selector" => [qname => {"element-name" => "body"}]]],
                                                          "declarations" => {"background" => {"expr" => ["background-color" => {"color" => {"r" => 0, "g" => 255, "b" => 0}}]}}}],
                          "\@" => "media"},
    },
    at-rule => {input => 'media all and (color) { }',
                ast => {"media-list" => ["media-query" => ["media" => "all", "media-expr" => {"property" => "color"}]], "media-rules" => [], '@' => "media"},
    },
    at-rule => {input => 'media all and (color) { }',
                ast => {"media-list" => ["media-query" => ["media" => "all", "media-expr" => {"property" => "color"}]], "media-rules" => [], '@' => "media"},
    },
    at-rule => {input => 'media screen { * { font-family: sans-serif } }',
                ast => {"media-list" => ["media-query" => ["media" => "screen"]], "media-rules" => ["ruleset" => {"selectors" => ["selector" => ["simple-selector" => [universal => {"element-name" => "*"}]]], "declarations" => {"font-family" => {"expr" => ["generic-family" => "sans-serif"]}}}], "\@" => "media"},
    },
    # try out dpi and dpcm term extensions
    at-rule => {input => 'media all AND (min-resolution: 300dpi) And (min-resolution: 118dpcm) {}',
                ast => {"media-list" => ["media-query" => ["media" => "all", "media-expr" => {"property" => "min-resolution", "expr" => ["resolution" => 300]}, "media-expr" => {"property" => "min-resolution", "expr" => ["resolution" => 118]}]], "media-rules" => [], "\@" => "media"},
    },
    at-rule => {input => 'media noT print {body{margin : 1cm}}',
                ast => {"media-list" => ["media-query" => ["media-op" => "not", "media" => "print"]],
                        "media-rules" => ["ruleset" => {"selectors" => ["selector" => ["simple-selector" => [qname => {"element-name" => "body"}]]],
                                                        "declarations" => {"margin-top" => {"expr" => ["length" => 1]},
                                                                           "margin-right" => {"expr" => ["length" => 1]},
                                                                           "margin-bottom" => {"expr" => ["length" => 1]},
                                                                           "margin-left" => {"expr" => ["length" => 1]}}}],
                        "\@" => "media"},
    },
    at-rule => {input => 'media ONLY all And (none) { }',
                ast => {"media-list" => ["media-query" => ["media-op" => "only", "media" => "all", "media-expr" => {"property" => "none"}]], "media-rules" => [], "\@" => "media"},
    },
    # error handling unknown media features; treated as not all:
    # http://www.w3.org/TR/2012/REC-css3-mediaqueries-20120619/#error-handling
    # all the following should equate to 'not all'
    at-rule => {input => 'media not all {}',
                ast => {"media-list" => ["media-query" => ["media-op" => "not", "media" => "all"]], "media-rules" => [], "\@" => "media"},
    },
    at-rule => {input => 'media (min-orientation:portrait) {}',
                 warnings => 'unknown media-feature: min-orientation',
                 ast => {"media-list" => ["media-query" => ["media-op" => "not", "media" => "all"]], "media-rules" => [], "\@" => "media"},
    },
    at-rule => {input => 'media (color:20example) {}',
                warnings => 'media expression cannot take an argument: color',
                ast => {"media-list" => ["media-query" => ["media-op" => "not", "media" => "all"]], "media-rules" => [], "\@" => "media"},
    },
    at-rule => {input => 'media (example, all,), speech {}',
                warnings => 'unknown media-feature: example',
                ast => {"media-list" => ["media-query" => ["media-op" => "not", "media" => "all"]], "media-rules" => [], "\@" => "media"},
    },
    at-rule => {input => 'media &test, screen {}',
                ast => {"media-list" => ["media-query" => ["media-op" => "not", "media" => "all"]], "media-rules" => [], "\@" => "media"},
    },
    # we should also have extended the import at-rule
    import => {input => '@import url(example.css) screen and (color), projection and (color);',
               ast => {"url" => "example.css", "media-list" => ["media-query" => ["media" => "screen", "media-expr" => {"property" => "color"}], "media-query" => ["media" => "projection", "media-expr" => {"property" => "color"}]]},
    },
    at-rule => {input => $embedded_page, ast => $embedded_page_ast},
    ) {
    my $rule = .key;
    my %test = .value;
    my $input = %test<input>;

    $css_actions.reset;
    my $p3 = CSS::Language::CSS3.parse( $input, :rule($rule), :actions($css_actions));
    CSS::Grammar::Test::parse_tests($input, $p3, :rule($rule), :suite('css3 @media'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;
