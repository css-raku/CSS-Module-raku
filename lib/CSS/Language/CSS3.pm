use v6;

use CSS::Extensions::CSS3::Colors;
use CSS::Language::CSS21;
use CSS::Grammar::CSS3;

grammar CSS::Language::CSS3
    is CSS::Extensions::CSS3::Colors
    is CSS::Extensions::CSS21
    is CSS::Grammar::CSS3 {};
