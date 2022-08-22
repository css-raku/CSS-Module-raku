use v6;
#  -- DO NOT EDIT --
# generated by: make-modules.raku
use NativeCall;
use CSS::Module::Property;

module CSS::Module::SVG::Metadata {
    BEGIN our $property = ${:alignment-baseline(${:default($["see property description", Any]), :inherit(Bool::False), :synopsis("auto | baseline | before-edge | text-before-edge | middle | central | after-edge | text-after-edge | ideographic | alphabetic | hanging | mathematical")}), :baseline-shift(${:default($["baseline", Any]), :inherit(Bool::False), :synopsis("baseline | sub | super | <percentage> | <length>")}), :color(${:default($["depends on user agent"]), :inherit(Bool::True), :synopsis("<color>")}), :color-interpolation(${:default($["sRGB", Any]), :inherit(Bool::True), :synopsis("auto | sRGB | linearRGB")}), :color-interpolation-filters(${:default($["linearRGB", Any]), :inherit(Bool::True), :synopsis("auto | sRGB | linearRGB")}), :color-rendering(${:default($["auto", Any]), :inherit(Bool::True), :synopsis("auto | optimizeSpeed | optimizeQuality")}), :direction(${:default($["ltr", [{:keyw("ltr")},]]), :inherit(Bool::True), :synopsis("ltr | rtl")}), :display(${:default($["inline", [{:keyw("inline")},]]), :inherit(Bool::False), :synopsis("inline | block | list-item | run-in | compact | marker | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none")}), :dominant-baseline(${:default($["auto", Any]), :inherit(Bool::True), :synopsis("auto | use-script | no-change | reset-size | ideographic | alphabetic | hanging | mathematical | central | middle | text-after-edge | text-before-edge")}), :fill(${:default($["black", Any]), :inherit(Bool::True), :synopsis("<paint>")}), :fill-opacity(${:default($["1", Any]), :inherit(Bool::True), :synopsis("<alpha-value>")}), :fill-rule(${:default($["nonzero", Any]), :inherit(Bool::True), :synopsis("nonzero | evenodd")}), :font-family(${:synopsis("<family-name>")}), :font-feature-settings(${:default($["normal", [{:keyw("normal")},]]), :synopsis("normal | <feature-tag-value>#")}), :font-stretch(${:default($["normal", [{:keyw("normal")},]]), :synopsis("normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded")}), :font-style(${:default($["normal", [{:keyw("normal")},]]), :synopsis("normal | italic | oblique")}), :font-variant(${:default($["normal", [{:keyw("normal")},]]), :inherit(Bool::True), :synopsis("normal | small-caps")}), :font-weight(${:default($["normal", [{:keyw("normal")},]]), :synopsis("normal | bold | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900")}), :glyph-orientation-vertical(${:default($["auto", Any]), :inherit(Bool::True), :synopsis("auto | <angle> | <number>")}), :image-rendering(${:default($["auto", Any]), :inherit(Bool::True), :synopsis("auto | optimizeSpeed | optimizeQuality")}), :lighting-color(${:default($["white", Any]), :inherit(Bool::False), :synopsis("<color>")}), :line-height(${:default($["normal", [{:keyw("normal")},]]), :inherit(Bool::True), :synopsis("normal | <number> | <length-percentage>")}), :marker(${:children($["marker-start", "marker-mid", "marker-end"]), :inherit(Bool::True), :synopsis("'marker-start' || 'marker-mid' || 'marker-end'")}), :marker-end(${:default($["none", Any]), :inherit(Bool::True), :synopsis("none | <url>")}), :marker-mid(${:default($["none", Any]), :inherit(Bool::True), :synopsis("none | <url>")}), :marker-start(${:default($["none", Any]), :inherit(Bool::True), :synopsis("none | <url>")}), :opacity(${:default($["1", [{:num(1)},]]), :inherit(Bool::False), :synopsis("<alpha-value>")}), :overflow(${:default($["see prose", Any]), :inherit(Bool::False), :synopsis("visible | hidden | scroll | auto")}), :paint-order(${:default($["normal", Any]), :inherit(Bool::True), :synopsis("normal | [ fill || stroke || markers ]")}), :pointer-events(${:default($["visiblePainted", Any]), :inherit(Bool::True), :synopsis("bounding-box | visiblePainted | visibleFill | visibleStroke | visible | painted | fill | stroke | all | none")}), :shape-rendering(${:default($["auto", Any]), :inherit(Bool::True), :synopsis("auto | optimizeSpeed | crispEdges | geometricPrecision")}), :src(${:synopsis("<font-src-expr>#")}), :stop-color(${:default($["black", Any]), :inherit(Bool::False), :synopsis("currentColor |<color>")}), :stop-opacity(${:default($["1", Any]), :inherit(Bool::False), :synopsis("<alpha-value>")}), :stroke(${:default($["none", Any]), :inherit(Bool::True), :synopsis("<paint>")}), :stroke-dasharray(${:default($["none", Any]), :inherit(Bool::True), :synopsis("none | <dash-elem>#")}), :stroke-dashoffset(${:default($["0", Any]), :inherit(Bool::True), :synopsis("<length-percentage>")}), :stroke-linecap(${:default($["butt", Any]), :inherit(Bool::True), :synopsis("butt | round | square")}), :stroke-linejoin(${:default($["miter", Any]), :inherit(Bool::True), :synopsis("miter | round | bevel")}), :stroke-miterlimit(${:default($["4", Any]), :inherit(Bool::True), :synopsis("<number>")}), :stroke-opacity(${:default($["1", Any]), :inherit(Bool::True), :synopsis("<alpha-value>")}), :stroke-width(${:default($["1", Any]), :inherit(Bool::True), :synopsis("<length-percentage>")}), :text-anchor(${:default($["start", Any]), :inherit(Bool::True), :synopsis("start | middle | end")}), :text-decoration(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::False), :synopsis("none | [ underline || overline || line-through || blink ]")}), :text-overflow(${:default($["clip", Any]), :synopsis("clip | ellipsis")}), :text-rendering(${:default($["auto", Any]), :inherit(Bool::True), :synopsis("auto | optimizeSpeed | optimizeLegibility | geometricPrecision")}), :unicode-range(${:default($["U+0-10FFFF", [{:unicode-range($[0, 1114111])},]]), :synopsis("<urange>#")}), :vector-effect(${:default($["none", Any]), :inherit(Bool::False), :synopsis("non-scaling-stroke | none")}), :visibility(${:default($["visible", [{:keyw("visible")},]]), :inherit(Bool::True), :synopsis("visible | hidden | collapse")}), :white-space(${:default($["normal", [{:keyw("normal")},]]), :inherit(Bool::True), :synopsis("normal | pre | nowrap | pre-wrap | pre-line")}), :writing-mode(${:default($["lr-tb", Any]), :inherit(Bool::True), :synopsis("lr-tb | rl-tb | tb-rl | lr | rl | tb")})};
    our enum prop-names <alignment-baseline baseline-shift color color-interpolation color-interpolation-filters color-rendering direction display dominant-baseline fill fill-opacity fill-rule font-family font-feature-settings font-stretch font-style font-variant font-weight glyph-orientation-vertical image-rendering lighting-color line-height marker marker-end marker-mid marker-start opacity overflow paint-order pointer-events shape-rendering src stop-color stop-opacity stroke stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width text-anchor text-decoration text-overflow text-rendering unicode-range vector-effect visibility white-space writing-mode>;
    our sub index {
        state $ //= do {
            my $enums := prop-names.enums;
            CArray[CSS::Module::Property].new: |$property.sort.map({CSS::Module::Property.new(:$enums, name => .key, |.value)});
        }
    }
}

