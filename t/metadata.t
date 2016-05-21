use v6;
use Test;
use CSS::Module::CSS3::Metadata;
is-deeply $CSS::Module::CSS3::Metadata::property<azimuth>, {:default["center", [{:keyw<center>},]], :inherit, :synopsis("<angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards")}, 'azimuth';
is-deeply $CSS::Module::CSS3::Metadata::property<border>, {:!inherit, :synopsis("[ 'border-width' || 'border-style' || 'border-color' ]")}, 'border';
is-deeply $CSS::Module::CSS3::Metadata::property<border-style>, {:box, :default["none", [{:keyw<none>},]], :!inherit, :synopsis("[ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]\{1,4}") }, 'border-style';

done-testing;
