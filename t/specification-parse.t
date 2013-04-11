#!/usr/bin/env perl6

use Test;

use CSS::Language::Specification;
use CSS::Language::Specification::Actions;
use lib '.';
use t::AST;

my $spec_actions = CSS::Language::Specification::Actions.new;

for (
    'value-list' => {'input' => "<single-animation-direction> [ ‘,’ <single-animation-direction> ]*",
                     ast => "<single-animation-direction> [ ',' <single-animation-direction> ]*",
    },
    'property-spec' => {'input' => "'content'\tnormal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+ | inherit",
                        ast => {
                            "content" => {"synopsis" => "normal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+ | inherit",
                                          "grammar" => "[ [ normal | none ] \& <ident>  | [ [ <string> | <uri> | <counter> | <attr> | [ open\\-quote | close\\-quote | no\\-open\\-quote | no\\-close\\-quote ] \& <ident>  ] ]+ | <inherit> ]"}
                        },
             
    },
    ) {

    my $rule = $_.key;
    my %test = $_.value;
    my $input = %test<input>;

     my $p = CSS::Language::Specification.parse( $input, :rule($rule), :actions($spec_actions));
    t::AST::parse_tests($input, $p, :rule($rule), :suite('spec'),
                         :expected(%test) );
}

done;
