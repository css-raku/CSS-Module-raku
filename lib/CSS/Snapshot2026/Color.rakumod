unit grammar CSS::Snapshot2026::Color;

use CSS::Snapshot2026::Color::Gen::Grammar;
also is CSS::Snapshot2026::Color::Gen::Grammar;

token func-arg-delim {','?} # comma is becoming optional in many CSS4 functions, including, rgb(), rgba(), rect()
token alpha-channel-delim {<[,/]>}
