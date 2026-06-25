unit class CSS::Snapshot2026::Backgrounds::Actions;

use CSS::Snapshot2026::Backgrounds::Gen::Actions;
also is CSS::Snapshot2026::Backgrounds::Gen::Actions;

method bg-position($/) {
    dd $/.Str, @<keyw>.map: *.Str;
    callsame();
}
