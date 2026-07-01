use v6;

use experimental :rakuast;
use CSS::Specification::Compiler :&build-metadata;
use NativeCall;

sub path(RakuAST::Package $p) {
    $p.name.parts>>.name.join: '/';
}

class Make {

    method make($where) {

        indir $where, {
            my %props;

            for ('Module::CSS1'  => [<src css1-properties.tsv>,],
                 'Module::CSS21' => [<src css21-properties.tsv>,],
                 'Module::CSS3'  => [
                                     :Fonts<src css3x-font-properties.tsv>,
                                     :PagedMedia<src css3x-paged-media.tsv>,
                                     :Values_and_Units<src css-values-3-20240322.tsv>,
                      ],
                 'Module::SVG' => [<src svg-properties.tsv>,],
                 :Snapshot2026[
                          :Backgrounds<src css-snapshot-2026 css-backgrounds-3.tsv>,
                          :Box<src css-snapshot-2026 css-box-4.tsv>,
                          :Color<src css-snapshot-2026 css-color-4.tsv>,
                          :Images<src css-snapshot-2026 css-images-3.tsv>,
                          :Masking<src css-snapshot-2026 css-masking-1.tsv>,
                          :Shapes<src css-snapshot-2026 css-shapes-1.tsv>,
                          :Values<src css-snapshot-2026 css-values-5.tsv>,
                      ],
                 'Module::CSS3::Fonts::AtFontFace' => [<src css3x-font-@fontface-properties.tsv>,],
                ) {
                my $meta-root = .key;
                my @module-ids;
                %props = () if $meta-root eq 'CSS3::Fonts::AtFontFace';
                my @group-id = flat <CSS>, $meta-root.split('::');
                for .value.list {
                    my ($module, $input-spec) = .isa(Pair) ?? .kv !! ([], $_);
                    my @base-id = flat @group-id, @$module, <Gen>;
                    my @grammar-id = @base-id.Slip, 'Grammar';
                    my $scope := 'unit';
                    my CSS::Specification::Compiler $compiler .= new;
                    my $file = $input-spec.join: '/';
                    my @defs = $compiler.load-defs: :$file;
                    my %child-props = $compiler.child-props;

                    my RakuAST::Package $grammar-ast = $compiler.compile-grammar(@grammar-id, :$scope);
                    "lib/{$grammar-ast.&path}.rakumod".IO.spurt: $grammar-ast.DEPARSE;

                    my @actions-id = @base-id.Slip, 'Actions';
                    my RakuAST::Package $actions-ast = $compiler.compile-actions(@actions-id, :$scope);
                    "lib/{$actions-ast.&path}.rakumod".IO.spurt: $actions-ast.DEPARSE;

                    my @external-id = @base-id.Slip, 'External';
                    my RakuAST::Package $external-ast = $compiler.compile-external(@external-id, :$scope);
                    "lib/{$external-ast.&path}.rakumod".IO.spurt: $external-ast.DEPARSE;

                    my %meta = @defs.&build-metadata(:%child-props);
                    %props ,= %meta;
                    @module-ids.push: @base-id;
                }
                %props.&write-metadata($meta-root);
                if $meta-root eq 'Snapshot2026' {
                    my @actions-link-id = flat @group-id, 'Gen', 'Actions';
                    my @grammar-link-id = flat @group-id, 'Gen', 'Grammar';
                    # my @use-ids = @module-ids.map: { .Slip, 'Actions' }
                    # RakuAST version nyi (Raku v2026.05)
                    # my RakuAST::Package $actions-package = CSS::Specification::Compiler.link-actions(@link-id, @use-ids);
                    # "lib/{$actions-package.&path}.rakumod".IO.spurt: $actions-package.DEPARSE;
                    ("lib/" ~ @actions-link-id.join('/') ~ ".rakumod").IO.spurt: link-actions(@actions-link-id, @module-ids);
                    ("lib/" ~ @grammar-link-id.join('/') ~ ".rakumod").IO.spurt: link-grammars(@grammar-link-id, @module-ids);
                }
            }
        }
    }
}

# Non-RakuAST implementations
sub link-actions(@group-id, @modules) {
    my @lines = 'unit class ' ~  @group-id.join('::') ~ ';';
    @lines.push: '';
    for @modules {
        my $name = (.Slip, 'Actions').join('::');
        @lines.push: "use {$name};";
        @lines.push: "also is {$name};";
    }
    @lines.push('').join: "\n";
}

sub link-grammars(@group-id, @modules) {
    my @lines = 'unit grammar ' ~  @group-id.join('::') ~ ';';
    @lines.push: '';
    for @modules {
        my $name = (.Slip, 'Grammar').join('::');
        @lines.push: "use {$name};";
        @lines.push: "also is {$name};";
    }
    @lines.push: '';
    for @modules {
        my $name = (.Slip, 'External').join('::');
        @lines.push: "use {$name};";
        @lines.push: "also does {$name};";
    }
    @lines.push('').join: "\n";
}

sub write-metadata(%props, $meta) {
    my $class-dir = $*SPEC.catdir(<lib CSS>, $meta.split('::').Slip);
    my $class-path = $*SPEC.catfile( $class-dir, 'Metadata.rakumod' );
    my $class-name = "CSS::{$meta}::Metadata";
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
    Make.new.make($working-directory);
}

