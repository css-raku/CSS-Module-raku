#!/usr/bin/env perl6

use Test;

use CSS::Grammar;
use CSS::Grammar::CSS3;
use CSS::Grammar::Actions;
use CSS::Language::CSS3::PagedMedia;
use CSS::Language::CSS3::Media;

# prepare our own composite class with paged media extensions

grammar t::CSS3::MediaGrammar
    is CSS::Language::CSS3::PagedMedia  # for nested @page
    is CSS::Language::CSS3::Media
    is CSS::Grammar::CSS3
{};

class t::CSS3::MediaActions
    is CSS::Language::CSS3::PagedMedia::Actions
    is CSS::Language::CSS3::Media::Actions
    is CSS::Grammar::Actions
{};

use lib '.';
use t::AST;

my $css_actions = t::CSS3::MediaActions.new;

my $embedded_page = 'media print and (width: 21cm) and (height: 29.7cm) {
      @page { margin: 3cm; }
   }';

my $embedded_page_ast = {"media-list" => ["media-query" => ["media" => "print",
                                                            "media-expr" => {"media-feature" => "width", "expr" => ["term" => 21]},
                                                            "media-expr" => {"media-feature" => "height", "expr" => ["term" => 29.7]}]],
                         "media-rules" => ["at-rule" => {"declarations" => {"margin" => {"expr" => ["term" => 3]}}},
                                           '@' => "page"],
                         '@' => "media"};

for (
    term      => {input => '300dpi', ast => 300, token => {type => 'resolution', units => 'dpi'}},
    at-rule   => {input => 'media all { body { background:lime } }',
                  ast => {"media-list" => ["media-query" => ["media" => "all"]], "media-rules" => ["ruleset" => {"selectors" => ["selector" => ["simple-selector" => ["element-name" => "body"]]], "declarations" => {"background" => {"expr" => ["term" => "lime"]}}}], '@' => "media"},
    },
    at-rule => {input => 'media all and (color) { }',
                ast => {"media-list" => ["media-query" => ["media" => "all", "media-expr" => {"media-feature" => "color"}]], "media-rules" => [], '@' => "media"},
    },
    at-rule => {input => 'media all and (min-color: 2) { }',
                ast => {"media-list" => ["media-query" => ["media" => "all", "media-expr" => {"media-feature" => "min-color", "expr" => ["term" => 2]}]], "media-rules" => [], '@' => "media"},
    },
    # try out dpi and dpcm term extensions
    at-rule => {input => 'media all AND (min-resolution: 300dpi) And (min-resolution: 118dpcm) {}',
                ast => {"media-list" => ["media-query" => ["media" => "all", "media-expr" => {"media-feature" => "min-resolution", "expr" => ["term" => 300]}, "media-expr" => {"media-feature" => "min-resolution", "expr" => ["term" => 118]}]], "media-rules" => [], '@' => "media"},
    },
    at-rule => {input => 'media noT print {body{margin : 1cm}}',
                ast => {"media-list" => ["media-query" => ["media-op" => "not", "media" => "print"]], "media-rules" => ["ruleset" => {"selectors" => ["selector" => ["simple-selector" => ["element-name" => "body"]]], "declarations" => {"margin" => {"expr" => ["term" => 1]}}}], "\@" => "media"},
    },
    at-rule => {input => 'media ONLY all And (none) { }',
                ast => {"media-list" => ["media-query" => ["media-op" => "only", "media" => "all", "media-expr" => {"media-feature" => "none"}]], "media-rules" => [], '@' => "media"},
    },
    # we should also have extended the import at-rule
    import => {input => '@import url(example.css) screen and (color), projection and (color);',
               ast => {"url" => "example.css",
                       "media-list" => ["media-query" => ["media" => "screen", "media-expr" => {"media-feature" => "color"}],
                                        "media-query" => ["media" => "projection", "media-expr" => {"media-feature" => "color"}]]},
    },
    at-rule => {input => $embedded_page, ast => $embedded_page_ast},
    ) {
    my $rule = $_.key;
    my %test = $_.value;
    my $input = %test<input>;

    $css_actions.reset;
    my $p3 = t::CSS3::MediaGrammar.parse( $input, :rule($rule), :actions($css_actions));
    t::AST::parse_tests($input, $p3, :rule($rule), :suite('css3 @media'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;
