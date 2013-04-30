#!/usr/bin/env perl6

# quick script to translate w3c property definitions to draft
# Perl 6 grammars and actions.
#
# it was used to generate the initial draft grammar and actions for
# CSS::Language:CSS1 and CSS::Language:CSS21 etc. These have since been
# hand-tailored.
#
# Example: perl6 etc/gen-properties.pl gen grammar etc/css21-properties.txt
#

use CSS::Language::Specification;
use CSS::Language::Specification::Actions;

# actions to generate actions stub. You'll need to pipe stdout somewhere

multi MAIN('gen', 'grammar', $properties-spec?) {

    my $actions = CSS::Language::Specification::Actions.new;
    my %props = load-props($properties-spec, $actions);
    generate-perl6-rules(%props, $actions.prop-refs);

}

multi MAIN('gen', 'actions', $properties-spec?) {

    my $actions = CSS::Language::Specification::Actions.new;
    my %props = load-props($properties-spec, $actions);
    generate-perl6-actions(%props, $actions.prop-refs);
}

multi MAIN('diff', $properties-spec1,  $properties-spec2) {

    my $actions = CSS::Language::Specification::Actions.new;
    my %props1 = load-props($properties-spec1, $actions);
    my %props2 = load-props($properties-spec2, $actions);

    for %props1.keys {
        say $_ unless %props2.exists($_);
    }
}

sub load-props ($properties-spec, $actions?) {
    my $fh = open($properties-spec // "etc/css21-properties.txt");

    my %props;

    for $fh.lines ~> $spec {
        # '| inherit' annd '| initial' are used inconsistantly. get rid
        # of them
        $spec = $spec.subst(/\s* '|'? \s* [inherit|initial]/, ''):g;

        my $/ = CSS::Language::Specification.parse($spec, :rule('property-spec'), :actions($actions) );
        my %prop_details = $/.ast;
        my $prop_names = %prop_details.<props>;

        for @$prop_names -> $prop_name {
            note "prop $prop_name";
            %props{ $prop_name } = %prop_details;
        }
    }

    return %props;
}

sub generate-perl6-rules(%gen-props, %prop-refs) {

    my %seen;

    for %gen-props.kv -> $prop, $def {

        my $sym = $def<sym>;
        next if %seen{$sym}++;

        my $synopsis = $def<synopsis>;
        my $match = $def<match>;
        my $defn = $def<defn>;
        my $props = $def<props>;

        for $defn {
            next unless /^\s*\[/ && /\]\s*$/;
            s/^\s*\[\s*//;
            s/\s*\]\s*$//;
        }

        say;
        say "    # - $sym: $synopsis";

        if @$props == 1 && %prop-refs{ $props[0] } {
            # property is referenced by other definitions; factor out body
            $defn ~~  s/\|\s*\<inherit\>\s*//;
            say "    token $sym \{:i $defn \}";
            say "    rule decl:sym<{$sym}> \{:i ($match) ':'  [ <$sym> || <misc> ] \}";
        }
        else {
            say "    rule decl:sym<{$sym}> \{:i ($match) ':'  [ $defn || <misc> ] \}";
        }
    }
}

sub generate-perl6-actions(%gen-props, %prop-refs) {

    my %seen;

    for %gen-props.kv -> $prop, $def {

        my $sym = $def<sym>;
        next if %seen{$sym}++;

        my $synopsis = $def<synopsis>;
        my $props = $def<props>;

        say;
        if @$props == 1 && %prop-refs{ $props[0] } {
            # property is referenced by other definitions; factor out body
            say "    method {$sym}(\$/) \{ make \$.list(\$/) \}";
            say "    method decl:sym<{$sym}>(\$/) \{";
            say "        \$._make_decl(\$/, q\{" ~ $synopsis ~ "\}, :body(\$<$sym>));";
            say "    \}";      
        }
        else {
            say "    method decl:sym<{$sym}>(\$/) \{";
            say "        \$._make_decl(\$/, q\{" ~ $synopsis ~ "\});";
            say "    \}";
        }
    }
}
