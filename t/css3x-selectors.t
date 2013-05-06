#!/usr/bin/env perl6

use Test;

use CSS::Grammar::CSS3;
use CSS::Language::CSS3::Selectors;
use CSS::Grammar::Actions;

# prepare our own composite class with paged selector extensions

grammar t::CSS3::SelectorsGrammar
    is CSS::Language::CSS3::Selectors
    is CSS::Grammar::CSS3
    {};

class t::CSS3::SelectorsActions
    is CSS::Language::CSS3::Selectors::Actions
    is CSS::Grammar::Actions
    {};

use lib '.';
use t::AST;

my $css_actions = t::CSS3::SelectorsActions.new;

for (
    term => {input => 'U+2??a', ast => {unicode-range => [0x200A, 0x2FFA]}},
    pseudo => {input => '::my-elem',
               ast => {element => 'my-elem'},
    },
    # thanks to: http://kilianvalkhof.com/2008/css-xhtml/the-css3-not-selector/
    selector   => {input => ':not(p)',
                   ast => ["simple-selector" => ["pseudo" => {"function" => {"ident" => "not", "args" => ["type-selector" => {"element-name" => "p"}]}}]],
    },
    selector   => {input => ':not(:not(p))',
                   warnings => "illegal nested negation: :not(p)",
                   ast => Mu,
    },
    selector   => {input => ':not(.home)',
                   ast => ["simple-selector" => ["pseudo" => {"function" => {"ident" => "not", "args" => ["class" => "home"]}}]],
    },
    selector   => {input => 'div *:not(p)',
                   ast => ["simple-selector" => ["element-name" => "div"], "simple-selector" => ["element-name" => "*", "pseudo" => {"function" => {"ident" => "not", "args" => ["type-selector" => {"element-name" => "p"}]}}]],
    },
    selector   => {input => 'input:not([type="file"])',
                   ast => ["simple-selector" => ["element-name" => "input", "pseudo" => {"function" => {"ident" => "not", "args" => ["attrib" => {"ident" => "type", "attribute-selector" => "=", "string" => "file"}]}}]],
    },
# :first-child is a pseudo-class, :first-line is a pseudo-element
    selector   => {input => 'li:not(.pingback) .comment-content p:first-child:first-line',
                   ast => ["simple-selector" => [
                               "element-name" => "li",
                               "pseudo" => {"function" => {"ident" => "not",
                                                           "args" => ["class" => "pingback"]}}],
                           "simple-selector" => ["class" => "comment-content"],
                           "simple-selector" => ["element-name" => "p",
                                                 "pseudo" => {"class" => "first-child"},
                                                 "pseudo" => {"element" => "first-line"}]],
    },
    selector   => {input => 'body:not(.home) h2 + p:first-letter',
                   ast => ["simple-selector" => ["element-name" => "body", "pseudo" => {"function" => {"ident" => "not", "args" => ["class" => "home"]}}],
                           "simple-selector" => ["element-name" => "h2"],
                           "combinator" => "+",
                           "simple-selector" => ["element-name" => "p", "pseudo" => {"element" => "first-letter"}]],
    },
    selector =>   {input => 'h2:not(:first-of-type):not(:last-of-type)',
                   ast => ["simple-selector" => ["element-name" => "h2",
                                                 "pseudo" => {"function" => {"ident" => "not", "args" => ["pseudo" => {"class" => "first-of-type"}]}},
                                                 "pseudo" => {"function" => {"ident" => "not", "args" => ["pseudo" => {"class" => "last-of-type"}]}}]],
    },
    # namespaces and wildcards
    selector   => {input => '*', ast => ["simple-selector" => ["element-name" => "*"]],},
    selector => {input => 'foo|h1',
                 ast => ["simple-selector" => ["namespace-prefix" => {"ident" => "foo"}, "element-name" => "h1"]],
    },
    selector => {input => 'foo|*',
                 ast => ["simple-selector" => ["namespace-prefix" => {"ident" => "foo"},
                                               "element-name" => "*"]],
    },
    selector => {input => '|h1',
                 ast => ["simple-selector" => ["namespace-prefix" => {},
                                               "element-name" => "h1"]],
    },
    selector => {input => '*|h1',
                 ast => ["simple-selector" => ["namespace-prefix" => {"wildcard" => "*"},
                                               "element-name" => "h1"]],
                 
    },
    # attributes
    selector => {input => 'span[hello="Cleveland"][goodbye="Columbus"]',
                 ast => ["simple-selector" => ["element-name" => "span",
                                               "attrib" => {"ident" => "hello", "attribute-selector" => "=", "string" => "Cleveland"},
                                               "attrib" => {"ident" => "goodbye", "attribute-selector" => "=", "string" => "Columbus"}]],
    },
    selector => {input => 'object[type^="image/"]',
                 ast => ["simple-selector" => ["element-name" => "object",
                                              "attrib" => {"ident" => "type", "attribute-selector" => "^=", "string" => "image/"}]],
    },
    # regular functions
    selector => {input => 'foo:lang(en)',
                 ast => ["simple-selector" => ["element-name" => "foo",
                                               "pseudo" => {"function" => {"ident" => "lang",
                                                                           "args" => {ident => 'en'}}}]],
    },
    # nth-... selectors
    selector => {input => 'bar:nth-child(3n+1)',
                 ast => ["simple-selector" => ["element-name" => "bar",
                                               "pseudo" => {"function" => {"ident" => "nth-child",
                                                                           "args" => {"a" => 3, "b" => 1}}}]],
    },
    selector => {input => 'bar:nth-last-child(odd)',
                 ast => ["simple-selector" => ["element-name" => "bar",
                                               "pseudo" => {"function" => {"ident" => "nth-last-child",
                                                                           "args" => {"a" => 2, "b" => 1}}}]],
    },
    selector => {input => 'tr:nth-last-child(-n+2)',
                 ast => ["simple-selector" => ["element-name" => "tr", "pseudo" => {"function" => {"ident" => "nth-last-child", "args" => {"b" => 2, "a" => -1}}}]],
    },
    selector => {input => 'td:nth-child(3)',
                 ast => ["simple-selector" => ["element-name" => "td",
                                               "pseudo" => {"function" => {"ident" => "nth-child",
                                                                           "args" => {"b" => 3}}}]],
    },
    selector => {input => 'tr:nth-last-child(2n)',
                 ast => ["simple-selector" => ["element-name" => "tr", "pseudo" => {"function" => {"ident" => "nth-last-child", "args" => {"a" => 2}}}]],
    },
    # white-space - valid
    selector => {input => 'tr:nth-child( 3n + 1 )',
                 ast => ["simple-selector" => ["element-name" => "tr", "pseudo" => {"function" => {"ident" => "nth-child", "args" => {"a" => 3, "b" => 1}}}]],
    },
    selector => {input => 'tr:nth-child( +3n - 2 )',
                 ast => ["simple-selector" => ["element-name" => "tr", "pseudo" => {"function" => {"ident" => "nth-child", "args" => {"a" => 3, "b" => -2}}}]]
    },
    selector => {input => 'tr:nth-child( -n+ 6 )',
                 ast => ["simple-selector" => ["element-name" => "tr", "pseudo" => {"function" => {"ident" => "nth-child", "args" => {"b" => 6, "a" => -1}}}]],
    },
    # white-space - invalid
    selector => {input => 'tr:nth-child(+ 2n)',
                 warnings => 'usage nth-child(an+b) e.g "4" "3n+1"',
                 ast => Mu,
    },
    ) {
    my $rule = $_.key;
    my %test = $_.value;
    my $input = %test<input>;

    $css_actions.reset;
    my $p3 = t::CSS3::SelectorsGrammar.parse( $input, :rule($rule), :actions($css_actions));
    t::AST::parse_tests($input, $p3, :rule($rule), :suite('css3-selector'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;
