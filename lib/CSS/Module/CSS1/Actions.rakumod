use v6;

unit class CSS::Module::CSS1::Actions;

use CSS::Specification::Base::Actions;
use CSS::Grammar::Actions;
use CSS::Module::CSS1::Gen::External;
use CSS::Module::CSS1::Gen::Actions;

also is CSS::Module::CSS1::Gen::Actions;
also is CSS::Grammar::Actions;
also does CSS::Specification::Base::Actions;
also does CSS::Module::CSS1::Gen::External;

