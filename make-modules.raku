use v6;

use experimental :rakuast;
use CSS::Specification::Compiler;
use NativeCall;

sub path(RakuAST::Package $p) {
    $p.name.parts>>.name.join: '/';
}

class Build {

    method build($where) {

        indir $where, {
            my %props;

            for (:CSS1[<src css1-properties.txt> => <CSS1>],
                 :CSS21[<src css21-properties.txt> => <CSS21>],
                 :CSS3[<src css3x-font-properties.txt> => <CSS3 Fonts>,
                       <src css3x-paged-media.txt> => <CSS3 PagedMedia>],
                 :SVG[<src svg-properties.txt> => <SVG>],
                 'CSS3::Fonts::AtFontFace' => [<src css3x-font-@fontface-properties.txt> => <CSS3 Fonts AtFontFace>],

                ) {
                my $meta-root = .key;
                %props = () if $meta-root eq 'CSS3::Fonts::AtFontFace';
                for .value.list {
                    my ($input-spec, $class-isa) = .kv;
                    my @base-id = flat <CSS Module>, @$class-isa, <Gen>;
                    my @grammar-id = @base-id.Slip, 'Grammar';
                    my $scope := 'unit';
                    my CSS::Specification::Compiler $compiler .= new;
                    my @defs = $compiler.load-defs($input-spec.join: '/');
                    my %child-props = $compiler.actions.child-props;
                    %props ,= @defs.&build-props(:$meta-root, :%child-props);

                    my RakuAST::Package $grammar = $compiler.build-grammar(@grammar-id, :$scope);
                    "lib/{$grammar.&path}.rakumod".IO.spurt: $grammar.DEPARSE
                     .subst(/";\n;"/, ';', :g); # work-around for https://github.com/rakudo/rakudo/issues/5991

                    my @actions-id = @base-id.Slip, 'Actions';
                    my RakuAST::Package $actions = $compiler.build-actions(@actions-id, :$scope);
                    "lib/{$actions.&path}.rakumod".IO.spurt: $actions.DEPARSE;

                    my @role-id = @base-id.Slip, 'Interface';
                    my RakuAST::Package $interface = $compiler.build-role(@role-id, :$scope);
                    "lib/{$interface.&path}.rakumod".IO.spurt: $interface.DEPARSE;
                }
                
                %props.&write-meta($meta-root);
            }
        }
    }
}

sub build-props(@defs, :$meta-root!, :%child-props --> Hash) {
    my %props;
    my $grammar = (require ::("CSS::Module::{$meta-root}"));
    my $actions = (require ::("CSS::Module::{$meta-root.split('::').head}::Actions"));
    for @defs .grep(*.<props>).sort(*.<props>[0]) {
        my $name = .<props>[0];
        my %details = .<synopsis>:kv;
        %details<inherit> = $_ with .<inherit>;

        with .<default> -> $default {
            unless $default ~~ /agent/ {
                my @d = $default;
                # either a description or concrete term
                $actions .= new;
                with $grammar.parse("$name:$default", :$actions, :rule<declaration>) {
                    @d.push: .ast<property><expr>
                        unless $actions.warnings;
                }
                %details<default> = @d;
            }
        }

        for .<props>.flat -> $prop-name {
            %props{$prop-name} = %details;
        }
    }
    %props.&find-edges(%child-props);
    %props.&check-edges;
    %props;
}

sub find-edges(%props, %child-props) {
    # match boxed properties with children
    for %props.kv -> $key, $value {
        unless $key ~~ / '-'[top|right|bottom|left]<?before ['-'|$$]> / {
            # see if the property has any children
            for <top right bottom left> -> $side {
                # find child. could be xxxx-side (e.g. margin-left)
                # or xxx-yyy-side (e.g. border-left-width);
                for $key ~ '-' ~ $side, $key.subst("-", [~] '-', $side, '-') -> $edge {
                    if $edge ne $key && (%props{$edge}:exists) {
                        my $prop = %props{$edge};
                        $prop<edge> = $key;
                        $value<edges>.push: $edge;
                        $value<box> ||= True;
                        last;
                    }
                }
            }
        }
    }
    for %props.kv -> $key, $value {
        with %child-props{$key} {
            for .unique -> $child-prop {
                next if $value<edges> && $value<edges>.grep($child-prop);
                my $prop = %props{$child-prop};
                # property may have multiple parents
                $value<children>.push: $child-prop;
            }
        }
        # we can get defaults from the children
        $value<default>:delete
            if ($value<edges>:exists)
            || ($value<children>:exists);
    }
}

sub check-edges(%props) {
    for %props.pairs {
        my $key = .key;
        my $value = .value;
        my $edges = $value<edges>;

        note "box property doesn't have four edges $key: $edges"
            if $edges && +$edges != 4;

        my $children = $value<children>;
        if $value<edge> && $children {
            my $non-edges = $children.grep: { ! %props{$_}<edge> };
            note "edge property $key has non-edge properties: $non-edges"
                if $non-edges;
        }
    }
}

sub write-meta(%props, $meta) {
    my $class-dir = $*SPEC.catdir(<lib CSS Module>, $meta.split('::').Slip);
    my $class-path = $*SPEC.catfile( $class-dir, 'Metadata.rakumod' );
    my $class-name = "CSS::Module::{$meta}::Metadata";
    say "Building $class-name";
    {
        my $*OUT = open $class-path, :w;
        say "#  -- DO NOT EDIT --";
        say "# generated by: $*PROGRAM-NAME {@*ARGS}".trim;
        say 'use NativeCall;';
        say 'use CSS::Module::Property;';
        say '';
        say "module $class-name \{";
        say "    BEGIN our \$property = {%props.item.raku};";
        # todo: BEGIN our \$index = ... ; ## Missing serialize REPR function for REPR
        say '    our enum prop-names <' ~ %props.keys.sort.join(' ') ~ '>;';
        say q:to<END>;
            our sub index {
                state $ //= do {
                    my $enums := prop-names.enums;
                    CArray[CSS::Module::Property].new: |$property.sort.map({CSS::Module::Property.new(:$enums, name => .key, |.value)});
                }
            }
        }
        END
        $*OUT.close;
    }
}

sub MAIN(Str $working-directory = '.' ) {
    Build.new.build($working-directory);
}

