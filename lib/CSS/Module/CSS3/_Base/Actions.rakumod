use v6;

use CSS::Specification::Defs::Actions;
use CSS::Grammar::Actions;

class CSS::Module::CSS3::_Base::Actions
    is CSS::Specification::Defs::Actions
    is CSS::Grammar::Actions {

    method build {
        use CSS::Specification::AST;
        my class builder is CSS::Specification::AST {
            method proforma { ['inherit', 'initial'] }
        }
    }

    method resolution:sym<dim>($/)        { make $.build.token($<num>.ast, :type($0.lc) ) }
    method dimension:sym<resolution>($/)  { make $<resolution>.ast }
}
