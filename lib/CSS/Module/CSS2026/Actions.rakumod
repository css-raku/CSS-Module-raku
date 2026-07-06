unit class CSS::Module::CSS2026::Actions;

use CSS::Grammar::Actions;
also is CSS::Grammar::Actions;

use     CSS::Module::CSS3::Colors;
also is CSS::Module::CSS3::Colors::Actions;

use CSS::Specification::Base::Actions;
also does CSS::Specification::Base::Actions;

use CSS::Snapshot2026::Gen::Actions;
also is CSS::Snapshot2026::Gen::Actions;

method rect ($/) {
    $.make-func("rect", $/)
}

method build {
    use CSS::Grammar::AST;
    my class builder is CSS::Grammar::AST {
        method proforma { ['inherit', 'initial'] }
    }
}
