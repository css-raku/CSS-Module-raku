#!perl6

# quick script to translate w3c property definitions to draft
# Perl 6 grammars and actions.
#
# it was used to generatate the initial draft grammar and actions for
# CSS::Language:CSS1 and CSS::Language:CSS21 etc. These have since been
# hand-tailored.
#
# Example usage: perl6 etc/gen-properties.pl gen grammar etc/css21-properties.txt etc/css1-properties.txt > /tmp/css21-grammar.pm
#

use CSS::Language::Specification;
use CSS::Language::Specification::Actions;

# actions to generate actions stub. You'll need to pipe stdout somewhere

multi MAIN('gen', 'grammar', $properties_spec?, $base_properties?) {

    my $actions = CSS::Language::Specification::Actions.new;
    my %props = load_props($properties_spec, $actions);
    generate_perl6_rules(%props);

}

multi MAIN('gen', 'actions', $properties_spec?, $base_properties?) {

    my $actions = CSS::Language::Specification::Actions.new;
    my %props = load_props($properties_spec, $actions);

    generate_perl6_actions(%props);
}

sub load_props ($properties_spec, $actions?) {
    my $fh = open($properties_spec // "etc/css21-properties.txt");

    my %props;

    for $fh.lines {
        my $/ = CSS::Language::Specification.parse($_, :rule('property-spec'), :actions($actions) );
        my %prop_details = $/.ast;
        my $prop_names = %prop_details.delete('props');

        for @$prop_names -> $prop_name {
            note "prop $prop_name";
            %props{ $prop_name } = %prop_details;
        }
    }

    return %props;
}

sub generate_perl6_rules(%gen_props) {

    my %seen;

    for %gen_props.kv -> $prop, $def {

        my $sym = $def<sym>;
        next if %seen{$sym}++;

        my $synopsis = $def<synopsis>;
        my $grammar = $def<grammar>;

        say;
        say "    # - $sym: $synopsis";
        say "    rule decl:sym<{$sym}> $grammar";
    }
}

sub generate_perl6_actions(%gen_props) {

    my %seen;

    for %gen_props.kv -> $prop, $def {

        my $sym = $def<sym>;
        next if %seen{$sym}++;

        my $synopsis = $def<synopsis>;

        say;
        say "    method decl:sym<{$sym}>(\$/) \{";
        say "        \$._make_decl(\$/, q\{" ~ $synopsis ~ "\});";
        say "    \}";
    }
}
