#!perl6

# quick and dirty script to translate w3c property definitions to
# Perl 6 grammars and actions

use CSS::Language::Specification;
use CSS::Lange::Specification::Actions;

# actions to generate actions stub. You'll need to pipe stdout somewhere


multi MAIN('gen', 'grammar', $properties_spec?, $properties_isa?) {

}

multi MAIN('gen', 'actions', $properties_spec?, $base_properties?) {

    my $actions = CSS::Lange::Specification::Actions.new;
    my %gen_props = load_props($properties_spec, $actions);
    my %base_props = load_props($base_properties, $actions)
        if $base_properties;

    generate_perl6_actions(%gen_props, %base_props);
}

sub load_props ($properties_spec, $actions?) {
    my $fh = open($properties_spec // "etc/css21-properties.txt");

    my %props;

    for $fh.lines {
        my $/ = CSS::Language::Specification.parse($_, :rule('property-spec'), :actions($actions) );
        my %prop = $/.ast;

        for %prop.kv -> $k,$v {
            note "prop $k -> $v";
            %props{$k} = $v;
        }
    }

    return %props;
}

sub generate_perl6_actions(%gen_props,%base_props) {

    for %gen_props.kv -> $prop, $def {

        my $synopsis = $def<synopsis>;
        my $cmp_synopsis = $synopsis.subst(/\s*\|\s*inherit\s*$/,'');
        warn "$prop synopsis: $cmp_synopsis";
        warn "base synopsis:" ~ %base_props{$prop}<synopsis>
            if %base_props.exists($prop);

        my $inherit = %base_props.exists($prop)
            && %base_props{$prop}<synopsis> eq $cmp_synopsis;

        say;
        if $inherit {
            say "# -- $prop: $synopsis  -- inherited";
        }
        else {
            say "    method decl:sym<{$prop}>(\$/) \{";
            say "        \$._make_decl(\$/, q\{" ~ $synopsis ~ "\});";
            say "    \}";
        }
    }
}
