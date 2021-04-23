use v6;

use CSS::Specification::Defs::Actions;
use CSS::Grammar::Actions;
use CSS::Module::CSS1::Gen::Interface;
use CSS::Module::CSS1::Gen::Actions;

class CSS::Module::CSS1::Actions
    is CSS::Specification::Defs::Actions
    is CSS::Module::CSS1::Gen::Actions
    is CSS::Grammar::Actions
    does CSS::Module::CSS1::Gen::Interface {
}

