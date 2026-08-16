use v6;
use Test;
use CSS::Module::CSS1;
use CSS::Module::CSS21;
use CSS::Module::CSS3;
use CSS::Module::CSS3::Fonts::AtFontFace;
use CSS::Module::SVG;
use CSS::Module::Snapshot2026;

subtest 'CSS1', {
    my \module = CSS::Module::CSS1.module;
    isa-ok module.grammar, 'CSS::Module::CSS1', 'css1 grammar';
    isa-ok module.actions, 'CSS::Module::CSS1::Actions', 'css1 actions';
    my \css1-prop = module.property-metadata;
    nok css1-prop<azimuth>:exists, 'css1 does not have azimuth';
    is-deeply css1-prop<border>, {:box, :edges["border-top", "border-right", "border-bottom", "border-left"], :children["border-width", "border-style", "border-color"], :!inherit, :synopsis("'border-width' || 'border-style' || 'border-color'")}, 'css1 border';
    is-deeply css1-prop<border-style>, {:box, :edges[<border-top-style border-right-style border-bottom-style border-left-style>], :!inherit, :synopsis("[ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]\{1,4}") }, 'css1 border-style';
    is-deeply module.parse-property('border-style', 'none' ), [{ :keyw<none> }, ], 'module.parse-property method';
    is-deeply module.parse-property('width', '5pt' ), [{ :pt(5) }, ], 'module.parse-property method';

    nok module.parse-property('border-style', 'flashy', :!warn), 'module.parse-property failure';

    is-deeply module.colors<red>, [ 255, 0,   0 ], "colors";

    is module.property-name(1), 'background-attachment';
    lives-ok { module.index };
    lives-ok { module.index[1] };
    is-deeply module.index[1].default, 'scroll';
    is module.property-name(6), 'border';
    is module.property-number('border'), 6;
    is module.index[6].child-names[1], 'border-style';
    is module.property-name(module.index[6].children[1]), 'border-style';
}

subtest 'CSS2.1', {
    my \module = CSS::Module::CSS21.module;
    module.extend(:name<-xhtml-align>, :like<text-align>);
    my \alias = module.index.tail;
    is alias.name, '-xhtml-align';
    isa-ok module.grammar, 'CSS::Module::CSS21', 'css21 grammar';
    isa-ok module.actions, 'CSS::Module::CSS21::Actions', 'css21 actions';
    my \css21-prop = module.property-metadata;
    ok css21-prop<azimuth>:exists, 'css21 has azimuth';
    is-deeply css21-prop<border>, {:box, :children["border-width", "border-style", "border-color"], :edges["border-top", "border-right", "border-bottom", "border-left"], :!inherit, :synopsis("[ 'border-width' || 'border-style' || 'border-color' ]")}, 'css21 border';
    is-deeply css21-prop<border-style>, {:box, :edges[<border-top-style border-right-style border-bottom-style border-left-style>], :!inherit, :synopsis("<border-style>\{1,4}") }, 'css21 border-style';

    is-deeply css21-prop<-xhtml-align>, {:default("a nameless value that acts as 'left' if 'direction' is 'ltr', 'right' if 'direction' is 'rtl'"), :inherit, :synopsis("<align> | justify")}, 'css21 alias property metadata';
    is-deeply module.parse-property('-xhtml-align', 'center' ), [{ :keyw<center> }, ], 'css21 alias property metadata';

    is-deeply module.colors<red>, [ 255, 0,   0 ], "colors";

    is module.property-name(7), 'border';
    is module.property-number('border'), 7;
    is module.property-name(module.index[7].children[1]), 'border-style';
}

