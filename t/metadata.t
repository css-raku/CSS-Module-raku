use v6;
use Test;
use CSS::Module::MetaData;

is-deeply $CSS::Module::MetaData::property<azimuth>, {:level(2.1), :synopsis("<angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards")}, 'azimuth';
is-deeply $CSS::Module::MetaData::property<border>, {:level(1.0), :synopsis("'border-width' || 'border-style' || 'border-color'")}, 'border';
is-deeply $CSS::Module::MetaData::property<border-style>, {:boxed, :level(1.0), :synopsis("[ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]\{1,4}")}, 'border-style';

done;
