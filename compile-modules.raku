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
            my %inherit;

            for ('Module::CSS1'  => [<src css1-properties.tsv>,],
                 'Module::CSS21' => [<src css21-properties.tsv>,],
                 'Module::CSS3'  => [:inherit,
                                     :Fonts<src css3x-font-properties.tsv>,
                                     :PagedMedia<src css3x-paged-media.tsv>,
                                     :Values_and_Units<src css-values-3-20240322.tsv>,
                      ],
                 'Module::SVG' => [:inherit, <src svg-properties.tsv>,],
                 :Snapshot2026[:link,
                          :Align<src css-snapshot-2026 css-align-3.tsv>,
                          :Animations<src css-snapshot-2026 css-animations-1.tsv>,
                          :Backgrounds<src css-snapshot-2026 css-backgrounds-3.tsv>,
                          :Box<src css-snapshot-2026 css-box-4.tsv>,
                          :Break<src css-snapshot-2026 css-break-1.tsv>,
                          :Compositing<src css-snapshot-2026 css-compositing-1.tsv>,
                          :Color<src css-snapshot-2026 css-color-4.tsv>,
                          :ColorAdjust<src css-snapshot-2026 css-color-adjust-1.tsv>,
                          :Fonts<src css-snapshot-2026 css-fonts-4.tsv>,
                          'Fonts::Defs' => <src css-snapshot-2026 css-fonts-4 defs.tsv>,
                          :FilterEffects<src css-snapshot-2026 css-filter-effects-1.tsv>,
                          :Images<src css-snapshot-2026 css-images-3.tsv>,
                          :Inline<src css-snapshot-2026 css-inline-3.tsv>,
                          :Logical<src css-snapshot-2026 css-logical-1.tsv>,
                          :Masking<src css-snapshot-2026 css-masking-1.tsv>,
                          :MultiCol<src css-snapshot-2026 css-multicol-1.tsv>,
                          :PagedMedia<src css3x-paged-media.tsv>,
                          :Shapes<src css-snapshot-2026 css-shapes-1.tsv>,
                          :Speech<src css-snapshot-2026 css-speech-1.tsv>,
                          :SVG<src css-snapshot-2026 svg2-propidx.tsv>,
                          :Text<src css-snapshot-2026 css-text-3.tsv>,
                          :Transforms<src css-snapshot-2026 css-transforms-2.tsv>,
                          :UI<src css-snapshot-2026 css-ui-3.tsv>,
                          :Values<src css-snapshot-2026 css-values-5.tsv>,
                          :WritingModes<src css-snapshot-2026 css-writing-modes-4.tsv>,
                          :CSS21<src css21-properties.tsv>,
                      ],
                 'Snapshot2026::Fonts' => [:AtFontFace<src css-snapshot-2026 css-fonts-4 @fontface.tsv>],
                 'Module::CSS3::Fonts::AtFontFace' => [<src css3x-font-@fontface-properties.tsv>,],
                ) {
                my $meta-root = .key;
                my @modules = .value.list;
                my %props;

                my @group-id = flat <CSS>, $meta-root.split('::');
                note "Building $meta-root";

                my @module-ids;

                subset Flag of Pair where .value ~~ Bool;
                my Bool ($inherit, $link);
                while @modules.head ~~ Flag {
                    given @modules.shift.key {
                        when 'inherit' { $inherit = True }
                        when 'link'    { $link = True }
                    }
                }

                for @modules {
                    my ($module, $input-spec) = .isa(Pair) ?? .kv !! ([], $_);
                    my @base-id = flat @group-id, @$module, <Gen>;
                    my @grammar-id = @base-id.Slip, 'Grammar';
                    my $scope := 'unit';
                    my CSS::Specification::Compiler $compiler .= new;
                    my $file = $input-spec.join: '/';
                    my @defs = $compiler.load-defs: :$file;
                    my %child-rules = $compiler.child-rules;

                    note " - " ~ $file;
                    mkdir 'lib/' ~ @base-id.join('/');
                    my RakuAST::Package $grammar-ast = $compiler.compile-grammar(@grammar-id, :$scope);
                    "lib/{$grammar-ast.&path}.rakumod".IO.spurt: $grammar-ast.DEPARSE;

                    my @actions-id = @base-id.Slip, 'Actions';
                    my RakuAST::Package $actions-ast = $compiler.compile-actions(@actions-id, :$scope);
                    "lib/{$actions-ast.&path}.rakumod".IO.spurt: $actions-ast.DEPARSE;

                    my @external-id = @base-id.Slip, 'External';
                    my RakuAST::Package $external-ast = $compiler.compile-external(@external-id, :$scope);
                    "lib/{$external-ast.&path}.rakumod".IO.spurt: $external-ast.DEPARSE;

                    my %meta = @defs.&build-metadata(:%child-rules);
                    %props{.key} //= .value for %meta.pairs;
                    @module-ids.push: @base-id;
                }

                if $inherit {
                    %props{.key} //= .value for %inherit.pairs;
                }
                %inherit := %props;

                %props.&write-metadata($meta-root);

                if $link {
                    my @actions-link-id = flat @group-id, 'Gen', 'Actions';
                    my @grammar-link-id = flat @group-id, 'Gen', 'Grammar';
                    my @external-link-id = flat @group-id, 'Gen', 'External';
                    # my @use-ids = @module-ids.map: { .Slip, 'Actions' }
                    # RakuAST version nyi (Raku v2026.05)
                    # my RakuAST::Package $actions-package = CSS::Specification::Compiler.link-actions(@actions-link-id, @module-ids);
                    # "lib/{$actions-package.&path}.rakumod".IO.spurt: $actions-package.DEPARSE;
                    ("lib/" ~ @actions-link-id.join('/') ~ ".rakumod").IO.spurt:  link-actions(@actions-link-id, @module-ids);
                    ("lib/" ~ @grammar-link-id.join('/') ~ ".rakumod").IO.spurt:  link-grammar(@grammar-link-id, @module-ids);
                    ("lib/" ~ @external-link-id.join('/') ~ ".rakumod").IO.spurt: link-external(@external-link-id, @module-ids);
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

sub link-grammar(@group-id, @modules) {
    my @lines = 'unit grammar ' ~  @group-id.join('::') ~ ';';
    @lines.push: '';
    for @modules {
        my $name = (.Slip, 'Grammar').join('::');
        @lines.push: "use {$name};";
        @lines.push: "also is {$name};";
    }
    @lines.join("\n") ~ "\n";
}

sub link-external(@group-id, @modules) {
    my @lines = 'unit role ' ~  @group-id.join('::') ~ ';';
    @lines.push: '';
    for @modules {
        my $name = (.Slip, 'External').join('::');
        @lines.push: "use {$name};";
        @lines.push: "also does {$name};";
    }
    @lines.join("\n") ~ "\n";
}

sub write-metadata(%props, $meta) {
    my $class-dir = $*SPEC.catdir(<lib CSS>, $meta.split('::').Slip);
    my $class-path = $*SPEC.catfile( $class-dir, 'Metadata.rakumod' );
    my $class-name = "CSS::{$meta}::Metadata";
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

