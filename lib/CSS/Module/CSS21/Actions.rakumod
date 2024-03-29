use v6;

class CSS::ModuleX::CSS21::Actions {
    use     CSS::Module::CSS21::Gen::Actions;
    also is CSS::Module::CSS21::Gen::Actions;

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

class CSS::Module::CSS21::Actions {

    also is CSS::ModuleX::CSS21::Actions;

    use     CSS::Specification::Defs::Actions;
    also is CSS::Specification::Defs::Actions ;

    use     CSS::Grammar::Actions;
    also is CSS::Grammar::Actions;

    use       CSS::Module::CSS21::Gen::Interface;
    also does CSS::Module::CSS21::Gen::Interface;

    method build {
        use CSS::Specification::AST;
        my class builder is CSS::Specification::AST {
            method proforma { ['inherit'] }
        }
    }

}
