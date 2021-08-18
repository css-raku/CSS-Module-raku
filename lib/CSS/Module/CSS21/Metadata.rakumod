use v6;
#  -- DO NOT EDIT --
# generated by: make-modules.raku
use NativeCall;
use CSS::Module::Property;

module CSS::Module::CSS21::Metadata {
    BEGIN our $property = ${:azimuth(${:default($["center", [{:keyw("center")},]]), :inherit(Bool::True), :synopsis("<angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards")}), :background(${:children($["background-color", "background-image", "background-repeat", "background-attachment", "background-position"]), :inherit(Bool::False), :synopsis("['background-color' || 'background-image' || 'background-repeat' || 'background-attachment' || 'background-position']")}), :background-attachment(${:default($["scroll", [{:keyw("scroll")},]]), :inherit(Bool::False), :synopsis("scroll | fixed")}), :background-color(${:default($["transparent", [{:keyw("transparent")},]]), :inherit(Bool::False), :synopsis("<color> | transparent")}), :background-image(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::False), :synopsis("<uri> | none")}), :background-position(${:default($["0\% 0\%", [{:percent(0)}, {:percent(0)}]]), :inherit(Bool::False), :synopsis("[ [ <percentage> | <length> | <align> ] [ <percentage> | <length> | <valign> ]? ] | [ <align> || <valign> ]")}), :background-repeat(${:default($["repeat", [{:keyw("repeat")},]]), :inherit(Bool::False), :synopsis("repeat | repeat-x | repeat-y | no-repeat")}), :border(${:box(Bool::True), :children($["border-width", "border-style", "border-color"]), :edges($["border-top", "border-right", "border-bottom", "border-left"]), :inherit(Bool::False), :synopsis("[ 'border-width' || 'border-style' || 'border-color' ]")}), :border-bottom(${:children($["border-bottom-width", "border-bottom-style", "border-bottom-color"]), :edge("border"), :inherit(Bool::False), :synopsis("[ 'border-bottom-width' || 'border-bottom-style' || 'border-bottom-color' ]")}), :border-bottom-color(${:default($["the value of the 'color' property", Any]), :edge("border-color"), :inherit(Bool::False), :synopsis("<color> | transparent")}), :border-bottom-style(${:default($["none", [{:keyw("none")},]]), :edge("border-style"), :inherit(Bool::False), :synopsis("<border-style>")}), :border-bottom-width(${:default($["medium", [{:keyw("medium")},]]), :edge("border-width"), :inherit(Bool::False), :synopsis("<border-width>")}), :border-collapse(${:default($["separate", [{:keyw("separate")},]]), :inherit(Bool::True), :synopsis("collapse | separate")}), :border-color(${:box(Bool::True), :edges($["border-top-color", "border-right-color", "border-bottom-color", "border-left-color"]), :inherit(Bool::False), :synopsis("[ <color> | transparent ]\{1,4}")}), :border-left(${:children($["border-left-width", "border-left-style", "border-left-color"]), :edge("border"), :inherit(Bool::False), :synopsis("[ 'border-left-width' || 'border-left-style' || 'border-left-color' ]")}), :border-left-color(${:default($["the value of the 'color' property", Any]), :edge("border-color"), :inherit(Bool::False), :synopsis("<color> | transparent")}), :border-left-style(${:default($["none", [{:keyw("none")},]]), :edge("border-style"), :inherit(Bool::False), :synopsis("<border-style>")}), :border-left-width(${:default($["medium", [{:keyw("medium")},]]), :edge("border-width"), :inherit(Bool::False), :synopsis("<border-width>")}), :border-right(${:children($["border-right-width", "border-right-style", "border-right-color"]), :edge("border"), :inherit(Bool::False), :synopsis("[ 'border-right-width' || 'border-right-style' || 'border-right-color' ]")}), :border-right-color(${:default($["the value of the 'color' property", Any]), :edge("border-color"), :inherit(Bool::False), :synopsis("<color> | transparent")}), :border-right-style(${:default($["none", [{:keyw("none")},]]), :edge("border-style"), :inherit(Bool::False), :synopsis("<border-style>")}), :border-right-width(${:default($["medium", [{:keyw("medium")},]]), :edge("border-width"), :inherit(Bool::False), :synopsis("<border-width>")}), :border-spacing(${:default($["0", [{:px(0)},]]), :inherit(Bool::True), :synopsis("<length> <length>?")}), :border-style(${:box(Bool::True), :edges($["border-top-style", "border-right-style", "border-bottom-style", "border-left-style"]), :inherit(Bool::False), :synopsis("<border-style>\{1,4}")}), :border-top(${:children($["border-top-width", "border-top-style", "border-top-color"]), :edge("border"), :inherit(Bool::False), :synopsis("[ 'border-top-width' || 'border-top-style' || 'border-top-color' ]")}), :border-top-color(${:default($["the value of the 'color' property", Any]), :edge("border-color"), :inherit(Bool::False), :synopsis("<color> | transparent")}), :border-top-style(${:default($["none", [{:keyw("none")},]]), :edge("border-style"), :inherit(Bool::False), :synopsis("<border-style>")}), :border-top-width(${:default($["medium", [{:keyw("medium")},]]), :edge("border-width"), :inherit(Bool::False), :synopsis("<border-width>")}), :border-width(${:box(Bool::True), :edges($["border-top-width", "border-right-width", "border-bottom-width", "border-left-width"]), :inherit(Bool::False), :synopsis("<border-width>\{1,4}")}), :bottom(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::False), :synopsis("<length> | <percentage> | auto")}), :caption-side(${:default($["top", [{:keyw("top")},]]), :inherit(Bool::True), :synopsis("top | bottom")}), :clear(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::False), :synopsis("none | left | right | both")}), :clip(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::False), :synopsis("<shape> | auto")}), :color(${:default($["depends on user agent"]), :inherit(Bool::True), :synopsis("<color>")}), :content(${:default($["normal", [{:keyw("normal")},]]), :inherit(Bool::False), :synopsis("normal | none | [ <string> | <uri> | <counter> | <counters> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+")}), :counter-increment(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::False), :synopsis("none | [ <identifier> <integer>? ]+")}), :counter-reset(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::False), :synopsis("none | [ <identifier> <integer>? ]+")}), :cue(${:children($["cue-before", "cue-after"]), :inherit(Bool::False), :synopsis("[ 'cue-before' || 'cue-after' ]")}), :cue-after(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::False), :synopsis("<uri> | none")}), :cue-before(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::False), :synopsis("<uri> | none")}), :cursor(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::True), :synopsis("[ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ]")}), :direction(${:default($["ltr", [{:keyw("ltr")},]]), :inherit(Bool::True), :synopsis("ltr | rtl")}), :display(${:default($["inline", [{:keyw("inline")},]]), :inherit(Bool::False), :synopsis("inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none")}), :elevation(${:default($["level", [{:keyw("level")},]]), :inherit(Bool::True), :synopsis("<angle> | below | level | above | higher | lower")}), :empty-cells(${:default($["show", [{:keyw("show")},]]), :inherit(Bool::True), :synopsis("show | hide")}), :float(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::False), :synopsis("left | right | none")}), :font(${:children($["font-style", "font-variant", "font-weight", "font-size", "line-height", "font-family"]), :inherit(Bool::True), :synopsis("[ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family' ] | caption | icon | menu | message-box | small-caption | status-bar")}), :font-family(${:default($["depends on user agent"]), :inherit(Bool::True), :synopsis("[ <generic-family> | <family-name> ]#")}), :font-size(${:default($["medium", [{:keyw("medium")},]]), :inherit(Bool::True), :synopsis("<absolute-size> | <relative-size> | <length>")}), :font-style(${:default($["normal", [{:keyw("normal")},]]), :inherit(Bool::True), :synopsis("normal | italic | oblique")}), :font-variant(${:default($["normal", [{:keyw("normal")},]]), :inherit(Bool::True), :synopsis("normal | small-caps")}), :font-weight(${:default($["normal", [{:keyw("normal")},]]), :inherit(Bool::True), :synopsis("normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900")}), :height(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::False), :synopsis("<length> | <percentage> | auto")}), :left(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::False), :synopsis("<length> | <percentage> | auto")}), :letter-spacing(${:default($["normal", [{:keyw("normal")},]]), :inherit(Bool::True), :synopsis("normal | <length>")}), :line-height(${:default($["normal", [{:keyw("normal")},]]), :inherit(Bool::True), :synopsis("normal | <number> | <length> | <percentage>")}), :list-style(${:children($["list-style-type", "list-style-position", "list-style-image"]), :inherit(Bool::True), :synopsis("[ 'list-style-type' || 'list-style-position' || 'list-style-image' ]")}), :list-style-image(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::True), :synopsis("<uri> | none")}), :list-style-position(${:default($["outside", [{:keyw("outside")},]]), :inherit(Bool::True), :synopsis("inside | outside")}), :list-style-type(${:default($["disc", [{:keyw("disc")},]]), :inherit(Bool::True), :synopsis("disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none")}), :margin(${:box(Bool::True), :edges($["margin-top", "margin-right", "margin-bottom", "margin-left"]), :inherit(Bool::False), :synopsis("<margin-width>\{1,4}")}), :margin-bottom(${:default($["0", [{:px(0)},]]), :edge("margin"), :inherit(Bool::False), :synopsis("<margin-width>")}), :margin-left(${:default($["0", [{:px(0)},]]), :edge("margin"), :inherit(Bool::False), :synopsis("<margin-width>")}), :margin-right(${:default($["0", [{:px(0)},]]), :edge("margin"), :inherit(Bool::False), :synopsis("<margin-width>")}), :margin-top(${:default($["0", [{:px(0)},]]), :edge("margin"), :inherit(Bool::False), :synopsis("<margin-width>")}), :max-height(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::False), :synopsis("<length> | <percentage> | none")}), :max-width(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::False), :synopsis("<length> | <percentage> | none")}), :min-height(${:default($["0", [{:px(0)},]]), :inherit(Bool::False), :synopsis("<length> | <percentage>")}), :min-width(${:default($["0", [{:px(0)},]]), :inherit(Bool::False), :synopsis("<length> | <percentage>")}), :opacity(${:default($["1.0", [{:num(1)},]]), :inherit(Bool::False), :synopsis("<number>")}), :orphans(${:default($["2", [{:int(2)},]]), :inherit(Bool::True), :synopsis("<integer>")}), :outline(${:children($["outline-color", "outline-style", "outline-width"]), :inherit(Bool::False), :synopsis("[ 'outline-color' || 'outline-style' || 'outline-width' ]")}), :outline-color(${:default($["invert", [{:keyw("invert")},]]), :inherit(Bool::False), :synopsis("<color> | invert")}), :outline-style(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::False), :synopsis("[ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]")}), :outline-width(${:default($["medium", [{:keyw("medium")},]]), :inherit(Bool::False), :synopsis("thin | medium | thick | <length>")}), :overflow(${:default($["visible", [{:keyw("visible")},]]), :inherit(Bool::False), :synopsis("visible | hidden | scroll | auto")}), :padding(${:box(Bool::True), :edges($["padding-top", "padding-right", "padding-bottom", "padding-left"]), :inherit(Bool::False), :synopsis("<padding-width>\{1,4}")}), :padding-bottom(${:default($["0", [{:px(0)},]]), :edge("padding"), :inherit(Bool::False), :synopsis("<padding-width>")}), :padding-left(${:default($["0", [{:px(0)},]]), :edge("padding"), :inherit(Bool::False), :synopsis("<padding-width>")}), :padding-right(${:default($["0", [{:px(0)},]]), :edge("padding"), :inherit(Bool::False), :synopsis("<padding-width>")}), :padding-top(${:default($["0", [{:px(0)},]]), :edge("padding"), :inherit(Bool::False), :synopsis("<padding-width>")}), :page-break-after(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::False), :synopsis("auto | always | avoid | left | right")}), :page-break-before(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::False), :synopsis("auto | always | avoid | left | right")}), :page-break-inside(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::False), :synopsis("avoid | auto")}), :pause(${:inherit(Bool::False), :synopsis("[ [<time> | <percentage>]\{1,2} ]")}), :pause-after(${:default($["0", [{:s(0)},]]), :inherit(Bool::False), :synopsis("<time> | <percentage>")}), :pause-before(${:default($["0", [{:s(0)},]]), :inherit(Bool::False), :synopsis("<time> | <percentage>")}), :pitch(${:default($["medium", [{:keyw("medium")},]]), :inherit(Bool::True), :synopsis("<frequency> | x-low | low | medium | high | x-high")}), :pitch-range(${:default($["50", [{:num(50)},]]), :inherit(Bool::True), :synopsis("<number>")}), :play-during(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::False), :synopsis("<uri> [ mix || repeat ]? | auto | none")}), :position(${:default($["static", [{:keyw("static")},]]), :inherit(Bool::False), :synopsis("static | relative | absolute | fixed")}), :quotes(${:default($["depends on user agent"]), :inherit(Bool::True), :synopsis("[<string> <string>]+ | none")}), :richness(${:default($["50", [{:num(50)},]]), :inherit(Bool::True), :synopsis("<number>")}), :right(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::False), :synopsis("<length> | <percentage> | auto")}), :size(${:default($["auto", [{:keyw("auto")},]]), :synopsis("<length>\{1,2} | auto | portrait | landscape")}), :speak(${:default($["normal", [{:keyw("normal")},]]), :inherit(Bool::True), :synopsis("normal | none | spell-out")}), :speak-header(${:default($["once", [{:keyw("once")},]]), :inherit(Bool::True), :synopsis("once | always")}), :speak-numeral(${:default($["continuous", [{:keyw("continuous")},]]), :inherit(Bool::True), :synopsis("digits | continuous")}), :speak-punctuation(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::True), :synopsis("code | none")}), :speech-rate(${:default($["medium", [{:keyw("medium")},]]), :inherit(Bool::True), :synopsis("<number> | x-slow | slow | medium | fast | x-fast | faster | slower")}), :stress(${:default($["50", [{:num(50)},]]), :inherit(Bool::True), :synopsis("<number>")}), :table-layout(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::False), :synopsis("auto | fixed")}), :text-align(${:default($["a nameless value that acts as 'left' if 'direction' is 'ltr', 'right' if 'direction' is 'rtl'", Any]), :inherit(Bool::True), :synopsis("<align> | justify")}), :text-decoration(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::False), :synopsis("none | [ underline || overline || line-through || blink ]")}), :text-indent(${:default($["0", [{:px(0)},]]), :inherit(Bool::True), :synopsis("<length> | <percentage>")}), :text-transform(${:default($["none", [{:keyw("none")},]]), :inherit(Bool::True), :synopsis("capitalize | uppercase | lowercase | none")}), :top(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::False), :synopsis("<length> | <percentage> | auto")}), :unicode-bidi(${:default($["normal", [{:keyw("normal")},]]), :inherit(Bool::False), :synopsis("normal | embed | bidi-override")}), :vertical-align(${:default($["baseline", [{:keyw("baseline")},]]), :inherit(Bool::False), :synopsis("baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length>")}), :visibility(${:default($["visible", [{:keyw("visible")},]]), :inherit(Bool::True), :synopsis("visible | hidden | collapse")}), :voice-family(${:default($["depends on user agent"]), :inherit(Bool::True), :synopsis("[<generic-voice> | <specific-voice> ]#")}), :volume(${:default($["medium", [{:keyw("medium")},]]), :inherit(Bool::True), :synopsis("<number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud")}), :white-space(${:default($["normal", [{:keyw("normal")},]]), :inherit(Bool::True), :synopsis("normal | pre | nowrap | pre-wrap | pre-line")}), :widows(${:default($["2", [{:int(2)},]]), :inherit(Bool::True), :synopsis("<integer>")}), :width(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::False), :synopsis("<length> | <percentage> | auto")}), :word-spacing(${:default($["normal", [{:keyw("normal")},]]), :inherit(Bool::True), :synopsis("normal | <length>")}), :z-index(${:default($["auto", [{:keyw("auto")},]]), :inherit(Bool::False), :synopsis("auto | <integer>")})};
    our enum prop-names <azimuth background background-attachment background-color background-image background-position background-repeat border border-bottom border-bottom-color border-bottom-style border-bottom-width border-collapse border-color border-left border-left-color border-left-style border-left-width border-right border-right-color border-right-style border-right-width border-spacing border-style border-top border-top-color border-top-style border-top-width border-width bottom caption-side clear clip color content counter-increment counter-reset cue cue-after cue-before cursor direction display elevation empty-cells float font font-family font-size font-style font-variant font-weight height left letter-spacing line-height list-style list-style-image list-style-position list-style-type margin margin-bottom margin-left margin-right margin-top max-height max-width min-height min-width opacity orphans outline outline-color outline-style outline-width overflow padding padding-bottom padding-left padding-right padding-top page-break-after page-break-before page-break-inside pause pause-after pause-before pitch pitch-range play-during position quotes richness right size speak speak-header speak-numeral speak-punctuation speech-rate stress table-layout text-align text-decoration text-indent text-transform top unicode-bidi vertical-align visibility voice-family volume white-space widows width word-spacing z-index>;
    our sub index {
        state $ //= do {
            my $enums := prop-names.enums;
            CArray[CSS::Module::Property].new: |$property.sort.map({CSS::Module::Property.new(:$enums, name => .key, |.value)});
        }
    }
}

