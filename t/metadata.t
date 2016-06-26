use v6;
use Test;
use CSS::Module::CSS21;
use CSS::Module::CSS3;
my $css3-module = CSS::Module::CSS3.module;
my $css3-prop = $css3-module.property-metadata;
is-deeply  $css3-prop<azimuth>, {:default["center", [{:keyw<center>},]], :inherit, :synopsis("<angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards")}, 'css3 azimuth';
is-deeply $css3-prop<border>, {:box, :children["border-top", "border-right", "border-bottom", "border-left"], :!inherit, :synopsis("[ 'border-width' || 'border-style' || 'border-color' ]")}, 'css3 border';
is-deeply $css3-prop<border-style>, {:box, :children[<border-top-style border-right-style border-bottom-style border-left-style>], :!inherit, :synopsis("[ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]\{1,4}") }, 'css3 border-style';

is-deeply $css3-module.colors<gold>, [ 255, 215,   0 ], "colors";

my $css21-module = CSS::Module::CSS21.module;
my $css21-prop = $css21-module.property-metadata;
nok $css21-prop<azimuth>:exists, 'css21 azimuth';
todo "css21 meta-data", 2;
is-deeply $css21-prop<border>, {:box, :children["border-top", "border-right", "border-bottom", "border-left"], :!inherit, :synopsis("[ 'border-width' || 'border-style' || 'border-color' ]")}, 'css21 border';
is-deeply $css21-prop<border-style>, {:box, :children[<border-top-style border-right-style border-bottom-style border-left-style>], :!inherit, :synopsis("[ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]\{1,4}") }, 'css21 border-style';

nok $css21-module.colors<gold>:exists, "css21 colors";
is-deeply $css21-module.colors<red>, [ 255, 0,   0 ], "colors";

done-testing;
