use v6;

use CSS::Language::_Base::Actions;
use CSS::Language::CSS21::Spec::Interface;
use CSS::Language::CSS21::Spec::Actions;

class CSS::Language::CSS21::Actions {...};

class CSS::Module::CSS21::Actions
    is CSS::Language::CSS21::Spec::Actions {

    has @._proforma = 'inherit';

    method color:sym<system>($/) { make $.node($/) }

    # --- Functions --- #

    #= usage: attr( attribute-name <type-or-unit>? )
    method attr($/)             {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.list($/);
    }

    #= usage: counter(ident [, ident [,...] ])
    method counter($/) {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.list($/);
    }

    #= usage: counters(ident [, "string"])
    method counters($/) {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.list($/);
    }

    #= usage: rect(<top>, <right>, <botom>, <left>)
    method shape($/)     {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.list($/);
    }
    method shape-arg($/) { make $.list($/) }

    method val($/) { make $.list($<expr> // $/) }

   # --- Expressions --- #

    method border-style($/) { make $.list($/) }
    method border-width($/) { make $.list($/) }
    method family-name($/) { make $<family-name>.ast }
    method generic-family($/) { make $<generic-family>.ast }
    method absolute-size($/) { make $.token($<keyw>.ast) }
    method relative-size($/) { make $.token($<keyw>.ast) }
    method margin-width($/) { make $.list($/) }
    method padding-width($/) { make $.list($/) }
    method generic-voice($/) { make $.list($/) }
    method specific-voice($/) { make $.list($/) }
}

class CSS::Language::CSS21::Actions
    is CSS::Language::_Base::Actions 
    is CSS::Module::CSS21::Actions
    does CSS::Language::CSS21::Spec::Interface { }