subtest 'CSS3', {
    my \module = CSS::Module::CSS3.module;
    is module.name, 'CSS3', 'module.name';
    isa-ok module.grammar, 'CSS::Module::CSS3', 'css3 grammar';
    isa-ok module.actions, 'CSS::Module::CSS3::Actions', 'css3 actions';
    my \css3-prop = module.property-metadata;
    is-deeply css3-prop<azimuth>, {:default<center>, :inherit, :synopsis("<angle> | [ <direction> || <behind> ] | <delta>")}, 'css3 azimuth';
    is-deeply css3-prop<border>, {:box, :children["border-width", "border-style", "border-color"], :edges["border-top", "border-right", "border-bottom", "border-left"], :!inherit, :synopsis("[ 'border-width' || 'border-style' || 'border-color' ]")}, 'css3 border';
    is-deeply css3-prop<border-style>, {:box, :edges[<border-top-style border-right-style border-bottom-style border-left-style>], :!inherit, :synopsis("<border-style>\{1,4}") }, 'css3 border-style';

    is-deeply module.colors<gold>, [ 255, 215,   0 ], "colors";

    is module.property-name(7), 'border';
    is module.property-number('border'), 7;
    is module.property-name(module.index[7].children[1]), 'border-style';
}

subtest 'CSS3 @font-face', {
    my \module = CSS::Module::CSS3.module.sub-module<@font-face>;
    isa-ok module.grammar, 'CSS::Module::CSS3::Fonts::AtFontFace', '@font-face grammar';
    isa-ok module.actions, 'CSS::Module::CSS3::Actions', '@font-face actions';
    my \at-fontface-prop = module.property-metadata;
    is-deeply at-fontface-prop<font-style>, { :synopsis("normal | italic | oblique"), :!inherit, :default<normal>, }, '@font-face font-style';
}

subtest 'SVG', {
    my \module = CSS::Module::SVG.module;
    isa-ok module.grammar, 'CSS::Module::SVG', 'svg grammar';
    isa-ok module.actions, 'CSS::Module::SVG::Actions', 'svg actions';
    my \prop = module.property-metadata;
    is-deeply prop<azimuth>, { :synopsis("<angle> | [ <direction> || <behind> ] | <delta>"), :inherit, :default<center>, }, 'svg azimuth';
    is-deeply prop<alignment-baseline>, { :synopsis("auto | baseline | before-edge | text-before-edge | middle | central | after-edge | text-after-edge | ideographic | alphabetic | hanging | mathematical"), :!inherit, :default<baseline>, }, 'svg alignment-baseline';
    is-deeply prop<font-style>, { :synopsis("normal | italic | oblique"), :inherit, :default<normal>, }, 'svg font-style';
}

subtest 'Snapshot2026', {
    my \module = CSS::Module::Snapshot2026.module;
    isa-ok module.grammar, 'CSS::Module::Snapshot2026', 'css2026 grammar';
    isa-ok module.actions, 'CSS::Module::Snapshot2026::Actions', 'css2026 actions';
    my \prop = module.property-metadata;
    is-deeply prop<azimuth>, { :synopsis("<angle> | [ <direction> || <behind> ] | <delta>"), :inherit, :default<center>, }, 'css2026 azimuth';
    is-deeply prop<font-style>, { :synopsis("normal | italic | left | right | oblique <angle [-90deg,90deg]>?"), :inherit, :default<normal>, }, 'css2026 font-style';
}

subtest 'Snapshot2026 @color-profile', {
    my \module = CSS::Module::Snapshot2026.module.sub-module<@color-profile>;
    isa-ok module.grammar, 'CSS::Module::Snapshot2026::AtColorProfile', '@color-profile grammar';
    isa-ok module.actions, 'CSS::Module::Snapshot2026::Actions::AtColorProfile', '@color-profile actions';
    my \at-color-profile-prop = module.property-metadata;
    is-deeply at-color-profile-prop<components>, { :synopsis("<ident>#"), :!inherit, :default<n/a>, }, '@color-profile ';
}

subtest 'Snapshot2026 @font-face', {
    my \module = CSS::Module::Snapshot2026.module.sub-module<@font-face>;
    isa-ok module.grammar, 'CSS::Module::Snapshot2026::AtFontFace', '@font-face grammar';
    isa-ok module.actions, 'CSS::Module::Snapshot2026::Actions::AtFontFace', '@font-face actions';
    my \at-fontface-prop = module.property-metadata;
    is-deeply at-fontface-prop<font-style>, { :synopsis("auto | normal | italic | left | right | oblique [ <angle [-90deg,90deg]>\{1,2} ]?"), :!inherit, :default<auto>, }, '@font-face font-style';
}

done-testing;
