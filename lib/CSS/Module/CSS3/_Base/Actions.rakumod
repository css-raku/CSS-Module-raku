use v6;

use CSS::Specification::Terms::Actions;
use CSS::Grammar::Actions;

class CSS::Module::CSS3::_Base::Actions
    is CSS::Specification::Terms::Actions
    is CSS::Grammar::Actions {

    method decl($/, :@proforma = <inherit initial>) {
        nextwith($/, :@proforma);;
    }

    method resolution:sym<dim>($/)        { make $.token($<num>.ast, :type($0.lc) ) }
    method dimension:sym<resolution>($/)  { make $<resolution>.ast }
}
