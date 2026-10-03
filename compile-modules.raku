use CSS::Specification::Compiler::Make;

sub MAIN(Str $working-directory = '.' ) {
    my %props;
    for ('Module::CSS1' => [<src/css1-properties.tsv>,],
         'Module::CSS21' => [<src/css21-properties.tsv>,],
         'Module::CSS3' => [:inherit,
                            :Fonts<src/css3x-font-properties.tsv>,
                            :PagedMedia<src/css3x-paged-media.tsv>,
                            :Values_and_Units<src/css-values-3-20240322.tsv>,
                           ],
         'Module::SVG' => [:inherit, <src/svg-properties.tsv>,],
         'Module::CSS3::Fonts::AtFontFace' => [<src/css3x-font/@fontface.tsv>,],
        ) -> Pair:D $_ {
        my $root = 'CSS::' ~ .key;
        my @sources = .value.List;
        my Bool ($inherit);
        while @sources.head ~~ Pair:D {
            given @sources.head.key {
                when 'inherit' { $inherit = @sources.shift.value }
                default { last }
            }
        }
        my %inherit = %props if $inherit;
        %props = CSS::Specification::Compiler::Make.make-module($working-directory, $root, @sources, :%inherit);
    }
}

