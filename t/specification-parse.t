#!/usr/bin/env perl6

use Test;

use CSS::Language::Specification;
use CSS::Language::Specification::Actions;
use CSS::Grammar::Test;

my $actions = CSS::Language::Specification::Actions.new;

for (
    'terms' => {'input' => "<single-animation-direction> [, <'single-animation-direction'> ]*",
                ast => "<single-animation-direction> [ ',' <expr-single-animation-direction> ]*",
    },
    # precedence tests taken from: https://developer.mozilla.org/en-US/docs/CSS/Value_definition_syntax
    'terms' => {input => 'bold thin && <length>',
                ast => "[ bold \& <keyw> thin \& <keyw> | <length> ]**2",
    },
    'terms' => {input => 'bold || thin && <length>',
                ast => "[:my @*SEEN; bold & <keyw> <!seen(0)> | [ thin & <keyw> | <length> ]**2 <!seen(1)> ]+",
    },
    'property-spec' => {'input' => "'content'\tnormal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+ | inherit",
                        ast => {"props" => ["content"],
                                "terms" => "[ [ normal | none ] \& <keyw> | [ [ <string> | <uri> | <counter> | <attr> | [ open\\-quote | close\\-quote | no\\-open\\-quote | no\\-close\\-quote ] \& <keyw> ] ]+ | inherit & <keyw> ]",
                                "synopsis" => "normal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+ | inherit"},
    },
    # css1 spec with property name and '*' junk
    property-spec => {input => "'width' *\t<length> | <percentage> | auto",
                      ast => Mu,
    },
    ) {

    my $rule = .key;
    my %test = .value;
    my $input = %test<input>;

    CSS::Grammar::Test::parse-tests( CSS::Language::Specification, $input,
				     :rule($rule),
				     :actions($actions),
				     :suite<spec>,
				     :expected(%test) );
}

done;
