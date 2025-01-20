use v6;

use CSS::Specification::Defs::Actions;
use CSS::Grammar::Actions;

class CSS::Module::CSS3::_Base::Actions
    is CSS::Specification::Defs::Actions
    is CSS::Grammar::Actions {

    method build {
        use CSS::Grammar::AST;
        my class builder is CSS::Grammar::AST {
            method proforma { ['inherit', 'initial'] }
        }
    }

}
