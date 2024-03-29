use v6;
#  -- DO NOT EDIT --
# generated by: make-modules.raku
use NativeCall;
use CSS::Module::Property;

module CSS::Module::CSS3::Fonts::AtFontFace::Metadata {
    BEGIN our $property = ${:font-family(${:synopsis("<family-name>")}), :font-feature-settings(${:default($["normal", [{:keyw("normal")},]]), :synopsis("normal | <feature-tag-value>#")}), :font-stretch(${:default($["normal", [{:keyw("normal")},]]), :synopsis("normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded")}), :font-style(${:default($["normal", [{:keyw("normal")},]]), :synopsis("normal | italic | oblique")}), :font-variant(${:default($["normal", [{:keyw("normal")},]]), :synopsis("normal | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]")}), :font-weight(${:default($["normal", [{:keyw("normal")},]]), :synopsis("normal | bold | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900")}), :src(${:synopsis("<font-src-expr>#")}), :unicode-range(${:default($["U+0-10FFFF", [{:unicode-range($[0, 1114111])},]]), :synopsis("<urange>#")})};
    our enum prop-names <font-family font-feature-settings font-stretch font-style font-variant font-weight src unicode-range>;
    our sub index {
        state $ //= do {
            my $enums := prop-names.enums;
            CArray[CSS::Module::Property].new: |$property.sort.map({CSS::Module::Property.new(:$enums, name => .key, |.value)});
        }
    }
}

