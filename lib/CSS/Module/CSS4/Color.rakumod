unit grammar CSS::Module::CSS4::Color;

use CSS::Module::CSS4::Color::Gen::Grammar;
also is CSS::Module::CSS4::Color::Gen::Grammar;

token func-arg-delim {','?} # comma is becoming optional in many CSS4 functions, including, rgb(), rgba(), rect()
token alpha-channel-delim {<[,/]>}
