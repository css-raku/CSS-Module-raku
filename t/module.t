use v6;
use Test;
use CSS::Module::CSS1;
use CSS::Module::CSS21;
use CSS::Module::CSS3;
use CSS::Module::CSS3::Fonts::AtFontFace;
use CSS::Module::SVG;

lives-ok {require CSS::Specification:ver(v0.4.4..*) }, "CSS::Specification version";
my \css1-module = CSS::Module::CSS1.module;
isa-ok css1-module.grammar, ::('CSS::Module::CSS1'), 'css1 grammar';
isa-ok css1-module.actions, ::('CSS::Module::CSS1::Actions'), 'css1 actions';
my \css1-prop = css1-module.property-metadata;
nok css1-prop<azimuth>:exists, 'css1 does not have azimuth';
is-deeply css1-prop<border>, {:box, :edges["border-top", "border-right", "border-bottom", "border-left"], :children["border-width", "border-style", "border-color"], :!inherit, :synopsis("'border-width' || 'border-style' || 'border-color'")}, 'css1 border';
is-deeply css1-prop<border-style>, {:box, :edges[<border-top-style border-right-style border-bottom-style border-left-style>], :!inherit, :synopsis("[ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]\{1,4}") }, 'css1 border-style';
is-deeply css1-module.parse-property('border-style', 'none' ), [{ :keyw<none> }, ], 'module.parse-property method';
is-deeply css1-module.parse-property('width', '5pt' ), [{ :pt(5) }, ], 'module.parse-property method';

nok css1-module.parse-property('border-style', 'flashy', :!warn), 'module.parse-property failure';

is-deeply css1-module.colors<red>, [ 255, 0,   0 ], "colors";

is css1-module.property-name(1), 'background-attachment';
lives-ok { css1-module.index };
lives-ok { css1-module.index[1] };
is-deeply css1-module.index[1].default-type, 'keyw';
is-deeply css1-module.index[1].default, 'scroll';
is css1-module.property-name(6), 'border';
is css1-module.property-number('border'), 6;
is css1-module.index[6].child-names[1], 'border-style';
is css1-module.property-name(css1-module.index[6].children[1]), 'border-style';

my \css21-module = CSS::Module::CSS21.module;
css21-module.extend(:name<-xhtml-align>, :like<text-align>);
my \alias = css21-module.index.tail;
is alias.name, '-xhtml-align';
isa-ok css21-module.grammar, ::('CSS::Module::CSS21'), 'css21 grammar';
isa-ok css21-module.actions, ::('CSS::Module::CSS21::Actions'), 'css21 actions';
my \css21-prop = css21-module.property-metadata;
ok css21-prop<azimuth>:exists, 'css21 has azimuth';
is-deeply css21-prop<border>, {:box, :children["border-width", "border-style", "border-color"], :edges["border-top", "border-right", "border-bottom", "border-left"], :!inherit, :synopsis("[ 'border-width' || 'border-style' || 'border-color' ]")}, 'css21 border';
is-deeply css21-prop<border-style>, {:box, :edges[<border-top-style border-right-style border-bottom-style border-left-style>], :!inherit, :synopsis("<border-style>\{1,4}") }, 'css21 border-style';

is-deeply css21-prop<-xhtml-align>, {:inherit, :synopsis("<align> | justify")}, 'css21 alias property metadata';
is-deeply css21-module.parse-property('-xhtml-align', 'center' ), [{ :keyw<center> }, ], 'css21 alias property metadata';

is-deeply css21-module.colors<red>, [ 255, 0,   0 ], "colors";

is css21-module.property-name(7), 'border';
is css21-module.property-number('border'), 7;
is css21-module.property-name(css21-module.index[7].children[1]), 'border-style';

my \css3-module = CSS::Module::CSS3.module;
is css3-module.name, 'CSS3', 'module.name';
isa-ok css3-module.grammar, ::('CSS::Module::CSS3'), 'css3 grammar';
isa-ok css3-module.actions, ::('CSS::Module::CSS3::Actions'), 'css3 actions';
my \css3-prop = css3-module.property-metadata;
is-deeply css3-prop<azimuth>, {:default["center", [{:keyw<center>},]], :inherit, :synopsis("<angle> | [ <direction> || <behind> ] | <delta>")}, 'css3 azimuth';
is-deeply css3-prop<border>, {:box, :children["border-width", "border-style", "border-color"], :edges["border-top", "border-right", "border-bottom", "border-left"], :!inherit, :synopsis("[ 'border-width' || 'border-style' || 'border-color' ]")}, 'css3 border';
is-deeply css3-prop<border-style>, {:box, :edges[<border-top-style border-right-style border-bottom-style border-left-style>], :!inherit, :synopsis("<border-style>\{1,4}") }, 'css3 border-style';

is-deeply css3-module.colors<gold>, [ 255, 215,   0 ], "colors";

is css3-module.property-name(7), 'border';
is css3-module.property-number('border'), 7;
is css3-module.property-name(css3-module.index[7].children[1]), 'border-style';

my \at-fontface-module = css3-module.sub-module<@font-face>;
isa-ok at-fontface-module.grammar, ::('CSS::Module::CSS3::Fonts::AtFontFace'), '@font-face grammar';
isa-ok at-fontface-module.actions, ::('CSS::Module::CSS3::Actions'), '@font-face actions';
my \at-fontface-prop = at-fontface-module.property-metadata;
is-deeply at-fontface-prop<font-style>, { :synopsis("normal | italic | oblique"), :default["normal", [{:keyw("normal")},]], }, '@font-face font-style';

my \svg-module = CSS::Module::SVG.module;
isa-ok svg-module.grammar, ::('CSS::Module::SVG'), 'svg grammar';
isa-ok svg-module.actions, ::('CSS::Module::SVG::Actions'), 'svg actions';
my \svg-prop = svg-module.property-metadata;
is-deeply svg-prop<azimuth>, { :synopsis("<angle> | [ <direction> || <behind> ] | <delta>"), :inherit, :default["center", [{:keyw("center")},]], }, 'svg azimuth';
is-deeply svg-prop<alignment-baseline>, { :synopsis("auto | baseline | before-edge | text-before-edge | middle | central | after-edge | text-after-edge | ideographic | alphabetic | hanging | mathematical"), :!inherit, :default["baseline", [{:keyw("baseline")},]], }, 'svg alignment-baseline';
is-deeply svg-prop<font-style>, { :synopsis("normal | italic | oblique"), :inherit, :default["normal", [{:keyw("normal")},]], }, 'svg font-style';

done-testing;
