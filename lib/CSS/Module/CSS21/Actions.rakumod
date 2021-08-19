use v6;

use CSS::Specification::Defs::Actions;
use CSS::Module::CSS21::Gen::Interface;
use CSS::Module::CSS21::Gen::Actions;
use CSS::Grammar::Actions;

class CSS::ModuleX::CSS21::Actions
    is CSS::Module::CSS21::Gen::Actions {

    method color:sym<system>($/) { make $.node($/) }

    # --- Functions --- #

    #| usage: attr( attribute-name <type-or-unit>? )
    method attr($/)             {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.build.func( 'attr', $.build.list($/) );
    }

    #| usage: counter(ident [, ident [,...] ])
    method counter($/) {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.build.func( 'counter', $.build.list($/) );
    }

    #| usage: counters(ident [, "string"])
    method counters($/) {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.build.func( 'counters', $.build.list($/) );
    }

    #| usage: rect(<top>, <right>, <botom>, <left>)
    method shape($/)     {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.build.func( 'rect', $.build.list($/) );
    }

}

class CSS::Module::CSS21::Actions
    is CSS::ModuleX::CSS21::Actions
    is CSS::Specification::Defs::Actions 
    is CSS::Grammar::Actions
    does CSS::Module::CSS21::Gen::Interface {

    method build {
        use CSS::Specification::AST;
        my class builder is CSS::Specification::AST {
            method proforma { ['inherit'] }
        }
    }

}
