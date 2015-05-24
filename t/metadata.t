use v6;
use Test;
use CSS::Module::MetaData;

is-deeply $CSS::Module::MetaData::property<azimuth>, {:default<center>, :level(2.1), :inherit, :synopsis("<angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards")}, 'azimuth';
is-deeply $CSS::Module::MetaData::property<border>, {:!inherit, :level(1.0), :synopsis("[ 'border-width' || 'border-style' || 'border-color' ]")}, 'border';
is-deeply $CSS::Module::MetaData::property<border-style>, {:box, :default<none>, :!inherit, :level(1.0), :synopsis("[ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]\{1,4}")}, 'border-style';

done;
