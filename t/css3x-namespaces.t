#!/usr/bin/env perl6

use Test;

use CSS::Module::CSS3::Namespaces;
use CSS::Grammar::Test;

my $actions = CSS::Module::CSS3::Namespaces::Actions.new;

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
                ast => [{at-rule => {"prefix" => "toto", "url" => "http://toto.example.org", '@' => "namespace"}}],
    },
    ) {
    my $rule = .key;
    my $expected = .value;
    my $input = $expected<input>;

    CSS::Grammar::Test::parse-tests(CSS::Module::CSS3::Namespaces, $input,
				    :$rule,
				    :$actions,
				    :suite<css3-namespaces>,
				    :$expected );
}

done;
