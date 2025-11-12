use v6;

unit class CSS::Module::CSS21::Actions;

our class _Body {
    use     CSS::Module::CSS21::Gen::Actions;
    also is CSS::Module::CSS21::Gen::Actions;

    method color:sym<system>($/) { make $.node($/) }
}

also is _Body;

use     CSS::Specification::Base::Actions;
also does CSS::Specification::Base::Actions ;

use     CSS::Grammar::Actions;
also is CSS::Grammar::Actions;

use       CSS::Module::CSS21::Gen::External;
also does CSS::Module::CSS21::Gen::External;

method build {
    use CSS::Grammar::AST;
    my class builder is CSS::Grammar::AST {
        method proforma { ['inherit'] }
    }
}

