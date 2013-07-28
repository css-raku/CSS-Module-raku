#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS3::Namespaces;

use lib '.';
use CSS::Grammar::Test;

my $css_actions = CSS::Language::CSS3::Namespaces::Actions.new;

for (
    at-decl => {input => 'namespace empty "";',
                ast => {"prefix" => "empty", "url" => "", '@' => "namespace"},
    },
    at-decl => {input => 'NAMESPACE "";',
                ast => {"url" => "", '@' => "namespace"},
    },
    at-decl => {input => 'namespace "http://www.w3.org/1999/xhtml";',
                ast => {"url" => "http://www.w3.org/1999/xhtml", '@' => "namespace"},
    },
    at-decl => {input => 'namespace svg "http://www.w3.org/2000/svg";',
                ast => {"prefix" => "svg", "url" => "http://www.w3.org/2000/svg", '@' => "namespace"},
    },
    stylesheet => {input => '@namespace toto url(http://toto.example.org);',
                ast => [at-rule => {"prefix" => "toto", "url" => "http://toto.example.org", '@' => "namespace"}],
    },
    ) {
    my $rule = .key;
    my %test = .value;
    my $input = %test<input>;

    $css_actions.reset;
    my $p3 = CSS::Language::CSS3::Namespaces.parse( $input, :rule($rule), :actions($css_actions));
    CSS::Grammar::Test::parse_tests($input, $p3, :rule($rule), :suite('css3-namespaces'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;
