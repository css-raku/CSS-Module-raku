unit class CSS::Module::CSS3::_Base::Actions;

use CSS::Specification::Base::Actions;
use CSS::Grammar::Actions;

also does CSS::Specification::Base::Actions;
also is CSS::Grammar::Actions;

method build {
    use CSS::Grammar::AST;
    my class builder is CSS::Grammar::AST {
        method proforma { ['inherit', 'initial'] }
    }
}
