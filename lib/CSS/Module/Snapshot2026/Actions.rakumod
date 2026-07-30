unit class CSS::Module::Snapshot2026::Actions;

use CSS::Grammar::Actions;
also is CSS::Grammar::Actions;

use CSS::Module::CSS3::Values_and_Units;
also is CSS::Module::CSS3::Values_and_Units::Actions::Calc;

use CSS::Specification::Base::Actions;
also does CSS::Specification::Base::Actions;

use CSS::Snapshot2026::Actions;
also is CSS::Snapshot2026::Actions;

use     CSS::Module::Snapshot2026::Colors;
also is CSS::Module::Snapshot2026::Colors::Actions;

method build {
    use CSS::Grammar::AST;
    my class builder is CSS::Grammar::AST {
        method proforma { ['inherit', 'initial'] }
    }
}
